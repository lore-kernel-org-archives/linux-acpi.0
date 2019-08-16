Return-Path: <SRS0=xQYu=WM=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB8C3A5A1
	for <linux-acpi@archiver.kernel.org>; Fri, 16 Aug 2019 21:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5A521783
	for <linux-acpi@archiver.kernel.org>; Fri, 16 Aug 2019 21:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfHPV6h (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:58:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:56320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfHPV6h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381397"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:34 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Jung-uk Kim <jkim@free_BSD.org>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 8/9] ACPICA: Add "Windows 2019" string to _OSI support.
Date:   Fri, 16 Aug 2019 14:43:27 -0700
Message-Id: <20190816214328.3900-9-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jung-uk Kim <jkim@free_BSD.org>

ACPICA commit 32fffb242800b0202986e86d9b0e16f88a23de66

Link: https://github.com/acpica/acpica/commit/32fffb24
Signed-off-by: Jung-uk Kim <jkim@free_BSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/utosi.c | 1 +
 include/acpi/actypes.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index fc09d234fe62..ad2b218039d0 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -72,6 +72,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2017.2", NULL, 0, ACPI_OSI_WIN_10_RS3},	/* Windows 10 version 1709 - Added 02/2018 */
 	{"Windows 2018", NULL, 0, ACPI_OSI_WIN_10_RS4},	/* Windows 10 version 1803 - Added 11/2018 */
 	{"Windows 2018.2", NULL, 0, ACPI_OSI_WIN_10_RS5},	/* Windows 10 version 1809 - Added 11/2018 */
+	{"Windows 2019", NULL, 0, ACPI_OSI_WIN_10_19H1},	/* Windows 10 version 1903 - Added 08/2019 */
 
 	/* Feature Group Strings */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 10c10b9d18ae..2f3f28c7cea3 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1272,6 +1272,7 @@ typedef enum {
 #define ACPI_OSI_WIN_10_RS3             0x11
 #define ACPI_OSI_WIN_10_RS4             0x12
 #define ACPI_OSI_WIN_10_RS5             0x13
+#define ACPI_OSI_WIN_10_19H1            0x14
 
 /* Definitions of getopt */
 
-- 
2.17.2

