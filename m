From: Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH 3/9] ideapad: make sure we bind on the correct device
Date: Fri,  1 Oct 2010 15:39:14 +0800
Message-ID: <1285918754-12942-1-git-send-email-ike.pan@canonical.com>
References: <1285918660-12802-1-git-send-email-ike.pan@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1285918660-12802-1-git-send-email-ike.pan@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Corentin Chary <corentincj@iksaif.net>, David Woodhouse <David.Woodhouse@intel.com>, Mario.Holbe@TU-Ilmenau.DE
List-Id: linux-acpi@vger.kernel.org

By reading from method _CFG to make sure we bind on the correct VPC2004 device.

Signed-off-by: Ike Panhc <ike.pan@canonical.com>
---
 drivers/platform/x86/ideapad_acpi.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/ideapad_acpi.c b/drivers/platform/x86/ideapad_acpi.c
index 15d7e7e..9face93 100644
--- a/drivers/platform/x86/ideapad_acpi.c
+++ b/drivers/platform/x86/ideapad_acpi.c
@@ -326,10 +326,13 @@ MODULE_DEVICE_TABLE(acpi, ideapad_device_ids);
 
 static int ideapad_acpi_add(struct acpi_device *adevice)
 {
-	int i;
+	int i, cfg;
 	int devs_present[5];
 	struct ideapad_private *priv;
 
+	if (read_method_int(adevice->handle, "_CFG", &cfg))
+		return -ENODEV;
+
 	for (i = IDEAPAD_DEV_CAMERA; i < IDEAPAD_DEV_KILLSW; i++) {
 		devs_present[i] = ideapad_dev_exists(i);
 		if (devs_present[i] < 0)
-- 
1.7.1
