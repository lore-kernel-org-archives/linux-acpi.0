From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] ACPI/CPC: Don't try to clean up uninitialized CPC data
Date: Fri, 16 Dec 2016 13:35:46 -0500
Message-ID: <1481913346-16321-1-git-send-email-boris.ostrovsky@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:17803 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758175AbcLPSky (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Dec 2016 13:40:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>

If acpi_cppc_processor_probe() had not executed successfully (for
example, if _CPC object was not found) then cpc_desc_ptr for that
processor will be invalid.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/acpi/cppc_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d0d0504..5bba26e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -824,6 +824,8 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	void __iomem *addr;
 
 	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
+	if (!cpc_ptr)
+		return;
 
 	/* Free all the mapped sys mem areas for this CPU */
 	for (i = 2; i < cpc_ptr->num_entries; i++) {
-- 
1.8.3.1

