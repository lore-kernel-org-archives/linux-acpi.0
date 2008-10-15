From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: WDRT based watchdog timer
Date: Wed, 15 Oct 2008 15:33:50 +0200
Message-ID: <20081015133350.GA6822@infomag.infomag.iguana.be>
References: <20080926232752.GA6061@cosmic.amd.com> <alpine.LFD.1.10.0810081552220.3041@localhost.localdomain> <20081008204422.GA2932@cosmic.amd.com> <20081014204034.GF30246@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:11636 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751544AbYJONdy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Oct 2008 09:33:54 -0400
Content-Disposition: inline
In-Reply-To: <20081014204034.GF30246@infomag.infomag.iguana.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Marc Brooker <mbrooker@rrsg.ee.uct.ac.za>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

> wdrt.c would indeed be better then (I agree with Len's comment about ACPI).
> Can you change the code and the documentation (Kconfig) so that it is clear that
> this is about the Watchdog Resource Table Watchdog Timer and not about an ACPI
> WATCHDOG.

I applied my comments into the below patch.
If it's ok for you then we can continue on getting this in the mainline tree
(after that Marc could test it).

Kind regards,
Wim.


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wdrt.patch"

commit 8277a9b616e90be295e50a93fa049454544f1a00
Author: Jordan Crouse <jordan.crouse@amd.com>
Date:   Fri Sep 26 17:27:52 2008 -0600

    [WATCHDOG] Add a watchdog driver for the WDRT ACPI table
    
    A watchdog timer driver for systems with that implement hardware
    timers described by the ACPI Watchdog Resource Table (WDRT).
    
    Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d0b8a2..f5d64f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4569,6 +4569,13 @@ M:	wim@iguana.be
 T:	git kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
 S:	Maintained
 
+WATCHDOG RESOURCE TABLE (WDRT) DRIVER
+P:	Jordan Crouse
+M:	jordan.crouse@amd.com
+L:	linux-acpi@vger.kernel.org
+W:	http://www.lesswatts.org/projects/acpi/
+S:	Maintained
+
 WAVELAN NETWORK DRIVER & WIRELESS EXTENSIONS
 P:	Jean Tourrilhes
 M:	jt@hpl.hp.com
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1a22fe7..132c884 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -551,6 +551,16 @@ config CPU5_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpu5wdt.
 
+config WDRT_WDT
+	tristate "Watchdog Resource Table (WDRT) Watchdog Timer"
+	depends on X86 && ACPI
+	---help---
+	  This driver supports hardware watchdog timer implementations
+	  described by the Watchdog Resource Table (WDRT) ACPI table.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called wdrt.
+
 config SMSC37B787_WDT
 	tristate "Winbond SMsC37B787 Watchdog Timer"
 	depends on X86
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index e352bbb..2b8afe7 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_SBC8360_WDT) += sbc8360.o
 obj-$(CONFIG_SBC7240_WDT) += sbc7240_wdt.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
+obj-$(CONFIG_WDRT_WDT) += wdrt.o
 obj-$(CONFIG_SMSC37B787_WDT) += smsc37b787_wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
 obj-$(CONFIG_W83697HF_WDT) += w83697hf_wdt.o
