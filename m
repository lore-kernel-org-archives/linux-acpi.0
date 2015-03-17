From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI: Introduce has_acpi_companion()
Date: Tue, 17 Mar 2015 15:17:51 +0100
Message-ID: <5919377.PEzjxVSVEh@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <CACxGe6tiDszPDpP_u1yxNgMA8HjagDKtGuu35hfkyJtZdGE0Aw@mail.gmail.com> <10066684.kPKm7OTnxF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56451 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753108AbbCQNx6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2015 09:53:58 -0400
In-Reply-To: <10066684.kPKm7OTnxF@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Now that the ACPI companions of devices are represented by pointers
to struct fwnode_handle, it is not quite efficient to check whether
or not an ACPI companion of a device is present by evaluating the
ACPI_COMPANION() macro.

For this reason, introduce a special static inline routine for that,
has_acpi_companion(), and update the code to use it where applicable.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/patch/6010351/

---
 drivers/acpi/glue.c                         |    4 ++--
 drivers/i2c/busses/i2c-designware-platdrv.c |    4 ++--
 drivers/iommu/intel-iommu.c                 |    2 +-
 include/linux/acpi.h                        |   10 ++++++++++
 4 files changed, 15 insertions(+), 5 deletions(-)

Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -58,6 +58,11 @@ static inline acpi_handle acpi_device_ha
 	acpi_fwnode_handle(adev) : NULL
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
+static inline bool has_acpi_companion(struct device *dev)
+{
+	return is_acpi_node(dev->fwnode);
+}
+
 static inline void acpi_preset_companion(struct device *dev,
 					 struct acpi_device *parent, u64 addr)
 {
@@ -472,6 +477,11 @@ static inline struct fwnode_handle *acpi
 	return NULL;
 }
 
+static inline bool has_acpi_companion(struct device *dev)
+{
+	return false;
+}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return NULL;
Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -166,7 +166,7 @@ static int dw_i2c_probe(struct platform_
 	/* fast mode by default because of legacy reasons */
 	clk_freq = 400000;
 
-	if (ACPI_COMPANION(&pdev->dev)) {
+	if (has_acpi_companion(&pdev->dev)) {
 		dw_i2c_acpi_configure(pdev);
 	} else if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node,
@@ -286,7 +286,7 @@ static int dw_i2c_remove(struct platform
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	if (ACPI_COMPANION(&pdev->dev))
+	if (has_acpi_companion(&pdev->dev))
 		dw_i2c_acpi_unconfigure(pdev);
 
 	return 0;
Index: linux-pm/drivers/iommu/intel-iommu.c
===================================================================
--- linux-pm.orig/drivers/iommu/intel-iommu.c
+++ linux-pm/drivers/iommu/intel-iommu.c
@@ -684,7 +684,7 @@ static struct intel_iommu *device_to_iom
 	if (dev_is_pci(dev)) {
 		pdev = to_pci_dev(dev);
 		segment = pci_domain_nr(pdev->bus);
-	} else if (ACPI_COMPANION(dev))
+	} else if (has_acpi_companion(dev))
 		dev = &ACPI_COMPANION(dev)->dev;
 
 	rcu_read_lock();
Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -168,7 +168,7 @@ int acpi_bind_one(struct device *dev, st
 	unsigned int node_id;
 	int retval = -EINVAL;
 
-	if (ACPI_COMPANION(dev)) {
+	if (has_acpi_companion(dev)) {
 		if (acpi_dev) {
 			dev_warn(dev, "ACPI companion already set\n");
 			return -EINVAL;
@@ -220,7 +220,7 @@ int acpi_bind_one(struct device *dev, st
 	list_add(&physical_node->node, physnode_list);
 	acpi_dev->physical_node_count++;
 
-	if (!ACPI_COMPANION(dev))
+	if (!has_acpi_companion(dev))
 		ACPI_COMPANION_SET(dev, acpi_dev);
 
 	acpi_physnode_link_name(physical_node_name, node_id);

