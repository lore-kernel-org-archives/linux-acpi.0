From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/73] ACPICA: Fix for memory leak related to DdbHandle objects
Date: Sat, 12 Apr 2008 00:25:08 -0400
Message-ID: <e690f3f1f8126632a1008d61ab360bbd6727c54e.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:47253 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752795AbYDLE2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:04 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a memory leak where DdbHandle objects were not deleted
automatically at control method exit.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 8cc410c..a0f34b4 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -366,6 +366,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 		/* table_ptr was deallocated above */
 
+		acpi_ut_remove_reference(ddb_handle);
 		return_ACPI_STATUS(status);
 	}
 
-- 
1.5.5.29.g7134

