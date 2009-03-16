From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: The Garbled screen issue on Sony laptops with two graphics
	(Intel and Nvidia)
Date: Mon, 16 Mar 2009 13:46:17 +0800
Message-ID: <1237182377.2807.157.camel@rzhang-dt>
References: <1236739527.2820.178.camel@rzhang-dt>
	 <20090311024652.GA14493@srcf.ucam.org>
	 <1236756550.2820.218.camel@rzhang-dt> <20090311130847.GC13101@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-/SJXcgEuri/FLP7A3LH+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8407 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbZCPFpf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Mar 2009 01:45:35 -0400
In-Reply-To: <20090311130847.GC13101@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-/SJXcgEuri/FLP7A3LH+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2009-03-11 at 21:08 +0800, Mattia Dongili wrote:
> On Wed, Mar 11, 2009 at 03:29:10PM +0800, Zhang Rui wrote:
> > On Wed, 2009-03-11 at 10:46 +0800, Matthew Garrett wrote:
> > > On Wed, Mar 11, 2009 at 10:45:27AM +0800, Zhang Rui wrote:
> > > 
> > > > The problem can be fixed by disabling Nvidia card via ACPI _DSM method.
> > > > And it seems that there are some works already done for this issue.
> > > > http://archive.netbsd.se/?ml=xorg&a=2009-02&t=9908058
> > > 
> > > This method is specific to Sony. What would be most helpful here would 
> > > be for Intel to tell us how this is actually meant to work. 
> > > 
> > Well, the change in sony-laptop driver is a new feature rather than a
> > bug fix.
> > the new sony-laptop driver introduces a new sysfs I/F:
> > /sys/devices/platform/sony-laptop/speed_stamina
> > and users can echo {speed, stamina} to this file to switch between
> > Intel and Nvidia graphics card.
> 
> and see their Xorg miserably die. ;)
> 
> Jokes aside, I have no big problem incorporating the differences in the
> driver, just that:
> - I can't test it
> - some models have different magic numbers for the _DSM invocation, from
>   the DSDT I have available:
> 	DSDT.sz.xxx.dsl (some uknown model)
> 	DSDT.sz61mn-forXP.dsl
> 	DSDT.tt11lnb.dsl
> 	DSDT.z11vn.dsl
> 	DSDT.z90s.dsl
> 	VGN-SZ4XWNC-R0111N0.dsl
>   and for what I can see, z and tt have the same magic numbers while the
>   sz has different ones. So the code that calls _DSM will need to have
>   some DMI switch to make sure we are calling it with the right
>   parameters (for now supporting z and tt might be enough)
> 
> I'll see what I can do (I accept patches in case someone feels like
> doing it)
I made a diff between the sony-laptop-zseries driver v0.5 and the
upstream kernel sony-laptop driver, it seems that we don't need to
change the current code a lot, only some code to play with _DSM method
is needed. the diff file is attached.

the sony-laptop-zseries driver can be found at
http://www.basyskom.org/~eva/log_installation_vaio_z21vnx.html

thanks,
rui

--=-/SJXcgEuri/FLP7A3LH+
Content-Disposition: attachment; filename=diff-sony-laptop
Content-Type: text/x-patch; name=diff-sony-laptop; charset=utf-8
Content-Transfer-Encoding: 7bit

--- drivers/platform/x86/sony-laptop.c	2009-01-12 09:40:55.000000000 +0800
+++ sony-laptop-zseries-0.5/sony-laptop.c	2009-02-15 18:56:26.000000000 +0800
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2004-2005 Stelian Pop <stelian@popies.net>
  * Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
+ * Copyright (C) 2009 Matthias Welwarsky <matze@welwarsky.de>
  *
  * Parts of this driver inspired from asus_acpi.c and ibm_acpi.c
  * which are copyrighted by their respective authors.
@@ -84,6 +85,8 @@
 #define SONY_PIC_HID		"SNY6001"
 #define SONY_PIC_DRIVER_NAME	"Sony Programmable IO Control Driver"
 
+#define SONY_WMMX_GUID "F6CB5C3C-9CAE-4EBD-B577-931EA32A2CC0"
+
 MODULE_AUTHOR("Stelian Pop, Mattia Dongili");
 MODULE_DESCRIPTION("Sony laptop extras driver (SPIC and SNC ACPI device)");
 MODULE_LICENSE("GPL");
@@ -115,6 +118,11 @@ MODULE_PARM_DESC(camera,
 		 "set this to 1 to enable Motion Eye camera controls "
 		 "(only use it if you have a C1VE or C1VN model)");
 
