from django.conf.urls import url, include
from rest_framework import routers
from . import views

app_name = "polls"

router = routers.DefaultRouter()
router.register(r'result', views.PollsViewSet)

urlpatterns = [
    url(r'^api/', include(router.urls), name='api_polls'),
    url(r'^$', views.index, name="index"),
    url(r'^vote$', views.voting, name="voting"),
    url(r'^dashboard$', views.dashboard, name="dashboard"),
    # url(r'^api/polls$', views.polls_dashboard_api, name="api_polls"),
]
