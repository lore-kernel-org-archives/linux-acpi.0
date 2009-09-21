From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 2/8] ACPI: use acpi_device_hid() when possible
Date: Mon, 21 Sep 2009 13:35:09 -0600
Message-ID: <20090921193509.21656.63871.stgit@bob.kio>
References: <20090921193417.21656.32718.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:48276 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbZIUTfG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:35:06 -0400
In-Reply-To: <20090921193417.21656.32718.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Use acpi_device_hid() rather than accessing acpi_device.pnp.hardware_id
directly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c        |    6 +++---
 drivers/pnp/pnpacpi/core.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e9227ea..269c0aa 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -185,7 +185,7 @@ static ssize_t
 acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf) {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "%s\n", acpi_dev->pnp.hardware_id);
+	return sprintf(buf, "%s\n", acpi_device_hid(acpi_dev));
 }
 static DEVICE_ATTR(hid, 0444, acpi_device_hid_show, NULL);
 
@@ -501,7 +501,7 @@ static int acpi_device_register(struct acpi_device *device)
 	 * If failed, create one and link it into acpi_bus_id_list
 	 */
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
-		if(!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id? device->pnp.hardware_id : "device")) {
+		if (!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id ? acpi_device_hid(device) : "device")) {
 			acpi_device_bus_id->instance_no ++;
 			found = 1;
 			kfree(new_bus_id);
@@ -510,7 +510,7 @@ static int acpi_device_register(struct acpi_device *device)
 	}
 	if (!found) {
 		acpi_device_bus_id = new_bus_id;
-		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? device->pnp.hardware_id : "device");
+		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? acpi_device_hid(device) : "device");
 		acpi_device_bus_id->instance_no = 0;
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index c07fdb9..ff963d4 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -234,7 +234,7 @@ static int __init acpi_pnp_match(struct device *dev, void *_pnp)
 	/* true means it matched */
 	return acpi->flags.hardware_id
 	    && !acpi_get_physical_device(acpi->handle)
-	    && compare_pnp_id(pnp->id, acpi->pnp.hardware_id);
+	    && compare_pnp_id(pnp->id, acpi_device_hid(acpi));
 }
 
 static int __init acpi_pnp_find_device(struct device *dev, acpi_handle * handle)

