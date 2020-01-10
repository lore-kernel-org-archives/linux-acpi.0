Return-Path: <SRS0=bwoO=27=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C303C33CA3
	for <linux-acpi@archiver.kernel.org>; Fri, 10 Jan 2020 19:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167C2206DA
	for <linux-acpi@archiver.kernel.org>; Fri, 10 Jan 2020 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgAJTw2 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:52:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:12666 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgAJTw2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Jan 2020 14:52:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218165274"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2020 11:52:28 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 2/2] ACPICA: Update version to 20200110
Date:   Fri, 10 Jan 2020 11:31:50 -0800
Message-Id: <20200110193150.4196-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200110193150.4196-1-erik.kaneda@intel.com>
References: <20200110193150.4196-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f78d50aacc2a1c6dfa59052a696a54cec16e6aab

Version 20200110.

Link: https://github.com/acpica/acpica/commit/f78d50aa
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index ca07b1371daf..00994b1b8681 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20191213
+#define ACPI_CA_VERSION                 0x20200110
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.21.0

