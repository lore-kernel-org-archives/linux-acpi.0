From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] ACPI / EC: Use busy polling mode when GPE is not enabled
Date: Fri,  6 Jan 2017 16:58:23 +0800
Message-ID: <1483693104-14003-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Lv Zheng <lv.zheng@intel.com>

Previously we have report that during system bootup, the EC command
was running too slow because the EC GPE has not been enabled yet
(For example, _REG tries to access the EC operation region, while the
EC GPE has not been enabled at that stage). Actually we can optimize this
scenario by using busy polling mode if GPE is disabled, which is much
faster than the default behavior.

Reported-and-tested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 48e19d0..457949d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -342,6 +342,14 @@ static const char *acpi_ec_cmd_string(u8 cmd)
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
@@ -734,7 +742,7 @@ static int ec_guard(struct acpi_ec *ec)
 
 	/* Ensure guarding period before polling EC status */
 	do {
-		if (ec_busy_polling) {
+		if (!acpi_ec_is_gpe_enabled(ec) || ec_busy_polling) {
 			/* Perform busy polling */
 			if (ec_transaction_completed(ec))
 				return 0;
-- 
2.7.4
