From: Shanker Donthineni <shankerd@codeaurora.org>
Subject: [PATCH] ACPI : Update platform device numa node based on _PXM method
Date: Tue, 21 Mar 2017 09:54:30 -0500
Message-ID: <1490108070-24061-1-git-send-email-shankerd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Vikram Sethi <vikrams@codeaurora.org>, Shanker Donthineni <shankerd@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

The optional _PXM method evaluates to an integer that identifies the
proximity domain of a device object. This patch implements support for
ACPI _PXM method and updates the platform device numa node id using
acpi_get_node(), which provides the PXM to NUMA mapping information.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/acpi/acpi_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index b4c1a6a..83d953e 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -119,11 +119,14 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
 			PTR_ERR(pdev));
-	else
+	else {
+		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
 		dev_dbg(&adev->dev, "created platform device %s\n",
 			dev_name(&pdev->dev));
+	}
 
 	kfree(resources);
+
 	return pdev;
 }
 EXPORT_SYMBOL_GPL(acpi_create_platform_device);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
