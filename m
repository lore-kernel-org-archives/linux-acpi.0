From: malattia@linux.it
Subject: [patch 6/9] additional platform attributes coming from SNY6001
Date: Mon, 9 Apr 2007 19:28:56 +0200
Message-ID: <20070409172856.GG10646@inferi.kami.home>
References: <20070409081903.057292676@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:56310 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbXDIRab (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2007 13:30:31 -0400
Content-Disposition: inline; filename="0006-add-SNY6001-platform-attributes.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, stelian@popies.net

Register additional platform attributes coming from the SPIC (sonypi) driver.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |  205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-05 15:33:26.285380581 +0200
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-05 15:33:32.785751095 +0200
@@ -774,7 +774,8 @@ static int sony_nc_add(struct acpi_devic
 
 	}
 
-	if (sony_pf_add())
+	result = sony_pf_add();
+	if (result)
 		goto outbacklight;
 
 	/* create sony_pf sysfs attributes related to the SNC device */
@@ -903,6 +904,8 @@ struct sony_pic_irq {
 
 struct sony_pic_dev {
 	int			model;
+	u8			camera_power;
+	u8			bluetooth_power;
 	struct acpi_device	*acpi_dev;
 	struct sony_pic_irq	*cur_irq;
 	struct sony_pic_ioport	*cur_ioport;
@@ -1181,6 +1184,186 @@ static u8 sony_pic_call2(u8 dev, u8 fn)
 	return v1;
 }
 
+static u8 sony_pic_call3(u8 dev, u8 fn, u8 v)
+{
+	u8 v1;
+
+	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2, ITERATIONS_LONG);
+	outb(dev, spic_dev.cur_ioport->io.minimum + 4);
+	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2, ITERATIONS_LONG);
+	outb(fn, spic_dev.cur_ioport->io.minimum);
+	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2, ITERATIONS_LONG);
+	outb(v, spic_dev.cur_ioport->io.minimum);
+	v1 = inb_p(spic_dev.cur_ioport->io.minimum);
+	dprintk("sony_pic_call3: 0x%.4x\n", v1);
+	return v1;
+}
+
+/* camera tests and poweron/poweroff */
+#define SONYPI_CAMERA_PICTURE		5
+#define SONYPI_CAMERA_MUTE_MASK		0x40
+#define SONYPI_CAMERA_CONTROL		0x10
+#define SONYPI_CAMERA_STATUS 		7
+#define SONYPI_CAMERA_STATUS_READY 	0x2
+#define SONYPI_CAMERA_STATUS_POSITION	0x4
+
+static int sony_pic_camera_ready(void)
+{
+	u8 v;
+
+	v = sony_pic_call2(0x8f, SONYPI_CAMERA_STATUS);
+	return (v != 0xff && (v & SONYPI_CAMERA_STATUS_READY));
+}
+
+static void sony_pic_camera_off(void)
+{
+	wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_PICTURE,
+				SONYPI_CAMERA_MUTE_MASK),
+			ITERATIONS_SHORT);
+
+	if (!spic_dev.camera_power)
+		return;
+
+	sony_pic_call2(0x91, 0);
+	spic_dev.camera_power = 0;
+}
+
+static void sony_pic_camera_on(void)
+{
+	int i, j;
+
+	if (spic_dev.camera_power)
+		return;
+
+	for (j = 5; j > 0; j--) {
+
+		while (sony_pic_call2(0x91, 0x1))
+			msleep(10);
+		sony_pic_call1(0x93);
+
+		for (i = 400; i > 0; i--) {
+			if (sony_pic_camera_ready())
+				break;
+			msleep(10);
+		}
+		if (i)
+			break;
+	}
+
+	if (j == 0) {
+		printk(KERN_WARNING "sonypi: failed to power on camera\n");
+		return;
+	}
+
+	wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_CONTROL,
+				0x5a),
+			ITERATIONS_SHORT);
+
+	spic_dev.camera_power = 1;
+}
+
+static ssize_t sony_pic_camerapower_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buffer, size_t count)
+{
+	unsigned long value;
+	if (count > 31)
+		return -EINVAL;
+
+	value = simple_strtoul(buffer, NULL, 10);
+	if (value)
+		sony_pic_camera_on();
+	else
+		sony_pic_camera_off();
+
+	return count;
+}
+
+static ssize_t sony_pic_camerapower_show(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	return snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.camera_power);
+}
+
+/* bluetooth subsystem power state */
+static void sony_pic_set_bluetoothpower(u8 state)
+{
+	state = !!state;
+	if (spic_dev.bluetooth_power == state)
+		return;
+	sony_pic_call2(0x96, state);
+	sony_pic_call1(0x82);
+	spic_dev.bluetooth_power = state;
+}
+
+static ssize_t sony_pic_bluetoothpower_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buffer, size_t count)
+{
+	unsigned long value;
+	if (count > 31)
+		return -EINVAL;
+
+	value = simple_strtoul(buffer, NULL, 10);
+	sony_pic_set_bluetoothpower(value);
+
+	return count;
+}
+
+static ssize_t sony_pic_bluetoothpower_show(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	return snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.bluetooth_power);
+}
+
+/* fan speed */
+/* FAN0 information (reverse engineered from ACPI tables) */
+#define SONY_PIC_FAN0_STATUS	0x93
+static ssize_t sony_pic_fanspeed_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buffer, size_t count)
+{
+	unsigned long value;
+	if (count > 31)
+		return -EINVAL;
+
+	value = simple_strtoul(buffer, NULL, 10);
+	if (ec_write(SONY_PIC_FAN0_STATUS, value))
+		return -EIO;
+
+	return count;
+}
+
+static ssize_t sony_pic_fanspeed_show(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	u8 value = 0;
+	if (ec_read(SONY_PIC_FAN0_STATUS, &value))
+		return -EIO;
+
+	return snprintf(buffer, PAGE_SIZE, "%d\n", value);
+}
+
+#define SPIC_ATTR(_name, _mode)					\
+struct device_attribute spic_attr_##_name = __ATTR(_name,	\
+		_mode, sony_pic_## _name ##_show,		\
+		sony_pic_## _name ##_store)
+
+static SPIC_ATTR(camerapower, 0644);
+static SPIC_ATTR(bluetoothpower, 0644);
+static SPIC_ATTR(fanspeed, 0644);
+
+static struct attribute *spic_attributes[] = {
+	&spic_attr_camerapower.attr,
+	&spic_attr_bluetoothpower.attr,
+	&spic_attr_fanspeed.attr,
+	NULL
+};
+
+static struct attribute_group spic_attribute_group = {
+	.attrs = spic_attributes
+};
+
 /*
  * ACPI callbacks
  */
@@ -1447,6 +1630,10 @@ static int sony_pic_remove(struct acpi_d
 
 	sony_laptop_remove_input();
 
+	/* pf attrs */
+	sysfs_remove_group(&sony_pf_device->dev.kobj, &spic_attribute_group);
+	sony_pf_remove();
+
 	list_for_each_entry_safe(io, tmp_io, &spic_dev.ioports, list) {
 		list_del(&io->list);
 		kfree(io);
@@ -1536,8 +1723,24 @@ static int sony_pic_add(struct acpi_devi
 		goto err_free_irq;
 	}
 
+	spic_dev.bluetooth_power = -1;
+	/* create device attributes */
+	result = sony_pf_add();
+	if (result)
+		goto err_disable_device;
+
+	result = sysfs_create_group(&sony_pf_device->dev.kobj, &spic_attribute_group);
+	if (result)
+		goto err_remove_pf;
+
 	return 0;
 
+err_remove_pf:
+	sony_pf_remove();
+
+err_disable_device:
+	sony_pic_disable(device);
+
 err_free_irq:
 	free_irq(spic_dev.cur_irq->irq.interrupts[0], &spic_dev);
 

--
-- 
mattia
:wq!
