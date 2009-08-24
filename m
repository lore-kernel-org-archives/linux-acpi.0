From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 02/10] ACPI: add ACPI_IS_ROOT_DEVICE()
Date: Mon, 24 Aug 2009 10:38:40 -0600
Message-ID: <20090824163840.28131.89192.stgit@bob.kio>
References: <20090824163659.28131.96400.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:2342 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZHXQif (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 12:38:35 -0400
In-Reply-To: <20090824163659.28131.96400.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This adds a macro to identify the root of the acpi_device tree.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index cbeb4c0..a253373 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -22,6 +22,8 @@ extern struct acpi_device *acpi_root;
 #define ACPI_BUS_HID			"LNXSYBUS"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
+#define ACPI_IS_ROOT_DEVICE(device)	(!(device)->parent)
+
 static LIST_HEAD(acpi_device_list);
 static LIST_HEAD(acpi_bus_id_list);
 DEFINE_MUTEX(acpi_device_lock);
@@ -950,7 +952,7 @@ static void acpi_device_get_busid(struct acpi_device *device)
 	 * The device's Bus ID is simply the object name.
 	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
 	 */
-	if (!device->parent) {
+	if (ACPI_IS_ROOT_DEVICE(device)) {
 		strcpy(device->pnp.bus_id, "ACPI");
 		return;
 	}
@@ -1033,7 +1035,7 @@ static void acpi_device_set_id(struct acpi_device *device)
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_DEVICE:
-		if (!device->parent) {
+		if (ACPI_IS_ROOT_DEVICE(device)) {
 			hid = ACPI_SYSTEM_HID;
 			break;
 		}

