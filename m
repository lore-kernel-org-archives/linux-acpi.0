From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Still problems with ACPI sleep state
Date: Fri, 2 Jul 2004 14:48:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040702124820.GA18100@elf.ucw.cz>
References: <200406251547.21050.mailinglisten@merula.de> <1088172763.1918.1.camel@camel> <20040625211440.P5510@root.org> <1088254830.4302.1.camel@tyrosine> <20040626120209.Y12968@root.org> <20040629213316.GN698@openzaurus.ucw.cz> <20040701123732.C48321@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040701123732.C48321-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > It tries to reinitialise the video bios after resume. This sometimes
> > > > helps get some amount of video functionality back. The actual sleep and
> > > > resume process is identical other than that.
> > >
> > > I see.  I didn't know if it was something else.  This is just the lcall
> > > hack.  We do that too:
> > >
> > >         /* Re-initialize video BIOS if the reset_video tunable is set. */
> > >         cmp     _0,reset_video
> > >         je      wakeup_16_gdt
> > >         lcall   _0xc000,_3
> > >
> >
> > Who is "we"? Do you have any other usefull hacks?
> > (we have second one trying to change the video mode)
> 
> We == FreeBSD.  I don't think your int 10h video hack helps so we don't
> use it.  Do you know of a system that it helps?

Toshiba 4030cdt notebook. Its VGA is in default text mode... which is
bad if you are trying to use vesafb. int 10 fixes it.

> As far as getting suspend/resume to work, I'm very suspicious
> of the disable bus mastering call in AcpiEnterSleepState.  It's known to
> cause laptops (IBM T40) not to enter S5.  That's why it's currently only
> enabled for sleep states other than S5.  I suspect it may affect S4 and
> possible S3 also.
> 
> Could you give me a quick summary of how linux sets up its drivers for
> suspend/resume?  I've found a Dell where Linux S3 works but FreeBSD's does
> not.  Even with all the drivers removed, it "bounces" back to life instead
> of going to sleep in FreeBSD.  It doesn't crash though.  For

Do you enable proper GPEs? I'm not ACPI wizard but I heard something
like that.

> suspend/resume, we save/restore the PCI BARs for the drivers and then let
> the drivers save their own private state.  Is there anything else you know
> of that would cause this "bounce"?  It happens even with no drivers
> installed except for ATA and all removable hw removed.

We do PCI BARs too (but started doing that only recently), plus many
drivers have specific things they do...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
