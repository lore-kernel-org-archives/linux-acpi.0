From: akpm@linux-foundation.org
Subject: [patch 1/2] acpi: fix unused function warning
Date: Tue, 20 Jul 2010 15:18:35 -0700
Message-ID: <201007202218.o6KMIZ6c020963@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47777 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758626Ab0GTWTK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:19:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, len.brown@intel.com, venki@google.com

From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>

CONFIG_ACPI_PROCFS=n:

drivers/acpi/processor_idle.c:83: warning: 'us_to_pm_timer_ticks' defined but not used.

Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Venkatesh Pallipadi <venki@google.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_idle.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN drivers/acpi/processor_idle.c~acpi-fix-unused-function-warning drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-fix-unused-function-warning
+++ a/drivers/acpi/processor_idle.c
@@ -80,10 +80,13 @@ module_param(nocst, uint, 0000);
 static unsigned int latency_factor __read_mostly = 2;
 module_param(latency_factor, uint, 0644);
 
+#ifdef CONFIG_ACPI_PROCFS
 static u64 us_to_pm_timer_ticks(s64 t)
 {
 	return div64_u64(t * PM_TIMER_FREQUENCY, 1000000);
 }
+#endif
+
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
_