+static int speed_stamina;
+module_param(speed_stamina, int, 0444);
+MODULE_PARM_DESC(speed_stamina,
+		"Set this to 1 to enable SPEED mode on module load (EXPERIMENTAL)");
+
 #ifdef CONFIG_SONYPI_COMPAT
 static int minor = -1;
 module_param(minor, int, 0);
@@ -475,9 +483,158 @@ static void sony_laptop_remove_input(voi
 }
 
 /*********** Platform Device ***********/
+static int sony_ovga_dsm(int func, int arg)
+{
+	static const char *path = "\\_SB.PCI0.OVGA._DSM";
+	static const char muid[] = {
+		/*00*/	0xA0, 0xA0, 0x95, 0x9D, 0x60, 0x00, 0x48, 0x4D,		/* MUID */
+		/*08*/	0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4,
+	};
+
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_object_list input;
+	union acpi_object params[4];
+	union acpi_object *obj;
+	int result;
+
+	input.count = 4;
+	input.pointer = params;
+	params[0].type = ACPI_TYPE_BUFFER;
+	params[0].buffer.length = sizeof(muid);
+	params[0].buffer.pointer = muid;
+	params[1].type = ACPI_TYPE_INTEGER;
+	params[1].integer.value = 0x00000102;
+	params[2].type = ACPI_TYPE_INTEGER;
+	params[2].integer.value = func;
+	params[3].type = ACPI_TYPE_INTEGER;
+	params[3].integer.value = arg;
+
+	result = acpi_evaluate_object(NULL, path, &input, &output);
+	if (result) {
+		printk("%s failed: %d\n", path, result);
+		return -1;
+	}
+
+	obj = (union acpi_object*)output.pointer;
+	printk("result type %d\n", obj->type);
+	if (obj->type == ACPI_TYPE_PACKAGE) {
+		int i;
+		printk("returned package sized %d\n", obj->package.count);
+		for (i = 0; i < obj->package.count; i++)
+			printk("%d %08x\n", i, obj->package.elements[i].integer.value);
+	} else
+	if (obj->type == ACPI_TYPE_INTEGER) {
+		printk("returned integer %08X\n", obj->integer.value);
+	} else
+	if (obj->type == ACPI_TYPE_BUFFER) {
+		int i;
+		printk("returned buffer sized %d\n", obj->buffer.length);
+		for (i = 0; i < obj->buffer.length; i++)
+			printk("%d %02x\n", i, obj->buffer.pointer[i]);
+	}
+	kfree(output.pointer);
+
+	return 0;
+}
+
+static int sony_led_stamina(void)
+{
+	return sony_ovga_dsm(2, 0x11);
+}
+
+static int sony_led_speed(void)
+{
+	return sony_ovga_dsm(2, 0x12);
+}
+
+static int sony_led_off(void)
+{
+	return sony_ovga_dsm(2, 0x13);
+}
+
+static int sony_dgpu_sta(void)
+{
+	return sony_ovga_dsm(3, 0x00);
+}
+
+static int sony_dgpu_off(void)
+{
+	return sony_ovga_dsm(3, 0x02);
+}
+
+static int sony_dgpu_on(void)
+{
+	return sony_ovga_dsm(3, 0x01);
+}
+
+static ssize_t sony_pf_store_speed_stamina(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buffer, size_t count)
+{
+	if (!strncmp(buffer, "speed", strlen("speed"))) {
+		sony_dgpu_on();
+		sony_led_speed();
+		speed_stamina = 1;
+	} else
+	if (!strncmp(buffer, "stamina", strlen("stamina"))) {
+		sony_dgpu_off();
+		sony_led_stamina();
+		speed_stamina = 0;
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t sony_pf_show_speed_stamina(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	return snprintf(buffer, PAGE_SIZE, "%s\n", speed_stamina ? "speed":"stamina");
+}
+
+static struct device_attribute sony_pf_speed_stamina_attr =
+	__ATTR(speed_stamina, S_IWUSR|S_IRUGO,
+		sony_pf_show_speed_stamina, sony_pf_store_speed_stamina);
+
+static int sony_pf_probe(struct platform_device *pdev)
+{
+	int result;
+
+	result = device_create_file(&pdev->dev, &sony_pf_speed_stamina_attr);
+	if (result)
+		printk(KERN_DEBUG "sony_pf_probe: failed to add speed/stamina switch\n");
+
+	/* initialize default, look at module param speed_stamina */
+	if (speed_stamina == 1) {
+		sony_dgpu_on();
+		sony_led_speed();
+	} else {
+		sony_dgpu_off();
+		sony_led_stamina();
+	}
+
+	return 0;
+}
+
+static int sony_pf_resume(struct platform_device *pdev)
+{
+	/* on resume, restore previous state */
+	if (speed_stamina == 1) {
+		sony_dgpu_on();
+		sony_led_speed();
+	} else {
+		sony_dgpu_off();
+		sony_led_stamina();
+	}
+	return 0;
+}
 
 static atomic_t sony_pf_users = ATOMIC_INIT(0);
 static struct platform_driver sony_pf_driver = {
+	.probe  = sony_pf_probe,
+#ifdef CONFIG_PM
+	.resume_early = sony_pf_resume,
+#endif
 	.driver = {
 		   .name = "sony-laptop",
 		   .owner = THIS_MODULE,
@@ -775,6 +932,36 @@ static ssize_t sony_nc_sysfs_store(struc
 	return count;
 }
 
+/* WWAN power */
+static ssize_t sony_wwanpower_show(struct device *dev, struct device_attribute *attr,
+			      char *buffer)
+{
+	return 0;
+}
+
+static ssize_t sony_wwanpower_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buffer, size_t count)
+{
+	int value;
+
+	value = strtoul(buffer, NULL, 10);
+	if ( (value < 0) || (value > 1) )
+		return -EINVAL;
+
+	if (value) {
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x9f070803, NULL) < 0)
+			return -EIO;
+	} else {
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x00000803, NULL) < 0)
+			return -EIO;
+	}
+
+	return count;
+}
+
+static struct device_attribute wwanpower_attr =
+	__ATTR(snc_wwanpower, S_IRUGO|S_IWUSR, sony_wwanpower_show, sony_wwanpower_store);
 
 /*
  * Backlight device
@@ -889,6 +1076,15 @@ static const struct dmi_system_id sony_n
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-N"),
 			},
 		},
+		{
+			.ident = "Sony Vaio Z Series",
+			.callback = sony_nc_C_enable,
+			.driver_data = sony_C_events,
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-Z"),
+			},
+		},
 		{ }
 };
 
@@ -935,17 +1131,14 @@ static void sony_acpi_notify(acpi_handle
 static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 				      void *context, void **return_value)
 {
-	struct acpi_device_info *info;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *operand;
 
-	if (ACPI_SUCCESS(acpi_get_object_info(handle, &buffer))) {
-		info = buffer.pointer;
+	node = (struct acpi_namespace_node *)handle;
+	operand = (union acpi_operand_object *)node->object;
 
-		printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n",
-			(char *)&info->name, info->param_count);
-
-		kfree(buffer.pointer);
-	}
+	printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n", node->name.ascii,
+	       (u32) operand->method.param_count);
 
 	return AE_OK;
 }
@@ -973,7 +1166,7 @@ static int sony_nc_resume(struct acpi_de
 	/* set the last requested brightness level */
 	if (sony_backlight_device &&
 			!sony_backlight_update_status(sony_backlight_device))
