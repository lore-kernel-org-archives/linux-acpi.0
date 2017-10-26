From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v16 29/32] et8ek8: Add support for flash and lens devices
Date: Thu, 26 Oct 2017 10:53:39 +0300
Message-ID: <20171026075342.5760-30-sakari.ailus@linux.intel.com>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: niklas.soderlund@ragnatech.se, maxime.ripard@free-electrons.com, hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, pavel@ucw.cz, sre@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Parse async sub-devices related to the sensor by switching the async
sub-device registration function.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/et8ek8/et8ek8_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
index c14f0fd6ded3..e9eff9039ef5 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -1453,7 +1453,7 @@ static int et8ek8_probe(struct i2c_client *client,
 		goto err_mutex;
 	}
 
-	ret = v4l2_async_register_subdev(&sensor->subdev);
+	ret = v4l2_async_register_subdev_sensor_common(&sensor->subdev);
 	if (ret < 0)
 		goto err_entity;
 
-- 
2.11.0
