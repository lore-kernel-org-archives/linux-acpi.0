From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 2/4] PNPACPI: clean blacklist
Date: Fri, 28 Oct 2005 15:01:42 -0700
Message-ID: <200510282201.j9SM1O0Z021811@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, castet.matthieu-GANU6spQydw@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
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
--- 25/drivers/pnp/pnpacpi/core.c~pnpacpi-clean-blacklist	Fri Oct 28 15:01:32 2005
+++ 25-akpm/drivers/pnp/pnpacpi/core.c	Fri Oct 28 15:01:32 2005
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


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
