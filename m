Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D3373BEB;
	Sat, 25 Apr 2026 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154278; cv=none; b=eZSqV/CRxK9aGs/b2JocQECt9xe+PQZLE3j+1CPJwuwK0NcXnGRVg9QEJ47eGs5oNo9Ld5eZcGTyE8CySyPSV30brIZ0jW01fPRRQL+UV5bqmF+ZwA/2MBQYLk3gkO2U2bdYb2398x2sXozw6gyYIxqLpmptlWes+GCCsOI40rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154278; c=relaxed/simple;
	bh=lj6qRce3XGPqnFdGjaPABbYz1BCY+7k6AN6GQM/aaPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgnB+z3AjtiU2yIzIIoGl0YJncuB6mBAmwF/N6dnRNdZ8LAc5MNMyP5/T9y7N5CfpRgzHr3ZHI+1sjRsC3C33NeGu1BuHEncaW1lwJOzAWwR3t4uY8HLRhPAhVa0VL+A0Y+UPam/JuGG7bvMj6vEQdeow1CRnzdiy9++QhwGxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=nQYUJCl/; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="nQYUJCl/"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 43E14C184A;
	Sun, 26 Apr 2026 00:57:52 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 5C8EEC184D;
	Sun, 26 Apr 2026 00:57:51 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 34FDB1FD3FD;
	Sun, 26 Apr 2026 00:57:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154271;
	bh=CZYXTvGrngAfz96+uQlwavAvoJjrJQLYDMFcnTwfgjA=; h=From:To:Subject;
	b=nQYUJCl/ln31o1fIfxqm0XAwwANRhbuEX2+SG0fcRPH2z8CA0Z+CyoUWVB9qayxKL
	 dyzGXupNsUq82jChl0S2dXOpiFdSsjOjIhcMuC/0n4S/O2R0HEikDaY1/XZ8/PMR18
	 1cHLdzaWoY1rbxy9+Qw9cjii4jNLs9XkuTAXHn/bmIfSl3NBkmxj2D1f4uz/6hW6g5
	 kdYbQYuyvqzurd3j1ouieGM4BAwH+1JbZb0q4fZkgUE1jQ4LIEycwne7fYWN/6TBAy
	 aVnyR2Qy8mzFEBL6xDVqYBRCBHhZEl/EKGc5edmKAw+JuqCcicUxZcKpozU2ianeAu
	 KI3L1r94N6xaQ==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v2 08/10] hint: Add hint class ABI for devices to receive
 updates on host activity
Date: Sat, 25 Apr 2026 23:57:32 +0200
Message-ID: <20260425215734.14116-9-lkml@antheas.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425215734.14116-1-lkml@antheas.dev>
References: <20260425215734.14116-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177715427095.3678339.13048950894727413804@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The s2idle device requires the ability for userspace to inform of its
idleness state (e.g., inactive, active, snooze) which is used to update
device appearance (e.g., turn off keyboard backlight). Ideally, we would
want to extend this ability to non-ACPI/non-X86 devices and drivers,
e.g. memory mapped ECs, to be able to use this activity hint to for
example turn off their backlight. Moreover, to prevent adding new ABIs,
we would also like the ability to add new types of hints in the future.

Therefore, introduce a /sys/class/hint sysfs interface, with
{idle, idle_choices} to allow userspace to inform devices of
its current idleness. The initial ABI for class hint makes {idle,
idle_choices} optional, which allows for future hint additions that
are unrelated without forcing the implementation of the idle hint.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 MAINTAINERS           |   8 ++
 drivers/base/Kconfig  |   3 +
 drivers/base/Makefile |   1 +
 drivers/base/hint.c   | 283 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/hint.h  |  38 ++++++
 5 files changed, 333 insertions(+)
 create mode 100644 drivers/base/hint.c
 create mode 100644 include/linux/hint.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..12712b628449 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7324,6 +7324,14 @@ F:	drivers/devfreq/event/
 F:	include/dt-bindings/pmu/exynos_ppmu.h
 F:	include/linux/devfreq-event.h
 
+DEVICE HINTS
+M:	Antheas Kapenekakis <lkml@antheas.dev>
+L:	driver-core@lists.linux.dev
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-hint
+F:	drivers/base/hint.c
+F:	include/linux/hint.h
+
 DEVICE I/O & IRQ [RUST]
 M:	Danilo Krummrich <dakr@kernel.org>
 M:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 1786d87b29e2..c5316e8f98d0 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -222,6 +222,9 @@ config DMA_FENCE_TRACE
 	  lockup related problems for dma-buffers shared across multiple
 	  devices.
 
