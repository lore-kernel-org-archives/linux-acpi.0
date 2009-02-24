From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/2] ACPI: fix broken usage of name.ascii
Date: Tue, 24 Feb 2009 11:48:17 -0300
Message-ID: <1235486898-27756-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43180 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756392AbZBXOsX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Feb 2009 09:48:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: stable@kernel.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lin Ming <ming.m.lin@intel.com>

acpi_namespace_node's name.ascii field is four chars, and not NULL-
terminated except by pure luck.  So, it cannot be used by sscanf() without
a length restriction.

This issue was fixed indirectly in mainline by commit
0175d562a29ad052c510782c7e76bc63d5155b9b.

This is the minimal fix for both stable 2.6.27 and 2.6.28.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: stable@kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/ec.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 30f3ef2..4aa9477 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -759,9 +759,10 @@ acpi_ec_register_query_methods(acpi_handle handle, u32 level,
 	struct acpi_namespace_node *node = handle;
 	struct acpi_ec *ec = context;
 	int value = 0;
-	if (sscanf(node->name.ascii, "_Q%x", &value) == 1) {
+
+	if (sscanf(node->name.ascii, "_Q%2x", &value) == 1)
 		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
-	}
+
 	return AE_OK;
 }
 
-- 
1.5.6.5

