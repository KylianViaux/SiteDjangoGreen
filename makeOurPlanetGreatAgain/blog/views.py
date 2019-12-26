from django.http import HttpResponse
from django.shortcuts import render, get_object_or_404
from blog.models import User, Project, UserForm, ProjectForm, ConnexionForm, InvestorLink
from django.views.generic import CreateView
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponseRedirect
from django.core.mail import send_mail, get_connection
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
    connexion = "null"

    # Formulaire de connexion
    if request.method == 'POST':
        form = ConnexionForm(request.POST)
        if form.is_valid():
            cd = form.cleaned_data
            username=request.POST.get('username')
            password=request.POST.get('password')
            user = authenticate(username=username, password= password)
            if user is not None:
                connexion="true"
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
    return render(request, 'blog/accueil.html', {'form' : form, 'derniers_users' : users, 'derniers_project' : project, 'connexion' : connexion })


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
    return render(request, 'blog/voirProjet.html', { 'project':project })

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
			if(request.POST.get('isExpert') == 'On'):
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
@permission_required('blog.evaluate_project')
def evaluateProject(request, project):
    return render(request, 'blog/confirmation.html')

#--------------------------------------------------------------------------------------------------------------------------

class PersonCreateView(CreateView):
    model = User
    fields = ('name', 'password', 'email', 'profil')
