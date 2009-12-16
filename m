From: Len Brown <lenb@kernel.org>
Subject: [PATCH 091/103] ACPI: Remove repeated registered as cooling_device
 messages
Date: Wed, 16 Dec 2009 03:36:42 -0500
Message-ID: <13c41157096f05d5037a99152b4cf9d68ef00ef7.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760925AbZLPMGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:06:00 -0500
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mike Travis <travis@sgi.com>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Mike Travis <travis@sgi.com>

This message shows up for each cpu.  Print as debug messages.

[   12.893967] processor ACPI0007:00: registered as cooling_device0
[   12.907838] processor ACPI0007:01: registered as cooling_device1

Signed-off-by: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/fan.c            |    2 +-
 drivers/acpi/processor_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f419849..acf2ab2 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -267,7 +267,7 @@ static int acpi_fan_add(struct acpi_device *device)
 		goto end;
 	}
 
-	dev_info(&device->dev, "registered as cooling_device%d\n", cdev->id);
+	dev_dbg(&device->dev, "registered as cooling_device%d\n", cdev->id);
 
 	device->driver_data = cdev;
 	result = sysfs_create_link(&device->dev.kobj,
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index ec742a4..ecb2c51 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -845,7 +845,7 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		goto err_power_exit;
 	}
 
-	dev_info(&device->dev, "registered as cooling_device%d\n",
+	dev_dbg(&device->dev, "registered as cooling_device%d\n",
 		 pr->cdev->id);
 
 	result = sysfs_create_link(&device->dev.kobj,
-- 
1.6.0.6

