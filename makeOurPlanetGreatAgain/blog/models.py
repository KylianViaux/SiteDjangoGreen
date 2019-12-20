from django.db import models
from django.utils import timezone
from django import forms

# Create your models here.

class User(models.Model):
    pseudo = models.CharField(max_length=30)
    slug = models.SlugField(max_length=100)
    password = models.CharField(max_length=40)
    email = models.CharField(max_length=50)
    profil = models.TextField(null=True)
    dateInscription = models.DateTimeField(default=timezone.now, 
                                verbose_name="Date d'inscription")
    
    class Meta:
        verbose_name = "Utilisateur"
        ordering = ['pseudo']
    
    def __str__(self):
        return self.pseudo



class UserForm(forms.Form):
	pseudo = forms.CharField(max_length=30, label='Pseudo')
	slug = forms.SlugField(max_length=100, label='Slug')
	password = forms.CharField(max_length=40, label='Password')
	confirmationPassword = forms.CharField(max_length=40, label='Confirmation Password')
	email = forms.EmailField(label='Email')
	profil = forms.CharField(required=False, widget=forms.Textarea, label='Profil')
