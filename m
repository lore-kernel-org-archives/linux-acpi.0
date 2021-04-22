Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2250DC43460
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Apr 2021 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD7C613F6
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Apr 2021 19:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhDVTZY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 22 Apr 2021 15:25:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:21022 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238883AbhDVTZW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 15:25:22 -0400
IronPort-SDR: En2h8my3pAYLsDeGPCGl42H89CuHs6VZhv/3F6StvO9qYM8Jn4WRLifVxQA1wpk0A6zBVlBwKZ
 d4w4j5yzU/Fw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192770838"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="192770838"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 12:24:47 -0700
IronPort-SDR: gYoD/uaudeVdSFoPJm9CcOx7ZU9idAbVeODLfZU240XFB09nEwNjfT9rnRN9V8g1Is2vzgikbT
 SP8ruuixd0BA==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="464063702"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 12:24:46 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 2/3] ACPI/table: Print MADT Wake table information
Date:   Thu, 22 Apr 2021 12:24:40 -0700
Message-Id: <20210422192442.706906-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When MADT is parsed, print MADT Wake table information as
debug message. It will be useful to debug CPU boot issues
related to MADT wake table.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/tables.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 9d581045acff..206df4ad8b2b 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -207,6 +207,17 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
+		{
+			struct acpi_madt_multiproc_wakeup *p;
+
+			p = (struct acpi_madt_multiproc_wakeup *) header;
+
+			pr_debug("MP Wake (Mailbox version[%d] base_address[%llx])\n",
+				 p->mailbox_version, p->base_address);
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
-- 
2.25.1

