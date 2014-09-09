From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] ACPI / platform / LPSS: disable async suspend/resume of LPSS
 devices
Date: Tue, 09 Sep 2014 13:36:48 +0800
Message-ID: <540E91F0.2060306@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

>From 6deb00230f5df68da3ca7490402a0c537bf386bb Mon Sep 17 00:00:00 2001
From: Fu Zhonghui <zhonghui.fu@linux.intel.com>
Date: Tue, 9 Sep 2014 13:02:25 +0800
Subject: [PATCH] ACPI / platform / LPSS: disable async suspend/resume of LPSS devices

LPSS devices must suspend/resume in fixed order. Or some LPSS devices
will hang during the transition to ACPI_STATE_D0 state.

Signed-off-by: Li Aubrey <aubrey.li@linux.intel.com>
Signed-off-by: Fu Zhonghui <zhonghui.fu@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index fddc1e8..54e5c97 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -419,7 +419,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev);
 	if (!IS_ERR_OR_NULL(pdev)) {
-		device_enable_async_suspend(&pdev->dev);
+		device_disable_async_suspend(&pdev->dev);
 		return 1;
 	}
 
-- 1.7.1
