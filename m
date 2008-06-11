From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] More cleanup of the thermal API
Date: Wed, 11 Jun 2008 17:42:26 +0100
Message-ID: <20080611164226.GA27437@srcf.ucam.org>
References: <20080611100647.GA20013@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54414 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbYFKQmb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 12:42:31 -0400
Content-Disposition: inline
In-Reply-To: <20080611100647.GA20013@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The state management functions in the thermal API also pass strings 
around. Change them to ints and do the conversion at the sysfs point.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 6cf10cb..f3db49e 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -69,27 +69,30 @@ static struct acpi_driver acpi_fan_driver = {
 };
 
 /* thermal cooling device callbacks */
-static int fan_get_max_state(struct thermal_cooling_device *cdev, char *buf)
+static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned int
+			     *state)
 {
 	/* ACPI fan device only support two states: ON/OFF */
-	return sprintf(buf, "1\n");
+	*state = 1;
+	return 0;
 }
 
-static int fan_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
+static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned int
+			     *state)
 {
 	struct acpi_device *device = cdev->devdata;
-	int state;
 	int result;
 
 	if (!device)
 		return -EINVAL;
 
-	result = acpi_bus_get_power(device->handle, &state);
+	result = acpi_bus_get_power(device->handle, state);
 	if (result)
 		return result;
 
-	return sprintf(buf, "%s\n", state == ACPI_STATE_D3 ? "0" :
-			 (state == ACPI_STATE_D0 ? "1" : "unknown"));
+	*state = (*state == ACPI_STATE_D3 ? 0 : 
+		 (*state == ACPI_STATE_D0 ? 1 : -1));
+	return 0;
 }
 
 static int
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index ef34b18..2a3721d 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -374,7 +374,8 @@ static int acpi_processor_max_state(struct acpi_processor *pr)
 	return max_state;
 }
 static int
-processor_get_max_state(struct thermal_cooling_device *cdev, char *buf)
+processor_get_max_state(struct thermal_cooling_device *cdev, unsigned int 
+			*state)
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_processor *pr = acpi_driver_data(device);
@@ -382,24 +383,24 @@ processor_get_max_state(struct thermal_cooling_device *cdev, char *buf)
 	if (!device || !pr)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", acpi_processor_max_state(pr));
+	*state = acpi_processor_max_state(pr);
+	return 0;
 }
 
 static int
-processor_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
+processor_get_cur_state(struct thermal_cooling_device *cdev, unsigned int 
+			*cur_state)
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_processor *pr = acpi_driver_data(device);
-	int cur_state;
 
 	if (!device || !pr)
 		return -EINVAL;
 
-	cur_state = cpufreq_get_cur_state(pr->id);
+	*cur_state = cpufreq_get_cur_state(pr->id);
 	if (pr->flags.throttling)
-		cur_state += pr->throttling.state;
-
-	return sprintf(buf, "%d\n", cur_state);
+		*cur_state += pr->throttling.state;
+	return 0;
 }
 
 static int
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 5e5dda3..d8d7596 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -358,26 +358,30 @@ static struct output_properties acpi_output_properties = {
 
 
 /* thermal cooling device callbacks */
-static int video_get_max_state(struct thermal_cooling_device *cdev, char *buf)
+static int video_get_max_state(struct thermal_cooling_device *cdev, unsigned
+			       int *state)
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
 
-	return sprintf(buf, "%d\n", video->brightness->count - 3);
+	*state = video->brightness->count - 3;
+	return 0;
 }
 
-static int video_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
+static int video_get_cur_state(struct thermal_cooling_device *cdev, unsigned
+			       int *state)
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
 	unsigned long level;
-	int state;
+	int offset;
 
 	acpi_video_device_lcd_get_level_current(video, &level);
-	for (state = 2; state < video->brightness->count; state++)
-		if (level == video->brightness->levels[state])
-			return sprintf(buf, "%d\n",
-				       video->brightness->count - state - 1);
+	for (offset = 2; offset < video->brightness->count; offset++)
+		if (level == video->brightness->levels[offset]) {
+			*state = video->brightness->count - offset - 1;
+			return 0;
+		}
 
 	return -EINVAL;
 }
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index c537a5b..02abaf0 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -249,8 +249,12 @@ thermal_cooling_device_max_state_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	int state, ret;
 
-	return cdev->ops->get_max_state(cdev, buf);
+	ret = cdev->ops->get_max_state(cdev, &state);
+	if (ret)
+		return ret;
+	return sprintf(buf, "%d\n", state);
 }
 
 static ssize_t
@@ -258,8 +262,12 @@ thermal_cooling_device_cur_state_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	int state, ret;
 
-	return cdev->ops->get_cur_state(cdev, buf);
+	ret = cdev->ops->get_cur_state(cdev, &state);
+	if (ret)
+		return ret;
+	return sprintf(buf, "%d\n", state);
 }
 
 static ssize_t
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 63e6619..5ddbd4f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -46,8 +46,8 @@ struct thermal_zone_device_ops {
 };
 
 struct thermal_cooling_device_ops {
-	int (*get_max_state) (struct thermal_cooling_device *, char *);
-	int (*get_cur_state) (struct thermal_cooling_device *, char *);
+	int (*get_max_state) (struct thermal_cooling_device *, unsigned int *);
+	int (*get_cur_state) (struct thermal_cooling_device *, unsigned int *);
 	int (*set_cur_state) (struct thermal_cooling_device *, unsigned int);
 };

-- 
Matthew Garrett | mjg59@srcf.ucam.org
