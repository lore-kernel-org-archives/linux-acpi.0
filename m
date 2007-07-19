From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 21/23] ACPI: thinkpad-acpi: make EC-based
	thermal readings non-experimental
Date: Wed, 18 Jul 2007 23:45:46 -0300
Message-ID: <11848131522378-git-send-email-hmh@hmh.eng.br>
References: <11848131483573-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11848131483573-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Reading the 16 thermal sensors directly from the EC has been stable for
about one year, in all supported ThinkPad models.  Remove its
"experimental" label.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   18 +++++-------------
 drivers/misc/thinkpad_acpi.c    |    2 +-
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 5d827de..3eb949e 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -710,23 +710,15 @@ Temperature sensors
 procfs: /proc/acpi/ibm/thermal
 sysfs device attributes: (hwmon) temp*_input
 
-Most ThinkPads include six or more separate temperature sensors but
-only expose the CPU temperature through the standard ACPI methods.
-This feature shows readings from up to eight different sensors on older
-ThinkPads, and it has experimental support for up to sixteen different
-sensors on newer ThinkPads.
-
-EXPERIMENTAL: The 16-sensors feature is marked EXPERIMENTAL because the
-implementation directly accesses hardware registers and may not work as
-expected. USE WITH CAUTION! To use this feature, you need to supply the
-experimental=1 parameter when loading the module.  When EXPERIMENTAL
-mode is enabled, reading the first 8 sensors on newer ThinkPads will
-also use an new experimental thermal sensor access mode.
+Most ThinkPads include six or more separate temperature sensors but only
+expose the CPU temperature through the standard ACPI methods.  This
+feature shows readings from up to eight different sensors on older
+ThinkPads, and up to sixteen different sensors on newer ThinkPads.
 
 For example, on the X40, a typical output may be:
 temperatures:   42 42 45 41 36 -128 33 -128
 
-EXPERIMENTAL: On the T43/p, a typical output may be:
+On the T43/p, a typical output may be:
 temperatures:   48 48 36 52 38 -128 31 -128 48 52 48 -128 -128 -128 -128 -128
 
 The mapping of thermal sensors to physical locations varies depending on
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index f74d7d6..84a1000 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2709,7 +2709,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 
 	acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
 
-	if (thinkpad_id.ec_model && experimental) {
+	if (thinkpad_id.ec_model) {
 		/*
 		 * Direct EC access mode: sensors at registers
 		 * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
