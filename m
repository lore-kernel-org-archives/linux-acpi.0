From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [RFC] ACPI serial port BASE_BAUD
Date: Thu, 4 Mar 2004 16:44:46 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403041644.46250.bjorn.helgaas@hp.com>
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
To: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

It seems wrong that ACPI serial ports should depend on the
architecture BASE_BAUD.  Isn't ACPI supposed to give us a
generic way to describe things like this?

I think there should either be some item in the UART's _CRS
to tell us the clock rate, or a statement somewhere that "all
PNP0501 devices must use a 115200 clock rate".  I can't find
either one (pointers welcome).

This patch against 2.6.4-rc2 just removes the dependency on
the per-arch BASE_BAUD -- no functional change for i386,
x86_64, or ia64.

===== drivers/serial/8250_acpi.c 1.7 vs edited =====
--- 1.7/drivers/serial/8250_acpi.c	Fri Jan 16 15:01:45 2004
+++ edited/drivers/serial/8250_acpi.c	Thu Mar  4 14:06:51 2004
@@ -22,6 +22,9 @@
 #include <asm/io.h>
 #include <asm/serial.h>
 
+/* ACPI should expose this value via _CRS, or document it as fixed */
+#define ACPI_PNP0501_BASE_BAUD	115200
+
 struct serial_private {
 	int	line;
 	void	*iomem_base;
@@ -133,7 +136,7 @@
 		goto fail;
 	}
 
-	serial_req.baud_base = BASE_BAUD;
+	serial_req.baud_base = ACPI_PNP0501_BASE_BAUD;
 	serial_req.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF |
 			   UPF_AUTO_IRQ  | UPF_RESOURCES;
 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
