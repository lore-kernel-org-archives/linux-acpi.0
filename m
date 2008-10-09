From: Thomas Renninger <trenn@suse.de>
Subject: Re: Unexpected shutdown - perhaps ACPI related?
Date: Thu, 9 Oct 2008 15:03:51 +0200
Message-ID: <200810091503.51617.trenn@suse.de>
References: <4b97db550810080302j79f9001la5a4c06019701131@mail.gmail.com> <alpine.LFD.1.10.0810081508180.3041@localhost.localdomain> <4b97db550810090440j5815793ar7e09b3fd7a0b141c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:48054 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbYJINDx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2008 09:03:53 -0400
In-Reply-To: <4b97db550810090440j5815793ar7e09b3fd7a0b141c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brian Schau <brian.schau@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thursday 09 October 2008 13:40:36 Brian Schau wrote:
> Hi,
>
> > Thomas' guess is a good one.  See if this is thermal related.
> > load your cpu with a copy of "cat /dev/zero > /dev/null
> > for each core.  Listen for fans to speed up,
>
> I did so for 10 minutes and the temperatur never rose beyond 72 deg C.
> I also did some other work during that time.
> I couldn't get it to shutdown ...
>
> BTW, the system is a dual core 2GHz system.
>
> > grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*
>
> root@stacy:~# grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*
> /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
> /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
> /proc/acpi/thermal_zone/THRM/state:state:                   ok
> /proc/acpi/thermal_zone/THRM/temperature:temperature:             73 C
> /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           104 C
> grep: /proc/acpi/fan/*/*: No such file or directory
73 C is beyond 72 C :)
104 sounds as if the HW would switch off before, could still be a thermal 
issue. Hmm, but the fans seem to be controlled by HW...

> wrt.to the last line (grep error) - the 'fan' modules is loaded but
> there are not
> files present in the /proc/acpi/fan directory.
>
> Also, when I see the shutdowns it occurs as you described above - the
> hardware shutdown.
Means, the power just gets switched off?
You should try to reproduce this easier somehow. Heavy battery/thermal 
reading, switching cpufreq up and down or something?
How often does that happen?
If it happens often you could try to exclude/not load ACPI drivers, cpufreq 
drivers. Switch off C-states. These are good candidates.

Does this only happen with X?
Maybe using another X driver (vesa fb) solves it?

Did this machine ever worked fine with older kernels/distributions?

     Thomas
