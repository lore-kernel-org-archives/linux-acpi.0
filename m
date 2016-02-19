From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/15] ACPICA: iASL: Fix some typos with the name strtoul64
Date: Fri, 19 Feb 2016 14:16:20 +0800
Message-ID: <633622ce780e0db222322e6881f2c8f2add75a83.1455857580.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e9622aa824e00997dc92e8638733b7553a4dba26

Was defined as stroul64 in some places.

Link: https://github.com/acpica/acpica/commit/e9622aa8
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utnonansi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index c427a5c..d1f4a47 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -171,7 +171,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 	u8 sign_of0x = 0;
 	u8 term = 0;
 
-	ACPI_FUNCTION_TRACE_STR(ut_stroul64, string);
+	ACPI_FUNCTION_TRACE_STR(ut_strtoul64, string);
 
 	switch (base) {
 	case ACPI_ANY_BASE:
-- 
1.7.10
