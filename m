From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: ACPI support for VIA chipsets
Date: Wed, 12 May 2004 14:07:36 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040512110736.GC16712@luna.mooo.com>
References: <200405121520.14811.meaton@vasco.com> <44701.152.91.8.11.1084342478.squirrel@www.dreamcraft.com.au> <200405121626.41883.meaton@vasco.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200405121626.41883.meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, May 12, 2004 at 04:26:34PM +1000, Mark Eaton wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> It works fully under windows so I assume this is more of a we don't fully 
> support it yet (possibly because we don't have specs).
> 
> Oh well, such is life. Hopefully things will improve and I will be able to get 
> full support for this in the near future.
> 

Don't know if you mean S3 (2.6 kernels only) or S4.

There is a problem with power management code for AGP/DRM.

In 2.6 agp PM is not in the kernel yet. There is a patch though. I
don't know where the original is but if you get the swsusp2 patches
from swsusp.sourceforge.org (the development ones), they include that
patch and it is also relevant for S3, not only software suspend.

2.4 has the agp PM code in the kernel.

drm suspend code is another problem. Its in the dri cvs tree, I don't
know if it made it into mainstream. Radeon needs some kernel support, I
think its in 2.6 don't know about 2.4. You also need the cvs drivers
from dri or X 4.4 IIRC.

Just as a test if that is the problem, try using the vesa driver for X
and make sure that the agpgart and radeon drivers aren't loaded and see
if suspend works (or just try from the console in single mode without X
as a start).

> Thanks anyway.
> 
> On Wed, 12 May 2004 04:14 pm, you wrote:
> > You have a radeon video chip. They are notorious for having suspend/resume
> > problems.
> > TMC
> >
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> === Cut ==
> > > 		Status: <OUT OF SPEC>
> > > Handle 0x0017
> > > 	DMI type 127, 4 bytes.
> > > 	End Of Table
> > >
> > >
> > > - --
> > > Mark Eaton
> > > Senior Software Engineer
> > > VASCO The Authentication Company
> > > +67 3511 5404
> > > +67 (0) 403 384 886
> > > meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org
> > > -----BEGIN PGP SIGNATURE-----
> > > Version: GnuPG v1.2.4 (GNU/Linux)
> > >
> > > iD8DBQFAobQCKd93Pkvz/M4RAjmCAJ9KYcrPE8OQjn7yq9KKqF7nFAEtbQCfRucF
> > > lAYSNBBGg/3S28EzXtn1VbM=0nfD
> > > -----END PGP SIGNATURE-----
> > >
> > >
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by Sleepycat Software
> > > Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to
> > > deliver higher performing products faster, at low TCO.
> > > http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> - -- 
> Mark Eaton
> Senior Software Engineer
> VASCO The Authentication Company
> +67 3511 5404
> +67 (0) 403 384 886
> meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFAocOeKd93Pkvz/M4RAmR2AJ4jRCbMsQ8oouPCHkpomblnoGuedACcCZ7a
> HQer1Bu79277S+kHflFH1eI=
> =wbLE
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
> higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
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
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
