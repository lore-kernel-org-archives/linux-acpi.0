From: Roland Dreier <rdreier@cisco.com>
Subject: [PATCH] ACPI: Get rid of "registered as cooling_deviceX" messages
Date: Mon, 28 Sep 2009 15:43:39 -0700
Message-ID: <adahbumwuzo.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70]:65133 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbZI1Wnh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2009 18:43:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The messages "<xyz> registered as cooling_deviceX" printed by various
ACPI drivers give the same information as just looking at the symlinks
/sys/class/thermal/cooling_deviceX/device.  On a big system, they
clutter up the syslog and take a long time to print on a serial console.

On a 64-thread system I've been lucky enough to play with:

    $ dmesg | grep 'registered as cooling_device' | wc
         64     448    4278

which is getting past tragedy and into the realm of comedy.  We may as
well not print these messages.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
Len, still more in my trimming of the boot log on my big box.  If this
makes sense to you, please apply.

Also I think <http://patchwork.kernel.org/patch/50048/> might have
gotten lost somewhere -- you applied the C-state version but not the
equivalent T-state patch.

 drivers/acpi/fan.c            |    2 --
 drivers/acpi/processor_core.c |    3 ---
 drivers/acpi/video.c          |    2 --
 3 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f419849..6bbc61d 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -267,8 +267,6 @@ static int acpi_fan_add(struct acpi_device *device)
 		goto end;
 	}
 
-	dev_info(&device->dev, "registered as cooling_device%d\n", cdev->id);
-
 	device->driver_data = cdev;
 	result = sysfs_create_link(&device->dev.kobj,
 				   &cdev->device.kobj,
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index c2d4d6e..3d6e95e 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -845,9 +845,6 @@ static int acpi_processor_add(struct acpi_device *device)
 		goto err_power_exit;
 	}
 
-	dev_info(&device->dev, "registered as cooling_device%d\n",
-		 pr->cdev->id);
-
 	result = sysfs_create_link(&device->dev.kobj,
 				   &pr->cdev->device.kobj,
 				   "thermal_cooling");
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index a4fddb2..3f67f4d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1022,8 +1022,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 			return;
 		}
 
-		dev_info(&device->dev->dev, "registered as cooling_device%d\n",
-			 device->cooling_dev->id);
 		result = sysfs_create_link(&device->dev->dev.kobj,
 				&device->cooling_dev->device.kobj,
 				"thermal_cooling");
