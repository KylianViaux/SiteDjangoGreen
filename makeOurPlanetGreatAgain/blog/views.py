from django.http import HttpResponse
from django.shortcuts import render, get_object_or_404, redirect
from blog.models import User, Project, UserForm, ProjectForm, ExpertForm, ExpertNote, ConnexionForm, InvestorLink, ContactForm, RechercheForm
from blog.models import User, Project, UserForm, ProjectForm, ExpertForm, ExpertNote, ConnexionForm, InvestorLink, ContactForm, KarmaCheck
from django.views.generic import CreateView
from django.http import HttpResponseRedirect
from django.core.mail import send_mail, get_connection, EmailMessage
from django.db.models import Avg
from django.template.loader import get_template
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth.hashers import make_password

from datetime import datetime
import logging
# Permet d'afficher des log
logger = logging.getLogger(__name__)
#logger.error("message")
#logger.error("projectId {}".format(id))

#--------------------------------------------------------------------------------------------------------------------------

# Fonction de la page d'accueil
def home(request):

    # Récupération de l'utilisateur connecté si il y en a un et vérification si c'est un expert
    if request.user.is_authenticated:
        connexion = "true"
        user = request.user
        if user.isExpert:
            isExpert = True
        else:
            isExpert = False
    else:
        connexion = "null"
        user = False
        isExpert = False

    # Formulaire de connexion
    if request.method == 'POST':
        form = ConnexionForm(request.POST)
        if form.is_valid():
            username=request.POST.get('username')
            password=request.POST.get('password')
            user = authenticate(username=username, password=password)
            if user is not None:
                connexion="true"
                if user.isExpert:
                    isExpert = True
                login(request, user)
            else:
                connexion="false"
    else:
        form = ConnexionForm()

	# Afficher tous les utilisateurs de notre blog
    users = User.objects.all().order_by('-dateInscription')[0:10]

	# Afficher tous les projets de notre blog par date de publication
    projects = Project.objects.all().order_by('-datePublication')

    # Récupération du dernier projet financé ainsi que les commententaires reçus
    project_id = last_contributed_project = -1
    objects = InvestorLink.objects.all().select_related('idProject').order_by('-dateTransaction')[0:1]
    for object in objects:
        project_id = object.idProject_id
        last_contributed_project = get_object_or_404(Project, id=project_id)
    if project_id != -1:
        objects = ExpertNote.objects.filter(idProject=project_id).select_related('idExpert')
        comments = []
        for object in objects:
                array = {}
                array['idExpert'] = object.idExpert.id
                array['karma'] = object.idExpert.karma
                array['expertName'] = object.idExpert.username
                array['note'] = object.noteGlobale
                array['comment'] = object.commentaire
                comments.append(array)

	# Render
    return render(request, 'blog/accueil.html', locals())


#--------------------------------------------------------------------------------------------------------------------------

# Permet à un utilisateur connecté de se déconnecter
def deconnexion(request):
    logout(request)
    return redirect('accueil')

#--------------------------------------------------------------------------------------------------------------------------

# Retourne tous les utilisateurs existants
def voirUtilisateur(request, id):
    user = get_object_or_404(User, id=id)

    # Renvoi tous les projets que cet utilisateur à crée
    projects = Project.objects.filter(idCreateur = user)

    return render(request, 'blog/voirUtilisateur.html', locals())

#--------------------------------------------------------------------------------------------------------------------------

