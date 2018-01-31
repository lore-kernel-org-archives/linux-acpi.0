From: Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v3 3/4] libnvdimm: expose platform persistence attribute for
 nd_region
Date: Tue, 30 Jan 2018 17:01:24 -0700
Message-ID: <151735688433.34477.6251015810967028744.stgit@djiang5-desk3.ch.intel.com>
References: <151735668391.34477.11820724492631561208.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28155 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754258AbeAaABZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Jan 2018 19:01:25 -0500
In-Reply-To: <151735668391.34477.11820724492631561208.stgit@djiang5-desk3.ch.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, ross.zwisler@linux.intel.com
Cc: linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org

Providing a sysfs attribute for nd_region that shows the persistence
capabilities for the platform.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/nvdimm/region_devs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index abaf38c61220..e6d01911e092 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -528,6 +528,18 @@ static ssize_t resource_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(resource);
 
+static ssize_t persistence_domain_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nd_region *nd_region = to_nd_region(dev);
+	unsigned long flags = nd_region->flags;
+
+	return sprintf(buf, "%s%s\n",
+			flags & BIT(ND_REGION_PERSIST_CACHE) ? "cpu_cache " : "",
+			flags & BIT(ND_REGION_PERSIST_MEMCTRL) ? "memory_controller " : "");
+}
+static DEVICE_ATTR_RO(persistence_domain);
+
 static struct attribute *nd_region_attributes[] = {
 	&dev_attr_size.attr,
 	&dev_attr_nstype.attr,
@@ -543,6 +555,7 @@ static struct attribute *nd_region_attributes[] = {
 	&dev_attr_init_namespaces.attr,
 	&dev_attr_badblocks.attr,
 	&dev_attr_resource.attr,
+	&dev_attr_persistence_domain.attr,
 	NULL,
 };
 

