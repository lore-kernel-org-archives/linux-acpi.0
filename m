From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: dri-resume XFree86
Date: Thu, 5 Sep 2002 21:29:08 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020906032912.16913.qmail@scrye.com>
References: <20020903093612.GC27884@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "\"Charl P. Botha\"" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Charl" == Charl P Botha <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org> writes:

Charl> Dear lists, Is anyone else using the new dri-resume
Charl> binaries/patches at http://cpbotha.net/dri_resume.html ?  These
Charl> are different (read: improved) from the driReInit work in that
Charl> the new patches allow suspending/resuming whilst running 3D
Charl> applications.

Charl> I need some feedback, as one brave beta-tester is seeing
Charl> undefined symbols when building the modified radeon DRM and I
Charl> can't reproduce this problem on my systems.

Built fine here... Seems to have worked fine. I tried a swsusp and it
came back fine. 

You might note that you no longer need to abort the suspend if your
radeon module is still in use. At least it worked for me with it still
in use... and it never was not in use. 

One other strange thing... after a swsusp everything comes back except
Xv does look like it works. It just gives a blank window for anything
that uses Xv. :( This was the case with the driReInit version as
well. Or the stock X modules/libs. 

Happy to provide more info... 

Charl> Thanks, Charl

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9eCEH3imCezTjY0ERAjKHAJ0aLNzb2rFM1n7D7ssYZwPZrf/dDACfRFFI
1MO8Jwb6lyv53+KfiAUVeWM=
=daRD
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
