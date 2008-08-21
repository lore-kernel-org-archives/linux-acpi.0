From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Thu, 21 Aug 2008 20:01:36 +0400
Message-ID: <48AD9160.90005@suse.de>
References: <200808202341.m7KNflv7005413@imap1.linux-foundation.org> <48AD5BBB.2050701@suse.de> <48AD6F14.9080700@tuffmail.co.uk> <48AD73E9.9090904@suse.de> <48AD7EBD.9030507@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030205060500020908070007"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:34175 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751471AbYHUQBi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 12:01:38 -0400
In-Reply-To: <48AD7EBD.9030507@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: akpm@linux-foundation.org, andi@firstfloor.org, linux-acpi@vger.kernel.org, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

This is a multi-part message in MIME format.
--------------030205060500020908070007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here is the patch.

Please try/review.

Regards,
Alex.
Alan Jenkins wrote:
>
> Sounds sensible.  Hopefully we're right that most systems with these
> broken EC's don't want the workaround.  I assume you will still notify
> the user automatically, something like "acpi: ec: GPE storm detected,
> try booting with ec=poll".
> 
> Thanks
> Alan


--------------030205060500020908070007
Content-Type: text/x-diff;
 name="ec_manual_mode_switch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_manual_mode_switch.patch"

ACPI: EC: Don't degrade to poll mode at storm automatically.

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Not all users of semi-broken EC devices want to degrade to poll mode, so
give them right to choose.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/ec.c                   |   36 +++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)


diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a897646..cbde9bc 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -675,6 +675,11 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	eata=		[HW,SCSI]
 
+	ec_intr=	[HW,ACPI] ACPI Embedded Controller interrupt mode
+			Format: <int>
+			0: polling mode
+			non-0: interrupt mode (default)
+
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 13593f9..bdc9b6b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -110,6 +110,8 @@ static struct acpi_ec {
 	u8 handlers_installed;
 } *boot_ec, *first_ec;
 
+int acpi_ec_intr = 1; /* Default is interrupt mode */
+
 /* 
  * Some Asus system have exchanged ECDT data/command IO addresses.
  */
@@ -516,12 +518,14 @@ static u32 acpi_ec_gpe_handler(void *data)
 	acpi_status status = AE_OK;
 	struct acpi_ec *ec = data;
 	u8 state = acpi_ec_read_status(ec);
+	static bool warn_done = 0;
 
 	pr_debug(PREFIX "~~~> interrupt\n");
 	atomic_inc(&ec->irq_count);
-	if (atomic_read(&ec->irq_count) > 5) {
-		pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
-		ec_switch_to_poll_mode(ec);
+	if (!warn_done && atomic_read(&ec->irq_count) > 5) {
+		pr_warning(PREFIX "GPE storm detected, try to use ec_intr=0 "
+			"kernel option, if you see problems with keyboard.\n");
+		warn_done = 1;
 		goto end;
 	}
 	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
@@ -848,20 +852,21 @@ static int ec_install_handlers(struct acpi_ec *ec)
 	acpi_status status;
 	if (ec->handlers_installed)
 		return 0;
-	status = acpi_install_gpe_handler(NULL, ec->gpe,
+	if (acpi_ec_intr) {
+		status = acpi_install_gpe_handler(NULL, ec->gpe,
 					  ACPI_GPE_EDGE_TRIGGERED,
 					  &acpi_ec_gpe_handler, ec);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
 
+		acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	}
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
 						    NULL, ec);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status) && acpi_ec_intr) {
 		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
 		return -ENODEV;
 	}
@@ -1047,3 +1052,14 @@ static void __exit acpi_ec_exit(void)
 	return;
 }
 #endif	/* 0 */
+
+static int __init acpi_ec_set_intr_mode(char *str)
+{
+	if (!get_option(&str, &acpi_ec_intr)) {
+		acpi_ec_intr = 0;
+		return 0;
+	}
+	return 1;
+}
+
+__setup("ec_intr=", acpi_ec_set_intr_mode);

--------------030205060500020908070007--
