From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake howto was: RE: [BKPATCH] ACPI for 2.6
Date: Thu, 1 Apr 2004 02:38:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040401003823.GB9382@luna.mooo.com>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com> <20040330233155.463A.COUNT0@localnet.com> <20040331105851.GA11223@pc-math-vis1>
	 <406AB9DA.7020805@pca.it>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <406AB9DA.7020805-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 31, 2004 at 02:30:18PM +0200, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> on 03/31/04 12:58, Micha Feigin wrote:
> > The problem with 2.6 is that the power management (PM) code is only
> > partly implemented. It doesn't exist at all for agp and dri AFAIK it
> > doesn't exist for usb and is partial for the rest of the
> > stuff. Probably months before it will be fixed and if you want to hack
> > into things that is the first place to start in order to try and get
> > things working.
> IMHO this is wrong for different reasons:
> 
> 1) the latest AGP and DRI driver for my ATI Radeon Mobility NP M10/9600 works
>    great on my ASUS M6842NWH (Centrino) at least for S1 [1] (I haven't had
>    time to test S3/S4 yet), so this means that there's PM support for some
>    AGP/DRI drivers... BTW, to answer Huw about ATI drivers, I use the
>    *open-source* DRI ones [2] and they work perfect but 3D/OpenGL (which I don't
>    use as I don't have time to play): I can have dual-head (LCD 1400x1050 and
>    CRT 1600x1200), clone mode, Xinerama or MergedFB and DVD full screen...
> 

There very definitely is no PM support for dri and agp. Maybe S1 leaves
things awake enough so PM is not needed. If things still work with S4
it will be a different issue.

> 2) the same new 2.6 'radeonfb' driver has PM implementations, even if it needs
>    more work, as reported in this list ([3] and [4])
> 
> 3) USB *has* working PM support at least in 2.6.5-rc2 [5] (search for
>    "[PATCH] USB: Enable interrupts in UHCI after PM resume")
> 

AFAIK USB PM support is still partial. Works for some people fails for
others. Depends on your luck,

> 4) AFAIK some ALSA driver can suspend/resume [6]
> 

Like you said, only some of them.

> 5) I don't know a lot about network driver, but I know of PM implementations [7]
>    on 'e1000' and 'ipw2100' drivers and during my tests, I never remove the
>    'bcm5700' module (and this doens't cause any resuming problem)
> 

Most onboard will work, thats true.

Also AFAIK scsi and pcmcia still have no PM support.

> Thx, bye,
> Gismo / Luca
> 
> =====
> References:
> 1- http://marc.theaimsgroup.com/?l=acpi4linux&m=107989959514312&w=2
> 2- http://dri.sourceforge.net/cgi-bin/moin.cgi/ATIRadeon
> 3- http://marc.theaimsgroup.com/?l=acpi4linux&m=107731507729859&w=2
> 4- http://marc.theaimsgroup.com/?l=acpi4linux&m=107752252801966&w=2
> 5- ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.5-rc2
> 6- http://sourceforge.net/mailarchive/forum.php?thread_id=4107033&forum_id=1752
> 7- http://sourceforge.net/mailarchive/forum.php?thread_id=4075032&forum_id=38938
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQFAarnaVAp7Xm10JmkRAkBYAKCD2c0RMU86Pbnb59YbgKs1zyeafQCbBPM4
> xh2ota1KMneGFg3G4f0XUIE=
> =e0Kd
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