diff --git a/drivers/watchdog/acpiwdt.c b/drivers/watchdog/acpiwdt.c
new file mode 100644
index 0000000..9b082b4
--- /dev/null
+++ b/drivers/watchdog/acpiwdt.c
@@ -0,0 +1,345 @@
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
+/*
+ * For more information:
+ * "WDRT" Watchdog Resource Table Watchdog Timer Hardware Requirements for
+ * Windows Server 2003 - http://www.microsoft.com/whdc/system/CEC/watchdog.mspx
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
+#define PFX "wdrt: "
+
+#define WATCHDOG_TIMEOUT 60
+#define WDT_FLAGS_OPEN 1
+#define WDT_FLAGS_ORPHAN 2
+
+static int timeout = WATCHDOG_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, default="
+			__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static unsigned long wdt_flags;
+static int expect_close;
+
+/* WDRT ACPI table */
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
+static void wdrt_ping(void)
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
+static void wdrt_disable(void)
+{
+	u32 val = readl(wdt_ctrl_reg);
+	writel(val & ~WDT_CTRL_RUN, wdt_ctrl_reg);
+}
+
+static int wdrt_set_heartbeat(unsigned int interval)
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
+static int wdrt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(WDT_FLAGS_OPEN, &wdt_flags))
+		return -EBUSY;
+	if (!test_and_clear_bit(WDT_FLAGS_ORPHAN, &wdt_flags))
+		__module_get(THIS_MODULE);
+
+	wdrt_ping();
+	return nonseekable_open(inode, file);
+}
+
+static int wdrt_release(struct inode *inode, struct file *file)
+{
+	if (expect_close) {
+		wdrt_disable();
+		module_put(THIS_MODULE);
+	} else {
+		printk(KERN_CRIT PFX
+			"Unexpected close - watchdog is not stopping\n");
+		wdrt_ping();
+		set_bit(WDT_FLAGS_ORPHAN, &wdt_flags);
+	}
+
+	clear_bit(WDT_FLAGS_OPEN, &wdt_flags);
+	expect_close = 0;
+	return 0;
+}
+
+static ssize_t wdrt_write(struct file *file, const char __user *buf,
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
+		wdrt_ping();
+	}
+
+	return len;
+}
+
+static struct watchdog_info ident = {
+	.options = WDIOF_SETTIMEOUT |
+		   WDIOF_KEEPALIVEPING |
+		   WDIOF_MAGICCLOSE,
+	.identity = "WDRT Watchdog Timer",
+};
+
+static long wdrt_ioctl(struct file *file, unsigned cmd, unsigned long arg)
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
+			wdrt_disable();
+			ret = 0;
+		}
+
+		if (options & WDIOS_ENABLECARD) {
+			wdrt_ping();
+			ret = 0;
+		}
+		break;
+
+	case WDIOC_KEEPALIVE:
+		wdrt_ping();
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(new_timeout, p);
+		if (ret)
+			break;
+		ret = wdrt_set_heartbeat(new_timeout);
+		if (ret)
+			break;
+
+		wdrt_ping();
+		/* fall through */
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(timeout, p);
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations wdrt_fops = {
+	.owner          = THIS_MODULE,
+	.llseek         = no_llseek,
+	.write          = wdrt_write,
+	.unlocked_ioctl = wdrt_ioctl,
+	.open           = wdrt_open,
+	.release        = wdrt_release,
+};
+
+static struct miscdevice wdrt_miscdev = {
+	.minor          = WATCHDOG_MINOR,
+	.name           = "watchdog",
+	.fops           = &wdrt_fops,
+};
+
+static int __init wdrt_init(void)
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
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	wdt_ctrl_reg = ioremap(wdrt->ctrl_addr.address, sizeof(u64));
+	if (wdt_ctrl_reg == NULL)
+		return -EBUSY;
+
+	wdt_count_reg = ioremap(wdrt->count_addr.address, sizeof(u64));
+	if (wdt_count_reg == NULL) {
+		ret = -EBUSY;
+		goto err_ioremap;
+	}
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
+	if (wdrt_set_heartbeat(timeout)) {
+		wdrt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk(KERN_INFO PFX
+			"The timeout must be > 0 and < %d seconds. Using %d\n",
+			 (wdt_units * 0xFFFF) / 1000, WATCHDOG_TIMEOUT);
+	}
+
+	ret = misc_register(&wdrt_miscdev);
+	if (ret) {
+		printk(KERN_ERR PFX "Could not register misc device\n");
+		goto err;
+	}
+
+	printk(KERN_INFO PFX "initialized. timeout=%d sec (nowayout=%d)\n",
+		timeout, nowayout);
+	return 0;
+
+err:
+	iounmap(wdt_count_reg);
+err_ioremap:
+	iounmap(wdt_ctrl_reg);
+	return ret;
+}
+
+static void __exit wdrt_exit(void)
+{
+	misc_deregister(&wdrt_miscdev);
+
+	iounmap(wdt_count_reg);
+	iounmap(wdt_ctrl_reg);
+}
+
+module_init(wdrt_init);
+module_exit(wdrt_exit);
+
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
+MODULE_DESCRIPTION("Driver for watchdog timers described by the ACPI WDRT");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+

--YiEDa0DAkWCtVeE4--
