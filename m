From: Catalin BOIE <util-m7amzYTWDwUM5Le54R2NVQ@public.gmane.org>
Subject: [PATCH] Re: 2.6.0test4mm5 - compile problem (acpi)
Date: Thu, 4 Sep 2003 07:39:47 +0300 (EEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.56.0309040739210.20565@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi!
(Please CC me. Thank you.)


  CC      drivers/acpi/pci_link.o
drivers/acpi/pci_link.c: In function `acpi_pci_link_try_get_current':
drivers/acpi/pci_link.c:290: error: `_dbg' undeclared (first use in this
function)
drivers/acpi/pci_link.c:290: error: (Each undeclared identifier is
reported only once
drivers/acpi/pci_link.c:290: error: for each function it appears in.)
make[2]: *** [drivers/acpi/pci_link.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2


Patch:
diff -ur acpi.ok/pci_link.c acpi/pci_link.c
--- acpi.ok/pci_link.c  2003-09-03 09:28:42.000000000 +0300
+++ acpi/pci_link.c     2003-09-03 13:42:28.000000000 +0300
@@ -285,6 +285,8 @@
 {
        int result;

+       ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
+
        result = acpi_pci_link_get_current(link);
        if (result && link->irq.active) {
                return_VALUE(result);


---
Catalin(ux) BOIE
catab-m7amzYTWDwUM5Le54R2NVQ@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
