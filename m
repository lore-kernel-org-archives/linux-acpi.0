From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: insmod/rmmod bug?
Date: Fri, 8 Nov 2002 13:23:12 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E302@cceexc19.americas.cpqcorp.net>
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
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew,

I think I found the bug.  It appears that the device->driver field is
never getting populated in acpi_bus_register_driver.  This means that a
device match is not found in acpi_bus_unregister_driver, so the
ops.remove method is never called when unloading an ACPI driver module.
Here's a small patch that fixes it for me:

--- linux-2.4-acpi/drivers/acpi/bus.c   2002-11-08 13:14:49.000000000
-0600
+++ linux-2.4-acpi-jmc/drivers/acpi/bus.c       2002-11-08
12:35:24.000000000 -0600
@@ -1073,6 +1073,12 @@
        }

        /*
+        * Store driver reference in device structure so that
ops.remove()
+        * can be called at unload time.
+        */
+       device->driver =3D driver;
+
+       /*
         * TBD - Configuration Management: Assign resources to device
based
         * upon possible configuration and currently allocated
resources.
         */

BTW, I've only tested this with the "button" module.

Regards,
John

> -----Original Message-----
> From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Friday, November 08, 2002 11:35 AM
> To: Cagle, John (ISS-Houston); acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] insmod/rmmod bug?
>=20
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > There appears to be a bug in acpi_bus_unregister_driver(). =20
> > In the case
> > of the button driver, it's not calling acpi_button_remove() when I
> > "rmmod button".  This causes problems when I attempt to=20
> > "insmod button"
> > again.
>=20
> > Has anyone else seen this problem?  I'm using the latest
> > linux-2.4-acpi
> > kernel from bitkeeper.
>=20
> Yes, this may be a problem with bus.c, since I think this has=20
> been seen for other drivers besides button. Have you been=20
> able to determine exactly where the problem lies?
>=20
> Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
