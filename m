From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 5/6] ACPI: EC: Switch off GPE mode during suspend/resume
Date: Fri, 21 Mar 2008 17:07:21 +0300
Message-ID: <20080321140721.30578.33091.stgit@thinkpad.local>
References: <20080321140648.30578.73816.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51711 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753636AbYCUOHp (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 10:07:45 -0400
In-Reply-To: <20080321140648.30578.73816.stgit@thinkpad.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   60 ++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7f07b68..da67d22 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -83,28 +83,6 @@ enum {
 	EC_FLAGS_RESCHEDULE_POLL	/* Re-schedule poll */
 };
 
-static int acpi_ec_remove(struct acpi_device *device, int type);
-static int acpi_ec_start(struct acpi_device *device);
-static int acpi_ec_stop(struct acpi_device *device, int type);
-static int acpi_ec_add(struct acpi_device *device);
-
-static const struct acpi_device_id ec_device_ids[] = {
-	{"PNP0C09", 0},
-	{"", 0},
-};
-
-static struct acpi_driver acpi_ec_driver = {
-	.name = "ec",
-	.class = ACPI_EC_CLASS,
-	.ids = ec_device_ids,
-	.ops = {
-		.add = acpi_ec_add,
-		.remove = acpi_ec_remove,
-		.start = acpi_ec_start,
-		.stop = acpi_ec_stop,
-		},
-};
-
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
 /* External interfaces use first EC only, so remember */
 typedef int (*acpi_ec_query_func) (void *data);
@@ -924,6 +902,11 @@ int __init acpi_boot_ec_enable(void)
 	return -EFAULT;
 }
 
+static const struct acpi_device_id ec_device_ids[] = {
+	{"PNP0C09", 0},
+	{"", 0},
+};
+
 int __init acpi_ec_ecdt_probe(void)
 {
 	int ret;
@@ -973,6 +956,39 @@ int __init acpi_ec_ecdt_probe(void)
 	return -ENODEV;
 }
 
+static int acpi_ec_suspend(struct acpi_device *device, pm_message_t state)
+{
+	struct acpi_ec *ec = acpi_driver_data(device);
+	/* Stop using GPE */
+	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
+	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	return 0;
+}
+
+static int acpi_ec_resume(struct acpi_device *device)
+{
+	struct acpi_ec *ec = acpi_driver_data(device);
+	/* Enable use of GPE back */
+	clear_bit(EC_FLAGS_NO_GPE, &ec->flags);
+	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	return 0;
+}
+
+static struct acpi_driver acpi_ec_driver = {
+	.name = "ec",
+	.class = ACPI_EC_CLASS,
+	.ids = ec_device_ids,
+	.ops = {
+		.add = acpi_ec_add,
+		.remove = acpi_ec_remove,
+		.start = acpi_ec_start,
+		.stop = acpi_ec_stop,
+		.suspend = acpi_ec_suspend,
+		.resume = acpi_ec_resume,
+		},
+};
+
 static int __init acpi_ec_init(void)
 {
 	int result = 0;

