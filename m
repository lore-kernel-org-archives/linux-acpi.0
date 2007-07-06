From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 02/16] ACPI: thinkpad-acpi: remove all
	uneeded initializers
Date: Thu,  5 Jul 2007 23:42:14 -0300
Message-ID: <11836897481307-git-send-email-hmh@hmh.eng.br>
References: <11836897482509-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11836897482509-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Remove all initializers to NULL or zero.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 22a5f22..9f10b46 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -129,7 +129,7 @@ IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
  * ACPI basic handles
  */
 
-static acpi_handle root_handle = NULL;
+static acpi_handle root_handle;
 
 #define IBM_HANDLE(object, parent, paths...)			\
 	static acpi_handle  object##_handle;			\
@@ -515,8 +515,8 @@ static char *next_cmd(char **cmds)
  ****************************************************************************
  ****************************************************************************/
 
-static struct platform_device *tpacpi_pdev = NULL;
-static struct class_device *tpacpi_hwmon = NULL;
+static struct platform_device *tpacpi_pdev;
+static struct class_device *tpacpi_hwmon;
 
 static struct platform_driver tpacpi_pdriver = {
 	.driver = {
@@ -729,7 +729,7 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
-static struct attribute_set *hotkey_dev_attributes = NULL;
+static struct attribute_set *hotkey_dev_attributes;
 
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
@@ -2694,7 +2694,7 @@ static struct ibm_struct ecdump_driver_data = {
  * Backlight/brightness subdriver
  */
 
-static struct backlight_device *ibm_backlight_device = NULL;
+static struct backlight_device *ibm_backlight_device;
 
 static struct backlight_ops ibm_backlight_data = {
         .get_brightness = brightness_get,
@@ -3497,7 +3497,7 @@ static void fan_watchdog_fire(struct work_struct *ignored)
 
 static void fan_watchdog_reset(void)
 {
-	static int fan_watchdog_active = 0;
+	static int fan_watchdog_active;
 
 	if (fan_control_access_mode == TPACPI_FAN_WR_NONE)
 		return;
@@ -3900,7 +3900,7 @@ static struct ibm_struct fan_driver_data = {
  ****************************************************************************/
 
 /* /proc support */
-static struct proc_dir_entry *proc_dir = NULL;
+static struct proc_dir_entry *proc_dir;
 
 /* Subdriver registry */
 static LIST_HEAD(tpacpi_all_drivers);
@@ -4043,7 +4043,7 @@ static void ibm_exit(struct ibm_struct *ibm)
 
 /* Probing */
 
-static char *ibm_thinkpad_ec_found = NULL;
+static char *ibm_thinkpad_ec_found;
 
 static char* __init check_dmi_for_ec(void)
 {
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
