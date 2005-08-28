From: matthieu castet <castet.matthieu@free.fr>
Subject: [PATCH] PNPACPI: clean blacklist
Date: Sun, 28 Aug 2005 19:49:31 +0200
Message-ID: <4311F92B.5010609@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020902060306040407020700"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750716AbVH1RtT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acpi-devel@lists.sourceforge.net
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020902060306040407020700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch clean the blacklist and should be applied after "only parse 
device that have CRS method" patch:
Battery, Button, Fan don't have a CRS and should be removed.
PCI root, PIC, Timer are in pnpbios and are harmless.


Please comment and consider for inclusion.

Thanks,

Matthieu

--------------020902060306040407020700
Content-Type: text/x-patch;
 name="pnpacpi_clean_blacklist.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_clean_blacklist.patch"

Index: linux-2.6.13rc/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-2.6.13rc.orig/drivers/pnp/pnpacpi/core.c	2005-08-28 19:26:35.000000000 +0200
+++ linux-2.6.13rc/drivers/pnp/pnpacpi/core.c	2005-08-28 19:34:30.000000000 +0200
@@ -27,15 +27,15 @@
 
 static int num = 0;
 
+/* We need only to blacklist device that have already an acpi driver that
+ * can't use pnp layer. We don't need to blacklist device that are directly 
+ * used by the kernel (PIC, Timer, ...), as it is harmless and there were
+ * already present in pnpbios. Finaly only devices that have a CRS method
+ * need to be in this list.
+ */
 static char __initdata excluded_id_list[] =
-	"PNP0C0A," /* Battery */
-	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
 	"PNP0C09," /* EC */
-	"PNP0C0B," /* Fan */
-	"PNP0A03," /* PCI root */
 	"PNP0C0F," /* Link device */
-	"PNP0000," /* PIC */
-	"PNP0100," /* Timer */
 	;
 static inline int is_exclusive_device(struct acpi_device *dev)
 {

--------------020902060306040407020700--
