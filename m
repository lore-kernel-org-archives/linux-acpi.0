Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF2379996;
	Mon, 23 Feb 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879471; cv=none; b=e+AFIZ8TJVFte2p3NiwfaLl5tE6VabawkkS73p8EHSSKG8g9MExcdpKULFr2MKLZaop9IuCiAsA0JL1PhRST/sufdO/Pda2epV6Cd8aqPMrQSQpzbZKL1vfniiwZbSsP/wMeH1pTKeljEI4XyS6zqI+58HsXRVvjXYEuvHh12C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879471; c=relaxed/simple;
	bh=vsMyTY0R8IZvaS+rnwr/l8q2Ckjqj2nsO6DWVc9C3qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+zFmxeX9ObSDEby7sS7hC0L531qy69VQokeL2XDyEro6A3VcOs0NBYjdBg/UteqBCuNZipuGKAQfaSwVBqwnaJnqBaRvVEE9xuGLe8SE1Ev60cYJUVUVD+fZpKQj2uGTiFzW0Z/6YdY9UwXKXL5Gh6zyaLz1eJrFtuHTjSy0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JU7UD9A1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JU7UD9A1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771879467; x=1803415467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsMyTY0R8IZvaS+rnwr/l8q2Ckjqj2nsO6DWVc9C3qA=;
  b=JU7UD9A1pHsC7HWoKlingZLK9puSk0K5md+C0LK+kyqE6/BUTXtOdg8x
   vbieLchdS59D1jqu7jlLN2yAGs5Pd3e/jxopab8Owu/YFukjLEc/sw8b3
   QTwJ7XLDUeypLRD7ED8O5EGMIsQpEIDRtXV7g+vcD+XgHHGqkdZ2pU0RQ
   gPunqXwnEvwmKsokXZuDt32GK139pSFWgJmtO3NYW66SBMltG48l4wNdV
   ipl/OSxHHvlNP9L/Td9JYNIFEc4qdjRfHxwBp9mb3t6JJkXBixzLxMtUH
   iDnU66xef2Eb1eTfhmdFOLg195Forg+t2tW+8RZVapDIvyR2QzBU7q+A9
   A==;
X-CSE-ConnectionGUID: N3CbKy1eRx6oor3ad/SPxA==
X-CSE-MsgGUID: kvKlCu6AQs+AkRq9KkXgbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72795341"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72795341"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:44:22 -0800
X-CSE-ConnectionGUID: WuHfqXq0S/S1/4R+Yx+hGw==
X-CSE-MsgGUID: +DFjjOBNQsKyNKO1nC6mnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215700223"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 23 Feb 2026 12:44:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 358B699; Mon, 23 Feb 2026 21:44:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 2/3] driver core: Split device link data types and API to device/devlink.h
Date: Mon, 23 Feb 2026 21:30:31 +0100
Message-ID: <20260223204412.3298508-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device.h is a huge header which is hard to follow and easy to miss
something. Improve that by splitting device link data types and API
to device/devlink.h.

In particular this helps to speedup the build of the code that includes
device.h solely for a device link data types and/or API.

Note, get_dev_from_fwnode() goes to include/linux/fwnode.h as it seems
better to be there (it is on one hand related to device link, but it
is a getter for struct fwnode_handle respective field).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h         | 86 +-----------------------------
 include/linux/device/devlink.h | 97 ++++++++++++++++++++++++++++++++++
 include/linux/fwnode.h         |  2 +
 3 files changed, 100 insertions(+), 85 deletions(-)
 create mode 100644 include/linux/device/devlink.h

diff --git a/include/linux/device.h b/include/linux/device.h
index 8c85ee363567..4ba6ae72ddf6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -28,6 +28,7 @@
 #include <linux/gfp.h>
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
+#include <linux/device/devlink.h>
 #include <linux/device/devres.h>
 #include <linux/device/driver.h>
 #include <linux/device/types.h>
