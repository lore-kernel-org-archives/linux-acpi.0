Return-Path: <SRS0=XdkV=YS=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B711CA9EBC
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Oct 2019 21:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2778721D7F
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Oct 2019 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJYVy4 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:54:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:27336 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfJYVyx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 17:54:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 14:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="201936053"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 14:54:51 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 09/12] ACPICA: debugger: add field unit support for acpi_db_get_next_token
Date:   Fri, 25 Oct 2019 14:36:57 -0700
Message-Id: <20191025213700.14685-10-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025213700.14685-1-erik.schmauss@intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit d509afa88e9415f13a3283c38ce9ee034634ae24

Since field unit data output from the debugger are now surrounded by
braces '{', support has been added to acpi_db_get_next_token to recognize
strings beginning with this character as a ACPI_TYPE_FIELD_UNIT.

Link: https://github.com/acpica/acpica/commit/d509afa8
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbinput.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 44d6d7246e6e..e1632b340182 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -511,6 +511,21 @@ char *acpi_db_get_next_token(char *string,
 		}
 		break;
 
+	case '{':
+
+		/* This is the start of a field unit, scan until closing brace */
+
+		string++;
+		start = string;
+		type = ACPI_TYPE_FIELD_UNIT;
+
+		/* Find end of buffer */
+
+		while (*string && (*string != '}')) {
+			string++;
+		}
+		break;
+
 	case '[':
 
 		/* This is the start of a package, scan until closing bracket */
-- 
2.21.0

