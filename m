Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76309ECAAD1
	for <linux-acpi@archiver.kernel.org>; Tue, 30 Aug 2022 13:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiH3N4N (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiH3Nz2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2022 09:55:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839E760FE;
        Tue, 30 Aug 2022 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661867724; x=1693403724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8ucy6GgoRbrs0dCrNuA2Jw8XuIgfl/kZE/4ajDL4eiQ=;
  b=Fu5YCTYGrlUliZ4owWy+yXcJ27vX22lB4OlD161wFmp8l5Qy3dCwFAI5
   aq5UCNnm1fG3XAU5hf4tt4T81Ta7MXF9WU82uht+kG3pbxiixBhLJeQpj
   b24lbt+kA/IbCdGz83D1Mc3AWHhC65vpC0EJTeVTMMly9TPcY7tX9gPZc
   wtne+ZkytcZhKtqknLdxpw9dpX/3fWU4Fnl5OGYNH6ZCY0qBL1mwNBgCu
   ZNcKHQ1Wb62oMivm06twhL9eeFM+lMeqfrcM04/i6X+LhI1Bno4K3bGyF
   B30wKEsSFryyUHBL2ei71MDUICRgsh+jymkJBxQ5gx5R2XPv/cKJvVgS0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296455637"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296455637"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="857108290"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2022 06:55:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37A8D174; Tue, 30 Aug 2022 16:55:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI: PMIC: Use sizeof() instead of hard coded value
Date:   Tue, 30 Aug 2022 16:55:31 +0300
Message-Id: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's better to use sizeof() of a given buffer than spreading
a hard coded value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 418eec523025..6c2a6da430ed 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -87,7 +87,7 @@ static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
 	u8 buf[2];
 
-	if (regmap_bulk_read(regmap, reg, buf, 2))
+	if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
 		return -EIO;
 
 	/* stored in big-endian */
-- 
2.35.1

