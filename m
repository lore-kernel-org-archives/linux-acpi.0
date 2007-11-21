From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/2] ACPI: EC: Add debug printks.
Date: Wed, 21 Nov 2007 03:16:51 +0300
Message-ID: <20071121001650.6796.4860.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:43834 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754259AbXKUAQU (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 19:16:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Sometimes it is usefull to see raw protocol dump.
Uncomment '#define DEBUG' at the beginning of file to make EC=20
really verbose.

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   50 +++++++++++++++++++++++++++++++--------------=
-----
 1 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 06b78e5..74b9407 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -47,6 +47,9 @@
 #undef PREFIX
 #define PREFIX				"ACPI: EC: "
=20
+/* Uncomment next line to get verbose print outs*/
+/* #define DEBUG */
+
 /* EC status register */
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
@@ -131,21 +134,27 @@ static struct acpi_ec {
=20
 static inline u8 acpi_ec_read_status(struct acpi_ec *ec)
 {
-	return inb(ec->command_addr);
+	u8 x =3D inb(ec->command_addr);
+	pr_debug(PREFIX "---> status =3D 0x%2x\n", x);
+	return x;
 }
=20
 static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
 {
+	u8 x =3D inb(ec->data_addr);
+	pr_debug(PREFIX "---> data =3D 0x%2x\n", x);
 	return inb(ec->data_addr);
 }
=20
 static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
 {
+	pr_debug(PREFIX "<--- command =3D 0x%2x\n", command);
 	outb(command, ec->command_addr);
 }
=20
 static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 {
+	pr_debug(PREFIX "<--- data =3D 0x%2x\n", data);
 	outb(data, ec->data_addr);
 }
=20
@@ -175,13 +184,14 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum =
ec_event event, int force_poll)
 		if (acpi_ec_check_status(ec, event)) {
 			if (event =3D=3D ACPI_EC_EVENT_OBF_1) {
 				/* miss OBF =3D 1 GPE, don't expect it anymore */
-				printk(KERN_INFO PREFIX "missing OBF_1 confirmation,"
+				pr_info(PREFIX "missing OBF_1 confirmation,"
 					"switching to degraded mode.\n");
 				set_bit(EC_FLAGS_ONLY_IBF_GPE, &ec->flags);
 			} else {
 				/* missing GPEs, switch back to poll mode */
-				printk(KERN_INFO PREFIX "missing IBF_1 confirmations,"
-					"switch off interrupt mode.\n");
+				if (!printk_ratelimit())
+					pr_info(PREFIX "missing IBF_1 confirmations,"
+						"switch off interrupt mode.\n");
 				clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 			}
 			return 0;
@@ -194,7 +204,7 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec=
_event event, int force_poll)
 				return 0;
 		}
 	}
