From: Song liwei <liwei.song@windriver.com>
Subject: [PATCH V2] ACPI, APEI: Fixup incorrect 16-bit access width firmware bug
Date: Wed, 26 Jul 2017 22:31:08 -0400
Message-ID: <1501122668-53948-1-git-send-email-liwei.song@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:36784 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbdG0CbR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jul 2017 22:31:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LiweiSong <liwei.song@windriver.com>

From: Liwei Song <liwei.song@windriver.com>

This is a follow up to commit f712c71f7b2b ("ACPI, APEI: Fixup common
access width firmware bug") fix the following firmware bug:

[Firmware Bug]: APEI: Invalid bit width + offset in GAR [0xb2/16/0/1/1]

This is due to an 8-bit access width is specified for a 16-bit register,
Rearrange the condition and add 8-bit width check.

Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 drivers/acpi/apei/apei-base.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index da370e1..eca3d7a 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -604,12 +604,12 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	*access_bit_width = 1UL << (access_size_code + 2);
 
 	/* Fixup common BIOS bug */
-	if (bit_width == 32 && bit_offset == 0 && (*paddr & 0x03) == 0 &&
-	    *access_bit_width < 32)
-		*access_bit_width = 32;
-	else if (bit_width == 64 && bit_offset == 0 && (*paddr & 0x07) == 0 &&
-	    *access_bit_width < 64)
-		*access_bit_width = 64;
+	if (*access_bit_width < bit_width && bit_offset == 0) {
+		if ((bit_width == 16 && (*paddr & 0x01) == 0) ||
+		    (bit_width == 32 && (*paddr & 0x03) == 0) ||
+		    (bit_width == 64 && (*paddr & 0x07) == 0))
+			*access_bit_width = bit_width;
+	}
 
 	if ((bit_width + bit_offset) > *access_bit_width) {
 		pr_warning(FW_BUG APEI_PFX
-- 
2.7.4

