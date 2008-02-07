From: Len Brown <lenb@kernel.org>
Subject: [PATCH 065/112] ACPI : Check parameter when calling acpi_processor_get/set_throttling
Date: Thu,  7 Feb 2008 04:34:27 -0500
Message-ID: <87654273ef63213f90c4243913987436495824f0.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757679AbYBGJgX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:23 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

It is necessary to check the parameter when calling the function of
acpi_processor_get/set_throttling function so as to avoid the NULL
pointer reference in pr or throttling.

http://bugzilla.kernel.org/show_bug.cgi?id=9747

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 1685b40..5d2eae2 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -589,6 +589,11 @@ static int acpi_processor_get_throttling(struct acpi_processor *pr)
 	cpumask_t saved_mask;
 	int ret;
 
+	if (!pr)
+		return -EINVAL;
+
+	if (!pr->flags.throttling)
+		return -ENODEV;
 	/*
 	 * Migrate task to the cpu pointed by pr.
 	 */
@@ -743,6 +748,16 @@ int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 {
 	cpumask_t saved_mask;
 	int ret;
+
+	if (!pr)
+		return -EINVAL;
+
+	if (!pr->flags.throttling)
+		return -ENODEV;
+
+	if ((state < 0) || (state > (pr->throttling.state_count - 1)))
+		return -EINVAL;
+
 	/*
 	 * Migrate task to the cpu pointed by pr.
 	 */
-- 
1.5.4.23.gef5b9

