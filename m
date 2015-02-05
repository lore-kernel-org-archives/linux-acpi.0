From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 5/6] ACPI / EC: Reduce ec_poll() by referencing the last register access timestamp.
Date: Thu,  5 Feb 2015 16:27:29 +0800
Message-ID: <3bbd64fe5fdd5f0940acd18af7edcf6fc0d0fbff.1423123819.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1423123818.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423123818.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Timeout in the ec_poll() doesn't refer to the last register access time. It
thus can win the competition against the acpi_ec_gpe_handler() if a
transaction takes longer than 1ms but individual register accesses are less
than 1ms.  In some cases, it can make the following silicon bug easier to
be triggered:
 GPE EN is not wired to the GPE trigger line, so when GPE STS is already
 set when 1 is written to GPE EN, no GPE can be triggered.

This patch adds register access timestamp reference support for ec_poll()
to reduce the number of ec_poll() invocations.

Reported-by: Venkat Raghavulu <venkat.raghavulu@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2540870..e000cf7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -71,6 +71,7 @@ enum ec_command {
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #define ACPI_EC_MSI_UDELAY	550	/* Wait 550us for MSI EC */
+#define ACPI_EC_UDELAY_POLL	1000	/* Wait 1ms for EC transaction polling */
 #define ACPI_EC_CLEAR_MAX	100	/* Maximum number of events to query
 					 * when trying to clear the EC */
 
@@ -118,6 +119,7 @@ struct transaction {
 	u8 wlen;
 	u8 rlen;
 	u8 flags;
+	unsigned long timestamp;
 };
 
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data);
@@ -155,6 +157,7 @@ static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
 {
 	u8 x = inb(ec->data_addr);
 
+	ec->curr->timestamp = jiffies;
 	pr_debug("EC_DATA(R) = 0x%2.2x\n", x);
 	return x;
 }
@@ -163,12 +166,14 @@ static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
 {
 	pr_debug("EC_SC(W) = 0x%2.2x\n", command);
 	outb(command, ec->command_addr);
+	ec->curr->timestamp = jiffies;
 }
 
 static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 {
 	pr_debug("EC_DATA(W) = 0x%2.2x\n", data);
 	outb(data, ec->data_addr);
+	ec->curr->timestamp = jiffies;
 }
 
 #ifdef DEBUG
@@ -359,6 +364,7 @@ static void start_transaction(struct acpi_ec *ec)
 {
 	ec->curr->irq_count = ec->curr->wi = ec->curr->ri = 0;
 	ec->curr->flags = 0;
+	ec->curr->timestamp = jiffies;
 	advance_transaction(ec);
 }
 
@@ -370,20 +376,25 @@ static int ec_poll(struct acpi_ec *ec)
 	while (repeat--) {
 		unsigned long delay = jiffies +
 			msecs_to_jiffies(ec_delay);
+		unsigned long usecs = ACPI_EC_UDELAY_POLL;
 		do {
 			/* don't sleep with disabled interrupts */
 			if (EC_FLAGS_MSI || irqs_disabled()) {
-				udelay(ACPI_EC_MSI_UDELAY);
+				usecs = ACPI_EC_MSI_UDELAY;
+				udelay(usecs);
 				if (ec_transaction_completed(ec))
 					return 0;
 			} else {
 				if (wait_event_timeout(ec->wait,
 						ec_transaction_completed(ec),
-						msecs_to_jiffies(1)))
+						usecs_to_jiffies(usecs)))
 					return 0;
 			}
 			spin_lock_irqsave(&ec->lock, flags);
-			advance_transaction(ec);
+			if (time_after(jiffies,
+					ec->curr->timestamp +
+					usecs_to_jiffies(usecs)))
+				advance_transaction(ec);
 			spin_unlock_irqrestore(&ec->lock, flags);
 		} while (time_before(jiffies, delay));
 		pr_debug("controller reset, restart transaction\n");
-- 
1.7.10
