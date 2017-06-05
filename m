From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/53] ACPICA: Update Status field for BGRT table
Date: Mon,  5 Jun 2017 16:37:43 +0800
Message-ID: <be4a479c5a49a24624156547addbddfff9c701bc.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2848 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdFEIhs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:37:48 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit dbc6a3d5ff22df730cc81802af0422bb64b19347

Orientation flags added. ACPI 6.2

Link: https://github.com/acpica/acpica/commit/dbc6a3d5
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 94414b2..dc6de4e 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -116,6 +116,11 @@ struct acpi_table_bgrt {
 	u32 image_offset_y;
 };
 
+/* Flags for Status field above */
+
+#define ACPI_BGRT_DISPLAYED                 (1)
+#define ACPI_BGRT_ORIENTATION_OFFSET        (3 << 1)
+
 /*******************************************************************************
  *
  * DRTM - Dynamic Root of Trust for Measurement table
-- 
2.7.4

