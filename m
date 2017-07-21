From: Song liwei <liwei.song@windriver.com>
Subject: [PATCH] ACPI, APEI: Fixup incorrect 16-bit access width firmware bug
Date: Fri, 21 Jul 2017 05:41:20 -0400
Message-ID: <1500630080-18234-1-git-send-email-liwei.song@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:43354 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbdGUJl3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 05:41:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LiweiSong <liwei.song@windriver.com>

From: Liwei Song <liwei.song@windriver.com>

This is a follow up to commit f712c71f7b2b ("ACPI, APEI: Fixup common
access width firmware bug") fix the following firmware bug:

[Firmware Bug]: APEI: Invalid bit width + offset in GAR [0xb2/16/0/1/1]

This is due to an 8-bit access width is specified for a 16-bit register,
Do bit_width check just like what the original commit have done.

Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 drivers/acpi/apei/apei-base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index da370e1..7e47bc6 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -610,6 +610,9 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	else if (bit_width == 64 && bit_offset == 0 && (*paddr & 0x07) == 0 &&
 	    *access_bit_width < 64)
 		*access_bit_width = 64;
+	else if (bit_width == 16 && bit_offset == 0 && (*paddr & 0x01) == 0 &&
+	    *access_bit_width < 16)
+		*access_bit_width = 16;
 
 	if ((bit_width + bit_offset) > *access_bit_width) {
 		pr_warning(FW_BUG APEI_PFX
-- 
2.7.4

