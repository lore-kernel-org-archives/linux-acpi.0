From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Snore: BUG in ide-disk on suspend
Date: Tue, 28 Jan 2003 20:24:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301282024.20100.p_christ@hol.gr>
References: <200301152234.26117.p_christ@hol.gr> <20030120183850.GB530@zaurus>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030120183850.GB530-XqDnSF8rrUM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > drivers/ide/ide-disk.c: (around 1557)
> >         printk(KERN_INFO "suspending: %s ", drive->name);
> >         do_idedisk_standby(drive);
> >         drive->blocked = 1;
> >
> > 	BUG_ON (HWGROUP(drive)->handler);
> >
> > AFAIK handler is set whenever an irq is being handled (correct me if I'm
> > wrong). ide irqs are very often on the system and may happen between the
> > actual call to 'ide_do_cmd' (called by do_idedisk_standby) and the
> > "blocked=1" line.
>
> blocked=1 is basically sanity check; not critical.
>
> Userland should not be alive at this point, so
> there should be noone to ask for work to do,
> and when there's no work, there should be no
> interrupts.

noone:  I can thing of 2 already:
1. hw interrupts: Is there a case that a device (even IDE itself, having some 
result from previous transaction) will cause a system-land series of 
interrupts?
2. That devious 'printk' ! The syslog has to write to the log..

After little more testing, I noticed that the offending IRQ is more probable 
if a cdrom is in my drive (secondary IDE bus, when mounted it gets even more 
likely).
For some reason[1] 2.5.57 doesn't seem[2] to have that bug.

Thanks.

[1] after a rapid scan through the suspend code, I haven't noticed any changes 
since then. However, any unrelated event could cause a disk activity..

[2] 2.5.58 fails at 1st or 2nd (in a single boot) time I attempt to sleep it. 
2.5.57 has run for weeks w/o trouble.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
