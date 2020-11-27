from django.shortcuts import render, redirect, get_list_or_404
from django.http import JsonResponse
from .models import Polls
from .forms import PollsForm
import json
import logging
from rest_framework import viewsets
from .serializers import PollsSerializer


logger = logging.getLogger(__name__)


def index(request):
    return render(request=request, template_name="base.html")


def voting(request):
    poll_form = PollsForm(request.POST or None)
    if poll_form.is_valid():
        poll, _ = Polls.objects.get_or_create(party=poll_form.cleaned_data.get("party"))
        poll.vote_count += 1
        poll.save()
        return redirect("polls:dashboard")
    return render(request=request, template_name='generic_form.html', context={'form': poll_form})


def dashboard(request):
    polls_data = Polls.objects.all().values('party', 'vote_count')
    return render(request=request, template_name="dashboard.html",
                  context={'entries': polls_data, 'headings': ["Party", "Vote"]})


# def polls_dashboard_api(request):
#     polls_data = Polls.objects.all().values('party', 'vote_count')
#     return JsonResponse(data={"polls": json.dumps(list(polls_data))})


class PollsViewSet(viewsets.ModelViewSet):
    queryset = Polls.objects.all()
    serializer_class = PollsSerializer