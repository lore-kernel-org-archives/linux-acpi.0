From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: 'rmmod button' doesn't remove /proc/acpi/button
Date: Sun, 10 Nov 2002 10:07:18 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476BA07@cceexc19.americas.cpqcorp.net>
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
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andy,

I found a minor bug in button.c's acpi_button_exit() routine.  It
doesn't
remove the top-level 'button' directory when unloading the module, and
if
you insmod/rmmod multiple times, you'll end up with lots of 'button'
directories in /proc/acpi.

Here's a simple fix:

--- linux-2.4-acpi/drivers/acpi/button.c
+++ linux-2.4-acpi-j2/drivers/acpi/button.c
@@ -433,9 +433,13 @@
 static void __exit
 acpi_button_exit (void)
 {
+       int                     result =3D 0;
+
        ACPI_FUNCTION_TRACE("acpi_button_exit");

-       acpi_bus_unregister_driver(&acpi_button_driver);
+       result =3D acpi_bus_unregister_driver(&acpi_button_driver);
+       if (!result)
+               remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);

        return_VOID;
 }

Regards,
John

--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
