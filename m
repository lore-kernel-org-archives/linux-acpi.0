From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/5] ACPI: button: Obselete acpi_lid_open() invocations
Date: Fri,  5 May 2017 10:40:01 +0800
Message-ID: <3323fbefe77239808e9abba90929bf2a02d916a3.1493951798.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:48987 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754358AbdEECkF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 May 2017 22:40:05 -0400
In-Reply-To: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Since notification side has been changed to always notify kernel listeners
using _LID returning value. Now listeners needn't invoke invoke
acpi_lid_open(), it should use a spec suggested control method lid device
usage model: register lid notification and use the notified value instead,
which is the only way to ensure the value is correct.

This patch fixes i915 driver to drop acpi_lid_open() user. It's not
possible to change nouveau_connector.c user using a simple way now. So this
patch only marks acpi_lid_open() as deprecated to accelerate this process
by indicating this change to the nouveau developers.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c             | 7 ++++++-
 drivers/gpu/drm/i915/intel_lvds.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 7ff3a75..50d7898 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -348,7 +348,12 @@ int acpi_lid_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(acpi_lid_notifier_unregister);
 
-int acpi_lid_open(void)
+/*
+ * The intentional usage model is to register a lid notifier and use the
+ * notified value instead. Directly evaluating _LID without seeing a
+ * Notify(lid, 0x80) is not reliable.
+ */
+int __deprecated acpi_lid_open(void)
 {
 	if (!lid_device)
 		return -ENODEV;
diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index 9ca4dc4..8ca9080 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -548,7 +548,7 @@ static int intel_lid_notify(struct notifier_block *nb, unsigned long val,
 	/* Don't force modeset on machines where it causes a GPU lockup */
 	if (dmi_check_system(intel_no_modeset_on_lid))
 		goto exit;
-	if (!acpi_lid_open()) {
+	if (!val) {
 		/* do modeset on next lid open event */
 		dev_priv->modeset_restore = MODESET_ON_LID_OPEN;
 		goto exit;
-- 
2.7.4

