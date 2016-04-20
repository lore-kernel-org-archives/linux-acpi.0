From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] ACPI / amba: Remove CLK_IS_ROOT
Date: Tue, 19 Apr 2016 18:28:38 -0700
Message-ID: <1461115718-31151-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32969 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbcDTB2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2016 21:28:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/acpi/acpi_amba.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index 2a61b54ab968..7f77c071709a 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -35,8 +35,7 @@ static void amba_register_dummy_clk(void)
 	if (amba_dummy_clk)
 		return;
 
-	amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL,
-						CLK_IS_ROOT, 0);
+	amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 0);
 	clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

