From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: More seq-file fixes for /proc/acpi
Date: Fri, 14 Feb 2003 22:34:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030214213421.GG23589@atrey.karlin.mff.cuni.cz>
References: <20030213223900.GA141@elf.ucw.cz> <3E4D5D36.4080100@prairienet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E4D5D36.4080100-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Cc: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >More seq-file fixes. [This is not a dup ;-)] Toshiba maintainer,
> >please fix your stuff yourself. This should fix all /proc write
> >problems in acpi I know... Please apply,
> 
> >--- clean/drivers/acpi/toshiba_acpi.c	2003-02-11 17:40:46.000000000 +0100
> >+++ linux/drivers/acpi/toshiba_acpi.c	2003-02-13 23:17:16.000000000 +0100
> >@@ -519,6 +519,7 @@
> > 	if (proc) {
> > 		proc->proc_fops = &toshiba_lcd_fops;
> > 		proc->proc_fops->write = proc_write_lcd;
> >+#warning You need to fix up after converting to seq_file; see thermal.c 
> >for examples.
> > 	}
> > 
> > 	proc = create_proc_entry(PROC_VIDEO, S_IFREG | S_IRUGO | S_IWUSR,
> >
> 
> I take exception to this.  The person who converted my driver to 
> seq_file should be responsible for finishing the job.

> I disagreed with the conversion to seq_file because it doesn't support 
> an object oriented programming style, as I explained in a posting at the 
> time the conversion took place.

Okay, find whoever did seq_file conversion, lock him into room and
give him no pizza until he fixes it... 

							Pavel
PS: Or just post patch that reverses seq_file for toshiba_acpi....

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
