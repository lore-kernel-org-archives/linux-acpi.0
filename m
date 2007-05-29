From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: [PATCH 1/3] ACPI EC: Re-factor EC space handler to avoid using
	label/goto for cycle.
Date: Tue, 29 May 2007 16:42:52 +0400
Message-ID: <20070529124252.20303.89820.stgit@z61m>
References: <20070529123823.20303.55101.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:25118 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbXE2Mmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 May 2007 08:42:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1849494ugf
        for <linux-acpi@vger.kernel.org>; Tue, 29 May 2007 05:42:53 -0700 (PDT)
In-Reply-To: <20070529123823.20303.55101.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <aystarik@gmail.com>

Signed-off-by: Alexey Starikovskiy <aystarik@gmail.com>
---

 drivers/acpi/ec.c |   56 ++++++++++++++++-------------------------------------
 1 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 82f496c..5534b23 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -454,57 +454,35 @@ acpi_ec_space_setup(acpi_handle region_handle,
 }
 
 static acpi_status
-acpi_ec_space_handler(u32 function,
-		      acpi_physical_address address,
-		      u32 bit_width,
-		      acpi_integer * value,
+acpi_ec_space_handler(u32 function, acpi_physical_address address,
+		      u32 bits, acpi_integer *value,
 		      void *handler_context, void *region_context)
 {
-	int result = 0;
 	struct acpi_ec *ec = handler_context;
-	u64 temp = *value;
-	acpi_integer f_v = 0;
-	int i = 0;
+	int result = 0, i = 0;
+	u8 temp = 0;
 
 	if ((address > 0xFF) || !value || !handler_context)
 		return AE_BAD_PARAMETER;
 
-	if (bit_width != 8 && acpi_strict) {
+	if (function != ACPI_READ && function != ACPI_WRITE)
 		return AE_BAD_PARAMETER;
-	}
-
-      next_byte:
-	switch (function) {
-	case ACPI_READ:
-		temp = 0;
-		result = acpi_ec_read(ec, (u8) address, (u8 *) & temp);
-		break;
-	case ACPI_WRITE:
-		result = acpi_ec_write(ec, (u8) address, (u8) temp);
-		break;
-	default:
-		result = -EINVAL;
-		goto out;
-		break;
-	}
 
-	bit_width -= 8;
-	if (bit_width) {
-		if (function == ACPI_READ)
-			f_v |= temp << 8 * i;
-		if (function == ACPI_WRITE)
-			temp >>= 8;
-		i++;
-		address++;
-		goto next_byte;
-	}
+	if (bits != 8 && acpi_strict)
+		return AE_BAD_PARAMETER;
 
-	if (function == ACPI_READ) {
-		f_v |= temp << 8 * i;
-		*value = f_v;
+	while (bits - i > 0) {
+		if (function == ACPI_READ) {
+			result = acpi_ec_read(ec, address, &temp);
+			(*value) |= ((acpi_integer)temp) << i;
+		} else {
+			temp = 0xff & ((*value) >> i);
+			result = acpi_ec_write(ec, address, temp);
+		}
+		i += 8;
+		++address;
 	}
 
-      out:
 	switch (result) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;

