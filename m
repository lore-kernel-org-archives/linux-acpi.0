From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH RESEND] mailbox: pcc: Drop uninformative output during boot
Date: Tue,  1 Aug 2017 13:43:57 +0100
Message-ID: <20170801124357.18344-1-punit.agrawal@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbdHAMoR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Aug 2017 08:44:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-acpi@vger.kernel.org, Alexey Klimov <alexey.klimov@arm.com>, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Jassi Brar <jassisinghbrar@gmail.com>

When booting on an ACPI enabled system that does not provide the
Platform Communications Channel Table (PCCT), the pcc mailbox driver
prints -

[    0.484261] PCCT header not found.

during probe before returning -ENODEV.

This message clutters the bootlog and doesn't provide any useful
information. Drop this message.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Alexey Klimov <alexey.klimov@arm.com>
---

Hi Rafael,

Re-sending the patch with linux-acpi on cc and tags applied as
requested. If there are no objections please consider merging.

Thanks,
Punit

 drivers/mailbox/pcc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ac91fd0d62c6..3d83cdc11ab5 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -457,10 +457,8 @@ static int __init acpi_pcc_probe(void)
 	/* Search for PCCT */
 	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
 
-	if (ACPI_FAILURE(status) || !pcct_tbl) {
-		pr_warn("PCCT header not found.\n");
+	if (ACPI_FAILURE(status) || !pcct_tbl)
 		return -ENODEV;
-	}
 
 	count = acpi_table_parse_entries(ACPI_SIG_PCCT,
 			sizeof(struct acpi_table_pcct),
-- 
2.11.0

