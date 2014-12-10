From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] ACPI / Fan: Use bus id for non PNP0C0B (Fan) device
Date: Tue,  9 Dec 2014 16:15:40 -0800
Message-ID: <1418170540-8349-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1418170540-8349-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20467 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbaLJAQr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Dec 2014 19:16:47 -0500
In-Reply-To: <1418170540-8349-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The _ART (Active Cooling Relationship Table), specifies relationship
among heat generating sources to a target active cooling device like
fan. The _ART table refers to actual bus id name for specifying relationship.
Naming "Fan" is not enough as name in the _ART table can change on every
platform, to establish relationship for user space thermal controllers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/fan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index caf9b76..7a36f02 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -325,6 +325,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	struct thermal_cooling_device *cdev;
 	struct acpi_fan *fan;
 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	char *name;
 
 	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
 	if (!fan) {
@@ -346,7 +347,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		}
 	}
 
-	cdev = thermal_cooling_device_register("Fan", device,
+	if (!strncmp(pdev->name, "PNP0C0B", strlen("PNP0C0B")))
+		name = "Fan";
+	else
+		name = acpi_device_bid(device);
+
+	cdev = thermal_cooling_device_register(name, device,
 						&fan_cooling_ops);
 	if (IS_ERR(cdev)) {
 		result = PTR_ERR(cdev);
-- 
1.9.1

