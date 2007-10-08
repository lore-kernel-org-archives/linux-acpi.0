From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight
	handler if ACPI generic could do it
Date: Mon,  8 Oct 2007 10:12:58 -0300
Message-ID: <1191849179-24087-4-git-send-email-hmh@hmh.eng.br>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1191849179-24087-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If we detect the presence of _BCL on a Lenovo ThinkPad, it means there is
support for ACPI standard backlight brightness control.  In that case, it
is probably best to not make the ThinkPad-specific backlight interface
available.

Provide a Kconfig option (default disabled) to make the ThinkPad-specific
backlight always available, even if there is generic ACPI backlight
support in the DSDT.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |    5 ++++-
 drivers/misc/Kconfig            |   17 +++++++++++++++++
 drivers/misc/thinkpad_acpi.c    |   20 ++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 4db98b3..7ff0183 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -942,7 +942,10 @@ and CMOS.  The driver tries to autodetect which interface to use.
 
 When display backlight brightness controls are available through the
 standard ACPI interface, it is best to use it instead of this direct
-ThinkPad-specific interface.
+ThinkPad-specific interface.  In that case, the driver will not export
+the ThinkPad-specific interface by default, although this can be changed
+at compile time, using the CONFIG_THINKPAD_ACPI_BACKLIGHT_DESIRED
+Kconfig option.
 
 Procfs notes:
 
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 73e248f..bd8504a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -177,6 +177,23 @@ config THINKPAD_ACPI_DEBUG
 
 	  If you are not sure, say N here.
 
+config THINKPAD_ACPI_BACKLIGHT_DESIRED
+	bool "Always load backlight support"
+	depends on THINKPAD_ACPI
+	default n
+	---help---
+	  By default, if the ThinkPad supports the standard ACPI display
+	  brightness control, the thinkpad-specific backlight support will
+	  not be loaded.  This avoids duplicate backlight interfaces
+	  controlling the same LCD, as the ACPI video driver will also publish
+	  a backlight interface to control the display brightness.
+
+	  However, if you prefer to always have the thinkpad-specific backlight
+	  device available, even when it will just be a duplicate of the
+	  standard ACPI backlight device, say Y here.
+
+	  If you are not sure, say N here.
+
 config THINKPAD_ACPI_DOCK
 	bool "Legacy Docking Station Support"
 	depends on THINKPAD_ACPI
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 2a573db..29f521b 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3114,6 +3114,10 @@ static struct backlight_ops ibm_backlight_data = {
 
 static struct mutex brightness_mutex;
 
+#ifndef CONFIG_THINKPAD_ACPI_BACKLIGHT_DESIRED
+static int brightness_acpi_detected __initdata;
+#endif
+
 static int __init tpacpi_query_bcl_levels(acpi_handle handle)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -3147,6 +3151,9 @@ static acpi_status __init brightness_find_bcl(acpi_handle handle, u32 lvl,
 
 	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)) &&
 	    !strncmp("_BCL", name, sizeof(name) - 1)) {
+#ifndef CONFIG_THINKPAD_ACPI_BACKLIGHT_DESIRED
+		brightness_acpi_detected = 1;
+#endif
 		if (tpacpi_query_bcl_levels(handle) == 16) {
 			*rv = handle;
 			return AE_CTRL_TERMINATE;
@@ -3197,10 +3204,23 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	if (brightness_mode > 3)
 		return -EINVAL;
 
+#ifndef CONFIG_THINKPAD_ACPI_BACKLIGHT_DESIRED
+	brightness_acpi_detected = 0;
+#endif
+
 	tp_features.bright_16levels =
 			thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO &&
 			brightness_check_levels();
 
+#ifndef CONFIG_THINKPAD_ACPI_BACKLIGHT_DESIRED
+	if (brightness_acpi_detected) {
+		dbg_printk(TPACPI_DBG_INIT,
+			   "ACPI standard backlight brightness control "
+			   "available, aborting...\n");
+		return 1;
+	}
+#endif
+
 	b = brightness_get(NULL);
 	if (b < 0)
 		return 1;
-- 
1.5.3.2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
