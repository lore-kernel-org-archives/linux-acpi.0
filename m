From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 36/53] ACPICA: Remove extraneous status check
Date: Mon,  5 Jun 2017 16:40:45 +0800
Message-ID: <4b3d21192fe1d32e4292d2ec8c65a8a63c9e51ef.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9299 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbdFEIkr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:47 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a83f7212df71d4276d0057fa31bfdc9809660560

Removed an unnecessary status check after call to
ns_build_normalized_path.

Link: https://bugs.acpica.org/show_bug.cgi?id=1378
Link: https://github.com/acpica/acpica/commit/a83f7212
Reported-by: Colin King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsnames.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 3db9ca2..aa16aea 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -190,9 +190,6 @@ acpi_ns_handle_to_pathname(acpi_handle target_handle,
 
 	(void)acpi_ns_build_normalized_path(node, buffer->pointer,
 					    required_size, no_trailing);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%s [%X]\n",
 			  (char *)buffer->pointer, (u32) required_size));
-- 
2.7.4

