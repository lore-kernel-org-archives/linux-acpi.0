From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/2] thinkpad_acpi: Hook volume events
Date: Mon,  3 May 2010 16:03:00 -0400
Message-ID: <1272916980-11835-2-git-send-email-mjg@redhat.com>
References: <1272916980-11835-1-git-send-email-mjg@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1272916980-11835-1-git-send-email-mjg@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Not all Thinkpads generate events for volume hotkeys, so hook into the
CMOS update and generate events from there without polling. This should
let Pulseaudio do something sensible with the mute state.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 63290b3..c8c4f2b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3083,6 +3083,15 @@ static const struct tpacpi_quirk tpacpi_hotkey_qtable[] __initconst = {
 	TPACPI_Q_IBM('1', 'D', TPACPI_HK_Q_INIMASK), /* X22, X23, X24 */
 };
 
+static void volume_alsa_notify_change(void);
+static int volume_check_status(void);
+
+static void cmos_notifier(void *context)
+{
+	if (volume_check_status())
+		volume_alsa_notify_change();
+}
+
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
 	/* Requirements for changing the default keymaps:
@@ -4939,11 +4948,16 @@ static int __init cmos_init(struct ibm_init_struct *iibm)
 	if (res)
 		return res;
 
+	if (cmos_handle)
+		acpi_install_method_handler(cmos_handle, cmos_notifier,
+					    iibm->data);
+
 	return (cmos_handle)? 0 : 1;
 }
 
 static void cmos_exit(void)
 {
+	acpi_remove_method_handler(cmos_handle, cmos_notifier);
 	device_remove_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
 }
 
@@ -6458,6 +6472,7 @@ static enum tpacpi_volume_access_mode volume_mode =
 
 static enum tpacpi_volume_capabilities volume_capabilities;
 static int volume_control_allowed;
+static u8 volume_state;
 
 /*
  * Used to syncronize writers to TP_EC_AUDIO and
@@ -6544,6 +6559,21 @@ static int volume_set_status(const u8 status)
 	return volume_set_status_ec(status);
 }
 
+static int volume_check_status()
+{
+	u8 new_state;
+	int ret = 0;
+
+	volume_get_status(&new_state);
+
+	if (new_state != volume_state) {
+		ret = 1;
+		volume_state = new_state;
+	}
+
+	return ret;
+}
+
 /* returns < 0 on error, 0 on no change, 1 on change */
 static int __volume_set_mute_ec(const bool mute)
 {
@@ -6931,6 +6961,8 @@ static int __init volume_init(struct ibm_init_struct *iibm)
 		return rc;
 	}
 
+	volume_get_status(&volume_state);
+
 	printk(TPACPI_INFO
 		"Console audio control enabled, mode: %s\n",
 		(volume_control_allowed) ?
-- 
1.7.0.1

