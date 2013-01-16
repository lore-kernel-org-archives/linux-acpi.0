From: Lans Zhang <jia.zhang@windriver.com>
Subject: [PATCH] ACPI, APEI: Fixup incorrect 64-bit access width firmware bug
Date: Wed, 16 Jan 2013 17:03:29 +0800
Message-ID: <1358327009-14625-1-git-send-email-jia.zhang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58715 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185Ab3APJD2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jan 2013 04:03:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

The bit width check was introduced by 15afae60 (ACPI, APEI: Fix
incorrect APEI register bit width check and usage), and a fixup
for incorrect 32-bit width memory address was given by f712c71
(ACPI, APEI: Fixup common access width firmware bug). Now there
is a similar symptom:

[Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x12345000/64/0/3/0]

Another bogus BIOS reports an incorrect 64-bit width in trigger table.
Thus, apply to a similar workaround for 64-bit width memory address.

Signed-off-by: Lans Zhang <jia.zhang@windriver.com>
---
 drivers/acpi/apei/apei-base.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 00a7836..46f80e2 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -590,6 +590,9 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	if (bit_width == 32 && bit_offset == 0 && (*paddr & 0x03) == 0 &&
 	    *access_bit_width < 32)
 		*access_bit_width = 32;
+	else if (bit_width == 64 && bit_offset == 0 && (*paddr & 0x07) == 0 &&
+	    *access_bit_width < 64)
+		*access_bit_width = 64;
 
 	if ((bit_width + bit_offset) > *access_bit_width) {
 		pr_warning(FW_BUG APEI_PFX
-- 
1.7.8.110.g4cb5d

