From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 2/2]cpuidle: makes AMD C1E works in suspend/resume path
Date: Tue, 19 May 2009 16:09:54 +0800
Message-ID: <20090519080954.GB12117@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18638 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbZESIJy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 May 2009 04:09:54 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: mingo@redhat.com, thisistempbox@yahoo.com, lenb@kernel.org

When AMD C1E is enabled, local APIC timer will stop even in C1. To avoid
suspend/resume hang, this patch removes C1 and replace it with a cpu_relax() in
suspend/resume path. This hasn't any impact in runtime path.

http://bugzilla.kernel.org/show_bug.cgi?id=13233

[ impact: avoid suspend/resume hang in AMD CPU with C1E enabled ]

Tested-by: Dmitry Lyzhyn <thisistempbox@yahoo.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/processor_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/acpi/processor_idle.c
===================================================================
--- linux.orig/drivers/acpi/processor_idle.c	2009-05-19 09:56:59.000000000 +0800
+++ linux/drivers/acpi/processor_idle.c	2009-05-19 10:01:23.000000000 +0800
@@ -834,8 +834,8 @@ static int acpi_idle_enter_c1(struct cpu
 
 	/* Do not access any ACPI IO ports in suspend path */
 	if (acpi_idle_suspend) {
-		acpi_safe_halt();
 		local_irq_enable();
+		cpu_relax();
 		return 0;
 	}
 
