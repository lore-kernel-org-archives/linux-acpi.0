From: Bob Paauwe <bob.j.paauwe@intel.com>
Subject: [PATCH 1/2] Remove extra release mutex call.
Date: Fri,  3 Apr 2015 09:07:48 -0700
Message-ID: <1428077269-12764-2-git-send-email-bob.j.paauwe@intel.com>
References: <1428077269-12764-1-git-send-email-bob.j.paauwe@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5396 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbbDCQGC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Apr 2015 12:06:02 -0400
In-Reply-To: <1428077269-12764-1-git-send-email-bob.j.paauwe@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Bob Paauwe <bob.j.paauwe@intel.com>

Remove the release mutex call when a table is re-loaded. This seems to
be here to release a mutex that was aquired at one time in table verify
function.  That aquire is no longer present, so remove the release.

Signed-off-by: Bob Paauwe <bob.j.paauwe@intel.com>
---
 drivers/acpi/acpica/tbinstal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 9bad45e..7fbc2b9 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -346,7 +346,6 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 				 */
 				acpi_tb_uninstall_table(&new_table_desc);
 				*table_index = i;
-				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 				return_ACPI_STATUS(AE_OK);
 			}
 		}
-- 
2.1.0

