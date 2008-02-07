From: Len Brown <lenb@kernel.org>
Subject: [PATCH 017/112] ACPI: add "processor.ignore_ppc" hook to workaround BIOS _PPC weirdness
Date: Thu,  7 Feb 2008 04:33:39 -0500
Message-ID: <623b78c39c4525731f852072edd742cc4fba6786.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757496AbYBGJfk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:40 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

There have been fixes using _PPC, which seem to unhide a problem
on HP nx6125 (double cpufreq switch freezes the machine for
several seconds).

This one should provide a workaround for the nx6125 and for
possible other machines that show any weird _PPC behaviour.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_perflib.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 463b024..f32010b 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -60,6 +60,11 @@ static DEFINE_MUTEX(performance_mutex);
  * policy is adjusted accordingly.
  */
 
+static unsigned int ignore_ppc = 0;
+module_param(ignore_ppc, uint, 0644);
+MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
+		 "limited by BIOS, this should help");
+
 #define PPC_REGISTERED   1
 #define PPC_IN_USE       2
 
@@ -72,6 +77,9 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
 	struct acpi_processor *pr;
 	unsigned int ppc = 0;
 
+	if (ignore_ppc)
+		return 0;
+
 	mutex_lock(&performance_mutex);
 
 	if (event != CPUFREQ_INCOMPATIBLE)
@@ -130,7 +138,13 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 {
-	int ret = acpi_processor_get_platform_limit(pr);
+	int ret;
+
+	if (ignore_ppc)
+		return 0;
+
+	ret = acpi_processor_get_platform_limit(pr);
+
 	if (ret < 0)
 		return (ret);
 	else
-- 
1.5.4.23.gef5b9

