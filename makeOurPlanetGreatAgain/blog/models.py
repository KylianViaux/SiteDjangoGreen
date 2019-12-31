from django.db import models
from django.utils import timezone
from django import forms
from django.contrib.auth.models import AbstractUser

# Create your models here.
# https://docs.djangoproject.com/en/3.0/ref/models/fields/

# Custom user model
class User(AbstractUser):
    username = models.CharField(max_length=30, unique=True)
    slug = models.SlugField(max_length=100)
    password = models.CharField(max_length=128)
    email = models.CharField(max_length=50)
    profil = models.TextField(null=True)
    dateInscription = models.DateTimeField(default=timezone.now, verbose_name="Date d'inscription")
    isExpert = models.BooleanField(default=False)
    karma = models.IntegerField(default=0)

    class Meta:
        verbose_name = "Utilisateur"
        ordering = ['username']
    
    def __str__(self):
        return self.username

class UserForm(forms.Form):
	username = forms.CharField(max_length=30, label='Username')
	slug = forms.SlugField(max_length=100, label='Slug')
	password = forms.CharField(max_length=40, label='Password', widget=forms.PasswordInput)
	confirmationPassword = forms.CharField(max_length=40, label='Confirmation Password', widget=forms.PasswordInput)
	email = forms.EmailField(label='Email')
	isExpert = forms.BooleanField(required=False, initial=False, label='**Je suis un expert')
	profil = forms.CharField(required=False, widget=forms.Textarea, label='Profil')


class ConnexionForm(forms.Form):
    username = forms.CharField(max_length=30, label='Username')
    password = forms.CharField(max_length=40, label='Password', widget=forms.PasswordInput)


class Membre(models.Model):
    groupe = models.ForeignKey('Project', on_delete=models.CASCADE)
    personne = models.ForeignKey('User', on_delete=models.CASCADE)

#------------------------------------------------------------------------------------------------------------

#Table pour stocker les images qui seront liées à un projet
class Image(models.Model):
    #list de copyright https://fr.wikipedia.org/wiki/Licence_Creative_Commons
    COPYRIGHT = (
          (1, 'libre'),
          (2, 'propriétaire'),
          (3, 'libre diffusion'),
    )
    nom = models.CharField(max_length=30)
    copyright = models.PositiveSmallIntegerField(choices=COPYRIGHT, default=1,)
    #image = models.ImageField(upload_to='pic_folder/', default = 'pic_folder/')
    description = models.CharField(max_length=255, default="")

class EstLiee(models.Model):
    projet = models.ForeignKey('Project', on_delete=models.CASCADE)
    image = models.ForeignKey('Image', on_delete=models.CASCADE)

#------------------------------------------------------------------------------------------------------------

class Project(models.Model):
    nom = models.CharField(max_length=30)
    listeMembre = models.ManyToManyField(User,through='Membre',through_fields=('groupe', 'personne'))
    budgetActuel = models.IntegerField(default=0)
    budgetCible = models.IntegerField(default=0)
    description = models.CharField(max_length=255, default="")
    listeImage = models.ManyToManyField(Image,through='EstLiee',through_fields=('projet', 'image'))
    datePublication = models.DateTimeField(default=timezone.now,verbose_name="Date de publication")

    def __str__(self):
        return self.nom

    class Meta:
        verbose_name = "Projet"
        ordering = ['datePublication']
        permissions = (
            ("evaluate_project", "Evaluer un projet"),
        )



class ProjectForm(forms.Form):
	nom = forms.CharField(max_length=30, label='Name')
	budgetCible = forms.IntegerField(label='Targeted budget',min_value=10)
	description = forms.CharField(required=False, widget=forms.Textarea, label='description')

#------------------------------------------------------------------------------------------------------------

#Lien entre la table projet et utilisateur pour retrouver tous les investisseurs ainsi que la somme qu'ils ont investi sur chaque projet
class InvestorLink(models.Model):
    idProject = models.ForeignKey('Project', on_delete=models.SET_NULL, null=True)
    idInvestisseur = models.ForeignKey('User', on_delete=models.SET_NULL, null=True)
    contribution = models.IntegerField(default=0)
    derniereTransaction = models.IntegerField(default=0)
    dateTransaction = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return self.contribution



#Lien entre la table projet et utilisateur pour retrouver toutes les notation des experts sur chaque projet
class ExpertNote(models.Model):
    idProject = models.ForeignKey('Project', on_delete=models.CASCADE, null=True)
    idExpert = models.ForeignKey('User', on_delete=models.SET_NULL, null=True)
    noteBudget = models.IntegerField(default=0)
    noteFaisabilite = models.IntegerField(default=0)
    noteUtilite = models.IntegerField(default=0)
    noteGlobale = models.IntegerField(default=0)
    commentaire = models.CharField(max_length=255, default="")


class ExpertForm(forms.Form):
    noteBudget = forms.IntegerField(min_value=0, max_value=10)
    noteFaisabilite = forms.IntegerField(min_value=0, max_value=10)
    noteUtilite = forms.IntegerField(min_value=0, max_value=10)
    commentaire = forms.CharField(max_length=255, widget=forms.Textarea, required=False)

#------------------------------------------------------------------------------------------------------------

class ContactForm(forms.Form):
    contact_name = forms.CharField(required=True)
    contact_email = forms.EmailField(required=True)
    content = forms.CharField(
        required=True,
        widget=forms.Textarea
    )

    # the new bit we're adding
    def __init__(self, *args, **kwargs):
        super(ContactForm, self).__init__(*args, **kwargs)
        self.fields['contact_name'].label = "Your name:"
        self.fields['contact_email'].label = "Your email:"
        self.fields['content'].label = "What do you want to say?"