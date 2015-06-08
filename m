From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/6] ACPI / EC: Fix EC_FLAGS_QUERY_HANDSHAKE platforms using new event clearing timing.
Date: Mon,  8 Jun 2015 13:28:15 +0800
Message-ID: <ebee57860def2b2f74b449cbb5c82c1fd95799e3.1433734431.git.lv.zheng@intel.com>
References: <cover.1433734431.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50485 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbbFHF2U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2015 01:28:20 -0400
In-Reply-To: <cover.1433734431.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It is reported that on several platforms, EC firmware will not respond
non-expected QR_EC (see EC_FLAGS_QUERY_HANDSHAKE, only write QR_EC when
SCI_EVT is set).

Unfortunately, ACPI specification doesn't define when the SCI_EVT should be
cleared by the firmware, thus the original implementation queued up second
QR_EC right after writing QR_EC command and before reading the returned
event value as at that time the SCI_EVT is ensured not cleared. This
behavior is also based on the assumption that the firmware should be able
to return 0x00 to indicate "no outstanding event". This behavior did fix
issues on Samsung platforms where the spurious query value of 0x00 is
supported and didn't break platforms in my test queue.

But recently, specific Acer, Asus, Lenovo platforms keep on blaming this
change.

This patch changes the behavior to re-check the SCI_EVT a bit later and
removes EC_FLAGS_QUERY_HANDSHAKE quirks, hoping this is the Windows
compliant EC driver behavior.

This patch keeps old behavior for Samsung platforms.

In order to be robust to the possible regressions, instead of removing the
quirk directly, this patch keeps the quirk code and removes the quirk
users.

Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
Link: https://bugzilla.kernel.org/show_bug.cgi?id=94411
Link: https://bugzilla.kernel.org/show_bug.cgi?id=97381
Link: https://bugzilla.kernel.org/show_bug.cgi?id=98111
Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Reported-and-tested-by: Tigran Gabrielyan <tigrangab@gmail.com>
Reported-and-tested-by: Adrien D <ghbdtn@openmailbox.org>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8477626..2f13880 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -144,7 +144,7 @@ static unsigned int ec_polling_guard __read_mostly = ACPI_EC_UDELAY_POLL;
 module_param(ec_polling_guard, uint, 0644);
 MODULE_PARM_DESC(ec_polling_guard, "Guard time(us) between EC accesses in polling modes");
 
-static unsigned int ec_event_clearing __read_mostly = ACPI_EC_EVT_TIMING_STATUS;
+static unsigned int ec_event_clearing __read_mostly = ACPI_EC_EVT_TIMING_QUERY;
 
 /*
  * If the number of false interrupts per one transaction exceeds
@@ -1385,10 +1385,13 @@ static int ec_validate_ecdt(const struct dmi_system_id *id)
 	return 0;
 }
 
+#if 0
 /*
- * Acer EC firmware refuses to respond QR_EC when SCI_EVT is not set, for
- * which case, we complete the QR_EC without issuing it to the firmware.
- * https://bugzilla.kernel.org/show_bug.cgi?id=86211
+ * Some EC firmware variations refuses to respond QR_EC when SCI_EVT is not
+ * set, for which case, we complete the QR_EC without issuing it to the
+ * firmware.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=82611
+ * https://bugzilla.kernel.org/show_bug.cgi?id=97381
  */
 static int ec_flag_query_handshake(const struct dmi_system_id *id)
 {
@@ -1396,6 +1399,7 @@ static int ec_flag_query_handshake(const struct dmi_system_id *id)
 	EC_FLAGS_QUERY_HANDSHAKE = 1;
 	return 0;
 }
+#endif
 
 /*
  * On some hardware it is necessary to clear events accumulated by the EC during
@@ -1418,6 +1422,7 @@ static int ec_clear_on_resume(const struct dmi_system_id *id)
 {
 	pr_debug("Detected system needing EC poll on resume.\n");
 	EC_FLAGS_CLEAR_ON_RESUME = 1;
+	ec_event_clearing = ACPI_EC_EVT_TIMING_STATUS;
 	return 0;
 }
 
@@ -1447,9 +1452,6 @@ static struct dmi_system_id ec_dmi_table[] __initdata = {
 	{
 	ec_clear_on_resume, "Samsung hardware", {
 	DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")}, NULL},
-	{
-	ec_flag_query_handshake, "Acer hardware", {
-	DMI_MATCH(DMI_SYS_VENDOR, "Acer"), }, NULL},
 	{},
 };
 
-- 
1.7.10

