From: Larry Baker <baker@usgs.gov>
Subject: Add support for injecting ACPI events
Date: Fri, 7 Jun 2013 13:38:22 -0700
Message-ID: <947612E5-6CFE-4A62-8006-DFF1FEF4F5F2@usgs.gov>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from SMTP5.doi.gov ([137.227.28.11]:16413 "EHLO smtp5.doi.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756955Ab3FGUni convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jun 2013 16:43:38 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so1050666pac.12
        for <linux-acpi@vger.kernel.org>; Fri, 07 Jun 2013 13:38:25 -0700
 (PDT)
Received: from savaii.wr.usgs.gov (u-130-118-45-7.xr.usgs.gov. [130.118.45.7])
        by mx.google.com with ESMTPSA id vv6sm4623778pab.6.2013.06.07.13.38.24
        for <linux-acpi@vger.kernel.org>        (version=TLSv1
 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Fri, 07 Jun 2013 13:38:24
 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I am building a bare-bones CentOS 6.4 i386 server for remote data acquisition.  I am configuring as many features that I can find for automated state-of-health monitoring: smartd (disks), mcelogd (processors), and acpid (temperature -- alas, no supply voltage that I can find) for hardware alarms, watchdog for system lockups.  I set them all up to e-mail me alert messages.  The mcelog package has a nice testing feature that can inject MCE "events", using the mce-inject kernel module.  I could not find a similar feature for testing acpid ACPI event handling.  So, I wrote the acpi-inject kernel module below.

acpi-inject creates write-only /proc/acpi/inject to inject ACPI events, using the same format they are read from /proc/acpi/event (with lots of sanity checks).  I have been reading statements on the web that acpid is going away, and maybe /proc/acpi/event as well.  Even if this is a dead end, maybe one of the ACPI maintainers can pick up this idea and create an ACPI event injector that better fits the future ACPI framework.

FYI.  acpi-inject calls acpi_bus_generate_proc_event4() in acpi/bus.c to add an ACPI event to the queue.  I noticed there that the device_class and bus_id fields in the struct acpi_bus_event event are set using strcpy().  I think those should be strncpy()'s.  Also, I don't understand why the numeric arguments to acpi_bus_generate_proc_event4() are u8 and int, yet the corresponding fields in struct acpi_bus_event are u32.  No matter; just curious.

(If anyone knows how to monitor supply voltage, please let me know.  The system I am using is a tiny Intel Atom Z510-based system, and does not have an IPMI/BMC chip, as far as I can tell.)

Thank you,

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov

--- linux-2.6.32-358.6.2.el6/drivers/acpi/Makefile
+++ linux-2.6.32-358.6.2.el6/drivers/acpi/Makefile
@@ -61,2 +61,3 @@
 obj-$(CONFIG_ACPI_HED)		+= hed.o
+obj-$(CONFIG_ACPI_INJECT)	+= acpi-inject.o
 
--- linux-2.6.32-358.6.2.el6/drivers/acpi/acpi-inject.c
+++ linux-2.6.32-358.6.2.el6/drivers/acpi/acpi-inject.c
@@ -0,0 +1,184 @@
+/*
+ * acpi-inject.c - Kernel module for ACPI event injection support.
+ *
+ * Creates write-only /proc/acpi/inject, which accepts ACPI event messages in
+ * the format they are read from /proc/acpi/event (acpi_system_read_event()
+ * in event.c):
+ *
+ *    "%s %s %08x %08x"
+ *
+ * There must be exactly four fields, separated by whitespace.  Leading and
+ * trailing whitespace is ignored.  The fields are char device_name[40],
+ * char bus_id[8], u8 type, and int data.  The (unsigned) hex fields must
+ * be (case insensitive) hex digits only.
+ *
+ * Usage:
+ *
+ *    # modprobe acpi-inject
+ *    # service acpid start
+ *    # echo "thermal_zone TZ1 00000081 00000000" >/proc/acpi/inject
+ *
+ *    acpid should receive the Thermal Zone event and process it according
+ *    to the rules in /etc/acpi/events/.
+ *
+ * Author:
+ * Larry Baker
+ */
+
+#include <linux/spinlock.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <asm/uaccess.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+#ifndef UCHAR_MAX
+#define UCHAR_MAX       ((u8)(~0U))
+#endif
+
+#define _COMPONENT		ACPI_SYSTEM_COMPONENT
+ACPI_MODULE_NAME("inject");
+
+#ifdef CONFIG_ACPI_PROC_EVENT
+
+/* Global vars for handling inject proc entry */
+static DEFINE_SPINLOCK(acpi_system_inject_lock);
+int inject_is_open = 0;
+
+static int acpi_system_open_inject(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&acpi_system_inject_lock);
+
+	if (inject_is_open)
+		goto out_busy;
+
+	inject_is_open = 1;
+
+	spin_unlock_irq(&acpi_system_inject_lock);
+	return 0;
+
+out_busy:
+	spin_unlock_irq(&acpi_system_inject_lock);
+	return -EBUSY;
+}
+
+/* ACPI event record format: "%s %s %08x %08x" */
+
+static ssize_t
+acpi_system_write_inject(struct file *file, const char __user * buffer,
+			 size_t count, loff_t * ppos)
+{
+	static char str[ACPI_MAX_STRING];
+	char *ptr;
+	char *device_class = NULL, *bus_id = NULL, *typeP = NULL, *dataP = NULL;
+	unsigned long hex;
+	u8 type;
+	int data;
+	int i = 0, err;
+
+	if (count > sizeof(str) - 1)
+		return -EINVAL;
+
+	if (copy_from_user(str, buffer, count))
+		return -EFAULT;
+
+	str[count] = '\0';
+
+	ptr = str;
+	do {
+		while (isspace(*ptr))
+			ptr++;
+		if (*ptr) {
+			switch (i++) {
+				case 0:
+					device_class = ptr;
+					break;
+				case 1:
+					bus_id = ptr;
+					break;
+				case 2:
+					typeP = ptr;
+					break;
+				case 3:
+					dataP = ptr;
+					break;
+				default:
+					return -EINVAL;
+			}
+			while (*ptr && !isspace(*ptr))
+				ptr++;
+			if (*ptr)
+				*ptr++ = '\0';
+		}
+	} while (*ptr);
+
+	if (i != 4)
+		return -EINVAL;
+
+	if (strlen(device_class) > sizeof(acpi_device_class) - 1)
+		return -EINVAL;
+
+	if (strlen(bus_id ) > sizeof(acpi_bus_id) - 1)
+		return -EINVAL;
+
+	err = kstrtoul(typeP, 16, &hex);
+	if (err)
+		return err;
+	if (hex > UCHAR_MAX)
+		return -ERANGE;
+	type = hex;
+
+	err = kstrtoul(dataP, 16, &hex);
+	if (err)
+		return err;
+	if (hex > INT_MAX)
+		return -ERANGE;
+	data = hex;
+
+	acpi_bus_generate_proc_event4(device_class, bus_id, type, data);
+
+	return count;
+}
+
+static int acpi_system_close_inject(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&acpi_system_inject_lock);
+	inject_is_open = 0;
+	spin_unlock_irq(&acpi_system_inject_lock);
+	return 0;
+}
+
+static const struct file_operations acpi_system_inject_ops = {
+	.owner = THIS_MODULE,
+	.open = acpi_system_open_inject,
+	.write = acpi_system_write_inject,
+	.release = acpi_system_close_inject,
+};
+
+#endif	/* CONFIG_ACPI_PROC_EVENT */
+
+static int __init acpi_inject_init(void)
+{
+#ifdef CONFIG_ACPI_PROC_EVENT
+	struct proc_dir_entry *entry;
+#endif
+	if (acpi_disabled)
+		return 0;
+
+#ifdef CONFIG_ACPI_PROC_EVENT
+	/* 'inject' [W] */
+	entry = proc_create("inject", S_IWUSR, acpi_root_dir,
+		&acpi_system_inject_ops);
+	if (!entry)
+		return -ENODEV;
+#endif
+
+	return 0;
+}
+
+fs_initcall(acpi_inject_init);
+
+MODULE_LICENSE("GPL");

