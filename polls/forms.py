from django import forms
from .models import Polls


class PollsForm(forms.ModelForm):
    parties = [('DOCKER', 'DOCKER'),
               ('PYTHON', 'PYTHON'),
               ('CIRCLECI', 'CIRCLECI'),
               ('KUBERNETES', 'KUBERNETES')]
    party = forms.CharField(widget=forms.Select(choices=parties), required=True)

    class Meta:
        model = Polls
        exclude = ['vote_count']
