From: Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] WDRT based watchdog timer
Date: Fri, 26 Sep 2008 17:27:52 -0600
Message-ID: <20080926232752.GA6061@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:46788 "EHLO
	SG2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYIZXZm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 19:25:42 -0400
Received: from mail102-sin (localhost.localdomain [127.0.0.1])	by
 mail102-sin-R.bigfish.com (Postfix) with ESMTP id 1404C5303A0	for
 <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 23:25:40 +0000 (UTC)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail102-sin.bigfish.com (Postfix) with
 ESMTP id 2D5F885807D	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008
 23:25:37 +0000 (UTC)
Received: from ausb3twp02.amd.com ([163.181.250.38])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 m8QNPW5f002049	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 18:25:35
 -0500
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp02.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2400916A0652	for
 <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 18:25:16 -0500 (CDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Attached is a patch to support watchdog timers as described
by the WDRT (Watch Dog Resource Table).  This has been tested on
the AMD SB600 chipset, but it should work for any chipset / BIOS
that implements the WDRT table.

I'm not in love with the name - but I couldn't think of anything
better, so I'm open to suggestions.  I have a limited number of
systems that implement this interface, so I would be very happy
to hear from other users, especially ones not using AMD chipsets.

Thanks,
Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.

--BXVAT5kNtrzKuDFl
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: inline; filename="acpi-watchdog.patch"

[PATCH]:  Add a watchdog driver for the ACPI WDRT table

From: Jordan Crouse <jordan.crouse@amd.com>

A watchdog timer driver for systems with that implement hardware
timers described by the ACPI Watchdog Resource Table (WRDT).

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 MAINTAINERS                |    7 +
 drivers/watchdog/Kconfig   |   10 +
 drivers/watchdog/Makefile  |    1 
 drivers/watchdog/acpiwdt.c |  338 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 356 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3596d17..8500456 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -277,6 +277,13 @@ L:	linux-acpi@vger.kernel.org
 W:	http://www.lesswatts.org/projects/acpi/
 S:	Maintained
 
+ACPI WATCHDOG DRIVER
+P:     Jordan Crouse
+M:     jordan.crouse@amd.com
+L:     linux-acpi@vger.kernel.org
+W:     http://www.lesswatts.org/projects/acpi/
+S:     Maintained
+
 AD1889 ALSA SOUND DRIVER
 P:	Kyle McMartin
 M:	kyle@mcmartin.ca
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c510367..bf8ce27 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -249,6 +249,16 @@ config BFIN_WDT
 
 # X86 (i386 + ia64 + x86_64) Architecture
 
+config ACPI_WDT
+	tristate "ACPI WDRT Watchdog Timer"
+	depends on X86 && ACPI
+	---help---
+	  This driver supports hardware watchdog timer implementations
+	  described by the Watchdog Resource Table (WDRT) ACPI table.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called acpiwdt.
+
 config ACQUIRE_WDT
 	tristate "Acquire SBC Watchdog Timer"
 	depends on X86
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index e0ef123..d03167c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_BFIN_WDT) += bfin_wdt.o
 # H8300 Architecture
 
 # X86 (i386 + ia64 + x86_64) Architecture
+obj-$(CONFIG_ACPI_WDT) += acpiwdt.o
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
 obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
 obj-$(CONFIG_ALIM1535_WDT) += alim1535_wdt.o
