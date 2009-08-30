From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: Don't use Notebook as MSI vendor substitute
Date: Sun, 30 Aug 2009 20:30:23 +0400
Message-ID: <20090830163022.27730.14328.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:43950 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753858AbZH3QaW (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sun, 30 Aug 2009 12:30:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

"Notebook" name is not unique to MSI, thus should be not be used
to identify MSI hardware.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 839b542..bd35442 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -942,7 +942,7 @@ int __init acpi_ec_ecdt_probe(void)
 	 * Generate a boot ec context
 	 */
 	if (dmi_name_in_vendors("Micro-Star") ||
-	    dmi_name_in_vendors("Notebook")) {
+	    dmi_name_in_vendors("MICRO-STAR")) {
 		pr_info(PREFIX "Enabling special treatment for EC from MSI.\n");
 		EC_FLAGS_MSI = 1;
 	}