# La fonction permet :
#   - De visualiser toutes les informations concernant un projet
#   - De contribuer à celui-ci pour n'importe quel utilisateur connecté
#   - De commenter et d'évaluer un projet si l'utilisateur connecté est un expert
def voirProjet(request, id):

    project = get_object_or_404(Project, id = id)

    # Récupération des moyennes dans chaque catégorie que le projet à reçu
    # Calcul de la moyenne sur toutes les notes
    object = ExpertNote.objects.filter(idProject=project.id)
    avg_noteBudget = object.aggregate(Avg('noteBudget')).get('noteBudget__avg')
    avg_noteFaisabilite = object.aggregate(Avg('noteFaisabilite')).get('noteFaisabilite__avg')
    avg_noteUtilite = object.aggregate(Avg('noteUtilite')).get('noteUtilite__avg')
    if avg_noteBudget is not None:
        moyenne = round((avg_noteBudget+avg_noteFaisabilite+avg_noteUtilite)/3,2)

    # Renvoi la liste des 5 plus gros contributeurs ainsi que leur donation
    contributions = []
    objects = InvestorLink.objects.filter(idProject=project).select_related('idInvestisseur').order_by('-contribution')[0:5]
    for object in objects:
        array = {}
        array['nom'] = object.idInvestisseur.username
        array['contribution'] = object.contribution
        contributions.append(array)

    # Si la personne connectée est un expert qui n'a pas encore évalué le projet alors
    # le formulaire permettant de noter ce projet sera affiché
    form = ""
    hasEvaluated = False
    if request.user.is_authenticated:
        if request.user.isExpert:
            if not ExpertNote.objects.filter(idProject=id, idExpert=request.user.id).exists():
                if request.method == 'POST':
                    form = ExpertForm(request.POST)
                    if form.is_valid():
                        current_user = request.user
                        note1 = request.POST.get('noteBudget')
                        note2 = request.POST.get('noteFaisabilite')
                        note3 = request.POST.get('noteUtilite')
                        note4 = (int(note1)+int(note2)+int(note3))/3
                        note = ExpertNote.objects.create(
                           idExpert = current_user,
                           idProject = project,
                           noteBudget = note1,
                           noteFaisabilite = note2,
                           noteUtilite = note3,
                           noteGlobale = note4,
                           commentaire = request.POST.get('commentaire'),
                        )
                        return redirect('projectId', id = id)
                else:
                    form = ExpertForm()
            else:
                #l'expert a déjà noté ce projet
                hasEvaluated = True

    return render(request, 'blog/voirProjet.html', locals())

#--------------------------------------------------------------------------------------------------------------------------

# Permet à un utilisateur connecté d'effectuer un don sur un projet defini par son identifiant
# Une fois le don effectué l'utilisateur est redirigé vers la page du projet
@login_required(redirect_field_name='redirect_to')
def donate(request, id, contribution):

    # Récupération de l'utilisateur connecté ainsi que du projet
    current_user = request.user
    project = get_object_or_404(Project, id=id)

    # Ajout du lien entre le projet et le donateur
    # Si la transaction n'existe pas encore on la créée
    # Sinon on la met à jour
    # On sauvegarde la transaction effectuée dans derniereTransaction
    object = InvestorLink.objects.filter(idProject = project, idInvestisseur = current_user)
    if not object.exists():
        donation = InvestorLink.objects.create(
            idProject = project,
            idInvestisseur = current_user,
            contribution = contribution,
            derniereTransaction = contribution
        )
    else :
        for obj in object:
            obj.dateTransaction = datetime.now()
            obj.derniereTransaction = contribution
            obj.contribution += contribution
            obj.save()

    # Maj du budget dans la table projet
    project.budgetActuel += contribution
    project.save()

    return redirect('projectId', id = id)

#--------------------------------------------------------------------------------------------------------------------------

