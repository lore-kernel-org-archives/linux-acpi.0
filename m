From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI / EC: Improve busy polling quirk.
Date: Mon, 11 May 2015 11:38:11 +0800
Message-ID: <3b6064b23b148a9c3eed58566e9361a852618556.1430900840.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41424 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbbEKDib (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 May 2015 23:38:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The busy polling mode (EC_FLAGS_MSI) can be used to workaround some GPIO
driver bugs. After their initialization, the PIN configuration of the EC
GPE may be cleared and the EC GPE might be disabled out of the
GPE register's control. And the busy polling can significantly shorten the
EC driver waiting time in this situation while the wait_event_timeout() has
to wait the basic HZ interval.

In order to improve the busy polling mode, this patch:
1. Removes a useless polling guarding logic which has been covered by many
   state machine race fixes.
2. Refines the delay logic to tune it to poll faster by spinning around the
   EC_SC read instead of spinning around the nop execution lasted a
   determined interval.
3. Deletes irqs_disabled() check as ec_poll() is ensured to be invoked in
   the contexts that can sleep.
4. Adds logic to do busy polling when the EC GPE is disabled.

This patch also updates acpi_ec_is_gpe_raised() according to the following
commit:
  Commit: 09af8e8290deaff821ced01ea83594ee4c21e8df
  Subject: ACPICA: Events: Add support to return both enable/status register values for GPE and fixed event.
This is actually a no-op change as both the flags are defined to a same
value.

We've tested the patch on a test platform. The platform suffers from such
kind of the GPIO PIN issue. The GPIO driver resets all PIN configuration
and after that, EC interrupt cannot arrive because of the multiplexing.
Then the platform suffers from a long delay carried out by the
wait_event_timeout() as all further EC transactions will run in the polling
mode. We switched the EC driver to use the busy polling mechanism instead
of the wait timeout polling mechanism and the delay is still high:
[   44.283005] calling  PNP0C0B:00+ @ 1305, parent: platform
[   44.417548] call PNP0C0B:00+ returned 0 after 131323 usecs
And this patch can significantly reduce the delay:
[   44.502625] calling  PNP0C0B:00+ @ 1308, parent: platform
[   44.503760] call PNP0C0B:00+ returned 0 after 1103 usecs

Tested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5e8fed4..e98c242 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -70,7 +70,6 @@ enum ec_command {
 
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
-#define ACPI_EC_MSI_UDELAY	550	/* Wait 550us for MSI EC */
 #define ACPI_EC_UDELAY_POLL	1000	/* Wait 1ms for EC transaction polling */
 #define ACPI_EC_CLEAR_MAX	100	/* Maximum number of events to query
 					 * when trying to clear the EC */
@@ -262,12 +261,20 @@ static const char *acpi_ec_cmd_string(u8 cmd)
  *                           GPE Registers
  * -------------------------------------------------------------------------- */
 
+static inline bool acpi_ec_is_gpe_enabled(struct acpi_ec *ec)
+{
+	acpi_event_status gpe_status = 0;
+
+	(void)acpi_get_gpe_status(NULL, ec->gpe, &gpe_status);
+	return (gpe_status & ACPI_EVENT_FLAG_ENABLE_SET) ? true : false;
+}
+
 static inline bool acpi_ec_is_gpe_raised(struct acpi_ec *ec)
 {
 	acpi_event_status gpe_status = 0;
 
 	(void)acpi_get_gpe_status(NULL, ec->gpe, &gpe_status);
-	return (gpe_status & ACPI_EVENT_FLAG_SET) ? true : false;
+	return (gpe_status & ACPI_EVENT_FLAG_STATUS_SET) ? true : false;
 }
 
 static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
@@ -505,9 +512,7 @@ static int ec_poll(struct acpi_ec *ec)
 		unsigned long usecs = ACPI_EC_UDELAY_POLL;
 		do {
 			/* don't sleep with disabled interrupts */
-			if (EC_FLAGS_MSI || irqs_disabled()) {
-				usecs = ACPI_EC_MSI_UDELAY;
-				udelay(usecs);
+			if (EC_FLAGS_MSI || !acpi_ec_is_gpe_enabled(ec)) {
 				if (ec_transaction_completed(ec))
 					return 0;
 			} else {
@@ -517,7 +522,9 @@ static int ec_poll(struct acpi_ec *ec)
 					return 0;
 			}
 			spin_lock_irqsave(&ec->lock, flags);
-			if (time_after(jiffies,
+			if (EC_FLAGS_MSI ||
+			    !acpi_ec_is_gpe_enabled(ec) ||
+			    time_after(jiffies,
 					ec->curr->timestamp +
 					usecs_to_jiffies(usecs)))
 				advance_transaction(ec);
@@ -537,8 +544,6 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	unsigned long tmp;
 	int ret = 0;
 
-	if (EC_FLAGS_MSI)
-		udelay(ACPI_EC_MSI_UDELAY);
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
 	/* Enable GPE for command processing (IBF=0/OBF=1) */
-- 
1.7.10

