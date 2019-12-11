from django.db import models
from django.utils import timezone

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
