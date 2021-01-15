Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF9AC433DB
	for <linux-acpi@archiver.kernel.org>; Fri, 15 Jan 2021 19:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA22123A5E
	for <linux-acpi@archiver.kernel.org>; Fri, 15 Jan 2021 19:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbhAOTVv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:21:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:59259 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbhAOTVv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 14:21:51 -0500
IronPort-SDR: yfWoAVDSyglEU9xHVHSj+FvZ6hj+zrnhYdSyPcBhgZckBEQqJZE00ODyYff1VeCbDZ9odtLzGO
 OolcHdDvu6/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="240139535"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="240139535"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:20:55 -0800
IronPort-SDR: jPCKECkXy5P3tVGH6q7V8BvhH89bWtLaBtWLUY2gZv9Qi/7NOXUP5ZhWi5QlcV5eWdN+KuGZex
 IvVbdlSrGiog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="425417893"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2021 11:20:55 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 4/9] ACPICA: add type casts for string functions
Date:   Fri, 15 Jan 2021 10:48:21 -0800
Message-Id: <20210115184826.2250-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115184826.2250-1-erik.kaneda@intel.com>
References: <20210115184826.2250-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Detected by gcc 10.2.0

ACPICA commit 608559800e1ad48b819744aeb1866d94335e2655

Link: https://github.com/acpica/acpica/commit/60855980
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/dbinput.c    | 4 ++--
 drivers/acpi/acpica/utstrsuppt.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 2952856b8a67..b8a48923064f 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -473,7 +473,7 @@ char *acpi_db_get_next_token(char *string,
 
 	/* Remove any spaces at the beginning, ignore blank lines */
 
-	while (*string && isspace(*string)) {
+	while (*string && isspace((int)*string)) {
 		string++;
 	}
 
@@ -571,7 +571,7 @@ char *acpi_db_get_next_token(char *string,
 
 		/* Find end of token */
 
-		while (*string && !isspace(*string)) {
+		while (*string && !isspace((int)*string)) {
 			string++;
 		}
 		break;
diff --git a/drivers/acpi/acpica/utstrsuppt.c b/drivers/acpi/acpica/utstrsuppt.c
index 2d91003fcf26..199982a6fb16 100644
--- a/drivers/acpi/acpica/utstrsuppt.c
+++ b/drivers/acpi/acpica/utstrsuppt.c
@@ -104,7 +104,7 @@ acpi_status acpi_ut_convert_decimal_string(char *string, u64 *return_value_ptr)
 		 * 1) Runtime: terminate with no error, per the ACPI spec
 		 * 2) Compiler: return an error
 		 */
-		if (!isdigit(*string)) {
+		if (!isdigit((int)*string)) {
 #ifdef ACPI_ASL_COMPILER
 			status = AE_BAD_DECIMAL_CONSTANT;
 #endif
@@ -158,7 +158,7 @@ acpi_status acpi_ut_convert_hex_string(char *string, u64 *return_value_ptr)
 		 * 1) Runtime: terminate with no error, per the ACPI spec
 		 * 2) Compiler: return an error
 		 */
-		if (!isxdigit(*string)) {
+		if (!isxdigit((int)*string)) {
 #ifdef ACPI_ASL_COMPILER
 			status = AE_BAD_HEX_CONSTANT;
 #endif
-- 
2.29.2

