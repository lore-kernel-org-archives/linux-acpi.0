From: "Georg C. F. Greve" <greve-BSDwwRMYa8fNLxjTenLetw@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Wed, 21 Jul 2004 10:17:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3acxthizw.fsf@brain.gnuhh.org>
References: <m3d62rzi9a.fsf@brain.gnuhh.org>
	<1090350197.4828.5.camel@tyrosine>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1090350197.4828.5.camel-myFlNLNQP+Q@public.gmane.org> (Matthew Garrett's message of
	"Tue, 20 Jul 2004 20:03:17 +0100")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

 || On Tue, 20 Jul 2004 20:03:17 +0100
 || Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote: 

 >> I just tried a kernel 2.6.8-rc2 with swsusp2-2.0.0.100 and some
 >> other minor patches -- overall with great success. But when I
 >> updated from the ACPI included in the kernel to the acpi-20040715
 >> patch for 2.6.8, suspend to ram does not work anymore: the machine
 >> hangs on resume.

 mg> Do you get any output on the screen at all during resume?

Not with acpi-20040715. The screen remains entirely dead.

In fact my suspicion is that the whole machine has a problem, shutdown
does not work and even after a forced poweroff (keeping the power
button pressed for a while until machine shuts off) the screen is dead
when starting the machine again. I cannot say much more since it does
not even appear to boot.

Only after I took out the battery and took it off power for a while
did the machine come back to life, really.


With older versions, I see a yellow "inu" in the uppermost row for a
second, then the X server comes back up. I should mention at this time
that both DRI and AGP are compiled in and working fine.

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

iD8DBQBA/iaTbvivwoZXSsoRAgOSAJ4+kDll+z+Xvdmt21ez2SZRNbnKwACgvxJ4
B8gHgy+LB0F8BDTV44iYo98=
=F/cz
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
