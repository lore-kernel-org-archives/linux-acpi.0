From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH v7 06/15] arm64, numa: rework numa_add_memblk()
Date: Tue, 24 May 2016 15:35:36 -0700
Message-ID: <1464129345-18985-7-git-send-email-ddaney.cavm@gmail.com>
References: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Hanjun Guo <hanjun.guo@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: Robert Richter <rrichter@cavium.com>, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Rework numa_add_memblk() to update the parameter "u64 size" to "u64
end", this will make it consistent with x86 and simplifies the arm64
ACPI NUMA code to be added later.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/numa.c | 12 ++++++------
 drivers/of/of_numa.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 98dc104..6cb03f9 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -131,25 +131,25 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
  * numa_add_memblk - Set node id to memblk
  * @nid: NUMA node ID of the new memblk
  * @start: Start address of the new memblk
- * @size:  Size of the new memblk
+ * @end:  End address of the new memblk
  *
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int __init numa_add_memblk(int nid, u64 start, u64 size)
+int __init numa_add_memblk(int nid, u64 start, u64 end)
 {
 	int ret;
 
-	ret = memblock_set_node(start, size, &memblock.memory, nid);
+	ret = memblock_set_node(start, (end - start), &memblock.memory, nid);
 	if (ret < 0) {
 		pr_err("NUMA: memblock [0x%llx - 0x%llx] failed to add on node %d\n",
-			start, (start + size - 1), nid);
+			start, (end - 1), nid);
 		return ret;
 	}
 
 	node_set(nid, numa_nodes_parsed);
 	pr_info("NUMA: Adding memblock [0x%llx - 0x%llx] on node %d\n",
-			start, (start + size - 1), nid);
+			start, (end - 1), nid);
 	return ret;
 }
 
@@ -367,7 +367,7 @@ static int __init dummy_numa_init(void)
 	       0LLU, PFN_PHYS(max_pfn) - 1);
 
 	for_each_memblock(memory, mblk) {
-		ret = numa_add_memblk(0, mblk->base, mblk->size);
+		ret = numa_add_memblk(0, mblk->base, mblk->base + mblk->size);
 		if (!ret)
 			continue;
 
diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 0f2784b..ed5a097 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -91,8 +91,8 @@ static int __init of_numa_parse_memory_nodes(void)
 		pr_debug("NUMA:  base = %llx len = %llx, node = %u\n",
 			 rsrc.start, rsrc.end - rsrc.start + 1, nid);
 
-		r = numa_add_memblk(nid, rsrc.start,
-				    rsrc.end - rsrc.start + 1);
+
+		r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
 		if (r)
 			break;
 	}
-- 
1.7.11.7