# Permet à une personne de s'inscrire
def inscription(request):
	submitted = False
	if request.method == 'POST':
		form = UserForm(request.POST)
		if form.is_valid():
			cd = form.cleaned_data
			username=request.POST.get('username')
			password = make_password(request.POST.get('password'))
			email=request.POST.get('email')
			profil=request.POST.get('profil')
			if(request.POST.get('isExpert') == 'on'):
			    expert = True
			    karma = 110
			else:
			    expert = False
			    karma = 0
			user = User.objects.create(
				username=username,
				password=password,
				email=email,
				isExpert=expert,
				profil=profil,
				karma=karma
			)
			#assert False
			con = get_connection('django.core.mail.backends.console.EmailBackend')
			send_mail(
                 cd['username'],
                 cd['password'],
                 cd.get('email', 'noreply@example.com'),
                 ['siteowner@example.com'],
                 connection=con
            )
			return home(request)
	else:
		form = UserForm()
		if 'submitted' in request.GET:
			submitted = True
	return render(request, 'blog/inscription.html', {'form':form, 'submitted':submitted})

#--------------------------------------------------------------------------------------------------------------------------

# Permet à un utilisteur connecté de créer un projet
@login_required(redirect_field_name='redirect_to')
def nouveauProject(request):
    submitted = False
    if request.method == 'POST':
        form = ProjectForm(request.POST)
        if form.is_valid():
            utilisateur = request.user
            nom=request.POST.get('nom')
            budgetCible=request.POST.get('budgetCible')
            difficulte=request.POST.get('difficulte')
            description=request.POST.get('description')
            project = Project.objects.create(
                nom=nom,
                idCreateur=utilisateur,
                budgetActuel=0,
                budgetCible=budgetCible,
                difficulte=difficulte,
                description=description
            )
            return HttpResponseRedirect('/nouveauProject?submitted=True')
    else:
        form = ProjectForm()
        if 'submitted' in request.GET:
            submitted = True

    return render(request, 'blog/nouveauProject.html', {'form':form, 'submitted':submitted})


#--------------------------------------------------------------------------------------------------------------------------

def rechercher(request):
    submitted = False
    projects = []
    if request.method == 'POST':
        form = RechercheForm(request.POST)
        if form.is_valid():
            choix_et_ou_ou = request.POST.get('choix_et_ou_ou')
            nom_utilisateur = request.POST.get('nom_createur')
            nom_project = request.POST.get('nom_project')
            budget_min = request.POST.get('budget_min')
            budget_max = request.POST.get('budget_max')
            note_moyenne_min = request.POST.get('note_moyenne_min')
            note_moyenne_max = request.POST.get('note_moyenne_max')
            listObjects = Project.objects.all()
			# Il faut tout appliqués.
            if choix_et_ou_ou:
                if nom_utilisateur != '':
                    listUser = User.objects.filter(username__icontains=nom_utilisateur)
                    if len(listUser) == 0: 
                           listObjects = Project.objects.none()
                    else:                       
                        for user in listUser:
                            if user.id != None:
                                listObjects = listObjects.filter(idCreateur=user.id)			
                if nom_project != '':
                    listObjects = listObjects.filter(nom__icontains=nom_project)
                if budget_min != None and budget_min != '':
                    listObjects = listObjects.filter(budgetCible__gte=budget_min)
                if budget_max != None and budget_max != '':
                    listObjects = listObjects.filter(budgetCible__lte=budget_max)
                for object in listObjects:
                    array = {}
                    array['nom'] = object.nom
                    array['createur'] = object.idCreateur
                    array['budgetActuel'] = object.budgetActuel
                    array['budgetCible'] = object.budgetCible
                    array['description'] = object.description
                    array['datePublication'] = object.datePublication
                    projects.append(array)
                submitted = True
            # Il faut tout séparés.  
            else:
                listObjects = Project.objects.none()
                listUser = User.objects.filter(username__icontains=nom_utilisateur)
                if nom_utilisateur != '':
                    if len(listUser) != 0:                     
                        for user in listUser:
                            listObjects = listObjects | Project.objects.filter(idCreateur=user.id)
                if nom_project != '':
                    listObjects = listObjects | Project.objects.filter(nom__icontains=nom_project)
                if budget_min != None and budget_min != '':
                    listObjects = listObjects | Project.objects.filter(budgetCible__gte=budget_min)
                if budget_max != None and budget_max != '':
                    listObjects = listObjects | Project.objects.filter(budgetCible__lte=budget_max)
                for object in listObjects:
                    array = {}
                    array['nom'] = object.nom
                    array['createur'] = object.idCreateur
                    array['budgetActuel'] = object.budgetActuel
                    array['budgetCible'] = object.budgetCible
                    array['description'] = object.description
                    array['datePublication'] = object.datePublication
                    projects.append(array)
                submitted = True
         	    # Pour la recherche par 
            submitted = True
    else:
        form = RechercheForm()
        if 'submitted' in request.GET:
            submitted = True
    return render(request, 'blog/rechercher.html', {'form':form, 'submitted':submitted, 'projects':projects	})
    
