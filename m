From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [RFC PATCH] ACPICA: sprintf should use ACPI_SIZE_MAX
Date: Tue,  3 Jan 2017 18:29:58 -0500
Message-ID: <20170103232958.14506-1-vivien.didelot@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com, linux-acpi@vger.kernel.org, Vivien Didelot <vivien.didelot@savoirfairelinux.com>
List-Id: linux-acpi@vger.kernel.org

sprintf() should use the architecture independent ACPI_SIZE_MAX value
instead of the ACPI_UINT32_MAX 32-bit variant. Change this.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/acpi/acpica/utprint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 40eba804d49c..5001043351e8 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -627,7 +627,7 @@ int sprintf(char *string, const char *format, ...)
 	int length;
 
 	va_start(args, format);
-	length = vsnprintf(string, ACPI_UINT32_MAX, format, args);
+	length = vsnprintf(string, ACPI_SIZE_MAX, format, args);
 	va_end(args);
 
 	return (length);
-- 
2.11.0
