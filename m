From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Tue, 27 Jul 2004 15:40:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3k6wpmutz.fsf@reason.gnu-hamburg>
References: <m3d62rzi9a.fsf@brain.gnuhh.org>
	<1090350197.4828.5.camel@tyrosine> <m3acxthizw.fsf@brain.gnuhh.org>
	<m3oem1u2gg.fsf@reason.gnu-hamburg>
	<1090927462.4412.26.camel@tyrosine>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1090927462.4412.26.camel-myFlNLNQP+Q@public.gmane.org> (Matthew Garrett's message of
	"Tue, 27 Jul 2004 12:24:22 +0100")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

 || On Tue, 27 Jul 2004 12:24:22 +0100
 || Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote: 

 >> Which narrows the problem down to patch (b) as the one breaking
 >> suspend to ram on ASUS M2N. Hope this helps tracking things down.

 mg> Can you try doing the following:

 mg> 1) Open arch/i386/kernel/time.c
 mg> 2) Find sysdev_class pit_sysclass
 mg> 3) Change 

 mg> .resume = time_resume,
 mg> to
 mg> // .resume = time_resume,
 mg> 4) Rebuild the kernel

Tried it. No effect.

Did not change anything as far as I could tell. Problem persists.


 mg> You'll need to change your resume script to do a hwclock
 mg> --hwtosys once the system comes back up.

I've actually always had that. :)


 mg> If this works then it's the same problem that
 mg> I have - I have no idea what's causing it.

It seems to be a different problem, then.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBltpbvivwoZXSsoRAo8lAKC6/FwDZjhUFdvxyHX3V1M6oo8ncACeOGxJ
tRnsfCvDmTdq2Wc1MLfsuPI=
=0Adj
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
