From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/8] ACPI: cpufreq: Print _PPC changes via cpufreq debug layer
Date: Fri,  8 Feb 2008 01:29:18 -0500
Message-ID: <919158d17b42683a5c7368e1e77661c65a20a48a.1202452053.git.len.brown@intel.com>
References: <1202452164-32320-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:1240 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933444AbYBHG3h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 01:29:37 -0500
In-Reply-To: <1202452164-32320-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
References: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

enabled with CPU_FREQ_DEBUG

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_perflib.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index f32010b..b477a4b 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -50,6 +50,10 @@ ACPI_MODULE_NAME("processor_perflib");
 
 static DEFINE_MUTEX(performance_mutex);
 
+/* Use cpufreq debug layer for _PPC changes. */
+#define cpufreq_printk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, \
+						"cpufreq-core", msg)
+
 /*
  * _PPC support is implemented as a CPUfreq policy notifier:
  * This means each time a CPUfreq driver registered also with
@@ -131,6 +135,9 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 		return -ENODEV;
 	}
 
+	cpufreq_printk("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
+		       (int)ppc, ppc ? "" : "not");
+
 	pr->performance_platform_limit = (int)ppc;
 
 	return 0;
-- 
1.5.4.34.g053d9

