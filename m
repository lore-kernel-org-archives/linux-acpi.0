From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: insmod/rmmod bug?
Date: Fri, 8 Nov 2002 11:15:32 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E301@cceexc19.americas.cpqcorp.net>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

There appears to be a bug in acpi_bus_unregister_driver().  In the case
of the button driver, it's not calling acpi_button_remove() when I
"rmmod button".  This causes problems when I attempt to "insmod button"
again.

Here's the log showing the "Error installing notify handler" that occurs
the second time I do "insmod button":

 stormin:/proc/acpi # insmod button
 Using /lib/modules/2.4.20-rc1/kernel/drivers/acpi/button.o

 stormin:/proc/acpi # dmesg -c
 ACPI: Power Button (CM) [PBTN]

 stormin:/proc/acpi # rmmod button

 stormin:/proc/acpi # dmesg -c

 stormin:/proc/acpi # insmod button
 Using /lib/modules/2.4.20-rc1/kernel/drivers/acpi/button.o

 stormin:/proc/acpi # dmesg -c
 acpi_button-0359 [-40] acpi_button_add       : Error installing notify
handler

Has anyone else seen this problem?  I'm using the latest linux-2.4-acpi
kernel from bitkeeper.

Regards,
John

--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
