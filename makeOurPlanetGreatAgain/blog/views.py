from django.http import HttpResponse
from django.shortcuts import render, get_object_or_404
from blog.models import User
from django.views.generic import CreateView

def home(request):
	#""" Afficher tous les utilisateurs de notre blog """
	users = User.objects.all()
	return render(request, 'blog/accueil.html', {'derniers_users': users})


def lire(request, id, slug):
    user = get_object_or_404(User, id=id, slug=slug)
    return render(request, 'blog/lire.html', {'user':user})


def inscription(request):
  	return render(request, 'blog/inscription.html')


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
