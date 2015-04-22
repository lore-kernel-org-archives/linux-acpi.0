From: Kast Bernd <kastbernd@gmx.de>
Subject: [RFC 2/2] asus-wmi: add fan control
Date: Wed, 22 Apr 2015 16:12:23 +0200
Message-ID: <d0b3b325b529ec98e16b0729e6a8dcb5674a3901.1429653764.git.kastbernd@gmx.de>
References: <cover.1429653764.git.kastbernd@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1429653764.git.kastbernd@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: corentin.chary@gmail.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dvhart@infradead.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch is partially based on Felipe Contrera's earlier patch, that
was discussed here: https://lkml.org/lkml/2013/10/8/800
Some problems of that patch are fixed, now:

1) The main downside of the earlier patch seemed to be the use of
virt_to_phys, thus an acpi-version of that function is used now.
(provided by the first patch of this patchset)

2) random memory corruption occurred on my notebook, thus DMA-able memory
is allocated now, which solves this problem

3) hwmon interface is used instead of the thermal interface, as a
hwmon device is already set up by this driver and seemed more
appropriate than the thermal interface

4) Calling the ACPI-functions was modularized thus it's possible to call
some multifunctions easily, now (by using
asus_wmi_evaluate_method_agfn).

Unfortunately the WMI doesn't support controlling both fans on
a dual-fan notebooks because of an restriction in the acpi-method
"SFNS", that is callable through the wmi. If "SFNV" would be called
direcly even dual fan configurations could be controlled, but not by using
wmi.

Speed readings only work on auto-mode, thus "-1" will be reported in
manual mode.
Additionally the speed readings are reported as hundreds of RPM thus
they are not too precize.

This patch is tested only on one notebook (N551JK) but a similar module,
that contained some code to try to control the second fan also, was
reported to work on an UX32VD, at least for the first fan.

As Felipe already mentioned the low-level functions are described here:
http://forum.notebookreview.com/threads/fan-control-on-asus-prime-ux31-ux31a-ux32a-ux32vd.705656/

Signed-off-by: Kast Bernd <kastbernd@gmx.de>
---
 drivers/platform/x86/asus-wmi.c | 297 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 277 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7543a56..b16658a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -78,6 +78,7 @@ MODULE_LICENSE("GPL");
 #define ASUS_WMI_METHODID_GPID		0x44495047 /* Get Panel ID?? (Resol) */
 #define ASUS_WMI_METHODID_QMOD		0x444F4D51 /* Quiet MODe */
 #define ASUS_WMI_METHODID_SPLV		0x4C425053 /* Set Panel Light Value */
+#define ASUS_WMI_METHODID_AGFN		0x4E464741 /* ?? FaN?*/
 #define ASUS_WMI_METHODID_SFUN		0x4E554653 /* FUNCtionalities */
 #define ASUS_WMI_METHODID_SDSP		0x50534453 /* Set DiSPlay output */
 #define ASUS_WMI_METHODID_GDSP		0x50534447 /* Get DiSPlay output */
@@ -150,11 +151,27 @@ MODULE_LICENSE("GPL");
 #define ASUS_WMI_DSTS_BRIGHTNESS_MASK	0x000000FF
 #define ASUS_WMI_DSTS_MAX_BRIGTH_MASK	0x0000FF00
 
+#define ASUS_FAN_DESC "cpu_fan"
+
 struct bios_args {
 	u32 arg0;
 	u32 arg1;
 } __packed;
 