-		printk(KERN_WARNING DRV_PFX "unable to restore brightness level\n");
+		printk(KERN_WARNING DRV_PFX "unable to restore brightness level");
 
 	/* re-initialize models with specific requirements */
 	dmi_check_system(sony_nc_ids);
@@ -1023,6 +1216,11 @@ static int sony_nc_add(struct acpi_devic
 						NULL, NULL)))
 			dprintk("_INI Method failed\n");
 	}
+#if 0
+	/* try to _INI the ECON variable */
+	if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, &result))
+			dprintk("ECON Method failed\n");
+#endif
 
 	/* setup input devices and helper fifo */
 	result = sony_laptop_setup_input(device);
@@ -1042,7 +1240,7 @@ static int sony_nc_add(struct acpi_devic
 	}
 
 	if (acpi_video_backlight_support()) {
-		printk(KERN_INFO DRV_PFX "brightness ignored, must be "
+		printk(KERN_INFO DRV_PFX "Sony: Brightness ignored, must be "
 		       "controlled by ACPI video driver\n");
 	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
 						&handle))) {
@@ -1109,6 +1307,10 @@ static int sony_nc_add(struct acpi_devic
 		}
 	}
 
+	result = device_create_file(&sony_pf_device->dev, &wwanpower_attr);
+	if (result)
+		goto out_sysfs;
+
 	return 0;
 
       out_sysfs:
@@ -1927,6 +2129,7 @@ static int sonypi_misc_fasync(int fd, st
 
 static int sonypi_misc_release(struct inode *inode, struct file *file)
 {
+	sonypi_misc_fasync(-1, file, 0);
 	atomic_dec(&sonypi_compat.open_count);
 	return 0;
 }

--=-/SJXcgEuri/FLP7A3LH+--

