From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 5/5] ACPI: EC: Simplify boot EC checks in acpi_ec_add()
Date: Fri, 01 Feb 2019 12:50:47 +0100
Message-ID: <2085385.krXRubZqFl@aspire.rjw.lan>
References: <2897234.rJkq6cDEjt@aspire.rjw.lan> <2804781.zocuRj5ZkX@aspire.rjw.lan> <1961969.KkQjHZ1Gvm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1961969.KkQjHZ1Gvm@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Erik Schmauss <erik.schmauss@intel.com>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: EC: Simplify boot EC checks in acpi_ec_add()

Consolidate boot EC checks in acpi_ec_add(), put the acpi_is_boot_ec()
checks directly into it and drop the latter.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
  * Drop the is_ecdt local var from acpi_ec_add() and update
    boot_ec_is_ecdt directly (adding a missing boot_ec_is_ecdt update).
  * Add dep_update local var to acpi_ec_add() to indicate when dependent
    devices shouls be re-probed.

---
 drivers/acpi/ec.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1560,43 +1560,34 @@ static bool acpi_ec_ecdt_get_handle(acpi
 	return true;
 }
 
-static bool acpi_is_boot_ec(struct acpi_ec *ec)
-{
-	if (!boot_ec)
-		return false;
-	if (ec->command_addr == boot_ec->command_addr &&
-	    ec->data_addr == boot_ec->data_addr)
-		return true;
-	return false;
-}
-
 static int acpi_ec_add(struct acpi_device *device)
 {
 	struct acpi_ec *ec = NULL;
-	int ret;
-	bool is_ecdt = false;
+	bool dep_update = true;
 	acpi_status status;
+	int ret;
 
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
 	if (!strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {
-		is_ecdt = true;
+		boot_ec_is_ecdt = true;
 		ec = boot_ec;
+		dep_update = false;
 	} else {
 		ec = acpi_ec_alloc();
 		if (!ec)
 			return -ENOMEM;
+
 		status = ec_parse_device(device->handle, 0, ec, NULL);
 		if (status != AE_CTRL_TERMINATE) {
 			ret = -EINVAL;
 			goto err_alloc;
 		}
-	}
 
-	if (acpi_is_boot_ec(ec)) {
-		boot_ec_is_ecdt = is_ecdt;
-		if (!is_ecdt) {
+		if (boot_ec && ec->command_addr == boot_ec->command_addr &&
+		    ec->data_addr == boot_ec->data_addr) {
+			boot_ec_is_ecdt = false;
 			/*
 			 * Trust PNP0C09 namespace location rather than
 			 * ECDT ID. But trust ECDT GPE rather than _GPE
@@ -1617,7 +1608,7 @@ static int acpi_ec_add(struct acpi_devic
 	if (ec == boot_ec)
 		acpi_handle_info(boot_ec->handle,
 				 "Boot %s EC used to handle transactions and events\n",
-				 is_ecdt ? "ECDT" : "DSDT");
+				 boot_ec_is_ecdt ? "ECDT" : "DSDT");
 
 	device->driver_data = ec;
 
@@ -1626,7 +1617,7 @@ static int acpi_ec_add(struct acpi_devic
 	ret = !!request_region(ec->command_addr, 1, "EC cmd");
 	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
 
-	if (!is_ecdt) {
+	if (dep_update) {
 		/* Reprobe devices depending on the EC */
 		acpi_walk_dep_device_list(ec->handle);
 	}
