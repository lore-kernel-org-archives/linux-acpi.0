From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] Discover ACPI serial ports before plug-in ports
Date: Tue, 10 Feb 2004 16:11:22 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402101611.22768.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I propose the following patch (against 2.6.2).  This makes us
discover ACPI serial ports before PCI ones.  The ACPI ports
tend to be built-in, and discovering them late means their ttyS
names move around if PCI serial ports are added or removed.  I
think it makes more sense to have relatively predictable and
consistent names for the built-in hardware.

===== drivers/serial/Makefile 1.20 vs edited =====
--- 1.20/drivers/serial/Makefile	Tue Sep  9 03:30:53 2003
+++ edited/drivers/serial/Makefile	Tue Feb 10 15:46:15 2004
@@ -5,11 +5,11 @@
 #
 
 serial-8250-y :=
+serial-8250-$(CONFIG_SERIAL_8250_ACPI) += 8250_acpi.o
 serial-8250-$(CONFIG_GSC) += 8250_gsc.o
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_PNP) += 8250_pnp.o
 serial-8250-$(CONFIG_SERIAL_8250_HCDP) += 8250_hcdp.o
-serial-8250-$(CONFIG_SERIAL_8250_ACPI) += 8250_acpi.o
 
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
