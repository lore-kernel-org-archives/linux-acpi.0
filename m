From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 2/2] acpi/nfit: Add sysfs "id" for NVDIMM ID
Date: Mon, 25 Apr 2016 15:34:59 -0600
Message-ID: <1461620099-11933-3-git-send-email-toshi.kani@hpe.com>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:46737 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965188AbcDYVnr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Apr 2016 17:43:47 -0400
In-Reply-To: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, dan.j.williams@intel.com
Cc: robert.moore@intel.com, elliott@hpe.com, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>

ACPI 6.1, section 5.2.25.9, defines an identifier for an NVDIMM.

Change the NFIT driver to add a new sysfs file "id" under nfit
directory.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Robert Elliott <elliott@hpe.com>
---
 drivers/acpi/nfit.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 5dc243c..5a7199d 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -870,6 +870,24 @@ static ssize_t flags_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(flags);
 
+static ssize_t id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
+
+	if (dcr->valid_fields & ACPI_NFIT_CONTROL_MFG_INFO_VALID)
+		return sprintf(buf, "%04x-%02x-%04x-%08x\n",
+				be16_to_cpu(dcr->vendor_id),
+				dcr->manufacturing_location,
+				be16_to_cpu(dcr->manufacturing_date),
+				be32_to_cpu(dcr->serial_number));
+	else
+		return sprintf(buf, "%04x-%08x\n",
+				be16_to_cpu(dcr->vendor_id),
+				be32_to_cpu(dcr->serial_number));
+}
+static DEVICE_ATTR_RO(id);
+
 static struct attribute *acpi_nfit_dimm_attributes[] = {
 	&dev_attr_handle.attr,
 	&dev_attr_phys_id.attr,
@@ -879,6 +897,7 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_rev_id.attr,
 	&dev_attr_flags.attr,
+	&dev_attr_id.attr,
 	NULL,
 };
 
