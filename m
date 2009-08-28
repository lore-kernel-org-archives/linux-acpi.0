From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 09/24] eeepc-laptop: switch to dev_pm_ops
Date: Fri, 28 Aug 2009 14:56:40 +0200
Message-ID: <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:61346 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZH1NDm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:42 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id 26CB2700255D
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:43 +0200 (CEST)
In-Reply-To: <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

This also involves switching the resume handler from the acpi device
to the platform device.  Using the more fine grained handlers allows
two improvements:

1. We only need to recheck rfkill state after resume from hibernation.

2. The wireless LED workaround accounts for up to 1.1s out of 1.7s
resuming devices (when wireless is enabled).  We can limit the
workaround to thaw(), so that it only delays suspend to disk.

The workaround is only likely to help when hibernation is aborted.
Suspend to ram cannot be aborted by the user.  Device suspend errors may
well happen before eeepc-laptop would even be frozen.  Suspend errors
which happen after that could be pretty funky anyway.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index df68ae6..1c94860 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -150,10 +150,19 @@ struct eeepc_hotk {
 static struct eeepc_hotk *ehotk;
 
 /* Platform device/driver */
+static int eeepc_hotk_thaw(struct device *device);
+static int eeepc_hotk_restore(struct device *device);
+
+static struct dev_pm_ops eeepc_pm_ops = {
+	.thaw = eeepc_hotk_thaw,
+	.restore = eeepc_hotk_restore,
+};
+
 static struct platform_driver platform_driver = {
 	.driver = {
 		.name = EEEPC_HOTK_FILE,
 		.owner = THIS_MODULE,
+		.pm = &eeepc_pm_ops,
 	}
 };
 
@@ -192,7 +201,6 @@ static struct key_entry eeepc_keymap[] = {
  */
 static int eeepc_hotk_add(struct acpi_device *device);
 static int eeepc_hotk_remove(struct acpi_device *device, int type);
-static int eeepc_hotk_resume(struct acpi_device *device);
 static void eeepc_hotk_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id eeepc_device_ids[] = {
@@ -209,7 +217,6 @@ static struct acpi_driver eeepc_hotk_driver = {
 	.ops = {
 		.add = eeepc_hotk_add,
 		.remove = eeepc_hotk_remove,
-		.resume = eeepc_hotk_resume,
 		.notify = eeepc_hotk_notify,
 	},
 };
@@ -821,7 +828,7 @@ error_slot:
 	return ret;
 }
 
-static int eeepc_hotk_resume(struct acpi_device *device)
+static int eeepc_hotk_thaw(struct device *device)
 {
 	if (ehotk->wlan_rfkill) {
 		bool wlan;
@@ -829,14 +836,20 @@ static int eeepc_hotk_resume(struct acpi_device *device)
 		/*
 		 * Work around bios bug - acpi _PTS turns off the wireless led
 		 * during suspend.  Normally it restores it on resume, but
-		 * we should kick it ourselves in case suspend is aborted.
+		 * we should kick it ourselves in case hibernation is aborted.
 		 */
 		wlan = get_acpi(CM_ASL_WLAN);
 		set_acpi(CM_ASL_WLAN, wlan);
+	}
+
+	return 0;
+}
 
-		/* Refresh both rfkill state and pci hotplug */
+static int eeepc_hotk_restore(struct device *device)
+{
+	/* Refresh both wlan rfkill state and pci hotplug */
+	if (ehotk->wlan_rfkill)
 		eeepc_rfkill_hotplug();
-	}
 
 	if (ehotk->bluetooth_rfkill)
 		rfkill_set_sw_state(ehotk->bluetooth_rfkill,
-- 
1.6.4


