From: akpm@linux-foundation.org
Subject: [patch 12/12] drivers/acpi/acpi_pad.c: squish warning
Date: Tue, 17 Nov 2009 14:27:38 -0800
Message-ID: <200911172227.nAHMRcq7023537@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43550 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756448AbZKQWgV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:36:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, shaohua.li@intel.com

From: Andrew Morton <akpm@linux-foundation.org>

drivers/acpi/acpi_pad.c: In function 'power_saving_thread':
drivers/acpi/acpi_pad.c:103: warning: 'preferred_cpu' may be used uninitialized in this function

Cc: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/acpi_pad.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/acpi_pad.c~drivers-acpi-acpi_padc-squish-warning drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~drivers-acpi-acpi_padc-squish-warning
+++ a/drivers/acpi/acpi_pad.c
@@ -100,7 +100,8 @@ static void round_robin_cpu(unsigned int
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
 	cpumask_var_t tmp;
 	int cpu;
-	unsigned long min_weight = -1, preferred_cpu;
+	unsigned long min_weight = -1;
+	unsigned long uninitialized_var(preferred_cpu);
 
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return;
_
