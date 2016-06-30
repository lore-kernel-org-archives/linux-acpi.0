From: Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 3/6] ACPICA: make use of new strtolower() function
Date: Thu, 30 Jun 2016 16:50:09 -0700
Message-ID: <1467330612-26242-4-git-send-email-mmayer@broadcom.com>
References: <1467330612-26242-1-git-send-email-mmayer@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467330612-26242-1-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Call strtolower() rather than walking the string explicitly to convert
it to lowercase.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

*** Please note that there don't seem to be any callers of acpi_ut_strlwr().
*** It may be possible to remove the function altogether.

 drivers/acpi/acpica/utnonansi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index 3465fe2..b6e11dc 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -64,19 +64,8 @@ ACPI_MODULE_NAME("utnonansi")
  ******************************************************************************/
 void acpi_ut_strlwr(char *src_string)
 {
-	char *string;
-
 	ACPI_FUNCTION_ENTRY();
-
-	if (!src_string) {
-		return;
-	}
-
-	/* Walk entire string, lowercasing the letters */
-
-	for (string = src_string; *string; string++) {
-		*string = (char)tolower((int)*string);
-	}
+	strtolower(src_string);
 }
 
 /*******************************************************************************
-- 
2.7.4
