from django.http import HttpResponse
from django.shortcuts import render, get_object_or_404
from blog.models import User, Project, UserForm, ProjectForm, ExpertForm, ExpertNote, ConnexionForm, InvestorLink
from django.views.generic import CreateView
from django.http import HttpResponseRedirect
from django.core.mail import send_mail, get_connection
from django.db.models import Avg
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth.hashers import make_password

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
    users = User.objects.all()

	# Afficher tous les projets de notre blog
    project = Project.objects.all()

	# Render
    return render(request, 'blog/accueil.html', {'form':form, 'derniers_users':users, 'user':user, 'derniers_project':project, 'connexion':connexion, 'isExpert':isExpert})


#--------------------------------------------------------------------------------------------------------------------------

# Permet à un utilisateur connecté de se déconnecter
def deconnexion(request):
    logout(request)
    return home(request)

#--------------------------------------------------------------------------------------------------------------------------

# Retourne tous les utilisateurs existants
def voirUtilisateur(request, id, slug):
    user = get_object_or_404(User, id=id, slug=slug)
    return render(request, 'blog/voirUtilisateur.html', {'user':user})

#--------------------------------------------------------------------------------------------------------------------------

# Retourne tous les projets existants
def voirProjet(request, id):

    project = get_object_or_404(Project, id=id)
    form = ""

    # Récupération de toutes les notes que le projet a recu
    object = ExpertNote.objects.filter(idProject=project.id)
    avg_noteBudget = object.aggregate(Avg('noteBudget')).get('noteBudget__avg')
    avg_noteFaisabilite = object.aggregate(Avg('noteFaisabilite')).get('noteFaisabilite__avg')
    avg_noteUtilite = object.aggregate(Avg('noteUtilite')).get('noteUtilite__avg')

    # Si la personne connectée est un expert permet formulaire permettant de noter un projet
    if request.user.is_authenticated:
        if request.user.isExpert:
            if request.method == 'POST':
                    form = ExpertForm(request.POST)
                    if form.is_valid():
                        current_user = request.user
                        note = ExpertNote.objects.create(
                           idExpert=current_user,
                           idProject=project,
                           noteBudget=request.POST.get('noteBudget'),
                           noteFaisabilite=request.POST.get('noteFaisabilite'),
                           noteUtilite=request.POST.get('noteUtilite'),
                           commentaire=request.POST.get('commentaire'),
                        )
            else:
                form = ExpertForm()

    # Renvoi la liste des 5 plus gros contributeurs ainsi que leur donation
    contributions = []
    objects = InvestorLink.objects.filter(idProject=project).select_related('idInvestisseur').order_by('-contribution')[0:5]
    for object in objects:
        array = {}
        array['name'] = object.idInvestisseur.username
        array['contribution'] = object.contribution
        contributions.append(array)

    return render(request, 'blog/voirProjet.html', { 'project':project, 'user':request.user, 'contributions':contributions, 'form':form, 'avg_noteBudget':avg_noteBudget, 'avg_noteFaisabilite':avg_noteFaisabilite,  'avg_noteUtilite':avg_noteUtilite})

#--------------------------------------------------------------------------------------------------------------------------

# Permet à un utilisateur connecté d'effectuer un don sur un projet definit par un identifiant
@login_required(redirect_field_name='redirect_to')
def donate(request, id, contribution):

    #récupération de l'utilisateur connecté ainsi que du projet
    current_user = request.user
    project = get_object_or_404(Project, id=id)

    # Ajout du lien entre le projet et le donateur
    # Si la transaction n'existe pas encore on la créée
    # Sinon on la met à jour
    object = InvestorLink.objects.filter(idProject=project, idInvestisseur=current_user)
    if not object.exists():
        donation = InvestorLink.objects.create(
            idProject=project,
            idInvestisseur=current_user,
            contribution=contribution
        )
    else :
        for obj in object:
            obj.contribution += contribution
            obj.save()

    # Maj du budget dans la table projet
    project.budgetActuel += contribution
    project.save()
    return voirProjet(request, id)

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
			else:
			    expert = False
			user = User.objects.create(
				username=username,
				slug=username,
				password=password,
				email=email,
				isExpert=expert,
				profil=profil
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

# Permet a un utilisteur connecté de créer un projet
@login_required(redirect_field_name='redirect_to')
def createProject(request):
    submitted = False
    if request.method == 'POST':
        form = ProjectForm(request.POST)
        if form.is_valid():
            cd = form.cleaned_data
            nom=request.POST.get('nom')
            budgetCible=request.POST.get('budgetCible')
            description=request.POST.get('description')
            project = Project.objects.create(
                nom=nom,
                budgetActuel=0,
                budgetCible=budgetCible,
                description=description
            )
            return HttpResponseRedirect('/createProject?submitted=True')
    else:
        form = ProjectForm()
        if 'submitted' in request.GET:
            submitted = True
    return render(request, 'blog/createProject.html', {'form':form, 'submitted':submitted})

#--------------------------------------------------------------------------------------------------------------------------

def confirmation(request):
    return render(request, 'blog/confirmation.html')

#--------------------------------------------------------------------------------------------------------------------------

# Permet à un utilisateur connecté qui est expert de noter un project
@login_required(redirect_field_name='redirect_to')
def evaluateProject(request, id):
    if request.user.isExpert:
        logger.error("expert")
    else:
        return home(request)

#--------------------------------------------------------------------------------------------------------------------------

class PersonCreateView(CreateView):
    model = User
    fields = ('name', 'password', 'email', 'profil')
