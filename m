From: "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>
Subject: RE: S3 Resume - System Timer Tick fix
Date: Fri, 18 Oct 2002 17:02:08 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1DD88DDBBB83D6119C8C00096BB0408FEC5DBE@USAMCMS5>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-return: allowed
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Pavel,

> 
> This code should go to the place where time is handled, and that place
> should be devicefs-aware so it is called... [I looked through
> arch/i386 and could not find the place. Weird.]
>

 I agree, but also couldn't find the correct place either, but I will find
the correct place (any clues would be helpful).
 
> > diff -urN -X dontdiff linux-2.5.42/drivers/acpi/sleep.c
> > linux-2.5.42_update/drivers/acpi/sleep.c
> > --- linux-2.5.42/drivers/acpi/sleep.c	Sat Oct 12 00:21:03 2002
> > +++ linux-2.5.42_update/drivers/acpi/sleep.c	Mon Oct 
> 14 14:21:23 2002
> > @@ -68,12 +68,18 @@
> >  	/* turn all the devices back on */
> >  	device_resume(RESUME_POWER_ON);
> >  
> > +	/* enable the system timer interrupt */
> > +	acpi_restore_sys_timer();
> > +
> 
> No special exceptions for timer, please.
> 

 Also, I agree, but again need to find the correct place to add the code.

 Thanks for feedback,

  Mike Faraoni

 
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
