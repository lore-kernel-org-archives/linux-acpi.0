From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Snore: BUG in ide-disk on suspend
Date: Mon, 20 Jan 2003 19:38:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030120183850.GB530@zaurus>
References: <200301152234.26117.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200301152234.26117.p_christ-U04EIuiosng@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> drivers/ide/ide-disk.c: (around 1557)
>         printk(KERN_INFO "suspending: %s ", drive->name);
>         do_idedisk_standby(drive);
>         drive->blocked = 1;
> 
> 	BUG_ON (HWGROUP(drive)->handler);
> 
> AFAIK handler is set whenever an irq is being handled (correct me if I'm 
> wrong). ide irqs are very often on the system and may happen between the 
> actual call to 'ide_do_cmd' (called by do_idedisk_standby) and the 
> "blocked=1" line. 

blocked=1 is basically sanity check; not critical.

Userland should not be alive at this point, so
there should be noone to ask for work to do,
and when there's no work, there should be no
interrupts.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
