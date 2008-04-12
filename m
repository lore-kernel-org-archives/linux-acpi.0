From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/73] ACPICA: Fixed a couple memory leaks associated with "implicit return" objects when the AML Interpreter slack mode is enabled
Date: Sat, 12 Apr 2008 00:25:29 -0400
Message-ID: <eebfce1bc757911d1d03a687356ce43e03078253.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:60403 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753146AbYDLE2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:08 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Lin Ming BZ 349

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    3 +++
 drivers/acpi/dispatcher/dsmthdat.c |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 7a99740..9e24641 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -103,6 +103,9 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 						    NULL);
 		acpi_ex_enter_interpreter();
 	}
+
+	acpi_ds_clear_implicit_return(walk_state);
+
 #ifdef ACPI_DISASSEMBLER
 	if (ACPI_FAILURE(status)) {
 
diff --git a/drivers/acpi/dispatcher/dsmthdat.c b/drivers/acpi/dispatcher/dsmthdat.c
index ba4626e..38510d1 100644
--- a/drivers/acpi/dispatcher/dsmthdat.c
+++ b/drivers/acpi/dispatcher/dsmthdat.c
@@ -172,6 +172,8 @@ void acpi_ds_method_data_delete_all(struct acpi_walk_state *walk_state)
 		}
 	}
 
+	acpi_ds_clear_implicit_return(walk_state);
+
 	return_VOID;
 }
 
-- 
1.5.5.29.g7134

