From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1] acpi EC: acpi-ecdt-uid-hack
Date: Tue, 07 Mar 2006 17:08:03 +0100
Message-ID: <E1FGejD-0000QV-00@decibel.fi.muni.cz>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751149AbWCGQIT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Luming Yu <luming.yu@intel.com>, Robert Moore <robert.moore@intel.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-acpi@vger.kernel.org

acpi-ecdt-uid-hack

On some boxes ecdt uid may be equal to 0, so do not test for uids equality, so
that fake handler will be unconditionally removed to allow loading the real one.

See http://bugzilla.kernel.org/show_bug.cgi?id=6111

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Luming Yu <luming.yu@intel.com>

---
commit ff7e5094ceaf67b950f7684c66c54011fa0e5cd5
tree bde2662da704bea931d88fcc8a5d16d2f8895700
parent 8e07cf694b71c1cddded6f311e15db6e25696157
author Jiri Slaby <ku@bellona.localdomain> Mon, 06 Mar 2006 17:40:42 +0059
committer Jiri Slaby <ku@bellona.localdomain> Mon, 06 Mar 2006 17:40:42 +0059

 drivers/acpi/ec.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f339bd4..de95a09 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -989,7 +989,6 @@ static int acpi_ec_poll_add(struct acpi_
 	int result = 0;
 	acpi_status status = AE_OK;
 	union acpi_ec *ec = NULL;
-	unsigned long uid;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add");
 
@@ -1012,10 +1011,9 @@ static int acpi_ec_poll_add(struct acpi_
 	acpi_evaluate_integer(ec->common.handle, "_GLK", NULL,
 			      &ec->common.global_lock);
 
-	/* If our UID matches the UID for the ECDT-enumerated EC,
-	   we now have the *real* EC info, so kill the makeshift one. */
-	acpi_evaluate_integer(ec->common.handle, "_UID", NULL, &uid);
-	if (ec_ecdt && ec_ecdt->common.uid == uid) {
+	/* XXX we don't test uids, because on some boxes ecdt uid = 0, see:
+	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
+	if (ec_ecdt) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 						  ACPI_ADR_SPACE_EC,
 						  &acpi_ec_space_handler);
@@ -1059,7 +1057,6 @@ static int acpi_ec_intr_add(struct acpi_
 	int result = 0;
 	acpi_status status = AE_OK;
 	union acpi_ec *ec = NULL;
-	unsigned long uid;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add");
 
@@ -1085,10 +1082,9 @@ static int acpi_ec_intr_add(struct acpi_
 	acpi_evaluate_integer(ec->common.handle, "_GLK", NULL,
 			      &ec->common.global_lock);
 
-	/* If our UID matches the UID for the ECDT-enumerated EC,
-	   we now have the *real* EC info, so kill the makeshift one. */
-	acpi_evaluate_integer(ec->common.handle, "_UID", NULL, &uid);
-	if (ec_ecdt && ec_ecdt->common.uid == uid) {
+	/* XXX we don't test uids, because on some boxes ecdt uid = 0, see:
+	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
+	if (ec_ecdt) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 						  ACPI_ADR_SPACE_EC,
 						  &acpi_ec_space_handler);