diff --git a/drivers/watchdog/acpiwdt.c b/drivers/watchdog/acpiwdt.c
new file mode 100644
index 0000000..b6bcd52
--- /dev/null
+++ b/drivers/watchdog/acpiwdt.c
@@ -0,0 +1,338 @@
+/* Driver for systems that implement hardware watchdog
+ * timers described by the ACPI Watchdog Resource Table (WDRT)
+ *
+ * Copyright (C) 2008, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version
+ * 2 of the License
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/acpi.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
+#include <acpi/actbl.h>
+
+#define PFX "acpiwdt: "
+
+#define WATCHDOG_TIMEOUT 60
+#define WDT_FLAGS_OPEN 1
+#define WDT_FLAGS_ORPHAN 2
+
+static int timeout = WATCHDOG_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, default="
+		 __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static u32 wdt_flags;
+static int expect_close;
+
+/* ACPI WDRT table */
+
+struct wdrt_table {
+	struct acpi_table_header header;
+	struct acpi_generic_address ctrl_addr;
+	struct acpi_generic_address count_addr;
+	u16 pci_devid;
+	u16 pci_venid;
+	u8 pci_bus;
+	u8 pci_device;
+	u8 pci_function;
+	u8 pci_segment;
+	u16 max_count;
+	u8 units;
+} __attribute__ ((packed));
+
+/* Bit definitions for the control register */
+
+#define WDT_CTRL_TRIGGER (1 << 7)
+#define WDT_CTRL_DISABLE (1 << 3)
+#define WDT_CTRL_ACTION  (1 << 2)
+#define WDT_CTRL_FIRED   (1 << 1)
+#define WDT_CTRL_RUN     (1 << 0)
+
+static u64 *wdt_ctrl_reg;	/* Address of the control register */
+static u64 *wdt_count_reg;	/* Address of the count register */
+
+static u32 wdt_units;		/* Number of milliseconds per tick */
+static u32 wdt_max_count;	/* Maximum number of ticks */
+
+static void acpiwdt_ping(void)
+{
+	u32 count = (timeout * 1000) / wdt_units;
+	u32 val;
+
+	/* Write the timeout to the counter */
+	writel(count, wdt_count_reg);
+
+	/* Hit the trigger bit */
+	val = readl(wdt_ctrl_reg);
+	writel(val | WDT_CTRL_TRIGGER, wdt_ctrl_reg);
+}
+
+static void acpiwdt_disable(void)
+{
+	u32 val = readl(wdt_ctrl_reg);
+	writel(val & ~WDT_CTRL_RUN, wdt_ctrl_reg);
+}
+
+static int acpiwdt_set_heartbeat(unsigned int interval)
+{
+	u32 val;
+
+	/* Make sure the interval is sane */
+
+	if (((interval * 1000) / wdt_units) > wdt_max_count)
+		return -EINVAL;
+
+	/* Enable the timer */
+
+	val = readl(wdt_ctrl_reg);
+	writel(val | WDT_CTRL_RUN, wdt_ctrl_reg);
+
+	timeout = interval;
+
+	return 0;
+}
+
+static int acpiwdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(WDT_FLAGS_OPEN, &wdt_flags))
+		return -EBUSY;
+	if (!test_and_clear_bit(WDT_FLAGS_ORPHAN, &wdt_flags))
+		__module_get(THIS_MODULE);
+
+	acpiwdt_ping();
+	return nonseekable_open(inode, file);
+}
+
+static int acpiwdt_release(struct inode *inode, struct file *file)
+{
+	if (expect_close) {
+		acpiwdt_disable();
+		module_put(THIS_MODULE);
+	} else {
+		printk(KERN_CRIT PFX
+			"Unexpected close - watchdog is not stopping\n");
+		acpiwdt_ping();
+		set_bit(WDT_FLAGS_ORPHAN, &wdt_flags);
+	}
+
+	clear_bit(WDT_FLAGS_OPEN, &wdt_flags);
+	expect_close = 0;
+	return 0;
+}
+
+static ssize_t acpiwdt_write(struct file *file, const char __user *buf,
+			size_t len, loff_t *ppos)
+{
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+			expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 42;
+			}
+		}
+
+		acpiwdt_ping();
+	}
+
+	return len;
+}
+
+static struct watchdog_info ident = {
+	.options = WDIOF_SETTIMEOUT |
+		   WDIOF_KEEPALIVEPING |
+		   WDIOF_MAGICCLOSE,
+	.identity = "ACPI Watchdog Timer",
+};
+
+static long acpiwdt_ioctl(struct file *file,
+			unsigned cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *) arg;
+	int __user *p = argp;
+	int new_timeout;
+	int options;
+	int ret = 0;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user(argp, &ident, sizeof(ident)))
+			ret = -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		ret = put_user(0, p);
+		break;
+
+	case WDIOC_SETOPTIONS:
+		ret = -EINVAL;
+
+		if (get_user(options, p)) {
+			ret = -EFAULT;
+			break;
+		}
+		if (options & WDIOS_DISABLECARD) {
+			acpiwdt_disable();
+			ret = 0;
+		}
+
+		if (options & WDIOS_ENABLECARD) {
+			acpiwdt_ping();
+			ret = 0;
+		}
+		break;
+
+	case WDIOC_KEEPALIVE:
+		acpiwdt_ping();
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(new_timeout, p);
+		if (ret)
+			break;
+		ret = acpiwdt_set_heartbeat(new_timeout);
+		if (ret)
+			break;
+
+		acpiwdt_ping();
+		/* fall through */
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(timeout, p);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations acpiwdt_fops = {
+	.owner          = THIS_MODULE,
+	.llseek         = no_llseek,
+	.write          = acpiwdt_write,
+	.unlocked_ioctl = acpiwdt_ioctl,
+	.open           = acpiwdt_open,
+	.release        = acpiwdt_release,
+};
+
+static struct miscdevice acpiwdt_miscdev = {
+	.minor          = WATCHDOG_MINOR,
+	.name           = "watchdog",
+	.fops           = &acpiwdt_fops,
+};
+
+static int __init acpiwdt_init(void)
+{
+	struct wdrt_table *wdrt;
+	acpi_status status;
+	u32 val;
+	int ret = -ENODEV;
+
+	status = acpi_get_table(ACPI_SIG_WDRT, 0,
+				(struct acpi_table_header **) &wdrt);
+
+	/* Silently return if there is no WDRT table */
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	wdt_ctrl_reg = ioremap(wdrt->ctrl_addr.address, sizeof(u64));
+	wdt_count_reg = ioremap(wdrt->count_addr.address, sizeof(u64));
+
+	if (wdt_ctrl_reg == NULL || wdt_count_reg == NULL)
+		goto err;
+
+	val = readl(wdt_ctrl_reg);
+
+	if (val & WDT_CTRL_DISABLE) {
+		/* Try to enable the watchdog timer if we can - some
+		 * implementations may not allow this
+		 */
+
+		writel(val & ~WDT_CTRL_DISABLE, wdt_ctrl_reg);
+
+		val = readl(wdt_ctrl_reg);
+
+		if (val & WDT_CTRL_DISABLE) {
+			printk(KERN_ERR PFX
+				"Timer is disabled by the firmware\n");
+			goto err;
+		}
+	}
+
+	wdt_max_count = wdrt->max_count;
+
+	switch (wdrt->units) {
+	case 0:  /* 1 sec/count */
+		wdt_units = 1000;
+		break;
+	case 1: /* 100 ms/count */
+		wdt_units = 100;
+		break;
+	case 2: /* 10 ms/count */
+		wdt_units = 10;
+		break;
+	}
+
+	if (acpiwdt_set_heartbeat(timeout)) {
+		acpiwdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk(KERN_INFO PFX
+			"The timeout must be > 0 and < %d seconds. Using %d\n",
+			 (wdt_units * 0xFFFF) / 1000, WATCHDOG_TIMEOUT);
+	}
+
+	ret = misc_register(&acpiwdt_miscdev);
+
+	if (ret) {
+		printk(KERN_ERR PFX "Could not register misc device\n");
+		goto err;
+	}
+
+	printk(KERN_INFO PFX "ACPI WRDT Watchdog Timer initialized\n");
+	return 0;
+
+err:
+	if (wdt_ctrl_reg != NULL)
+		iounmap(wdt_ctrl_reg);
+
+	if (wdt_count_reg != NULL)
+		iounmap(wdt_count_reg);
+
+	return ret;
+}
+
+static void __exit acpiwdt_exit(void)
+{
+	iounmap(wdt_ctrl_reg);
+	iounmap(wdt_count_reg);
+
+	misc_deregister(&acpiwdt_miscdev);
+}
+
+module_init(acpiwdt_init);
+module_exit(acpiwdt_exit);
+
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
+MODULE_DESCRIPTION("Driver for watchdog timers described by the ACPI WDRT");
+MODULE_LICENSE("GPL");

--BXVAT5kNtrzKuDFl--
