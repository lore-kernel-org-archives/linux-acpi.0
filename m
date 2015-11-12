From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH] Revert "ACPI / SBS: Add 5 us delay to fix SBS hangs on
 MacBook"
Date: Thu, 12 Nov 2015 19:24:47 +0000
Message-ID: <20151112192447.GA4564@localhost>
References: <20151106204408.GA11609@localhost>
 <53589361.gQMCOa1UoV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53589361.gQMCOa1UoV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lv.zheng@intel.com, aaron.lu@intel.com, aystarik@gmail.com
List-Id: linux-acpi@vger.kernel.org

This reverts commit 3349fb64b2927407017d970dd5c4daf3c5ad69f8.

After commit 8848d20cf09c ("ACPI / SMBus: Fix boot stalls / high CPU
caused by reentrant code") the delay is no longer necessary.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 drivers/acpi/sbshc.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index e2900518cf7e..2fa8304171e0 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/dmi.h>
 #include "sbshc.h"
 
 #define PREFIX "ACPI: "
@@ -89,8 +88,6 @@ enum acpi_smb_offset {
 	ACPI_SMB_ALARM_DATA = 0x26,	/* 2 bytes alarm data */
 };
 
-static bool macbook;
-
 static inline int smb_hc_read(struct acpi_smb_hc *hc, u8 address, u8 *data)
 {
 	return ec_read(hc->offset + address, data);
@@ -121,8 +118,6 @@ static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
 
 	mutex_lock(&hc->lock);
 	hc->done = false;
-	if (macbook)
-		udelay(5);
 	if (smb_hc_read(hc, ACPI_SMB_PROTOCOL, &temp))
 		goto end;
 	if (temp) {
@@ -250,29 +245,12 @@ extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
 
-static int macbook_dmi_match(const struct dmi_system_id *d)
-{
-	pr_debug("Detected MacBook, enabling workaround\n");
-	macbook = true;
-	return 0;
-}
-
-static struct dmi_system_id acpi_smbus_dmi_table[] = {
-	{ macbook_dmi_match, "Apple MacBook", {
-	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
-	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBook") },
-	},
-	{ },
-};
-
 static int acpi_smbus_hc_add(struct acpi_device *device)
 {
 	int status;
 	unsigned long long val;
 	struct acpi_smb_hc *hc;
 
-	dmi_check_system(acpi_smbus_dmi_table);
-
 	if (!device)
 		return -EINVAL;
 
-- 
2.1.4
