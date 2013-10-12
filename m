From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Subject: [PATCH part2 v2 5/8] acpi, numa, mem_hotplug: Mark hotpluggable memory
 in memblock
Date: Sat, 12 Oct 2013 14:07:20 +0800
Message-ID: <5258E718.3060601@cn.fujitsu.com>
References: <5258E560.5050506@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:2754 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab3JLGIe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Oct 2013 02:08:34 -0400
In-Reply-To: <5258E560.5050506@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>, Rik van Riel <riel@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Chen Tang <imtangchen@gmail.com>, Tang Chen <tangchen@cn.fujitsu.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

From: Tang Chen <tangchen@cn.fujitsu.com>

When parsing SRAT, we know that which memory area is hotpluggable.
So we invoke function memblock_mark_hotplug() introduced by previous
patch to mark hotpluggable memory in memblock.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 arch/x86/mm/numa.c |    2 ++
 arch/x86/mm/srat.c |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index ab69e1d..408c02d 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -569,6 +569,8 @@ static int __init numa_init(int (*init_func)(void))
 	memset(&numa_meminfo, 0, sizeof(numa_meminfo));
 	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
 				  MAX_NUMNODES));
+	/* In case that parsing SRAT failed. */
+	WARN_ON(memblock_clear_hotplug(0, ULLONG_MAX));
 	numa_reset_distance();
 
 	ret = init_func();
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 266ca91..ca7c484 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -181,6 +181,11 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 		(unsigned long long) start, (unsigned long long) end - 1,
 		hotpluggable ? " hotplug" : "");
 
+	/* Mark hotplug range in memblock. */
+	if (hotpluggable && memblock_mark_hotplug(start, ma->length))
+		pr_warn("SRAT: Failed to mark hotplug range [mem %#010Lx-%#010Lx] in memblock\n",
+			(unsigned long long) start, (unsigned long long) end - 1);
+
 	return 0;
 out_err_bad_srat:
 	bad_srat();
-- 
1.7.1
