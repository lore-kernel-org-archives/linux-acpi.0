From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Still problems with ACPI sleep state
Date: Thu, 1 Jul 2004 12:42:29 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040701123732.C48321@root.org>
References: <200406251547.21050.mailinglisten@merula.de> <1088172763.1918.1.camel@camel>
 <20040625211440.P5510@root.org> <1088254830.4302.1.camel@tyrosine>
 <20040626120209.Y12968@root.org> <20040629213316.GN698@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040629213316.GN698-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 29 Jun 2004, Pavel Machek wrote:
> > > > Could someone familiar with Linux let me know what s3_bios does
> > > > differently from a normal S3?
> > >
> > > It tries to reinitialise the video bios after resume. This sometimes
> > > helps get some amount of video functionality back. The actual sleep and
> > > resume process is identical other than that.
> >
> > I see.  I didn't know if it was something else.  This is just the lcall
> > hack.  We do that too:
> >
> >         /* Re-initialize video BIOS if the reset_video tunable is set. */
> >         cmp     _0,reset_video
> >         je      wakeup_16_gdt
> >         lcall   _0xc000,_3
> >
>
> Who is "we"? Do you have any other usefull hacks?
> (we have second one trying to change the video mode)

We == FreeBSD.  I don't think your int 10h video hack helps so we don't
use it.  Do you know of a system that it helps?

As far as getting suspend/resume to work, I'm very suspicious
of the disable bus mastering call in AcpiEnterSleepState.  It's known to
cause laptops (IBM T40) not to enter S5.  That's why it's currently only
enabled for sleep states other than S5.  I suspect it may affect S4 and
possible S3 also.

Could you give me a quick summary of how linux sets up its drivers for
suspend/resume?  I've found a Dell where Linux S3 works but FreeBSD's does
not.  Even with all the drivers removed, it "bounces" back to life instead
of going to sleep in FreeBSD.  It doesn't crash though.  For
suspend/resume, we save/restore the PCI BARs for the drivers and then let
the drivers save their own private state.  Is there anything else you know
of that would cause this "bounce"?  It happens even with no drivers
installed except for ATA and all removable hw removed.

-Nate


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
