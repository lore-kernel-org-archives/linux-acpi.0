From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v11 5/5] nfit: add sysfs dimm 'family' and 'dsm_mask'
 attributes
Date: Thu, 28 Apr 2016 19:42:49 -0700
Message-ID: <146189776923.29835.5521802180709532725.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146189774241.29835.12947278159500915461.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10962 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbcD2Cni (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Apr 2016 22:43:38 -0400
In-Reply-To: <146189774241.29835.12947278159500915461.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com

Communicate the command format and suppported functions to userspace
tooling.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 30801fe3367b..24549ba217b5 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -897,6 +897,30 @@ static ssize_t serial_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(serial);
 
+static ssize_t family_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+
+	if (nfit_mem->family < 0)
+		return -ENXIO;
+	return sprintf(buf, "%d\n", nfit_mem->family);
+}
+static DEVICE_ATTR_RO(family);
+
+static ssize_t dsm_mask_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+
+	if (nfit_mem->family < 0)
+		return -ENXIO;
+	return sprintf(buf, "%#lx\n", nfit_mem->dsm_mask);
+}
+static DEVICE_ATTR_RO(dsm_mask);
+
 static ssize_t flags_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -920,6 +944,8 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_rev_id.attr,
 	&dev_attr_flags.attr,
+	&dev_attr_family.attr,
+	&dev_attr_dsm_mask.attr,
 	NULL,
 };
 

