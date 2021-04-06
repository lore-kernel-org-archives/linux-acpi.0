Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB861C433B4
	for <linux-acpi@archiver.kernel.org>; Tue,  6 Apr 2021 22:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F359613D0
	for <linux-acpi@archiver.kernel.org>; Tue,  6 Apr 2021 22:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbhDFWFa (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:05:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:54929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243376AbhDFWFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:19 -0400
IronPort-SDR: t07Knq2Ea2uEru1pNvMPc2snBEvt7zehNRVTU0gHY7p91NAp3KfKRMxRNKoBpWBIgBKn4pap6R
 NoleasLSr6EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640462"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640462"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: EXPgGZsGQsWg2d7AyzAZKPCNziJLdHoo3aCTpacHyL+xzMshJWjDKrMCOXMHx0gk0ksnkcisqA
 zA/Jykx8D/7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581733"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 08/22] ACPICA: Tree-wide: fix various typos and spelling mistakes
Date:   Tue,  6 Apr 2021 14:30:14 -0700
Message-Id: <20210406213028.718796-9-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

This commit squashes the following:
ACPICA commit bc8939e2d902653e71bb1601b129a993c37fcfad
ACPICA commit 2d9e5e98e23f2a569e5691e6bed183146e25798d
ACPICA commit 937358156631ea7a0eef3569c213c82a031097d5

Fix more spelling issues found using the codespell checker and found
without tools.

Link: https://github.com/acpica/acpica/commit/bc8939e2
Link: https://github.com/acpica/acpica/commit/2d9e5e98
Link: https://github.com/acpica/acpica/commit/93735815

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acoutput.h           | 2 +-
 include/acpi/platform/acgcc.h     | 2 +-
 tools/power/acpi/common/cmfsize.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 1538a6853822..1b4c45815695 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -362,7 +362,7 @@
  *
  * A less-safe version of the macros is provided for optional use if the
  * compiler uses excessive CPU stack (for example, this may happen in the
- * debug case if code optimzation is disabled.)
+ * debug case if code optimization is disabled.)
  */
 
 /* Exit trace helper macro */
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 0cd4f61d4248..f6656be81760 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -61,7 +61,7 @@ typedef __builtin_va_list va_list;
 #endif
 
 /*
- * Explictly mark intentional explicit fallthrough to silence
+ * Explicitly mark intentional explicit fallthrough to silence
  * -Wimplicit-fallthrough in GCC 7.1+.
  */
 
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index 9ea2c0aeb86c..185b8c588e1d 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
 /******************************************************************************
  *
- * Module Name: cfsize - Common get file size function
+ * Module Name: cmfsize - Common get file size function
  *
  * Copyright (C) 2000 - 2021, Intel Corp.
  *
-- 
2.29.2

