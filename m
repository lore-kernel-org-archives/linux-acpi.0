From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 7/9] PNPACPI: clean blacklist
Date: Thu, 05 Jan 2006 22:30:58 -0800
Message-ID: <200601060631.k066VBNT008141@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, castet.matthieu-GANU6spQydw@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>

Clean the blacklist.  Battery, Button, Fan don't have a CRS and should be
removed.  PCI root is in pnpbios and is harmless.

Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/pnp/pnpacpi/core.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff -puN drivers/pnp/pnpacpi/core.c~pnpacpi-clean-blacklist drivers/pnp/pnpacpi/core.c
--- devel/drivers/pnp/pnpacpi/core.c~pnpacpi-clean-blacklist	2006-01-05 22:28:30.000000000 -0800
+++ devel-akpm/drivers/pnp/pnpacpi/core.c	2006-01-05 22:28:30.000000000 -0800
@@ -27,12 +27,15 @@
 
 static int num = 0;
 
+/* We need only to blacklist devices that have already an acpi driver that
+ * can't use pnp layer. We don't need to blacklist device that are directly
+ * used by the kernel (PCI root, ...), as it is harmless and there were
+ * already present in pnpbios. But there is an exception for devices that
+ * have irqs (PIC, Timer) because we call acpi_register_gsi.
+ * Finaly only devices that have a CRS method need to be in this list.
+ */
 static char __initdata excluded_id_list[] =
-	"PNP0C0A," /* Battery */
-	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
 	"PNP0C09," /* EC */
-	"PNP0C0B," /* Fan */
-	"PNP0A03," /* PCI root */
 	"PNP0C0F," /* Link device */
 	"PNP0000," /* PIC */
 	"PNP0100," /* Timer */
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