+config HINT
+	bool
+
 config GENERIC_ARCH_TOPOLOGY
 	bool
 	help
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8074a10183dc..27557351fa20 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
 obj-$(CONFIG_ACPI) += physical_location.o
+obj-$(CONFIG_HINT) += hint.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/hint.c b/drivers/base/hint.c
new file mode 100644
index 000000000000..0be4116d68cc
--- /dev/null
+++ b/drivers/base/hint.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Hint sysfs interface */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/hint.h>
+#include <linux/sysfs.h>
+
+struct hint_handler {
+	const char *name;
+	struct device dev;
+	int minor;
+	struct mutex lock; /* Prevents parallel calls to class device. */
+	unsigned long idle_choices[BITS_TO_LONGS(HINT_IDLE_LAST)];
+	enum hint_idle_option idle;
+	const struct hint_ops *ops;
+};
+
+#define to_hint_handler(d)	(container_of(d, struct hint_handler, dev))
+
+static const char * const hint_idle_names[] = {
+	[HINT_IDLE_SNOOZE]   = "snooze",
+	[HINT_IDLE_RESUME]   = "resume",
+	[HINT_IDLE_INACTIVE] = "inactive",
+	[HINT_IDLE_ACTIVE]   = "active",
+};
+static_assert(ARRAY_SIZE(hint_idle_names) == HINT_IDLE_LAST);
+
+static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hint_handler *handler = to_hint_handler(dev);
+
+	return sysfs_emit(buf, "%s\n", handler->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static ssize_t idle_choices_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct hint_handler *handler = to_hint_handler(dev);
+	int i, len = 0;
+
+	for_each_set_bit(i, handler->idle_choices, HINT_IDLE_LAST) {
+		if (len == 0)
+			len += sysfs_emit_at(buf, len, "%s", hint_idle_names[i]);
+		else
+			len += sysfs_emit_at(buf, len, " %s", hint_idle_names[i]);
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+static DEVICE_ATTR_RO(idle_choices);
+
+static ssize_t idle_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	enum hint_idle_option idle = HINT_IDLE_LAST;
+	struct hint_handler *handler = to_hint_handler(dev);
+	int err;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &handler->lock) {
+		if (!handler->ops->idle_get)
+			return handler->idle;
+
+		err = handler->ops->idle_get(dev, &idle);
+		if (err)
+			return err;
+
+		if (WARN_ON(idle >= HINT_IDLE_LAST))
+			return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%s\n", hint_idle_names[idle]);
+}
+
+static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct hint_handler *handler = to_hint_handler(dev);
+	int index, ret;
+
+	index = sysfs_match_string(hint_idle_names, buf);
+	if (index < 0)
+		return -EINVAL;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &handler->lock) {
+		if (!test_bit(index, handler->idle_choices))
+			return -EOPNOTSUPP;
+
+		if (handler->ops->idle_set) {
+			ret = handler->ops->idle_set(dev, index);
+			if (ret)
+				return ret;
+		}
+		handler->idle = index;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(idle);
+
+static umode_t hint_attr_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct hint_handler *handler = to_hint_handler(dev);
+
+	if ((attr == &dev_attr_idle.attr ||
+	     attr == &dev_attr_idle_choices.attr) &&
+	    bitmap_empty(handler->idle_choices, HINT_IDLE_LAST))
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *hint_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_idle_choices.attr,
+	&dev_attr_idle.attr,
+	NULL
+};
+
+static const struct attribute_group hint_group = {
+	.attrs      = hint_attrs,
+	.is_visible = hint_attr_is_visible,
+};
+
+static const struct attribute_group *hint_groups[] = {
+	&hint_group,
+	NULL,
+};
+
+static void hint_device_release(struct device *dev)
+{
+	struct hint_handler *handler = to_hint_handler(dev);
+
+	kfree(handler);
+}
+
+static const struct class hint_class = {
+	.name = "hint",
+	.dev_groups = hint_groups,
+	.dev_release = hint_device_release,
+};
+
+/**
+ * hint_register - Creates and registers a hint class device
+ * @dev: Parent device
+ * @name: Name of the class device
+ * @drvdata: Driver data that will be attached to the class device
+ * @ops: Hint probes and getters/setters
+ *
+ * Return: pointer to the new class device on success, ERR_PTR on failure
+ */
+struct device *hint_register(struct device *dev, const char *name,
+			     void *drvdata,
+			     const struct hint_ops *ops)
+{
+	struct device *adev;
+	int minor, err;
+
+	/* Sanity check */
+	if (WARN_ON_ONCE(!dev || !name || !ops))
+		return ERR_PTR(-EINVAL);
+
+	struct hint_handler *handler __free(kfree) = kzalloc_obj(*handler);
+	if (!handler)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Hint probes
+	 */
+
+	if (ops->idle_probe) {
+		err = ops->idle_probe(drvdata, handler->idle_choices);
+		if (err) {
+			dev_err(dev, "idle state hint probe failed\n");
+			return ERR_PTR(err);
+		}
+		handler->idle =
+			find_first_bit(handler->idle_choices, HINT_IDLE_LAST);
+	}
+
+	/* create class interface for handler */
+	handler->name = name;
+	handler->ops = ops;
+	handler->minor = minor;
+	handler->dev.class = &hint_class;
+	handler->dev.parent = dev;
+	mutex_init(&handler->lock);
+	dev_set_drvdata(&handler->dev, drvdata);
+	dev_set_name(&handler->dev, name, handler->minor);
+
+	adev = &no_free_ptr(handler)->dev;
+	err = device_register(adev);
+	if (err) {
+		put_device(adev);
+		return ERR_PTR(err);
+	}
+
+	return adev;
+}
+EXPORT_SYMBOL_GPL(hint_register);
+
+/**
+ * hint_remove - Unregisters a hint class device
+ * @dev: Class device
+ */
+void hint_remove(struct device *dev)
+{
+	struct hint_handler *handler;
+
+	if (IS_ERR_OR_NULL(dev))
+		return;
+
+	handler = to_hint_handler(dev);
+
+	guard(mutex)(&handler->lock);
+
+	device_unregister(&handler->dev);
+}
+EXPORT_SYMBOL_GPL(hint_remove);
+
+static void devm_hint_release(struct device *dev, void *res)
+{
+	struct device **adev = res;
+
+	hint_remove(*adev);
+}
+
+/**
+ * devm_hint_register - Device managed version of hint_register
+ * @dev: Parent device
+ * @name: Name of the class device
+ * @drvdata: Driver data that will be attached to the class device
+ * @ops: Activity operations
+ *
+ * Return: pointer to the new class device on success, ERR_PTR on failure
+ */
+struct device *devm_hint_register(struct device *dev, const char *name,
+				  void *drvdata, const struct hint_ops *ops)
+{
+	struct device *adev;
+	struct device **dr;
+
+	dr = devres_alloc(devm_hint_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	adev = hint_register(dev, name, drvdata, ops);
+	if (IS_ERR(adev)) {
+		devres_free(dr);
+		return adev;
+	}
+
+	*dr = adev;
+	devres_add(dev, dr);
+
+	return adev;
+}
+EXPORT_SYMBOL_GPL(devm_hint_register);
+
+static int __init hint_init(void)
+{
+	return class_register(&hint_class);
+}
+
+/*
+ * Required for s2idle to be able to register hints.
+ * module_init() would run after it tries to register the device.
+ */
+postcore_initcall(hint_init);
+
+MODULE_AUTHOR("Antheas Kapenekakis <lkml@antheas.dev>");
+MODULE_DESCRIPTION("Activity sysfs interface");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/hint.h b/include/linux/hint.h
new file mode 100644
index 000000000000..56686691442c
--- /dev/null
+++ b/include/linux/hint.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Device hints sysfs interface
+ */
+
+#ifndef _HINT_H_
+#define _HINT_H_
+
+#include <linux/device.h>
+#include <linux/bitops.h>
+
+enum hint_idle_option {
+	HINT_IDLE_ACTIVE,
+	HINT_IDLE_INACTIVE,
+	HINT_IDLE_SNOOZE,
+	HINT_IDLE_RESUME,
+	HINT_IDLE_LAST, /*must always be last */
+};
+
+/**
+ * struct hint_ops - hint probes and get/set operations
+ * @idle_probe:	Callback to setup idle hints available to the device.
+ * @idle_get:	Will be called when showing the current idle hint in sysfs.
+ * @idle_set:	Will be called when storing a new idle hint in sysfs.
+ */
+struct hint_ops {
+	int (*idle_probe)(void *drvdata, unsigned long *choices);
+	int (*idle_get)(struct device *dev, enum hint_idle_option *idle);
+	int (*idle_set)(struct device *dev, enum hint_idle_option idle);
+};
+
+struct device *hint_register(struct device *dev, const char *name,
+			     void *drvdata, const struct hint_ops *ops);
+void hint_remove(struct device *dev);
+struct device *devm_hint_register(struct device *dev, const char *name,
+				  void *drvdata, const struct hint_ops *ops);
+
+#endif  /*_HINT_H_*/
-- 
2.53.0


