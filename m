From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Wed, 26 Apr 2017 16:36:42 -0700
Message-ID: <149324959589.17912.8116722315071483296.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <x49zif23nvl.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50253 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754576AbdDZXmf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 19:42:35 -0400
In-Reply-To: <x49zif23nvl.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, linux-acpi@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org

The nvdimm_flush() mechanism helps to reduce the impact of an ADR
(asynchronous-dimm-refresh) failure. The ADR mechanism handles flushing
platform WPQ (write-pending-queue) buffers when power is removed. The
nvdimm_flush() mechanism performs that same function on-demand.

When a pmem namespace is associated with a block device, an
nvdimm_flush() is triggered with every block-layer REQ_FUA, or REQ_FLUSH
request. These requests are typically associated with filesystem
metadata updates. However, when a namespace is in device-dax mode,
userspace (think database metadata) needs another path to perform the
same flushing. In other words this is not required to make data
persistent, but in the case of metadata it allows for a smaller failure
domain in the unlikely event of an ADR failure.

The new 'wpq_drain' attribute is visible when the individual DIMMs
backing a given interleave-set are described by platform firmware. In
ACPI terms this is "NVDIMM Region Mapping Structures" and associated
"Flush Hint Address Structures". Reads return "1" if the region supports
triggering WPQ flushes on all DIMMs. Reads return "0" the flush
operation is a platform nop, and in that case the attribute is
read-only.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v4:
* Rename the attribute from "flush" to "wpq_drain". Short of moving this
  functionality to an ioctl() this rename hopefully makes clearer that
  this is an optional hardware specific operation and not a general purpose
  "flush" for reaching persistence. (Jeff)

 drivers/nvdimm/region_devs.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 24abceda986a..6bcbbfd9f015 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -255,6 +255,35 @@ static ssize_t size_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(size);
 
+static ssize_t wpq_drain_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nd_region *nd_region = to_nd_region(dev);
+
+	/*
+	 * NOTE: in the nvdimm_has_flush() error case this attribute is
+	 * not visible.
+	 */
+	return sprintf(buf, "%d\n", nvdimm_has_flush(nd_region));
+}
+
+static ssize_t wpq_drain_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	bool flush;
+	int rc = strtobool(buf, &flush);
+	struct nd_region *nd_region = to_nd_region(dev);
+
+	if (rc)
+		return rc;
+	if (!flush)
+		return -EINVAL;
+	nvdimm_flush(nd_region);
+
+	return len;
+}
+static DEVICE_ATTR_RW(wpq_drain);
+
 static ssize_t mappings_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -479,6 +508,7 @@ static struct attribute *nd_region_attributes[] = {
 	&dev_attr_btt_seed.attr,
 	&dev_attr_pfn_seed.attr,
 	&dev_attr_dax_seed.attr,
+	&dev_attr_wpq_drain.attr,
 	&dev_attr_read_only.attr,
 	&dev_attr_set_cookie.attr,
 	&dev_attr_available_size.attr,
@@ -508,6 +538,17 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 	if (!is_nd_pmem(dev) && a == &dev_attr_resource.attr)
 		return 0;
 
+	if (a == &dev_attr_wpq_drain.attr) {
+		int has_flush = nvdimm_has_flush(nd_region);
+
+		if (has_flush == 1)
+			return a->mode;
+		else if (has_flush == 0)
+			return 0444;
+		else
+			return 0;
+	}
+
 	if (a != &dev_attr_set_cookie.attr
 			&& a != &dev_attr_available_size.attr)
 		return a->mode;

