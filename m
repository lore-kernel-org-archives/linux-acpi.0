From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/53] ACPICA: Utilities: Make a notify value reserved
Date: Mon,  5 Jun 2017 16:45:22 +0800
Message-ID: <2b6b194d6bd786b37e4684a99064e5cf7024ac69.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751404AbdFEIpZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:45:25 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 54eb9be35414847da7e2903c8d410fa806b44fb5

0x0C (Graceful shutdown) is now reverted to reserved.
0x81 takes the place of this value.

Link: https://github.com/acpica/acpica/commit/54eb9be3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utdecode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 8f2f00d..02cd2c2 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -460,8 +460,8 @@ static const char *acpi_gbl_generic_notify[ACPI_GENERIC_NOTIFY_MAX + 1] = {
 	/* 09 */ "Device PLD Check",
 	/* 0A */ "Reserved",
 	/* 0B */ "System Locality Update",
-					/* 0C */ "Shutdown Request",
-					/* Reserved in ACPI 6.0 */
+								/* 0C */ "Reserved (was previously Shutdown Request)",
+								/* Reserved in ACPI 6.0 */
 	/* 0D */ "System Resource Affinity Update",
 								/* 0E */ "Heterogeneous Memory Attributes Update"
 								/* ACPI 6.2 */
-- 
2.7.4

