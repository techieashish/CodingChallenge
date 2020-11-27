from rest_framework import serializers

from .models import Polls


class PollsSerializer(serializers.ModelSerializer):

    class Meta:
        model = Polls
        fields = "__all__"
