From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 02/10] ACPI: thinkpad-acpi: add
	brightness_force parameter
Date: Sat, 13 Oct 2007 17:22:51 -0300
Message-ID: <1192306979-26886-3-git-send-email-hmh@hmh.eng.br>
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

Add a "brightness_force" module parameter that allows the local admin to
force the backlight support to not be enabled.

It can also be used to force the backlight support to be enabled, but that
is currently a no-op as the backlight support is enabled by default when
available.  This will be changed by a different patch.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |    4 ++++
 drivers/misc/thinkpad_acpi.c    |    9 +++++++++
 drivers/misc/thinkpad_acpi.h    |    1 +
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 4db98b3..353a1a7 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -944,6 +944,10 @@ When display backlight brightness controls are available through the
 standard ACPI interface, it is best to use it instead of this direct
 ThinkPad-specific interface.
 
+The brightness_enable module parameter can be used to control whether
+the LCD brightness control feature will be enabled when available.
+brightness_enable=0 forces it to be disabled.
+
 Procfs notes:
 
 	The available commands are:
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 44af5a6..f33758d 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3182,6 +3182,12 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 
 	mutex_init(&brightness_mutex);
 
+	if (!brightness_enable) {
+		dbg_printk(TPACPI_DBG_INIT,
+		           "brightness support disabled by module parameter\n");
+		return 1;
+	}
+
 	if (!brightness_mode) {
 		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO)
 			brightness_mode = 2;
@@ -4803,6 +4809,9 @@ module_param_named(fan_control, fan_control_allowed, bool, 0);
 static int brightness_mode;
 module_param_named(brightness_mode, brightness_mode, int, 0);
 
+static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
+module_param(brightness_enable, uint, 0);
+
 static unsigned int hotkey_report_mode;
 module_param(hotkey_report_mode, uint, 0);
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index de0f343..3c0edd8 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -339,6 +339,7 @@ static int bluetooth_write(char *buf);
 static struct backlight_device *ibm_backlight_device;
 static int brightness_offset = 0x31;
 static int brightness_mode;
+static unsigned int brightness_enable;	/* 0 = no, 1 = yes, 2 = auto */
 
 static int brightness_init(struct ibm_init_struct *iibm);
 static void brightness_exit(void);
-- 
1.5.3.2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
