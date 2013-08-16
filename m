From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 4/6] acpi cleanup: Use pr_err() instead of printk() in arch/x86/mm/srat.c
Date: Fri, 16 Aug 2013 15:06:47 +0800
Message-ID: <1376636809-10159-5-git-send-email-tangchen@cn.fujitsu.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Use pr_err() instead of printk() in arch/x86/mm/srat.c

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 arch/x86/mm/srat.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 6286e89..32b9597 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -33,7 +33,7 @@ static __init int setup_node(int pxm)
 
 static __init void bad_srat(void)
 {
-	printk(KERN_ERR "SRAT: SRAT not used.\n");
+	pr_err("SRAT: SRAT not used.\n");
 	acpi_numa = -1;
 }
 
@@ -77,7 +77,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 	node = setup_node(pxm);
 	if (node < 0) {
-		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
+		pr_err("SRAT: Too many proximity domains %x\n", pxm);
 		bad_srat();
 		return;
 	}
@@ -113,7 +113,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 		pxm |= *((unsigned int*)pa->proximity_domain_hi) << 8;
 	node = setup_node(pxm);
 	if (node < 0) {
-		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
+		pr_err("SRAT: Too many proximity domains %x\n", pxm);
 		bad_srat();
 		return;
 	}
@@ -160,7 +160,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 
 	node = setup_node(pxm);
 	if (node < 0) {
-		printk(KERN_ERR "SRAT: Too many proximity domains.\n");
+		pr_err("SRAT: Too many proximity domains.\n");
 		goto out_err_bad_srat;
 	}
 
-- 
1.7.1
