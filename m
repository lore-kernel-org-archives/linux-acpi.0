From: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Subject: Re: high pitch noise with kernel 2.6 and ACPI (Dell Inspiron
 8200)
Date: Wed, 18 Feb 2004 21:45:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040218214542.58569565.mike@it-loops.com>
References: <200402181320.29381.mailinglists@glomann.de>
	<1077111155.2028.3.camel@personal-118.mip.sdu.dk>
	<200402182017.47960.mailinglists@glomann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__18_Feb_2004_21_45_42_+0100_k8DYPq7FNm8d0G1R"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402182017.47960.mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
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

--Signature=_Wed__18_Feb_2004_21_45_42_+0100_k8DYPq7FNm8d0G1R
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 18 Feb 2004 20:17:47 +0100
Thomas Glomann <mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org> wrote:

> On Wednesday 18 February 2004 14:32, Mads Paulin wrote:
> > Hi Thomas,
> >
> > funny you mention it, I thought I was going crazy.
> >
> > I experienced the same thing, and discovered it to be the hard drive.
> >
> > Try to spind the drive down using hdparm and see if that helps.
> >
> nope, putting the drive to sleep doesn't do the trick. the sound remains. 
> Moreover I don't see how this "solution" was meant to work? Does the sound 
> reappear when you wake up your disk or does it keep silent after a nice 
> "onetime" sleep?
> > Obviously this is not a solution, but if it helps, kernel 2.6 could have
> > some other way of controlling the disk than 2.4.
> >
> Still it doesn't explain why that sound is gone when disabling the whole 
> acpi-system.
> > The noise disappears when my hdd is under heavy load.
> > - Maybe you just cant here it then, or it actually disappears because it
> > is no longer idle
> >
> well thats true. as long as the disk is Not idle, the noise is gone. But 
> returns right after.
> 
> > Regards
> > Mads
> 
> So any other ideas?

You could try and change HZ from 1000 to 100 in "src/linux/include/asm/param.h"

#ifdef __KERNEL__
# define HZ   1000   <--- change this to 100
# define USER_HZ  100   /* .. some user interfaces are in "ticks" */
# define CLOCKS_PER_SEC (USER_HZ) /* like times() */
#endif

It worked for me and I haven't seen any side effects after changing it.


/Michael


 

--Signature=_Wed__18_Feb_2004_21_45_42_+0100_k8DYPq7FNm8d0G1R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAM8749lrUeNl8Hv8RAgutAJwKK/pWziWSoZnxWvZSUbWExOsNpwCfUPxW
tMrc3/O0UNTYjs29mf4Qdr0=
=js3H
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Feb_2004_21_45_42_+0100_k8DYPq7FNm8d0G1R--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
