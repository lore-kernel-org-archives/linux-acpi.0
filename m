Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1296AC43214
	for <linux-acpi@archiver.kernel.org>; Thu, 12 Aug 2021 17:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BE0610A3
	for <linux-acpi@archiver.kernel.org>; Thu, 12 Aug 2021 17:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhHLRBK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:01:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:36933 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhHLRBJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 13:01:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="195670090"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="195670090"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 10:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="503934251"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2021 10:00:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D23E9F; Thu, 12 Aug 2021 20:00:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 2/4] clk: fractional-divider: Hide clk_fractional_divider_ops from wide audience
Date:   Thu, 12 Aug 2021 20:00:23 +0300
Message-Id: <20210812170025.67074-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
References: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The providers are all located in drivers/clk/ and hence no need
to export the clock operations to wider audience. Hide them by
moving to drivers/clk/clk-fractional-divider.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: rebased on top of latest CLK codebase, fixed compilation error

 drivers/clk/clk-fractional-divider.h | 2 ++
 drivers/clk/imx/clk-composite-7ulp.c | 1 +
 include/linux/clk-provider.h         | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fractional-divider.h b/drivers/clk/clk-fractional-divider.h
index 4fa359a12ef4..aaaef90b2777 100644
--- a/drivers/clk/clk-fractional-divider.h
+++ b/drivers/clk/clk-fractional-divider.h
@@ -2,6 +2,8 @@
 
 struct clk_hw;
 
+extern const struct clk_ops clk_fractional_divider_ops;
+
 void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 						  unsigned long rate,
 						  unsigned long *parent_rate,
diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index 7c4f31b31eb0..d85ba78abbb1 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include "../clk-fractional-divider.h"
 #include "clk.h"
 
 #define PCG_PCS_SHIFT	24
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7be81d5fcf8c..d8609aef2394 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1023,7 +1023,6 @@ struct clk_fractional_divider {
 #define CLK_FRAC_DIVIDER_ZERO_BASED	BIT(0)
 #define CLK_FRAC_DIVIDER_BIG_ENDIAN	BIT(1)
 
-extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
-- 
2.30.2

