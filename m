From: Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
Subject: Re: Snore: BUG in ide-disk on suspend
Date: Tue, 28 Jan 2003 02:24:45 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.10.10301280158400.9272-100000@master.linux-ide.org>
References: <20030120183850.GB530@zaurus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 20 Jan 2003, Pavel Machek wrote:

> Hi!
> 
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
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
           !!!!!!

Pavel,

This very point of uncertain state of the driver really bugs me.


> there should be noone to ask for work to do,

Noone == ??

SMI events by the BIOS or anything ...

> and when there's no work, there should be no
> interrupts.

If you say should and you get on report back that it is not ...
We are in deep crap ...

Also never trust a spec unless you were there to write it and then think
twice and do it once.

The "assume" kills me.

Cheers,

Andre Hedrick
LAD Storage Consulting Group



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
