From: Len Brown <lenb@kernel.org>
Subject: Re: Unexpected shutdown - perhaps ACPI related?
Date: Wed, 08 Oct 2008 15:14:05 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810081508180.3041@localhost.localdomain>
References: <4b97db550810080302j79f9001la5a4c06019701131@mail.gmail.com>
 <200810081223.20536.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:62017 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbYJHTOS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 15:14:18 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8F00J4UPFIBNI5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 08 Oct 2008 14:14:07 -0500 (CDT)
In-reply-to: <200810081223.20536.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Brian Schau <brian.schau@gmail.com>, linux-acpi@vger.kernel.org



On Wed, 8 Oct 2008, Thomas Renninger wrote:

> On Wednesday 08 October 2008 12:02:09 Brian Schau wrote:
> > Hello,
> >
> > I am seeing strange behaviour on my laptop.   I've been running
> > diverse distributions (OpenSUSE, Ubuntu and others) - my
> > current being gOS 3.0 gadgets.
> > No matter the distribution I see unexpected shutdowns!   That is - one
> > second I work, the other I don't.    The laptop shuts
> > itself off without any prior notice.

Is this a hardware poweroff, or a software poweroff?
Hardware poweroff would be sudden light's out -- often
you can hear the disk make a funny sound.
This is what would happen if you have no mattery and
you yank out the A/C.

Software poweroff would be something that invoked shutdown
command, and thus you'd see it in the logs at Thomas' suggested.

Thomas' guess is a good one.  See if this is thermal related.
load your cpu with a copy of "cat /dev/zero > /dev/null"
for each core.  Listen for fans to speed up,
watch the temperature files 
and see if they change.
see at what temperature the shutdown occurs.

For that matter, what temperature is it set to shutdown at? --
please respond with

grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*

thanks,
-Len

> > If I disable ACPI the unexpected shutdown disappears (and I loose a
> > bunch of other good stuff :-(
> >
> > I don't know how to diagnose this further so I am asking for help here.
> >
> > For starters I've attached the output from lsusb and lspci.
> >
> > I am running kernel 2.6.24-19.
> >
> > How to proceed?   I am willing to test ... :-)
> 
> Are this critical thermal shutdowns?
> grep -i critical /var/log/messages
> should reveal that.
> If yes:
>   - watch your fan/temperature states:
>     /proc/acpi/{thermal_zone,fan}
>   - Does cpufreq work?
>   - Maybe
>     echo 15 >/proc/acpi/thermal_zone/*/polling_frequency
>     helps then?
> 
>      Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
