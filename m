From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/26] ACPI: EC: Use proper handle for boot EC
Date: Thu, 21 Feb 2008 04:25:13 -0500
Message-ID: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36609 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754344AbYBUJ3B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:01 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Fall back to ACPI_ROOT_HANDLE only in case of error.

ACPI: EC: EC description table is found, configuring boot EC
ACPI Error (evregion-0316): No handler for Region [ECOR] (ffff81007a651620) [EmbeddedControl] [20070126]
ACPI Error (exfldio-0289): Region EmbeddedControl(3) has no handler [20070126]

http://bugzilla.kernel.org/show_bug.cgi?id=9916

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7222a18..caf873c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -943,7 +943,11 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->command_addr = ecdt_ptr->control.address;
 		boot_ec->data_addr = ecdt_ptr->data.address;
 		boot_ec->gpe = ecdt_ptr->gpe;
-		boot_ec->handle = ACPI_ROOT_OBJECT;
+		if (ACPI_FAILURE(acpi_get_handle(NULL, ecdt_ptr->id,
+				&boot_ec->handle))) {
+			pr_info("Failed to locate handle for boot EC\n");
+			boot_ec->handle = ACPI_ROOT_OBJECT;
+		}
 	} else {
 		/* This workaround is needed only on some broken machines,
 		 * which require early EC, but fail to provide ECDT */
-- 
1.5.4.2

