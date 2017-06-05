From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/53] ACPICA: Add new notify value for memory attributes update
Date: Mon,  5 Jun 2017 16:37:23 +0800
Message-ID: <2429d0239f58477fb340b80a1fd58abc7973f7a6.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47997 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdFEIh0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:37:26 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d37e878292bc9c7835b74e90d1c4c79e96ce6652

For ACPI 6.2

Link: https://github.com/acpica/acpica/commit/d37e8782
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utdecode.c | 4 +++-
 include/acpi/actypes.h         | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 6086830..8f2f00d 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -462,7 +462,9 @@ static const char *acpi_gbl_generic_notify[ACPI_GENERIC_NOTIFY_MAX + 1] = {
 	/* 0B */ "System Locality Update",
 					/* 0C */ "Shutdown Request",
 					/* Reserved in ACPI 6.0 */
-	/* 0D */ "System Resource Affinity Update"
+	/* 0D */ "System Resource Affinity Update",
+								/* 0E */ "Heterogeneous Memory Attributes Update"
+								/* ACPI 6.2 */
 };
 
 static const char *acpi_gbl_device_notify[5] = {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d549e31..7aa186d 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -629,8 +629,9 @@ typedef u64 acpi_integer;
 #define ACPI_NOTIFY_LOCALITY_UPDATE     (u8) 0x0B
 #define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
 #define ACPI_NOTIFY_AFFINITY_UPDATE     (u8) 0x0D
+#define ACPI_NOTIFY_MEMORY_UPDATE       (u8) 0x0E
 
-#define ACPI_GENERIC_NOTIFY_MAX         0x0D
+#define ACPI_GENERIC_NOTIFY_MAX         0x0E
 #define ACPI_SPECIFIC_NOTIFY_MAX        0x84
 
 /*
-- 
2.7.4

