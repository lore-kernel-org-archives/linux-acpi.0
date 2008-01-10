From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/2] ACPI: EC: Do the byte access with a fast path
Date: Fri, 11 Jan 2008 02:42:51 +0300
Message-ID: <20080110234250.26720.16527.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:33632 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753381AbYAJXnV (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 10 Jan 2008 18:43:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Specification allows only byte access for EC region, so
make it separate from bug-compatible multy-byte access.
Also do not allow return of garbage in supplied *value.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9341
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 97dc161..1de0905 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -563,7 +563,7 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 		      void *handler_context, void *region_context)
 {
 	struct acpi_ec *ec = handler_context;
-	int result = 0, i = 0;
+	int result = 0, i;
 	u8 temp = 0;
 
 	if ((address > 0xFF) || !value || !handler_context)
@@ -575,7 +575,16 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (bits != 8 && acpi_strict)
 		return AE_BAD_PARAMETER;
 
-	while (bits - i > 0) {
+	if (function == ACPI_READ) {
+		result = acpi_ec_read(ec, address, &temp);
+		*value = temp;
+	} else {
+		temp = 0xff & (*value);
+		result = acpi_ec_write(ec, address, temp);
+	}
+
+	for (i = 8; unlikely(bits - i > 0); i += 8) {
+		++address;
 		if (function == ACPI_READ) {
 			result = acpi_ec_read(ec, address, &temp);
 			(*value) |= ((acpi_integer)temp) << i;
@@ -583,8 +592,6 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 			temp = 0xff & ((*value) >> i);
 			result = acpi_ec_write(ec, address, temp);
 		}
-		i += 8;
-		++address;
 	}
 
 	switch (result) {

