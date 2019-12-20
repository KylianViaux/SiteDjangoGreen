from django.http import HttpResponse
from django.shortcuts import render, get_object_or_404
from blog.models import User
from blog.models import UserForm
from django.views.generic import CreateView
from django.http import HttpResponseRedirect
from django.core.mail import send_mail, get_connection

def home(request):
	#""" Afficher tous les utilisateurs de notre blog """
	users = User.objects.all()
	return render(request, 'blog/accueil.html', {'derniers_users': users})


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
			user = User.objects.create(
				pseudo=pseudo,
				slug=pseudo,
				password=password,
				email=email,
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
			return HttpResponseRedirect('/inscription?submitted=True')
	else:
		form = UserForm()
		if 'submitted' in request.GET:
			submitted = True
	return render(request, 'blog/inscription.html', {'form':form, 'submitted':submitted})


def confirmation(request):
    return render(request, 'blog/confirmation.html')


class PersonCreateView(CreateView):
    model = User
    fields = ('name', 'password', 'email', 'profil')


""" return HttpResponse("""
"""      
<h1>Bienvenue sur mon blog !</h1>
<p>Les crêpes bretonnes ça tue des mouettes en plein vol !</p>
<p>Tellement c'est bon !<p>
"""""")"""