@@ -254,76 +255,6 @@ int __must_check device_create_bin_file(struct device *dev,
 void device_remove_bin_file(struct device *dev,
 			    const struct bin_attribute *attr);
 
-/**
- * enum device_link_state - Device link states.
- * @DL_STATE_NONE: The presence of the drivers is not being tracked.
- * @DL_STATE_DORMANT: None of the supplier/consumer drivers is present.
- * @DL_STATE_AVAILABLE: The supplier driver is present, but the consumer is not.
- * @DL_STATE_CONSUMER_PROBE: The consumer is probing (supplier driver present).
- * @DL_STATE_ACTIVE: Both the supplier and consumer drivers are present.
- * @DL_STATE_SUPPLIER_UNBIND: The supplier driver is unbinding.
- */
-enum device_link_state {
-	DL_STATE_NONE = -1,
-	DL_STATE_DORMANT = 0,
-	DL_STATE_AVAILABLE,
-	DL_STATE_CONSUMER_PROBE,
-	DL_STATE_ACTIVE,
-	DL_STATE_SUPPLIER_UNBIND,
-};
-
-/*
- * Device link flags.
- *
- * STATELESS: The core will not remove this link automatically.
- * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
- * PM_RUNTIME: If set, the runtime PM framework will use this link.
- * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
- * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
- * AUTOPROBE_CONSUMER: Probe consumer driver automatically after supplier binds.
- * MANAGED: The core tracks presence of supplier/consumer drivers (internal).
- * SYNC_STATE_ONLY: Link only affects sync_state() behavior.
- * INFERRED: Inferred from data (eg: firmware) and not from driver actions.
- */
-#define DL_FLAG_STATELESS		BIT(0)
-#define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
-#define DL_FLAG_PM_RUNTIME		BIT(2)
-#define DL_FLAG_RPM_ACTIVE		BIT(3)
-#define DL_FLAG_AUTOREMOVE_SUPPLIER	BIT(4)
-#define DL_FLAG_AUTOPROBE_CONSUMER	BIT(5)
-#define DL_FLAG_MANAGED			BIT(6)
-#define DL_FLAG_SYNC_STATE_ONLY		BIT(7)
-#define DL_FLAG_INFERRED		BIT(8)
-#define DL_FLAG_CYCLE			BIT(9)
-
-/**
- * struct device_link - Device link representation.
- * @supplier: The device on the supplier end of the link.
- * @s_node: Hook to the supplier device's list of links to consumers.
- * @consumer: The device on the consumer end of the link.
- * @c_node: Hook to the consumer device's list of links to suppliers.
- * @link_dev: device used to expose link details in sysfs
- * @status: The state of the link (with respect to the presence of drivers).
- * @flags: Link flags.
- * @rpm_active: Whether or not the consumer device is runtime-PM-active.
- * @kref: Count repeated addition of the same link.
- * @rm_work: Work structure used for removing the link.
- * @supplier_preactivated: Supplier has been made active before consumer probe.
- */
-struct device_link {
-	struct device *supplier;
-	struct list_head s_node;
-	struct device *consumer;
-	struct list_head c_node;
-	struct device link_dev;
-	enum device_link_state status;
-	u32 flags;
-	refcount_t rpm_active;
-	struct kref kref;
-	struct work_struct rm_work;
-	bool supplier_preactivated; /* Owned by consumer probe. */
-};
-
 /**
  * device_iommu_mapped - Returns true when the device DMA is translated
  *			 by an IOMMU
@@ -678,7 +609,6 @@ void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
 int device_add_of_node(struct device *dev, struct device_node *of_node);
 void device_remove_of_node(struct device *dev);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
-struct device *get_dev_from_fwnode(struct fwnode_handle *fwnode);
 
 static inline struct device_node *dev_of_node(struct device *dev)
 {
@@ -784,20 +714,6 @@ void device_shutdown(void);
 /* debugging and troubleshooting/diagnostic helpers. */
 const char *dev_driver_string(const struct device *dev);
 
-/* Device links interface. */
-struct device_link *device_link_add(struct device *consumer,
-				    struct device *supplier, u32 flags);
-void device_link_del(struct device_link *link);
-void device_link_remove(void *consumer, struct device *supplier);
-void device_links_supplier_sync_state_pause(void);
-void device_links_supplier_sync_state_resume(void);
-void device_link_wait_removal(void);
-
-static inline bool device_link_test(const struct device_link *link, u32 flags)
-{
-	return !!(link->flags & flags);
-}
-
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
diff --git a/include/linux/device/devlink.h b/include/linux/device/devlink.h
new file mode 100644
index 000000000000..88e645bab303
--- /dev/null
+++ b/include/linux/device/devlink.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DEVICE_LINK_H_
+#define _DEVICE_LINK_H_
+
+#include <linux/bits.h>
+#include <linux/kref.h>
+#include <linux/refcount_types.h>
+#include <linux/types.h>
+#include <linux/workqueue_types.h>
+
+#include "types.h"
+
+/**
+ * enum device_link_state - Device link states.
+ * @DL_STATE_NONE: The presence of the drivers is not being tracked.
+ * @DL_STATE_DORMANT: None of the supplier/consumer drivers is present.
+ * @DL_STATE_AVAILABLE: The supplier driver is present, but the consumer is not.
+ * @DL_STATE_CONSUMER_PROBE: The consumer is probing (supplier driver present).
+ * @DL_STATE_ACTIVE: Both the supplier and consumer drivers are present.
+ * @DL_STATE_SUPPLIER_UNBIND: The supplier driver is unbinding.
+ */
+enum device_link_state {
+	DL_STATE_NONE = -1,
+	DL_STATE_DORMANT = 0,
+	DL_STATE_AVAILABLE,
+	DL_STATE_CONSUMER_PROBE,
+	DL_STATE_ACTIVE,
+	DL_STATE_SUPPLIER_UNBIND,
+};
+
+/*
+ * Device link flags.
+ *
+ * STATELESS: The core will not remove this link automatically.
+ * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
+ * PM_RUNTIME: If set, the runtime PM framework will use this link.
+ * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
+ * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
+ * AUTOPROBE_CONSUMER: Probe consumer driver automatically after supplier binds.
+ * MANAGED: The core tracks presence of supplier/consumer drivers (internal).
+ * SYNC_STATE_ONLY: Link only affects sync_state() behavior.
+ * INFERRED: Inferred from data (eg: firmware) and not from driver actions.
+ */
+#define DL_FLAG_STATELESS		BIT(0)
+#define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
+#define DL_FLAG_PM_RUNTIME		BIT(2)
+#define DL_FLAG_RPM_ACTIVE		BIT(3)
+#define DL_FLAG_AUTOREMOVE_SUPPLIER	BIT(4)
+#define DL_FLAG_AUTOPROBE_CONSUMER	BIT(5)
+#define DL_FLAG_MANAGED			BIT(6)
+#define DL_FLAG_SYNC_STATE_ONLY		BIT(7)
+#define DL_FLAG_INFERRED		BIT(8)
+#define DL_FLAG_CYCLE			BIT(9)
+
+/**
+ * struct device_link - Device link representation.
+ * @supplier: The device on the supplier end of the link.
+ * @s_node: Hook to the supplier device's list of links to consumers.
+ * @consumer: The device on the consumer end of the link.
+ * @c_node: Hook to the consumer device's list of links to suppliers.
+ * @link_dev: device used to expose link details in sysfs
+ * @status: The state of the link (with respect to the presence of drivers).
+ * @flags: Link flags.
+ * @rpm_active: Whether or not the consumer device is runtime-PM-active.
+ * @kref: Count repeated addition of the same link.
+ * @rm_work: Work structure used for removing the link.
+ * @supplier_preactivated: Supplier has been made active before consumer probe.
+ */
+struct device_link {
+	struct device *supplier;
+	struct list_head s_node;
+	struct device *consumer;
+	struct list_head c_node;
+	struct device link_dev;
+	enum device_link_state status;
+	u32 flags;
+	refcount_t rpm_active;
+	struct kref kref;
+	struct work_struct rm_work;
+	bool supplier_preactivated; /* Owned by consumer probe. */
+};
+
+/* Device links interface. */
+struct device_link *device_link_add(struct device *consumer,
+				    struct device *supplier, u32 flags);
+void device_link_del(struct device_link *link);
+void device_link_remove(void *consumer, struct device *supplier);
+void device_links_supplier_sync_state_pause(void);
+void device_links_supplier_sync_state_resume(void);
+void device_link_wait_removal(void);
+
+static inline bool device_link_test(const struct device_link *link, u32 flags)
+{
+	return !!(link->flags & flags);
+}
+
+#endif /* _DEVICE_LINK_H_ */
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 097be89487bf..38ebd810c1ec 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -60,6 +60,8 @@ struct fwnode_handle {
 	u8 flags;
 };
 
+struct device *get_dev_from_fwnode(struct fwnode_handle *fwnode);
+
 /*
  * fwnode link flags
  *
-- 
2.50.1

