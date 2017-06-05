From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/53] ACPICA: Add new notify value for HEST table
Date: Mon,  5 Jun 2017 16:38:20 +0800
Message-ID: <8317602bfdadeb2edbd4fada395415cc768e25a0.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20596 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbdFEIiX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:38:23 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 35e06462f3186e1e6e9cb4fe97dfb43d4b3718a2

"Software Delegated Exception" - ACPI 6.2

Link: https://github.com/acpica/acpica/commit/35e06462
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 070f322..87a12e1 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -514,7 +514,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEA = 8,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
-	ACPI_HEST_NOTIFY_RESERVED = 11	/* 11 and greater are reserved */
+	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
+	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.7.4

