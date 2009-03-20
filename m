From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Fri, 20 Mar 2009 02:18:37 +0100
Message-ID: <20090320011837.GA23183@gamma.logic.tuwien.ac.at>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090319212123.GA24700@srcf.ucam.org> <20090319213428.GK29624@gamma.logic.tuwien.ac.at> <20090319214437.GB24898@srcf.ucam.org> <20090319221527.GA11001@gamma.logic.tuwien.ac.at> <20090320002827.GB19755@gamma.logic.tuwien.ac.at> <20090320003823.GA27600@srcf.ucam.org> <20090320004043.GF19755@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mojUlQ0s9EVzWg2t"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:60602 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbZCTBSq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 21:18:46 -0400
Content-Disposition: inline
In-Reply-To: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320004043.GF19755@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Matthias Welwarsky <matze@welwarsky.de>
Cc: sony-vaio-z-series@lists.launchpad.net, malattia@linux.it, linux-acpi@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi all,

On Fr, 20 Mär 2009, Norbert Preining wrote:
> > As far as we can tell, the handling of the handover is consistent across 
> > all dual-GPU nvidia laptops[1]. The right place for support to end up is 
> > in the kernel component of the nouveau drivers.
> 
> Whatever the nouveau drivers are? You mean those based on the kernel
> mode swching? Unfortunately that is far from prime time, and we need
> power saving now.
> 
> I will take a look over the weekend maybe I can add a patch ontop of
> yours that only does that, taken from the code in the special vaio-Z
> sony-laptop module.

> Now it would be nice to merge over *only* the stuff concerning
> speed/stamina into the in-kernel driver added with the patch for rfkill
> support.

Ok, here is the code.

For those interested I Cc the  sony-vaio-z-series@lists.launchpad.net
group where I first found that modules.

You need:
	kernel 2.6.29-rc8	(maybe it works with all from .28 on)
	the patch Matthew sent 
	the attached patch

Together you get full rfkill support for bluetooth/wwan/wifi, plus afais
stamina-speed mode setting.

Maybe Matthias the creator of the sony-laptop for vaio-zseries modules
can take a look at the patch and see if I missed something.

Matthias: sony_led_off and sony_dgpu_sta is never used, is that
intentional? And also the #define SONY_WMMX_GUID I couldn't find being
used anywhere.

Maybe Matthew can take a look and fix the compile warnings in function
‘sony_ovga_dsm’ (there are some!).

My intention is that we do not digress too far from the kernel code of
sony-laptop making eventual merging possible.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
OSBASTON (n.)
A point made for the seventh time to somebody who insists that they
know exactly what you mean but clearly hasn't got the faintest idea.
			--- Douglas Adams, The Meaning of Liff

--mojUlQ0s9EVzWg2t
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="sony-laptop-stamina-speed.diff"

--- /usr/src/linux-2.6.29-rc8/drivers/platform/x86/sony-laptop.c	2009-03-19 22:52:44.000000000 +0100
+++ sony-laptop.c	2009-03-20 01:58:42.000000000 +0100
@@ -116,6 +116,11 @@
 		 "set this to 1 to enable Motion Eye camera controls "
 		 "(only use it if you have a C1VE or C1VN model)");
 
+static int speed_stamina;
+module_param(speed_stamina, int, 0444);
+MODULE_PARM_DESC(speed_stamina,
+		 "Set this to 1 to enable SPEED mode on module load (EXPERIMENTAL)");
+
 #ifdef CONFIG_SONYPI_COMPAT
 static int minor = -1;
 module_param(minor, int, 0);
@@ -482,8 +487,158 @@
 
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
+
 static atomic_t sony_pf_users = ATOMIC_INIT(0);
 static struct platform_driver sony_pf_driver = {
+	.probe  = sony_pf_probe,
+#ifdef CONFIG_PM
+	.resume_early = sony_pf_resume,
+#endif
 	.driver = {
 		   .name = "sony-laptop",
 		   .owner = THIS_MODULE,
@@ -1169,6 +1324,12 @@
 			dprintk("_INI Method failed\n");
 	}
 
+#if 0
+	/* try to _INI the ECON variable */
+	if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, &result))
+			dprintk("ECON Method failed\n");
+#endif
+
 	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN07",
 					 &handle))) {
 		dprintk("Doing SNC setup\n");

--mojUlQ0s9EVzWg2t--
