Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD816C10F13
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56B221841
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfDHUws (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:52:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:41642 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfDHUws (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 16:52:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="141104050"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2019 13:52:47 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 5/8] ACPICA: utilities: fix spelling of PCC to platform_comm_channel
Date:   Mon,  8 Apr 2019 13:42:27 -0700
Message-Id: <20190408204230.4335-6-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190408204230.4335-1-erik.schmauss@intel.com>
References: <20190408204230.4335-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 5e5c349e73982aea5d9f74416c0b2eea1b0767a1

Link: https://github.com/acpica/acpica/commit/5e5c349e
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utdecode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 76e054c83c39..65beaa237669 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -78,7 +78,7 @@ const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
 	"IPMI",			/* 0x07 */
 	"GeneralPurposeIo",	/* 0x08 */
 	"GenericSerialBus",	/* 0x09 */
-	"PCC"			/* 0x0A */
+	"PlatformCommChannel"	/* 0x0A */
 };
 
 const char *acpi_ut_get_region_name(u8 space_id)
-- 
2.17.2

