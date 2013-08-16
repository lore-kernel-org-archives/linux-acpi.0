From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 4/6] acpi cleanup: Use pr_err() instead of printk() in arch/x86/mm/srat.c
Date: Fri, 16 Aug 2013 18:11:23 +0800
Message-ID: <1376647883-17379-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1376637949.1947.3.camel@joe-AO722>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:20414 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab3HPKMo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Aug 2013 06:12:44 -0400
In-Reply-To: <1376637949.1947.3.camel@joe-AO722>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, joe@perches.com, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Use pr_err() instead of printk() in arch/x86/mm/srat.c

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/x86/mm/srat.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 591f4bb..d1e3b95 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -35,7 +35,7 @@ static __init int setup_node(int pxm)
 
 static __init void bad_srat(void)
 {
-	printk(KERN_ERR "SRAT: SRAT not used.\n");
+	pr_err("SRAT not used.\n");
 	acpi_numa = -1;
 }
 
@@ -79,7 +79,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 	node = setup_node(pxm);
 	if (node < 0) {
-		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
+		pr_err("Too many proximity domains %x\n", pxm);
 		bad_srat();
 		return;
 	}
@@ -115,7 +115,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 		pxm |= *((unsigned int*)pa->proximity_domain_hi) << 8;
 	node = setup_node(pxm);
 	if (node < 0) {
-		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
+		pr_err("Too many proximity domains %x\n", pxm);
 		bad_srat();
 		return;
 	}
@@ -162,7 +162,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 
 	node = setup_node(pxm);
 	if (node < 0) {
-		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
+		pr_err("Too many proximity domains.\n");
 		goto out_err_bad_srat;
 	}
 
-- 
1.7.1