#-------------------------------------------------------------------------------------------------------------------------

class PersonCreateView(CreateView):
    model = User
    fields = ('name', 'password', 'email', 'profil')

#--------------------------------------------------------------------------------------------------------------------------

# Page pour les mentions légales
def mentionsLegales(request):
    return render(request, 'blog/mentionsLegales.html')

#--------------------------------------------------------------------------------------------------------------------------

# Formulaire de contact
def contact(request):
    form_class = ContactForm

    if request.method == 'POST':
        form = form_class(data=request.POST)
        if form.is_valid():
            contact_name = request.POST.get('contact_name', '')
            contact_email = request.POST.get('contact_email', '')
            form_content = request.POST.get('content', '')

            template = get_template('blog/contactTemplate.txt')
            context = {
                'contact_name': contact_name,
                'contact_email': contact_email,
                'form_content': form_content,
            }
            content = template.render(context)

            email = EmailMessage(
                "New contact form submission",
                content,
                "Your website" +'',
                ['youremail@gmail.com'],
                headers = {'Reply-To': contact_email }
            )
            email.send()
            return HttpResponse('Thanks for contacting us!')
    else:
        form = ContactForm()

    return render(request, 'blog/contact.html', { 'form': form_class,})

#--------------------------------------------------------------------------------------------------------------------------

# Gestion du karma d'un expert
# Un expert gagne/perd du karma en fonction des commentaires et notes qu'il donne à un projet
# Un expert différent du premier peux lui attribuer un point de karma (plus/moins)
# Un expert ne peut pas noter son propre commentaire et il ne peut pas non plus noter plusieurs fois le même commentaire d'un autre expert
def updateKarma(request, idProject, idEvaluateur, idEvalue, note):

    # Récupération des objets a partir de leur id
    project = get_object_or_404(Project, id=idProject)
    evaluateur = get_object_or_404(User, id=idEvaluateur)
    evalue = get_object_or_404(User, id=idEvalue)

    # Il y a deux cas
        # - Un expert n'a pas encore évalué le commentaire d'un autre expert, dans ce cas on defini le karma en fontion de l'évaluation de l'expert et un crée un objet
        #   qui permet de connaitre la note qu'un expert a donné a un autre sur un projet défini
        # - Un expert souhaite modifier la note qu'il a donnée a un expert sur un commentaire, dans ce cas on retrouve la partie concernée et on la modifie
    object = KarmaCheck.objects.filter(idProject=project, ExpertEvaluateur=evaluateur, ExpertEvalue=evalue)
    if not object.exists():
        if note == 0:
            evalue.karma -= 1
            note = -1
        else:
            evalue.karma += 1
            evalue.save()
        KarmaCheck.objects.create(
            idProject=project,
            ExpertEvaluateur=evaluateur,
            ExpertEvalue=evalue,
            evaluation=note,
            oldEvaluation=note
        )
    else :
        for obj in object:
            obj.evaluation = note
            if obj.oldEvaluation != obj.evaluation:
                obj.oldEvaluation = obj.evaluation
                obj.save()
                if note == 0:
                    evalue.karma -= 1
                else:
                    evalue.karma += 1
                evalue.save()

    return redirect('accueil')