From: Richard Harman <acpi+nospam-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>
Subject: Re: Compaq Evo N600c DSDT woes
Date: Mon, 25 Nov 2002 21:19:00 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211260219.gAQ2J0h10186@localhost.localdomain>
References: <20021125234411.GE833@yggdras.agere.com>
Reply-To: Richard Harman <acpi+nospam-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Mon, 25 Nov 2002 18:44:11 EST."
             <20021125234411.GE833-OCtGrgxsRvDJaGQldrLmRgC/G2K4zDHf@public.gmane.org>
Content-ID: <10184.1038277140.1-SHbU9qxUxng@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jocelyn Jaubert <jaubert-6bugY6I12JBBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Actually I recently (just last night to be exact) updated the BIOS.  It's a real pain if the laptop has a really old BIOS (before 10/17/2001) -- you have to download a program designed to run in Windows NT logon scripts; it it installs various software patches/updates, with the bios being one of them.  Only then was I able to use the standard flash program.  Updating the bios didn't help the DSDT problems much, but I'll try changing linux/drivers/acpi/acpi_drivers.h.

Thanks!

---------------------------------------------------
Richard G Harman Jr <acpi+nospam-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>


  Quoted from Jocelyn Jaubert:

> On 2002.11.25 13:31 Richard Harman wrote:
> > I read through the archives about the Bios Override procedure
> > (http://www.intel.com/technology/iapc/acpi/bios_override.htm) and how
> > to fix some of the common DSDT problems "*PNPFOO" v.s. "PNPFOO".  Did
> > that.  I also saw somebody else had a N600c, but no fixed DSDT as far
> > as I could tell.  I'm still getting errors from the iasl compiler,
> > because I don't have any clue about the AML language (willing and
> > eager to learn though).  Do I need to go download the AML docs in pdf
> > and figure out what I need to "fix" based on what my hardware is?
> 
> I have the same laptop, and followed the advice of Duncan Gibb. I 
> modified my linux/drivers/acpi/acpi_drivers.h, replacing each PNP... 
> with *PNP... I then recompiled the kernel. 
> I know it's not really clean, but it works (even if I can only throttle 
> my CPU speed).
> 
> Somebody told about updating the BIOS, taking a newer one from Compaq. 
> Maybe you should try it ?
> 
> -- 
> Jocelyn Jaubert
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Get the new Palm Tungsten T 
> handheld. Power & Color in a compact size! 
> http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
