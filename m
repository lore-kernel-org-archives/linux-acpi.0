From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] s3_bios and lcall $0xc000,$3
Date: Tue, 18 Feb 2003 01:02:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030218000206.GC7372@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.33.0302171423290.21415-100000@godzilla.axis.se> <Pine.LNX.4.33.0302171647410.21415-100000@godzilla.axis.se> <20030217171610.GC25625@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030217171610.GC25625-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > I'm guessing that the bios call corrupt some data segment pointers, because 
> > > if I print out any of the real_save_* values, they are all zero! WHich 
> > > obviously causes a crash when you load up a zero GDT, zero CR0, zero CR4 
> > > etc... 
> > 
> > Yup - the s3_bios triggered lcall corrupts DS (and possibly SS) as well. CS 
> > is still alive though so redoing the CS->DS duplicating worked.. the 
> > following is not in patch format but you get the idea :)
> > 
> > 	lcall   $0xc000,$3
> > 
> > +       # reset the data and stack segments after possible bios tampering
> > +       movw    %cs, %ax
> > +       movw    %ax, %ds
> > +       movw    %ax, %ss
> > 
> > So now S3 resume works on the travelmate 630! :)

Applied.

> > However, the IDE system (using DMA) seems to not survive the resume. WHat is 
> > the current status of fixing that ? (kernel 2.5.61)

I do hdparm -d 0 before suspend...

> IMO this lcall should not be used at all.  This is used by the
> BIOS only on POST stage in order to setup the VGA subsystem (not
> reinitialize, which was first intented, I guess).

Yes that lcall is a hack. No I do not know a better way. Yes I need it
on the s**o system.

> Actually, everything can happen, as to setup the MCH in order
> to expose the VGA shadowing for example, which is completely
> wrong at this stage, or else, kaboom.
> 
> Then, providing a workaround in order to prevent the kaboom
> can work for you, but not for others.
> Hum this workaround do not work for you?  Try this one.
> But kill others.

I need lcall on the s**o system, and I need to reset video mode on
toshiba 4030cdt.

> Worst, in case of s4bios, since the whole POST is done
> (and because I use the same wakeup code), then
> we already know that the lcall is done.  Then, do I have to
> provide a different wakeup code just for s4bios?

OTOH you know you need to reset the video mode, right? So I'd do
save_acpi_flags = acpi_flags; acpi_flags = 1; just before suspend and
acpi_flags = save_acpi_flags after that, or add parameter to
copy_wakeup_routine.

> Pavel, really, we need to provide a better way to reinitialize
> the VGA subsystem.

But ... can we do it without in-kernel support for all the videocards?

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
