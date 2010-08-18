From: Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH 5/8] ideapad: use EC command to control camera
Date: Wed, 18 Aug 2010 16:38:15 +0800
Message-ID: <1282120695-11503-1-git-send-email-ike.pan@canonical.com>
References: <1282120564-11324-1-git-send-email-ike.pan@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51653 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab0HRIiV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Aug 2010 04:38:21 -0400
In-Reply-To: <1282120564-11324-1-git-send-email-ike.pan@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, David Woodhouse <David.Woodhouse@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>

Signed-off-by: Ike Panhc <ike.pan@canonical.com>
---
 drivers/platform/x86/ideapad_acpi.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/ideapad_acpi.c b/drivers/platform/x86/ideapad_acpi.c
index 673b44d..a1fdb45 100644
--- a/drivers/platform/x86/ideapad_acpi.c
+++ b/drivers/platform/x86/ideapad_acpi.c
@@ -35,6 +35,7 @@
 #define IDEAPAD_DEV_KILLSW	4
 
 struct ideapad_private {
+	acpi_handle handle;
 	struct rfkill *rfk[5];
 };
 
@@ -209,24 +210,28 @@ static ssize_t show_ideapad_cam(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	int state = ideapad_dev_get_state(IDEAPAD_DEV_CAMERA);
-	if (state < 0)
-		return state;
+	struct ideapad_private *priv = dev_get_drvdata(dev);
+	acpi_handle handle = priv->handle;
+	unsigned long result;
 
-	return sprintf(buf, "%d\n", state);
+	if (read_ec_data(handle, 0x1D, &result))
+		return sprintf(buf, "-1\n");
+	return sprintf(buf, "%lu\n", result);
 }
 
 static ssize_t store_ideapad_cam(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
+	struct ideapad_private *priv = dev_get_drvdata(dev);
+	acpi_handle handle = priv->handle;
 	int ret, state;
 
 	if (!count)
 		return 0;
 	if (sscanf(buf, "%i", &state) != 1)
 		return -EINVAL;
-	ret = ideapad_dev_set_state(IDEAPAD_DEV_CAMERA, !!state);
+	ret = write_ec_cmd(handle, 0x1E, state);
 	if (ret < 0)
 		return ret;
 	return count;
@@ -337,6 +342,7 @@ static int ideapad_acpi_add(struct acpi_device *adevice)
 		}
 	}
 
+	priv->handle = adevice->handle;
 	dev_set_drvdata(&adevice->dev, priv);
 	for (i = IDEAPAD_DEV_WLAN; i <= IDEAPAD_DEV_KILLSW; i++) {
 		if (!devs_present[i])
-- 
1.7.0.4

