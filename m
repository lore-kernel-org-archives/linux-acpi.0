From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] ACPI / LPSS: enable hard LLP for DMA
Date: Thu, 17 Nov 2016 16:30:06 +0200
Message-ID: <20161117143006.130266-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50970 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753435AbcKQOae (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Nov 2016 09:30:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, mika.westerberg@linux.intel.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Right now the DMA support of hard LLP (*) is fused. Enable it via specific
message sent to SoC at run time.

(*) Hard LLP stands for the multi-block transfer feature of DMA controller
supported by hardware.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
In v2:
- massage commit message
- add Mika's tag
 drivers/acpi/acpi_lpss.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 373657f..8ea836c 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -718,13 +718,14 @@ static int acpi_lpss_resume_early(struct device *dev)
 #define LPSS_GPIODEF0_DMA1_D3		BIT(2)
 #define LPSS_GPIODEF0_DMA2_D3		BIT(3)
 #define LPSS_GPIODEF0_DMA_D3_MASK	GENMASK(3, 2)
+#define LPSS_GPIODEF0_DMA_LLP		BIT(13)
 
 static DEFINE_MUTEX(lpss_iosf_mutex);
 
 static void lpss_iosf_enter_d3_state(void)
 {
 	u32 value1 = 0;
-	u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK;
+	u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK | LPSS_GPIODEF0_DMA_LLP;
 	u32 value2 = LPSS_PMCSR_D3hot;
 	u32 mask2 = LPSS_PMCSR_Dx_MASK;
 	/*
@@ -768,8 +769,9 @@ static void lpss_iosf_enter_d3_state(void)
 
 static void lpss_iosf_exit_d3_state(void)
 {
-	u32 value1 = LPSS_GPIODEF0_DMA1_D3 | LPSS_GPIODEF0_DMA2_D3;
-	u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK;
+	u32 value1 = LPSS_GPIODEF0_DMA1_D3 | LPSS_GPIODEF0_DMA2_D3 |
+		     LPSS_GPIODEF0_DMA_LLP;
+	u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK | LPSS_GPIODEF0_DMA_LLP;
 	u32 value2 = LPSS_PMCSR_D0;
 	u32 mask2 = LPSS_PMCSR_Dx_MASK;
 
-- 
2.10.2

