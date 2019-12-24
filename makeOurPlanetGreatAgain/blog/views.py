from django.http import HttpResponse
from django.shortcuts import render, get_object_or_404
from blog.models import User, Project, UserForm, ProjectForm, ConnexionForm
from django.views.generic import CreateView
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponseRedirect
from django.core.mail import send_mail, get_connection
from django.contrib.auth.decorators import login_required, permission_required


import logging
# Permet d'afficher des log
logger = logging.getLogger(__name__)
#logger.error("message")



def home(request):
    connexion = "null"

    # Formulaire de connexion
    if request.method == 'POST':
        form = ConnexionForm(request.POST)
        if form.is_valid():
            cd = form.cleaned_data
            pseudo=request.POST.get('pseudo')
            password=request.POST.get('password')
            user = authenticate(username=pseudo, password= password)
            if user :
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



def deconnexion(request):
    logout(request)
    return home(request)



def lire(request, id, slug):
    user = get_object_or_404(User, id=id, slug=slug)
    return render(request, 'blog/lire.html', {'user':user})


def inscription(request):
	submitted = False
	if request.method == 'POST':
		form = UserForm(request.POST)
		if form.is_valid():
			cd = form.cleaned_data
			pseudo=request.POST.get('pseudo')
			password=request.POST.get('password')
			email=request.POST.get('email')
			profil=request.POST.get('profil')
			expert=request.POST.get('isExpert')
			user = User.objects.create(
				pseudo=pseudo,
				slug=pseudo,
				password=password,
				email=email,
				isExpert=expert,
				profil=profil
			)
			#assert False
			con = get_connection('django.core.mail.backends.console.EmailBackend')
			send_mail(
                 cd['pseudo'],
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


def confirmation(request):
    return render(request, 'blog/confirmation.html')


@login_required(redirect_field_name='redirect_to')
@permission_required('blog.evaluate_project')
def evaluateProject(request, project):
    return render(request, 'blog/confirmation.html')


class PersonCreateView(CreateView):
    model = User
    fields = ('name', 'password', 'email', 'profil')