+struct agfn_args {
+	u16 mfun;
+	u16 sfun;
+	u16 len;
+	u8 stas;
+	u8 err;
+} __packed;
+
+struct fan_args {
+	struct agfn_args agfn;
+	u8 fan;
+	u32 speed;
+} __packed;
+
 /*
  * <platform>/    - debugfs root directory
  *   dev_id      - current dev_id
@@ -204,6 +221,10 @@ struct asus_wmi {
 	struct asus_rfkill gps;
 	struct asus_rfkill uwb;
 
+	int asus_hwmon_pwm;
+	int asus_hwmon_num_fans;
+	int asus_hwmon_fan_manual_mode;
+
 	struct hotplug_slot *hotplug_slot;
 	struct mutex hotplug_lock;
 	struct mutex wmi_lock;
@@ -294,6 +315,39 @@ exit:
 	return 0;
 }
 
+static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
+{
+	struct acpi_buffer input;
+	u32 status;
+	u64 phys_addr;
+	u32 retval;
+
+	/* copy to dma capable address */
+	input.pointer = kzalloc(args.length, GFP_DMA | GFP_KERNEL);
+	input.length = args.length;
+	if (!input.pointer)
+		return -ENOMEM;
+
+	if (acpi_os_get_physical_address(input.pointer, &phys_addr) != AE_OK)
+		goto fail;
+
+	memcpy(input.pointer, args.pointer, args.length);
+
+	status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_AGFN, phys_addr, 0,
+					  &retval);
+	if (status < 0)
+		goto fail;
+
+	memcpy(args.pointer, input.pointer, args.length);
+
+	kfree(input.pointer);
+	return retval;
+
+fail:
+	kfree(input.pointer);
+	return -1;
+}
+
 static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 {
 	return asus_wmi_evaluate_method(asus->dsts_id, dev_id, 0, retval);
@@ -1022,35 +1076,187 @@ exit:
 /*
  * Hwmon device
  */
-static ssize_t asus_hwmon_pwm1(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
+static int asus_hwmon_agfn_fan_speed(struct asus_wmi *asus, int write, int fan,
+				     int *speed)
+{
+	int status;
+
+	struct fan_args args = {
+		.agfn.len = sizeof(args),
+		.agfn.mfun = 0x13,
+		.agfn.sfun = write ? 0x07 : 0x06,
+		.fan = fan,
+		.speed = speed ? write ? *speed : 0 : 0,
+	};
+
+	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
+
+	status = asus_wmi_evaluate_method_agfn(input);
+
+	if (status || args.agfn.err)
+		return -1;
+
+	if (!speed)
+		return 0;
+
+	if (write) {
+		if (fan == 1 || fan == 2)
+			asus->asus_hwmon_pwm = fan > 0 ? *speed : -1;
+	} else {
+		*speed = args.speed;
+	}
+
+	return 0;
+}
+
+static int asus_hwmon_get_fan_number(struct asus_wmi *asus, int *num_fans)
+{
+	int status;
+	int speed = 0;
+
+	*num_fans = 0;
+
+	status = asus_hwmon_agfn_fan_speed(asus, 0, 1, &speed);
+	if (status)
+		return 0;
+
+	*num_fans = 1;
+	return 0;
+}
+
+static int asus_hwmon_fan_set_auto(struct asus_wmi *asus)
 {
+	int status;
+
+	status = asus_hwmon_agfn_fan_speed(asus, 1, 0, 0);
+	if (!status) {
+		asus->asus_hwmon_fan_manual_mode = 0;
+		return 0;
+	} else {
+		return -1;
+	}
+}
+
+static int asus_hwmon_fan_rpm_show(struct device *dev, int fan)
+{
+	int value;
+	int state;
 	struct asus_wmi *asus = dev_get_drvdata(dev);
-	u32 value;
+
+	/* no speed readable on manual mode */
+	if (asus->asus_hwmon_fan_manual_mode) {
+		value = -1;
+	} else {
+		state = asus_hwmon_agfn_fan_speed(asus, 0, fan+1, &value);
+		if (state) {
+			value = -1;
+			pr_warn("reading fan speed failed: %d\n", state);
+		}
+	}
+	return value;
+}
+
+static void asus_hwmon_pwm_show(struct asus_wmi *asus, int fan, int *value)
+{
 	int err;
 
-	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_CTRL, &value);
+	if (asus->asus_hwmon_pwm >= 0) {
+		*value = asus->asus_hwmon_pwm;
+		return;
+	}
 
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_CTRL, value);
 	if (err < 0)
-		return err;
-
-	value &= 0xFF;
+		return;
 
-	if (value == 1) /* Low Speed */
-		value = 85;
-	else if (value == 2)
-		value = 170;
-	else if (value == 3)
-		value = 255;
-	else if (value != 0) {
-		pr_err("Unknown fan speed %#x\n", value);
-		value = -1;
+	*value &= 0xFF;
+
+	if (*value == 1) /* Low Speed */
+		*value = 85;
+	else if (*value == 2)
+		*value = 170;
+	else if (*value == 3)
+		*value = 255;
+	else if (*value) {
+		pr_err("Unknown fan speed %#x\n", *value);
+		*value = -1;
 	}
+}
 
+static ssize_t asus_hwmon_pwm1_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int value;
+
+	asus_hwmon_pwm_show(asus, 0, &value);
 	return sprintf(buf, "%d\n", value);
 }
 
+static ssize_t asus_hwmon_pwm1_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count) {
+	int value;
+	int state;
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	kstrtouint(buf, 10, &value);
+	if (value > 255)
+		value = 255;
+
+	state = asus_hwmon_agfn_fan_speed(asus, 1, 1, &value);
+	if (state)
+		pr_warn("Setting fan speed failed: %d\n", state);
+	else
+		asus->asus_hwmon_fan_manual_mode = 1;
+
+	return count;
+}
+
+static ssize_t asus_hwmon_fan1_rpm_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int value = asus_hwmon_fan_rpm_show(dev, 0);
+
+	return sprintf(buf, "%d\n", value < 0 ? value : value*100);
+
+}
+
+static ssize_t asus_hwmon_cur_control_state_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", asus->asus_hwmon_fan_manual_mode);
+}
+
+static ssize_t asus_hwmon_cur_control_state_store(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf, size_t count)
+{
+	int state;
+	int status;
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	kstrtouint(buf, 10, &state);
+	if (state == 0 || state == 2)
+		status = asus_hwmon_fan_set_auto(asus);
+	else if (state == 1)
+		asus->asus_hwmon_fan_manual_mode = state;
+
+	return count;
+}
+
+static ssize_t asus_hwmon_fan1_label_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sprintf(buf, "%s\n", ASUS_FAN_DESC);
+}
+
 static ssize_t asus_hwmon_temp1(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -1069,11 +1275,24 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 	return sprintf(buf, "%d\n", value);
 }
 
