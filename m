From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/73] ACPICA: Updated error message for dynamic method serialization
Date: Sat, 12 Apr 2008 00:24:59 -0400
Message-ID: <25788ee6352469ade3cd9ce233be73db96efcf80.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:49384 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752267AbYDLE2F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:05 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added more information to make the message clearer.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psparse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index ce3139a..1442e55 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -532,7 +532,7 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			if ((status == AE_ALREADY_EXISTS) &&
 			    (!walk_state->method_desc->method.mutex)) {
 				ACPI_INFO((AE_INFO,
-					   "Marking method %4.4s as Serialized",
+					   "Marking method %4.4s as Serialized because of AE_ALREADY_EXISTS error",
 					   walk_state->method_node->name.
 					   ascii));
 
-- 
1.5.5.29.g7134

