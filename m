From: Pau Aliagas <linuxnow-MYlnYO1lEJtAfugRpC6u6w@public.gmane.org>
Subject: Re: [2.6.0-test5-mm1] Suspend to RAM problems
Date: Wed, 10 Sep 2003 18:10:01 +0200 (CEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0309101806480.2528-100000@pau.intranet.ct>
References: <20030910154551.GA1507@rootdir.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030910154551.GA1507-YJlxJerscEeELgA04lAiVw@public.gmane.org>
To: Claas Langbehn <claas-YJlxJerscEeELgA04lAiVw@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew de Quincey <adq-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 10 Sep 2003, Claas Langbehn wrote:

> Patrick Mochel wrote:

> > > 2) ACPI
> > > Thanks to Andrew de Quincey I can boot with ACPI without
> > > problems and I can read out my temp and so on, but when I do
> > >    echo -n "mem" >/sys/power/state 
> > > the machine goes into sleep (STR) but crashes after waking up again.
> > 
> > What exactly does it do on wakeup? 

Mine crashes before suspending. It says something like:
Stoppings tasks
===========================================================
critical region / count pages [XXXXXXXXXXXX]

> When the system sleeps, it the power LED blinks. I call it wake-up
> when the system starts again. I press a key or the power button. Then
> the system beeps once and it comes back...
> 
> > Would you please try the patch at: 
> > http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm2.diff.bz2
> 
> i will try it and report about my experiences later.

I'll give it a try too.

> > >    echo -n "S3" > /proc/acpi/sleep 
> 
> > That should be:
> > 	echo "3" > /proc/acpi/sleep

$ ls /proc/acpi
ac_adapter  battery  dsdt                 event  fan   power_resource  thermal_zone
alarm       button   embedded_controller  fadt   info  processor

> > But, please use the sysfs interface. 

It hangs the computer.

Pau
