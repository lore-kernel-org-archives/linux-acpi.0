From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: Thread mutex errors / out of memory errors
Date: Sat, 16 Nov 2002 10:12:13 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E30C@cceexc19.americas.cpqcorp.net>
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

I have retested this with the ACPI_WAIT_FOREVER patch removed,
and I'm still seeing the AE_ERROR exceptions:

utmisc-0700 [-58] Ut_acquire_mutex:
 Thread 4C3 could not acquire Mutex [ACPI_MTX_Caches] AE_ERROR

So I don't think they were caused by the patch.  Sorry this
took a few days to test -- I've been out of town.

Regards,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux

> -----Original Message-----
> From: Moore, Robert [mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Tuesday, November 12, 2002 10:02 AM
> To: Cagle, John (ISS-Houston); Grover, Andrew
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] Thread mutex errors / out of memory errors
>=20
>=20
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
>=20
>=20
> -----Original Message-----
> From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]=20
> Sent: Monday, November 11, 2002 3:18 PM
> To: Grover, Andrew
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Thread mutex errors / out of memory errors
>=20
> Andy,
>=20
> In my testing of the power button support in your 2.4 acpi=20
> tree, I occasionally encounter errors similar to these:
>=20
> utmisc-0700 [03] Ut_acquire_mutex      : Thread 41B could not acquire
> Mutex [ACPI_MTX_Caches] AE_ERROR
> utmisc-0700 [-2] Ut_acquire_mutex      : Thread 420 could not acquire
> Mutex [ACPI_MTX_Caches] AE_ERROR
> dsutils-0463: *** Error: Could not allocate an object descriptor
> dsutils-0549 [-5] Ds_create_operands    : While creating Arg 1 -
> AE_NO_MEMORY
> evevent-0816: *** Error: AE_NO_MEMORY while evaluating GPE4 method
> utmisc-0700 [-13] Ut_acquire_mutex      : Thread 437 could not acquire
> Mutex [ACPI_MTX_Caches] AE_ERROR
> utmisc-0700 [-5] Ut_acquire_mutex      : Thread 43F could not acquire
> Mutex [ACPI_MTX_Caches] AE_ERROR
> utmisc-0700 [-146] Ut_acquire_mutex      : Thread 497 could=20
> not acquire
> Mutex [ACPI_MTX_Caches] AE_ERROR
>=20
> These errors typically occur during event processing (ie.=20
> when I press the power button while cat'ing=20
> /proc/acpi/event).  The Mutex errors do not appear to affect=20
> button events, but the AE_NO_MEMORY errors are fatal (all=20
> button event processing dies).
>=20
> BTW, my kernel has your ACPI_WAIT_FOREVER mutex patch applied.
>=20
> Have you seen these errors before?  I am happy to do further=20
> testing if you can suggest where I should add debug code...
>=20
> Thanks,
> John


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
