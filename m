From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: Thread mutex errors / out of memory errors
Date: Tue, 12 Nov 2002 17:24:28 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476BA28@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I don't know.  If you can send me a patch that reverts the
ACPI_WAIT_FOREVER changes, I'll be glad to retest with it.  I don't have
an older tree.

Regards,
John

> -----Original Message-----
> From: Moore, Robert [mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Tuesday, November 12, 2002 10:02 AM
> To: Cagle, John (ISS-Houston); Grover, Andrew
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] Thread mutex errors / out of memory errors
>=20
> Did the Mutex AE_ERROR exceptions start happening with the=20
> ACPI_WAIT_FOREVER patch?
>=20
> I would guess that the error is coming from acpi_os_wait_semaphore:
>=20
> 		/*
> 		 * Wait Indefinitely:
> 		 * ------------------
> 		 */
> 		case WAIT_FOREVER:
> 		ret =3D down_interruptible(sem);
> 		if (ret < 0)
> 			status =3D AE_ERROR;
> 		break;
>=20
> Bob


-------------------------------------------------------
This sf.net email is sponsored by: 
To learn the basics of securing your web site with SSL, 
click here to get a FREE TRIAL of a Thawte Server Certificate: 
http://www.gothawte.com/rd522.html
