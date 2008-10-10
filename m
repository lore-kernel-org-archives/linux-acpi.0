From: "Brian Schau" <brian.schau@gmail.com>
Subject: Re: Unexpected shutdown - perhaps ACPI related?
Date: Fri, 10 Oct 2008 09:58:11 +0200
Message-ID: <4b97db550810100058r4d513732j1248adc293056ca3@mail.gmail.com>
References: <4b97db550810080302j79f9001la5a4c06019701131@mail.gmail.com>
	 <alpine.LFD.1.10.0810081508180.3041@localhost.localdomain>
	 <4b97db550810090440j5815793ar7e09b3fd7a0b141c@mail.gmail.com>
	 <200810091503.51617.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:47942 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYJJH6N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 03:58:13 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1210735ugf.37
        for <linux-acpi@vger.kernel.org>; Fri, 10 Oct 2008 00:58:11 -0700 (PDT)
In-Reply-To: <200810091503.51617.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

>> root@stacy:~# grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*
>> /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
>> /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
>> /proc/acpi/thermal_zone/THRM/state:state:                   ok
>> /proc/acpi/thermal_zone/THRM/temperature:temperature:             73 C
>> /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           104 C
>> grep: /proc/acpi/fan/*/*: No such file or directory
> 73 C is beyond 72 C :)

Sorry, my bad :-)

> 104 sounds as if the HW would switch off before, could still be a thermal
> issue. Hmm, but the fans seem to be controlled by HW...

I am pretty sure it somehow is hardware related.   And as the subject suggests
I am not even sure it is ACPI related (I don't know jack about ACPI so I cannot
identify if it is involved :-)
However, it seems that my laptop is shutting itself off when ACPI is enabled.
(Though, it hasn't done that for almost 2 days now - it's like when
you've been coughing
all night and then when you go to the doctors office you can't cough.
The minute you
step outside the coughing starts again.   Maybe I should stay on the
linux-acpi list :-)

>> Also, when I see the shutdowns it occurs as you described above - the
>> hardware shutdown.
> Means, the power just gets switched off?

Yes.   Just like that.

> You should try to reproduce this easier somehow. Heavy battery/thermal
> reading, switching cpufreq up and down or something?

I will try to create a script which scales the CPU and reads the battery ..

> How often does that happen?

Seldom enough to be easily diagnosed but often enough to be a pain in the a**!

> If it happens often you could try to exclude/not load ACPI drivers, cpufreq
> drivers. Switch off C-states. These are good candidates.

To have a stable system I boot with "apci=off noacpi" will that also
kill the cpufreq
drivers?     Turning off the acpi means I cannot have the machine automatically
turn off when I request a shutdown.   A minor thing I can live with ...
How do I switch off C-states?   (And what does it mean?  :-)

> Does this only happen with X?

So far, yes.  But I am only using X.   If I need to do console work
(which I often
do) I use xterm or gnome-termina.


> Did this machine ever worked fine with older kernels/distributions?

Yes.  I've been an avid slackware user and I never saw these problems.   OTOH
back then I rolled my own kernel and as far as I recall it did have
parts of the ACPI
interface included (primarily the battery interface) ...

/brian