-	printk(KERN_ERR PREFIX "acpi_ec_wait timeout,"
+	pr_err(PREFIX "acpi_ec_wait timeout,"
 			       " status =3D %d, expect_event =3D %d\n",
 			       acpi_ec_read_status(ec), event);
 	return -ETIME;
@@ -208,11 +218,11 @@ static int acpi_ec_transaction_unlocked(struct ac=
pi_ec *ec, u8 command,
 	int result =3D 0;
 	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	acpi_ec_write_cmd(ec, command);
-
+	pr_debug(PREFIX "transaction start\n");
 	for (; wdata_len > 0; --wdata_len) {
 		result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
 		if (result) {
-			printk(KERN_ERR PREFIX
+			pr_err(PREFIX
 			       "write_cmd timeout, command =3D %d\n", command);
 			goto end;
 		}
@@ -223,7 +233,7 @@ static int acpi_ec_transaction_unlocked(struct acpi=
_ec *ec, u8 command,
 	if (!rdata_len) {
 		result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
 		if (result) {
-			printk(KERN_ERR PREFIX
+			pr_err(PREFIX
 			       "finish-write timeout, command =3D %d\n", command);
 			goto end;
 		}
@@ -235,8 +245,7 @@ static int acpi_ec_transaction_unlocked(struct acpi=
_ec *ec, u8 command,
 			force_poll =3D 1;
 		result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, force_poll);
 		if (result) {
-			printk(KERN_ERR PREFIX "read timeout, command =3D %d\n",
-			       command);
+			pr_err(PREFIX "read timeout, command =3D %d\n", command);
 			goto end;
 		}
 		/* Don't expect GPE after last read */
@@ -245,6 +254,7 @@ static int acpi_ec_transaction_unlocked(struct acpi=
_ec *ec, u8 command,
 		*(rdata++) =3D acpi_ec_read_data(ec);
 	}
       end:
+	pr_debug(PREFIX "transaction end\n");
 	return result;
 }
=20
@@ -273,8 +283,8 @@ static int acpi_ec_transaction(struct acpi_ec *ec, =
u8 command,
=20
 	status =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
 	if (status) {
-		printk(KERN_ERR PREFIX
-		       "input buffer is not empty, aborting transaction\n");
+		pr_err(PREFIX "input buffer is not empty, "
+				"aborting transaction\n");
 		goto end;
 	}
=20
@@ -488,6 +498,7 @@ static u32 acpi_ec_gpe_handler(void *data)
 	acpi_status status =3D AE_OK;
 	struct acpi_ec *ec =3D data;
=20
+	pr_debug(PREFIX "~~~> interrupt\n");
 	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
 		wake_up(&ec->wait);
@@ -498,8 +509,9 @@ static u32 acpi_ec_gpe_handler(void *data)
 				acpi_ec_gpe_query, ec);
 	} else if (unlikely(!test_bit(EC_FLAGS_GPE_MODE, &ec->flags))) {
 		/* this is non-query, must be confirmation */
-		printk(KERN_INFO PREFIX "non-query interrupt received,"
-			" switching to interrupt mode\n");
+		if (!printk_ratelimit())
+			pr_info(PREFIX "non-query interrupt received,"
+				" switching to interrupt mode\n");
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	}
=20
@@ -701,10 +713,10 @@ static void ec_remove_handlers(struct acpi_ec *ec=
)
 {
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
-		printk(KERN_ERR PREFIX "failed to remove space handler\n");
+		pr_err(PREFIX "failed to remove space handler\n");
 	if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler)))
-		printk(KERN_ERR PREFIX "failed to remove gpe handler\n");
+		pr_err(PREFIX "failed to remove gpe handler\n");
 	ec->handlers_installed =3D 0;
 }
=20
@@ -747,9 +759,9 @@ static int acpi_ec_add(struct acpi_device *device)
 		first_ec =3D ec;
 	acpi_driver_data(device) =3D ec;
 	acpi_ec_add_fs(device);
-	printk(KERN_INFO PREFIX "GPE =3D 0x%lx, I/O: command/status =3D 0x%lx=
, data =3D 0x%lx\n",
+	pr_info(PREFIX "GPE =3D 0x%lx, I/O: command/status =3D 0x%lx, data =3D=
 0x%lx\n",
 			  ec->gpe, ec->command_addr, ec->data_addr);
-	printk(KERN_INFO PREFIX "driver started in %s mode\n",
+	pr_info(PREFIX "driver started in %s mode\n",
 		(test_bit(EC_FLAGS_GPE_MODE, &ec->flags))?"interrupt":"poll");
 	return 0;
 }
@@ -875,7 +887,7 @@ int __init acpi_ec_ecdt_probe(void)
 	status =3D acpi_get_table(ACPI_SIG_ECDT, 1,
 				(struct acpi_table_header **)&ecdt_ptr);
 	if (ACPI_SUCCESS(status)) {
-		printk(KERN_INFO PREFIX "EC description table is found, configuring =
boot EC\n");
+		pr_info(PREFIX "EC description table is found, configuring boot EC\n=
");
 		boot_ec->command_addr =3D ecdt_ptr->control.address;
 		boot_ec->data_addr =3D ecdt_ptr->data.address;
 		boot_ec->gpe =3D ecdt_ptr->gpe;

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
