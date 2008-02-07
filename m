From: Len Brown <lenb@kernel.org>
Subject: [PATCH 069/112] ACPI: throttling: fix build warning
Date: Thu,  7 Feb 2008 04:34:31 -0500
Message-ID: <3391a76f2bbb74e42b9ba44c05a7366ffd388753.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754897AbYBGJg2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:28 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 86c790e..1b8e592 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -987,7 +987,7 @@ static int acpi_processor_set_throttling_ptc(struct acpi_processor *pr,
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 {
 	cpumask_t saved_mask;
-	int ret;
+	int ret = 0;
 	unsigned int i;
 	struct acpi_processor *match_pr;
 	struct acpi_processor_throttling *p_throttling;
-- 
1.5.4.23.gef5b9

