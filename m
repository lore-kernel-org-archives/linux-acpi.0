From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: 2.5.69 - S3
Date: Mon, 19 May 2003 10:31:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030519083110.GB130@elf.ucw.cz>
References: <200305140140.02188.mflt1@micrologica.com.hk> <200305182005.30192.mflt1@micrologica.com.hk> <20030518211245.GA452@elf.ucw.cz> <200305191153.51196.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200305191153.51196.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > further, there is mode 5)
> > >
> > >   which is mode 4) _plus_ disk reset fails, and disk won't spin
> > > up again, and kjournald gets mad....
> >
> > Disk reset should never ever fail. Can you try to debug that?\
> 
> It just acts like the drive got removed. 
> 
> IDE bridge HW state must be messed up.
> 
> I'll look into init of IDE after resume and debug that. Any hints
>and pointers are welcome.

I'm not so sure that any IDE init is done upon resume -- which might
be a problem of course. 

> > > and mode 6)
> > >
> > >   System hangs after all tasks left fridge with disk led on.
> > >
> > > I suppose IDE gets false interupt upon resume.
> >
> > Spurious interrupts should be handled gracefully by IDE. On velo I
> > ran my machine with IDE interrupt connected to 1kHz timer, and it
> > more or less worked ("IDE0: spurious interrupt", "Last message
> > repeated 1539 times").
> 
> Cute, Your velo S3 OK (before it died) ? - Do you know of any
>machines that really work with S3?

Velo is mips handheld, there's no ACPI there.

But I have two notebooks and one desktop where S3 works. (More or
less, now I found that there's mtrr problem on second resume on
desktop).

> What do these msgs mean? - never seen anything like this before.
> 
> May 18 17:49:27 mhfl2 kernel:    evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for GPE[FE], disabling event
> May 18 17:49:27 mhfl2 kernel:    evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for GPE[105], disabling event
> May 18 17:49:27 mhfl2 kernel:    evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for GPE[D1], disabling event
> 

I do not know that part of ACPI.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
