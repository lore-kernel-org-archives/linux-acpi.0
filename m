From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] ACPI: EC: Fix an EC event IRQ storming issue
Date: Wed, 14 Jun 2017 13:59:09 +0800
Message-ID: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdFNF7O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jun 2017 01:59:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The EC event IRQ (SCI_EVT) can only be handled by submitting QR_EC. As the
EC driver handles SCI_EVT in a workqueue, after SCI_EVT is flagged and
before QR_EC is submitted, there is a period risking IRQ storming. EC IRQ
must be masked for this period but linux EC driver never does so.

No end user notices the IRQ storming and no developer fixes this known
issue because:
1. the EC IRQ is always edge triggered GPE, and
2. the kernel can execute no-op EC IRQ handler very fast.
For edge triggered EC GPE platforms, it is only reported of post-resume EC
event lost issues, there won't be an IRQ storming. For level triggered EC
GPE platforms, fortunately the kernel is always fast enough to execute such
a no-op EC IRQ handler so that the IRQ handler won't be accumulated to
starve the task contexts, causing a real IRQ storming.

But the IRQ storming actually can still happen when:
1. the EC IRQ performs like level triggered GPE, and
2. the kernel EC debugging log is turned on but the console is slow enough.
There are more and more platforms using EC GPE as wake GPE where the EC GPE
is likely designed as level triggered. Then when EC debugging log is
enabled, the EC IRQ handler is no longer a no-op but dumps IRQ status to
the consoles. If the consoles are slow enough, the EC IRQs can arrive much
faster than executing the handler. Finally the accumulated EC event IRQ
handlers starve the task contexts, causing the IRQ storming to occur, and
the kernel hangs can be observed during boot/resume.

See link #1 for reference, however the bug link can only be accessed by
priviledged Intel users.

This patch fixes this issue by masking EC IRQ for this period:
1. begins when there is an SCI_EVT IRQ pending, and
2. ends when there is a QR_EC completed (SCI_EVT acknowledged).

Link: https://jira01.devtools.intel.com/browse/LCK-4004 [#1]
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: Feng Chenzhou <chenzhoux.feng@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c24235d..30d7f82 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -459,8 +459,10 @@ static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
 
 static void acpi_ec_submit_query(struct acpi_ec *ec)
 {
-	if (acpi_ec_event_enabled(ec) &&
-	    !test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
+	acpi_ec_set_storm(ec, EC_FLAGS_COMMAND_STORM);
+	if (!acpi_ec_event_enabled(ec))
+		return;
+	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
 		ec_dbg_evt("Command(%s) submitted/blocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
 		ec->nr_pending_queries++;
@@ -470,11 +472,10 @@ static void acpi_ec_submit_query(struct acpi_ec *ec)
 
 static void acpi_ec_complete_query(struct acpi_ec *ec)
 {
-	if (test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
-		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+	if (test_and_clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
 		ec_dbg_evt("Command(%s) unblocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
-	}
+	acpi_ec_clear_storm(ec, EC_FLAGS_COMMAND_STORM);
 }
 
 static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
-- 
2.7.4

