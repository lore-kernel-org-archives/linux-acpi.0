From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: [2.6.0-test5-mm1] Suspend to RAM problems
Date: Wed, 10 Sep 2003 08:33:21 -0700 (PDT)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.33.0309100829470.1012-100000@localhost.localdomain>
References: <20030910103142.GA1053@rootdir.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030910103142.GA1053-YJlxJerscEeELgA04lAiVw@public.gmane.org>
To: Claas Langbehn <claas-YJlxJerscEeELgA04lAiVw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew de Quincey <adq-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> I have got kernel 2.6.0-test5-mm1 on an Epox 8k9a9i Mainboard with
> KT400A and an Nvidia FX5200 using the nvidia-module and drivers.
> I use only onboard IDE and onboard ethernet.
> 
> I want to be able to use Suspend to RAM with my machine. I tried
> APM and ACPI, both with no success. I also tried with no X11.

> 1.) APM:   (ACPI follows...)
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)

It's likely that if your system supports ACPI, the APM implementation will 
not work, especially if you boot with ACPI enabled. 

> 2) ACPI
> Thanks to Andrew de Quincey I can boot with ACPI without
> problems and I can read out my temp and so on, but when I do
>    echo -n "mem" >/sys/power/state 
> the machine goes into sleep (STR) but crashes after waking up again.

What exactly does it do on wakeup? 

Would you please try the patch at: 

http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm2.diff.bz2

against 2.6.0-test5 and report whether or not it works? 

Also, please try removing all modules before suspending and reinserting 
them after resuming. 

Do you have any of the following enabled: 

SMP?

Preempt?

APIC? 


> And an
>    echo -n "S3" > /proc/acpi/sleep 

That should be:

	echo "3" > /proc/acpi/sleep

But, please use the sysfs interface. 


Thanks,


	Pat
