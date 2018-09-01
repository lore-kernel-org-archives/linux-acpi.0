From: William Lieurance <william.lieurance@namikoda.com>
Subject: [PATCH] ACPI / LPSS: Ensure LPIOEP is always set on resume
Date: Sat,  1 Sep 2018 12:59:15 -0500
Message-ID: <20180901175916.28567-1-william.lieurance@namikoda.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: william.lieurance@namikoda.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

For some number of systems with lpss_quirks enabled, on boot the system
goes through an acpi_lpss_resume() without a corresponding
acpi_lpss_suspend() having been called.  In that case, it requires the
IOSF write to LPSS_IOSF_UNIT_LPIOEP / LPSS_IOSF_GPIODEF0 in order to
continue booting successfully.

Signed-off-by: William Lieurance <william.lieurance@namikoda.com>
---
 drivers/acpi/acpi_lpss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 9706613eecf9..c7790ba943d4 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -939,14 +939,14 @@ static void lpss_iosf_exit_d3_state(void)
 
 	mutex_lock(&lpss_iosf_mutex);
 
+	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
+			LPSS_IOSF_GPIODEF0, value1, mask1);
+
 	if (!lpss_iosf_d3_entered)
 		goto exit;
 
 	lpss_iosf_d3_entered = false;
 
-	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
-			LPSS_IOSF_GPIODEF0, value1, mask1);
-
 	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
 			LPSS_IOSF_PMCSR, value2, mask2);
 
-- 
2.17.1
