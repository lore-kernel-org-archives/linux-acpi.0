From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] dell-wmi - use pr_xxx() for printing messages
Date: Sun, 27 Dec 2009 01:50:18 -0800
Message-ID: <20091227095005.14542.67746.stgit@localhost.localdomain>
References: <20091227094754.14542.22118.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:36783 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbZL0JuV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Dec 2009 04:50:21 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so2364334pzk.33
        for <linux-acpi@vger.kernel.org>; Sun, 27 Dec 2009 01:50:20 -0800 (PST)
In-Reply-To: <20091227094754.14542.22118.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Use pr_xxx() instead of naked printk() to guarantee consistent prefixing
of generated messages.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/dell-wmi.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index e0a0716..ff67a78 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -23,6 +23,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -147,8 +149,7 @@ static void dell_wmi_notify(u32 value, void *context)
 		u16 *buffer_entry = (u16 *)obj->buffer.pointer;
 
 		if (dell_new_hk_type && buffer_entry[1] != 0x10) {
-			printk(KERN_INFO
-				"dell-wmi: Received unknown WMI event (0x%x)\n",
+			pr_info("Received unknown WMI event (0x%x)\n",
 				buffer_entry[1]);
 			return;
 		}
@@ -161,8 +162,7 @@ static void dell_wmi_notify(u32 value, void *context)
 		key = sparse_keymap_entry_from_scancode(dell_wmi_input_dev,
 							reported_key);
 		if (!key) {
-			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
-				reported_key);
+			pr_info("Unknown key %x pressed\n", reported_key);
 		} else if ((key->keycode == KEY_BRIGHTNESSUP ||
 			    key->keycode == KEY_BRIGHTNESSDOWN) && acpi_video) {
 			/* Don't report brightness notifications that will also
@@ -268,7 +268,7 @@ static int __init dell_wmi_init(void)
 	int err;
 
 	if (!wmi_has_guid(DELL_EVENT_GUID)) {
-		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
+		pr_warning("No known WMI GUID found\n");
 		return -ENODEV;
 	}
 
@@ -283,9 +283,7 @@ static int __init dell_wmi_init(void)
 					 dell_wmi_notify, NULL);
 	if (err) {
 		dell_wmi_input_destroy();
-		printk(KERN_ERR
-			"dell-wmi: Unable to register notify handler - %d\n",
-			err);
+		pr_err("Unable to register notify handler - %d\n", err);
 		return err;
 	}
 

