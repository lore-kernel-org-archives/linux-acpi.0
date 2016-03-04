From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v2-UPDATE 3/4] resource: Add device-managed insert/remove_resource()
Date: Fri,  4 Mar 2016 09:14:42 -0700
Message-ID: <1457108082-4610-1-git-send-email-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:39849 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbcCDPWK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Mar 2016 10:22:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org, bp@suse.de, dan.j.williams@intel.com, rjw@rjwysocki.net, akpm@linux-foundation.org
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>

insert_resource() and remove_resouce() are called by producers
of resources, such as FW modules and bus drivers.  These modules
may be implemented as loadable modules.

Add device-managed implementaions of insert_resource() and
remove_resouce() functions.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
v2-UPDATE:
 - Rename a helper remove func to __devm_remove_resource(). (Dan Williams)
---
 include/linux/ioport.h |    5 +++
 kernel/resource.c      |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8017b8b..3580038 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -259,6 +259,11 @@ extern struct resource * __devm_request_region(struct device *dev,
 
 extern void __devm_release_region(struct device *dev, struct resource *parent,
 				  resource_size_t start, resource_size_t n);
+
+extern int devm_insert_resource(struct device *dev, struct resource *root,
+				 struct resource *new);
+extern void devm_remove_resource(struct device *dev, struct resource *old);
+
 extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
 extern int iomem_is_exclusive(u64 addr);
 
diff --git a/kernel/resource.c b/kernel/resource.c
index effb6ee..12a9d57 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1449,6 +1449,75 @@ void __devm_release_region(struct device *dev, struct resource *parent,
 EXPORT_SYMBOL(__devm_release_region);
 
 /*
+ * Helper remove function for devm_insert_resource() and devm_remove_resource()
+ */
+static void __devm_remove_resource(struct device *dev, void *ptr)
+{
+	struct resource **r = ptr;
+
+	remove_resource(*r);
+}
+
+/**
+ * devm_insert_resource() - insert an I/O or memory resource
+ * @dev: device for which to produce the resource
+ * @root: root of the resource tree
+ * @new: descriptor of the new resource
+ *
+ * This is a device-managed version of insert_resource(). There is usually
+ * no need to release resources requested by this function explicitly since
+ * that will be taken care of when the device is unbound from its bus driver.
+ * If for some reason the resource needs to be released explicitly, because
+ * of ordering issues for example, bus drivers must call devm_remove_resource()
+ * rather than the regular remove_resource().
+ *
+ * devm_insert_resource() is intended for producers of resources, such as
+ * FW modules and bus drivers.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int devm_insert_resource(struct device *dev, struct resource *root,
+			  struct resource *new)
+{
+	struct resource **ptr;
+	int ret;
+
+	ptr = devres_alloc(__devm_remove_resource, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	*ptr = new;
+
+	ret = insert_resource(root, new);
+	if (ret) {
+		dev_err(dev, "unable to insert resource: %pR (%d)\n", new, ret);
+		devres_free(ptr);
+		return -EBUSY;
+	}
+
+	devres_add(dev, ptr);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_insert_resource);
+
+/**
+ * devm_remove_resource() - remove a previously inserted resource
+ * @dev: device for which to remove the resource
+ * @old: descriptor of the resource
+ *
+ * Remove a resource previously inserted using devm_insert_resource().
+ *
+ * devm_remove_resource() is intended for producers of resources, such as
+ * FW modules and bus drivers.
+ */
+void devm_remove_resource(struct device *dev, struct resource *old)
+{
+	WARN_ON(devres_release(dev, __devm_remove_resource, devm_resource_match,
+			       old));
+}
+EXPORT_SYMBOL_GPL(devm_remove_resource);
+
+/*
  * Called from init/main.c to reserve IO ports.
  */
 #define MAXRESERVE 4
