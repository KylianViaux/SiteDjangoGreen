"""makeOurPlanetGreatAgain URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from blog import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('accueil', views.home, name='accueil'),
    path('user/<int:id>-<slug:slug>', views.lire, name='lire'),
    path('projectId/<int:id>', views.voirProjet, name='projectId'),
    path('inscription', views.inscription, name='inscription'),
    path('donate/<int:id>-<int:contribution>', views.donate, name='donate'),
    path('createProject', views.createProject, name='createProject'),
    path('deconnexion', views.deconnexion, name='deconnexion'),
    path('confirmation', views.confirmation, name='confirmation')
]
