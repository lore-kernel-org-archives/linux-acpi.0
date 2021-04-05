Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA386C4360C
	for <linux-acpi@archiver.kernel.org>; Mon,  5 Apr 2021 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC93613C6
	for <linux-acpi@archiver.kernel.org>; Mon,  5 Apr 2021 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhDEVuS (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 5 Apr 2021 17:50:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:38289 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242462AbhDEVuP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:15 -0400
IronPort-SDR: f+KJ4FmScCKMU0qqRjNzr2/caCqS7DPHO5auFAnGq6oy0GtVwCj5kT9N9q8ylkgGJmaWaVP/t3
 x/NOmY2CS0Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914978"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: cTAIomVkirOFU3SzSrcNYj13GfRq4ibuYv2fsdr471Nl85lQLCpHzhpGsBZpV5Zq0zeQiCo5Ce
 7LfLnl5gvbOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673639"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 22/22] ACPICA: Update version to 20210331
Date:   Mon,  5 Apr 2021 14:15:10 -0700
Message-Id: <20210405211510.484603-23-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit eb423b7d5440472d0d2115cb81b52b1b7c56d95a

Link: https://github.com/acpica/acpica/commit/eb423b7d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 370293ee8399..f8d44b06f3e3 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20210105
+#define ACPI_CA_VERSION                 0x20210331
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.29.2

