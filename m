From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 03/10] ACPI: thinkpad-acpi: prefer standard
	ACPI backlight level control
Date: Sat, 13 Oct 2007 17:22:52 -0300
Message-ID: <1192306979-26886-4-git-send-email-hmh@hmh.eng.br>
References: <1192306979-26886-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1192306979-26886-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Newer Lenovo BIOSes support the standard ACPI backlight brightness
interface (_BCM, _BQC, _BCL).  It should be used instead of the native
thinkpad backlight brightness control interface when possible.

This patch disables the native brightness support in the driver by default
when we detect that the standard ACPI interface is available.  The local
admin can still enable it using the module parameter "brightness_enable".

Note that we need to detect the standard ACPI backlight interface only in
boxes for which we would load the native backlight interface in the first
place, and that no ThinkPad BIOS has _BCL but misses the other methods, so
the detection routines can be really simple.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |    8 ++++++--
 drivers/misc/thinkpad_acpi.c    |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 353a1a7..64d1fe9 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -942,11 +942,15 @@ and CMOS.  The driver tries to autodetect which interface to use.
 
 When display backlight brightness controls are available through the
 standard ACPI interface, it is best to use it instead of this direct
-ThinkPad-specific interface.
+ThinkPad-specific interface.  The driver will disable its native
+backlight brightness control interface if it detects that the standard
+ACPI interface is available in the ThinkPad.
 
 The brightness_enable module parameter can be used to control whether
 the LCD brightness control feature will be enabled when available.
-brightness_enable=0 forces it to be disabled.
+brightness_enable=0 forces it to be disabled.  brightness_enable=1
+forces it to be enabled when available, even if the standard ACPI
+interface is also available.
 
 Procfs notes:
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index f33758d..a99a40c 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3174,6 +3174,39 @@ static int __init brightness_check_levels(void)
 	return (ACPI_SUCCESS(status) && found_node != NULL);
 }
 
+static acpi_status __init brightness_find_bcl(acpi_handle handle, u32 lvl,
+					void *context, void **rv)
+{
+	char name[ACPI_PATH_SEGMENT_LENGTH];
+	struct acpi_buffer buffer = { sizeof(name), &name };
+
+	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)) &&
+	    !strncmp("_BCL", name, sizeof(name) - 1)) {
+		*rv = handle;
+		return AE_CTRL_TERMINATE;
+	} else {
+		return AE_OK;
+	}
+}
+
+static int __init brightness_check_std_acpi_support(void)
+{
+	int status;
+	void *found_node = NULL;
+
+	if (!vid_handle) {
+		IBM_ACPIHANDLE_INIT(vid);
+	}
+	if (!vid_handle)
+		return 0;
+
+	/* Search for a _BCL method, but don't execute it */
+	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
+	                             brightness_find_bcl, NULL, &found_node);
+
+	return (ACPI_SUCCESS(status) && found_node != NULL);
+}
+
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
@@ -3186,6 +3219,12 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		dbg_printk(TPACPI_DBG_INIT,
 		           "brightness support disabled by module parameter\n");
 		return 1;
+	} else if (brightness_enable > 1) {
+		if (brightness_check_std_acpi_support()) {
+			printk(IBM_NOTICE
+			       "standard ACPI backlight interface available, not loading native one...\n");
+			return 1;
+		}
 	}
 
 	if (!brightness_mode) {
-- 
1.5.3.2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
