From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 06/13] ACPI: thinkpad-acpi: claim tpacpi as
	an official short handle
Date: Thu, 10 Apr 2008 00:52:58 -0300
Message-ID: <1207799585-10112-7-git-send-email-hmh@hmh.eng.br>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1207799585-10112-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Unfortunately, a lot of stuff in the kernel has size limitations, so
"thinkpad-acpi" ends up eating up too much real estate.  We were using
"tpacpi" in symbols already, but this shorthand was not visible to
userland.

Document that the driver will use tpacpi as a short hand where necessary,
and use it to name the kernel thread for NVRAM polling (now named
"ktpacpi_nvramd").

Also, register a module alias with the shorthand.  One can refer to the
module using the shorthand name.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/laptops/thinkpad-acpi.txt |    5 +++++
 drivers/misc/thinkpad_acpi.c            |    8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index bbc8275..0f403ff 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -18,6 +18,11 @@ This driver used to be named ibm-acpi until kernel 2.6.21 and release
 moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
 2.6.22, and release 0.14.
 
+The driver is named "thinkpad-acpi".  In some places, like module
+names, "thinkpad_acpi" is used because of userspace issues.
+
+"tpacpi" is used as a shorthand where "thinkpad-acpi" would be too
+long due to lenght limitations on some Linux kernel versions.
 
 Status
 ------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 1a26423..f23acc8 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -133,8 +133,11 @@ enum {
 #define TPACPI_PROC_DIR "ibm"
 #define TPACPI_ACPI_EVENT_PREFIX "ibm"
 #define TPACPI_DRVR_NAME TPACPI_FILE
+#define TPACPI_DRVR_SHORTNAME "tpacpi"
 #define TPACPI_HWMON_DRVR_NAME TPACPI_NAME "_hwmon"
 
+#define TPACPI_NVRAM_KTHREAD_NAME "ktpacpi_nvramd"
+
 #define TPACPI_MAX_ACPI_ARGS 3
 
 /* Debugging */
@@ -1522,8 +1525,7 @@ static void hotkey_poll_setup(int may_warn)
 	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
 		if (!tpacpi_hotkey_task) {
 			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
-							 NULL,
-							 TPACPI_FILE "d");
+					NULL, TPACPI_NVRAM_KTHREAD_NAME);
 			if (IS_ERR(tpacpi_hotkey_task)) {
 				tpacpi_hotkey_task = NULL;
 				printk(TPACPI_ERR
@@ -6315,6 +6317,8 @@ static int __init thinkpad_acpi_module_init(void)
 /* Please remove this in year 2009 */
 MODULE_ALIAS("ibm_acpi");
 
+MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
+
 /*
  * DMI matching for module autoloading
  *
-- 
1.5.4.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
