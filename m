From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/12] Revert "ACPI: EC: Use proper handle for boot EC"
Date: Tue, 11 Mar 2008 02:51:47 -0400
Message-ID: <4af8e10a6c57e7292862bd1703712f0565c7e429.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:33378 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754341AbYCKGyz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:55 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit 208c70a45624400fafd7511b96bc426bf01f8f5e.

http://bugzilla.kernel.org/show_bug.cgi?id=10100

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index caf873c..7222a18 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -943,11 +943,7 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->command_addr = ecdt_ptr->control.address;
 		boot_ec->data_addr = ecdt_ptr->data.address;
 		boot_ec->gpe = ecdt_ptr->gpe;
-		if (ACPI_FAILURE(acpi_get_handle(NULL, ecdt_ptr->id,
-				&boot_ec->handle))) {
-			pr_info("Failed to locate handle for boot EC\n");
-			boot_ec->handle = ACPI_ROOT_OBJECT;
-		}
+		boot_ec->handle = ACPI_ROOT_OBJECT;
 	} else {
 		/* This workaround is needed only on some broken machines,
 		 * which require early EC, but fail to provide ECDT */
-- 
1.5.4.3.422.g34cd6