-static DEVICE_ATTR(pwm1, S_IRUGO, asus_hwmon_pwm1, NULL);
+/* Fan1 */
+static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, asus_hwmon_pwm1_show,
+		   asus_hwmon_pwm1_store);
+static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
+		   asus_hwmon_cur_control_state_show,
+		   asus_hwmon_cur_control_state_store);
+static DEVICE_ATTR(fan1_input, S_IRUGO, asus_hwmon_fan1_rpm_show, NULL);
+static DEVICE_ATTR(fan1_label, S_IRUGO, asus_hwmon_fan1_label_show, NULL);
+
+/* Temperature */
 static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
 
 static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm1.attr,
+	&dev_attr_pwm1_enable.attr,
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_label.attr,
+
 	&dev_attr_temp1_input.attr,
 	NULL
 };
@@ -1086,6 +1305,7 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	struct asus_wmi *asus = platform_get_drvdata(pdev);
 	bool ok = true;
 	int dev_id = -1;
+	int fan_attr = -1;
 	u32 value = ASUS_WMI_UNSUPPORTED_METHOD;
 
 	if (attr == &dev_attr_pwm1.attr)
@@ -1093,10 +1313,18 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_temp1_input.attr)
 		dev_id = ASUS_WMI_DEVID_THERMAL_CTRL;
 
+
+	if (attr == &dev_attr_fan1_input.attr
+	    || attr == &dev_attr_fan1_label.attr
+	    || attr == &dev_attr_pwm1.attr
+	    || attr == &dev_attr_pwm1_enable.attr) {
+		fan_attr = 1;
+	}
+
 	if (dev_id != -1) {
 		int err = asus_wmi_get_devstate(asus, dev_id, &value);
 
-		if (err < 0)
+		if (err < 0 && fan_attr == -1)
 			return 0; /* can't return negative here */
 	}
 
@@ -1112,10 +1340,16 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 		if (value == ASUS_WMI_UNSUPPORTED_METHOD || value & 0xFFF80000
 		    || (!asus->sfun && !(value & ASUS_WMI_DSTS_PRESENCE_BIT)))
 			ok = false;
+		else
+			ok = fan_attr <= asus->asus_hwmon_num_fans;
 	} else if (dev_id == ASUS_WMI_DEVID_THERMAL_CTRL) {
 		/* If value is zero, something is clearly wrong */
-		if (value == 0)
+		if (!value)
 			ok = false;
+	} else if (fan_attr <= asus->asus_hwmon_num_fans && fan_attr != -1) {
+		ok = true;
+	} else {
+		ok = false;
 	}
 
 	return ok ? attr->mode : 0;
@@ -1723,6 +1957,25 @@ error_debugfs:
 	return -ENOMEM;
 }
 
+static int asus_wmi_fan_init(struct asus_wmi *asus)
+{
+	int status;
+
+	asus->asus_hwmon_pwm = -1;
+	asus->asus_hwmon_num_fans = -1;
+	asus->asus_hwmon_fan_manual_mode = 0;
+
+	status = asus_hwmon_get_fan_number(asus, &asus->asus_hwmon_num_fans);
+	if (status) {
+		asus->asus_hwmon_num_fans = 0;
+		pr_warn("Could not determine number of fans: %d\n", status);
+		return -1;
+	}
+
+	pr_info("Number of fans: %d\n", asus->asus_hwmon_num_fans);
+	return 0;
+}
+
 /*
  * WMI Driver
  */
@@ -1756,6 +2009,9 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_input;
 
+	err = asus_wmi_fan_init(asus); /* probably no problems on error */
+	asus_hwmon_fan_set_auto(asus);
+
 	err = asus_wmi_hwmon_init(asus);
 	if (err)
 		goto fail_hwmon;
@@ -1832,6 +2088,7 @@ static int asus_wmi_remove(struct platform_device *device)
 	asus_wmi_rfkill_exit(asus);
 	asus_wmi_debugfs_exit(asus);
 	asus_wmi_platform_exit(asus);
+	asus_hwmon_fan_set_auto(asus);
 
 	kfree(asus);
 	return 0;
-- 
2.3.5
