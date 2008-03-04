From: akpm@linux-foundation.org
Subject: [patch (for 2.6.25?) 1/3] ACPI: EC: fix regression
Date: Tue, 04 Mar 2008 15:00:12 -0800
Message-ID: <200803042300.m24N0CD9001543@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47184 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765296AbYCDXBF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 18:01:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, astarikovskiy@suse.de, len.brown@intel.com, m.s.tsirkin@gmail.com, rjw@sisk.pl

From: Alexey Starikovskiy <astarikovskiy@suse.de>

no changelog?

Tested-by: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/ec.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff -puN drivers/acpi/ec.c~acpi-ec-fix-regression drivers/acpi/ec.c
--- a/drivers/acpi/ec.c~acpi-ec-fix-regression
+++ a/drivers/acpi/ec.c
@@ -129,7 +129,8 @@ static struct acpi_ec {
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
-	u8 handlers_installed;
+	u8 handlers_installed:1;
+	u8 from_ecdt:1;
 } *boot_ec, *first_ec;
 
 /* --------------------------------------------------------------------------
@@ -772,16 +773,18 @@ static int acpi_ec_add(struct acpi_devic
 
 	/* Check for boot EC */
 	if (boot_ec) {
-		if (boot_ec->handle == device->handle) {
-			/* Pre-loaded EC from DSDT, just move pointer */
-			ec = boot_ec;
-			boot_ec = NULL;
-			goto end;
-		} else if (boot_ec->handle == ACPI_ROOT_OBJECT) {
+		if (boot_ec->from_ecdt &&
+		    (boot_ec->handle == device->handle ||
+		     boot_ec->handle == ACPI_ROOT_OBJECT)) {
 			/* ECDT-based EC, time to shut it down */
 			ec_remove_handlers(boot_ec);
 			kfree(boot_ec);
 			first_ec = boot_ec = NULL;
+		} else if (boot_ec->handle == device->handle) {
+			/* Pre-loaded EC from DSDT, just move pointer */
+			ec = boot_ec;
+			boot_ec = NULL;
+			goto end;
 		}
 	}
 
@@ -943,6 +946,7 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->command_addr = ecdt_ptr->control.address;
 		boot_ec->data_addr = ecdt_ptr->data.address;
 		boot_ec->gpe = ecdt_ptr->gpe;
+		boot_ec->from_ecdt = 1;
 		if (ACPI_FAILURE(acpi_get_handle(NULL, ecdt_ptr->id,
 				&boot_ec->handle))) {
 			pr_info("Failed to locate handle for boot EC\n");
_
