From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/7 v2] ACPI: thinkpad-acpi: add brightness_force parameter
Date: Tue, 30 Oct 2007 18:02:07 -0200
Message-ID: <20071030200207.GB17225@khazad-dum.debian.net>
References: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br> <1193773585-17202-4-git-send-email-hmh@hmh.eng.br> <20071030195514.GA17225@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54366 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757045AbXJ3UCL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 16:02:11 -0400
Content-Disposition: inline
In-Reply-To: <20071030195514.GA17225@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Add a "brightness_enable" module parameter that allows the local admin to
force the backlight support to not be enabled.

It can also be used to force the backlight support to be enabled, but that
is currently a no-op as the backlight support is enabled by default when
available.  This will be changed by a different patch.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/thinkpad-acpi.txt |    4 ++++
 drivers/misc/thinkpad_acpi.c    |    9 +++++++++
 drivers/misc/thinkpad_acpi.h    |    1 +
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index a743bfa..f877c13 100644
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
index 322ba25..56a21e6 100644
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
index 8ca19c3..8fba2bb 100644
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
1.5.3.4

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
