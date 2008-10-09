From: Len Brown <lenb@kernel.org>
Subject: Re: Unexpected shutdown - perhaps ACPI related?
Date: Thu, 09 Oct 2008 12:40:49 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810091239150.3007@localhost.localdomain>
References: <4b97db550810080302j79f9001la5a4c06019701131@mail.gmail.com>
 <alpine.LFD.1.10.0810081508180.3041@localhost.localdomain>
 <4b97db550810090440j5815793ar7e09b3fd7a0b141c@mail.gmail.com>
 <200810091503.51617.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:46809 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbYJIQkx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 12:40:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K8H006SWD04VO53@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 09 Oct 2008 11:40:53 -0500 (CDT)
In-reply-to: <200810091503.51617.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Brian Schau <brian.schau@gmail.com>, linux-acpi@vger.kernel.org



On Thu, 9 Oct 2008, Thomas Renninger wrote:

> On Thursday 09 October 2008 13:40:36 Brian Schau wrote:

> > BTW, the system is a dual core 2GHz system.
> >
> > > grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*
> >
> > root@stacy:~# grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*
> > /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
> > /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
> > /proc/acpi/thermal_zone/THRM/state:state:                   ok
> > /proc/acpi/thermal_zone/THRM/temperature:temperature:             73 C
> > /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           104 C
> > grep: /proc/acpi/fan/*/*: No such file or directory

> 73 C is beyond 72 C :)
> 104 sounds as if the HW would switch off before, could still be a thermal 
> issue. Hmm, but the fans seem to be controlled by HW...
> 
> > wrt.to the last line (grep error) - the 'fan' modules is loaded but
> > there are not
> > files present in the /proc/acpi/fan directory.
> >
> > Also, when I see the shutdowns it occurs as you described above - the
> > hardware shutdown.

> Means, the power just gets switched off?
> You should try to reproduce this easier somehow. Heavy battery/thermal 
> reading, switching cpufreq up and down or something?
> How often does that happen?
> If it happens often you could try to exclude/not load ACPI drivers, cpufreq 
> drivers. Switch off C-states. These are good candidates.
> 
> Does this only happen with X?
> Maybe using another X driver (vesa fb) solves it?
> 
> Did this machine ever worked fine with older kernels/distributions?

Also, try running memtest overnight.

cheers,
-Len

