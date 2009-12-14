From: Mike Travis <travis@sgi.com>
Subject: [PATCH] ACPI: Remove repeated registered as cooling_device messages
Date: Mon, 14 Dec 2009 13:38:30 -0800
Message-ID: <4B26B056.3080708@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.179.30]:53524 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751253AbZLNVi3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2009 16:38:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

ACPI: Remove repeated registered as cooling_device messages

This message shows up for each cpu.  Print as debug messages.

[   12.893967] processor ACPI0007:00: registered as cooling_device0
[   12.907838] processor ACPI0007:01: registered as cooling_device1

Signed-off-by: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/acpi/fan.c            |    2 +-
 drivers/acpi/processor_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux.orig/drivers/acpi/fan.c
+++ linux/drivers/acpi/fan.c
@@ -267,7 +267,7 @@
 		goto end;
 	}
 
-	dev_info(&device->dev, "registered as cooling_device%d\n", cdev->id);
+	dev_dbg(&device->dev, "registered as cooling_device%d\n", cdev->id);
 
 	device->driver_data = cdev;
 	result = sysfs_create_link(&device->dev.kobj,
--- linux.orig/drivers/acpi/processor_core.c
+++ linux/drivers/acpi/processor_core.c
@@ -845,7 +845,7 @@
 		goto err_power_exit;
 	}
 
-	dev_info(&device->dev, "registered as cooling_device%d\n",
+	dev_dbg(&device->dev, "registered as cooling_device%d\n",
 		 pr->cdev->id);
 
 	result = sysfs_create_link(&device->dev.kobj,
