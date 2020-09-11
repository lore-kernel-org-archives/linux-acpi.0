Return-Path: <SRS0=wKv0=CU=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D107C43461
	for <linux-acpi@archiver.kernel.org>; Fri, 11 Sep 2020 16:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C854E22205
	for <linux-acpi@archiver.kernel.org>; Fri, 11 Sep 2020 16:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKQry (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:47:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:21153 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgIKQq7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Sep 2020 12:46:59 -0400
IronPort-SDR: j9r6YH91uOm3SFdoceoh2Ue4QbkiXlB7H8tU+1LKZc0S3LhrfgsGS8XRICEYZFARpARE45f9qI
 JZ0VyYlcl4Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="156196584"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="156196584"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 09:46:55 -0700
IronPort-SDR: 4wSeQLkkdDbSzaNuCwepoc0645ob78KV1mhFpACZBf/GfMoPmB+xvGcrz9G6aZh5ZQQXqT9Rya
 /oGGCatcpQ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="506330729"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 11 Sep 2020 09:46:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8F35B15C; Fri, 11 Sep 2020 19:46:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINTAINERS: Use my kernel.org address for Intel PMIC work
Date:   Fri, 11 Sep 2020 19:46:13 +0300
Message-Id: <20200911164613.4928-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use my kernel.org address for Intel PMIC work. While here,
upgrade status to maintainer of PMIC MFD devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 26af84f97353..f0be706caba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -405,7 +405,7 @@ F:	drivers/platform/x86/i2c-multi-instantiate.c
 ACPI PMIC DRIVERS
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Len Brown <lenb@kernel.org>
-R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+R:	Andy Shevchenko <andy@kernel.org>
 R:	Mika Westerberg <mika.westerberg@linux.intel.com>
 L:	linux-acpi@vger.kernel.org
 S:	Supported
@@ -9000,7 +9000,7 @@ F:	drivers/gpio/gpio-*cove.c
 F:	drivers/gpio/gpio-msic.c
 
 INTEL PMIC MULTIFUNCTION DEVICE DRIVERS
-R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+M:	Andy Shevchenko <andy@kernel.org>
 S:	Maintained
 F:	drivers/mfd/intel_msic.c
 F:	drivers/mfd/intel_soc_pmic*
-- 
2.28.0

