From: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Subject: Re: 2.5.69 - S3
Date: Mon, 19 May 2003 11:53:50 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305191153.51196.mflt1@micrologica.com.hk>
References: <200305140140.02188.mflt1@micrologica.com.hk> <200305182005.30192.mflt1@micrologica.com.hk> <20030518211245.GA452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030518211245.GA452-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 19 May 2003 05:12, Pavel Machek wrote:
> Hi!
>
> > > > > > Was playing a bit with S3 - Single user mode, console,
> > > > > > ACPI core only, no modules.
> > > > > >
> > > > > > Suspending always works.
> > > > > >
> > > > > > Resuming performs somewhat randomly as follows:
> > > > > >
> > > > > > 1) Linux! - hang
> > > > > >
> > > > > > 2) Resume failed
> > > > > >
> > > > > > 3) Resumes with lots of shell prompts scrolling, and
> > > > > > seems to be functional thereafter
> > > > > >
> > > > > > What is the expected behaviour at this time?
> > > > >
> > > > > 3) is expected. You held down enter
> > > > > when you did echo, so it still sees
> > > > > enter down after resume.
> > > >
> > > > Thank you,  a script which delays a few seconds before
> > > > suspend should fix 3)
> > > >
> > > > How to get rid of 1) and 2) ?
> > >
> > > For 4) (harddisk problems from other mail): does it work after
> > > IDE reset? If not, try disabling DMA with hdparm.
> >
> > Seems to work after hard disk reset. Problem seems to depend on
> > disk activity.
>
> Okay, so it works when you are lucky.
>
> > > As for 1) and 2): Good luck debugging 1) [adding more letters
> > > to see where it hangs etc];
> >
> > The disk LED stays on, so perhaps it hangs in IDE.
> >
> > > what exactly means 2)?
> >
> >   This is Toshiba BIOS message. System does cold reboot
> > thereafter.
>
> There's not much I can do about this one. Perhaps toshiba bios does
> something stupid with disk during resume and needs to have it in
> some particular state? But then, after S3, disk should be powering
> up...

It aborts resume here, so something must make it believe that resume state is bad. 

IMHO has nothing to do with disk as it is just after reset and display init.

Lets worry about IDE first. Pattern indicates that init of IDE upon resume is at fault.

> > further, there is mode 5)
> >
> >   which is mode 4) _plus_ disk reset fails, and disk won't spin
> > up again, and kjournald gets mad....
>
> Disk reset should never ever fail. Can you try to debug that?\

It just acts like the drive got removed. 

IDE bridge HW state must be messed up.

I'll look into init of IDE after resume and debug that. Any hints and pointers are welcome.

>
> > and mode 6)
> >
> >   System hangs after all tasks left fridge with disk led on.
> >
> > I suppose IDE gets false interupt upon resume.
>
> Spurious interrupts should be handled gracefully by IDE. On velo I
> ran my machine with IDE interrupt connected to 1kHz timer, and it
> more or less worked ("IDE0: spurious interrupt", "Last message
> repeated 1539 times").

Cute, Your velo S3 OK (before it died) ? - Do you know of any machines that really work with S3?

What do these msgs mean? - never seen anything like this before.

May 18 17:49:27 mhfl2 kernel:    evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for GPE[FE], disabling event
May 18 17:49:27 mhfl2 kernel:    evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for GPE[105], disabling event
May 18 17:49:27 mhfl2 kernel:    evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for GPE[D1], disabling event

Regards
Michael


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
