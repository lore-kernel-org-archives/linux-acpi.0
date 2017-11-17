From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 06/15] ACPICA: Trivial fix to spelling mistake in comment
Date: Fri, 17 Nov 2017 15:42:21 -0800
Message-ID: <20171117234230.913-7-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759953AbdKQXqi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:38 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Colin Ian King <colin.king@canonical.com>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit 62c3ff46de977456155fdedbd9f294f2ff700520

Fix spelling mistake, "Reseved" -> "Reserved"

Link: https://github.com/acpica/acpica/commit/62c3ff46
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actbl1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index ea0c71ece407..5ef905626c6d 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1163,7 +1163,7 @@ struct acpi_nfit_system_address {
 	struct acpi_nfit_header header;
 	u16 range_index;
 	u16 flags;
-	u32 reserved;		/* Reseved, must be zero */
+	u32 reserved;		/* Reserved, must be zero */
 	u32 proximity_domain;
 	u8 range_guid[16];
 	u64 address;
-- 
2.13.6

