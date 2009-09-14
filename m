From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 2/4] ACPI: Remove uneccessary NULL assignments in acpi drivers
Date: Mon, 14 Sep 2009 17:09:27 +0100
Message-ID: <1252944569-29799-3-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1252944569-29799-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxout-08.mxes.net ([216.86.168.183]:63755 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016AbZINQJf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 12:09:35 -0400
In-Reply-To: <1252944569-29799-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: bjorn.helgaas@hp.com, linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The core is responsibile for clearing device->driverdata on removal.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/acpi/ec.c            |    1 -
 drivers/acpi/sbshc.c         |    1 -
 drivers/acpi/video.c         |    1 -
 drivers/hwmon/asus_atk0110.c |    2 --
 4 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 64a20ef..add6621 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -852,7 +852,6 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 	}
 	mutex_unlock(&ec->lock);
 	acpi_ec_remove_fs(device);
-	device->driver_data = NULL;
 	if (ec == first_ec)
 		first_ec = NULL;
 	kfree(ec);
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index d933980..8d89337 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -304,7 +304,6 @@ static int acpi_smbus_hc_remove(struct acpi_device *device, int type)
 	hc = acpi_driver_data(device);
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
 	kfree(hc);
-	device->driver_data = NULL;
 	return 0;
 }
 
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b51f1fe..f405807 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2345,7 +2345,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	acpi_video_bus_remove_fs(device);
  err_free_video:
 	kfree(video);
-	device->driver_data = NULL;
 
 	return error;
 }
diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index fe4fa29..7fc7625 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -982,8 +982,6 @@ static int atk_remove(struct acpi_device *device, int type)
 	struct atk_data *data = device->driver_data;
 	dev_dbg(&device->dev, "removing...\n");
 
-	device->driver_data = NULL;
-
 	atk_remove_files(data);
 	atk_free_sensors(data);
 	hwmon_device_unregister(data->hwmon_dev);
-- 
1.6.3.2

