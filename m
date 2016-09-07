From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/14] ACPICA: Add a couple of casts to uthex.c
Date: Wed,  7 Sep 2016 14:06:10 +0800
Message-ID: <b5cff617f956839ca7ba3533ff76de93c3de99f3.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34577 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbcIGGGQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:06:16 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 2ba5d3fdaa24d66d67694cbae6ec66971a7a67c1

Required in some environments.

Link: https://github.com/acpica/acpica/commit/2ba5d3fd
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/uthex.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index 3a4ca95..36d2fc7 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -92,7 +92,8 @@ acpi_status acpi_ut_ascii_to_hex_byte(char *two_ascii_chars, u8 *return_byte)
 
 	/* Both ASCII characters must be valid hex digits */
 
-	if (!isxdigit(two_ascii_chars[0]) || !isxdigit(two_ascii_chars[1])) {
+	if (!isxdigit((int)two_ascii_chars[0]) ||
+	    !isxdigit((int)two_ascii_chars[1])) {
 		return (AE_BAD_HEX_CONSTANT);
 	}
 
-- 
1.7.10

