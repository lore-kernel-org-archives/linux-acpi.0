Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE05C432BE
	for <linux-acpi@archiver.kernel.org>; Thu, 26 Aug 2021 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D72F60F44
	for <linux-acpi@archiver.kernel.org>; Thu, 26 Aug 2021 15:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbhHZPEU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:04:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:43599 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231793AbhHZPEL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Aug 2021 11:04:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="217796075"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="217796075"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 08:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="465151649"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2021 08:03:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B23C1D1; Thu, 26 Aug 2021 18:03:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [resend, PATCH v2 1/1] x86/platform: Increase maximum GPIO number for X86_64
Date:   Thu, 26 Aug 2021 18:03:17 +0300
Message-Id: <20210826150317.29435-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By default the 512 GPIOs is the maximum on any x86 platform.
With, for example, Intel Tiger Lake-H the SoC based controller
occupies up to 480 pins. This leaves only 32 available for
GPIO expanders or other drivers, like PMIC. Hence, bump the
maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2 resend: actually added Rafael and linux-acpi@ to Cc list
v2: dropped confusing comment and help, simplified defaults (Rafael)
    added Rb tag (Linus)
 arch/x86/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 858ce2736bd6..25960fe242bd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -338,6 +338,11 @@ config NEED_PER_CPU_PAGE_FIRST_CHUNK
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 
+config ARCH_NR_GPIO
+	int
+	default 1024 if X86_64
+	default 512
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
-- 
2.32.0

