From: Al Stone <al.stone@linaro.org>
Subject: [PATCH 4/4] ACPI: for bad_madt_entry(), the GIC ITS table is 20 bytes long, not 16
Date: Wed, 14 Oct 2015 15:26:25 -0600
Message-ID: <1444857985-28844-5-git-send-email-al.stone@linaro.org>
References: <1444857985-28844-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35333 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093AbbJNV0n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 17:26:43 -0400
Received: by iofl186 with SMTP id l186so70219766iof.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2015 14:26:43 -0700 (PDT)
In-Reply-To: <1444857985-28844-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Al Stone <al.stone@linaro.org>

Correct a typo where bad_madt_entry() expected the MADT GIC ITS subtable
to be 16 bytes long, but it is actually 20 bytes.  This is a cut'n'paste
error picked up from the spec and inadvertently replicated in code.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/tables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 790d4b0..1b7c13e 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -292,7 +292,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
  * GICD                  0xc                         24    24    24
  * GICv2m MSI            0xd                               24    24
  * GICR                  0xe                               16    16
- * GIC ITS               0xf                                     16
+ * GIC ITS               0xf                                     20
  *
  * In the table, each length entry is what should be in the length
  * field of the subtable, and -- in general -- it should match the
@@ -366,7 +366,7 @@ static struct acpi_madt_subtable_lengths spec_info[] = {
 		.madt_version = 3,
 		.num_types = 16,
 		.lengths = { 8, 12, 10, 8, 6, 12, 16, SUBTABLE_VARIABLE,
-			     16, 16, 12, 80, 24, 24, 16, 16 }
+			     16, 16, 12, 80, 24, 24, 16, 20 }
 	},
 	{ /* terminator */
 		.major_version = 0,
-- 
2.4.3

