From: "Georg C. F. Greve" <greve-BSDwwRMYa8fNLxjTenLetw@public.gmane.org>
Subject: acpi-20040715: functional regression on ASUS M2N
Date: Tue, 20 Jul 2004 01:31:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3d62rzi9a.fsf@brain.gnuhh.org>
Reply-To: "Georg C. F. Greve" <greve-BSDwwRMYa8fNLxjTenLetw@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--=-=-=

Hi all,

I just tried a kernel 2.6.8-rc2 with swsusp2-2.0.0.100 and some other
minor patches -- overall with great success. But when I updated from
the ACPI included in the kernel to the acpi-20040715 patch for 2.6.8,
suspend to ram does not work anymore: the machine hangs on resume.

Except for the network cards, which are broken after resume from S3,
it otherwise works fine for the previous ACPI versions with kernel
2.6.7 and kernel 2.6.8 -- which are the first kernels for which this
is true.

This is on an ASUS M2N with intel 855GM Centrino chipset, running the
Debian GNU/Linux distribution.

If you need more info, let me know.

Regards,
Georg

-- 
Georg C. F. Greve                                 <greve-BSDwwRMYa8fNLxjTenLetw@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
GNU Business Network                        (http://mailman.gnubiz.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA/FnZbvivwoZXSsoRAhq2AJ9IQSVoBAI5cef3vzY3o6FGYUTUFwCgqx1b
UcfUAaJhx5CUTdTUbkGgKnU=
=7tlO
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
