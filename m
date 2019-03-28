From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] ACPI/IORT: Reject platform dev creation when dev set to
 wrong numa node
Date: Thu, 28 Mar 2019 22:00:22 +0800
Message-ID: <20190328140022.85790-1-wangkefeng.wang@huawei.com>
References: <20190328113230.GA19628@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190328113230.GA19628@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

If there is only node 0 in system, but smmuv3 device is set to offline
node 1, parsed from proximity domain in SMMUv3 IORT table, it will lead
to following crash,

[   47.492451] Unable to handle kernel paging request at virtual address 0000000000001388
[   47.500361] Mem abort info:
[   47.503143]   ESR = 0x96000004
[   47.506189]   Exception class = DABT (current EL), IL = 32 bits
[   47.512099]   SET = 0, FnV = 0
[   47.515140]   EA = 0, S1PTW = 0
[   47.518272] Data abort info:
[   47.521144]   ISV = 0, ISS = 0x00000004
[   47.524970]   CM = 0, WnR = 0
[   47.527929] [0000000000001388] user address but active_mm is swapper
[   47.534285] Internal error: Oops: 96000004 [#1] SMP
[   47.539151] Modules linked in:
[   47.542194] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.0.0 #15
[   47.549490] pstate: 80c00009 (Nzcv daif +PAN +UAO)
[   47.554272] pc : __alloc_pages_nodemask+0x13c/0x1068
[   47.559224] lr : __alloc_pages_nodemask+0xdc/0x1068
...
[   47.646873] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[   47.653560] Call trace:
[   47.655994]  __alloc_pages_nodemask+0x13c/0x1068
[   47.660600]  new_slab+0xec/0x570
[   47.663816]  ___slab_alloc+0x3e0/0x4f8
[   47.667553]  __slab_alloc+0x60/0x80
[   47.671029]  __kmalloc_node_track_caller+0x10c/0x478
[   47.675984]  devm_kmalloc+0x44/0xb0
[   47.679460]  pinctrl_bind_pins+0x4c/0x188
[   47.683457]  really_probe+0x78/0x2b8
[   47.687019]  driver_probe_device+0x64/0x110
[   47.691189]  device_driver_attach+0x74/0x98
[   47.695360]  __driver_attach+0x9c/0xe8
[   47.699095]  bus_for_each_dev+0x84/0xd8
[   47.702919]  driver_attach+0x30/0x40
[   47.706481]  bus_add_driver+0x170/0x218
[   47.710304]  driver_register+0x64/0x118
[   47.714128]  __platform_driver_register+0x54/0x60
[   47.718820]  arm_smmu_driver_init+0x24/0x2c
[   47.722991]  do_one_initcall+0xbc/0x328
[   47.726816]  kernel_init_freeable+0x304/0x3ac
[   47.731162]  kernel_init+0x18/0x110
[   47.734638]  ret_from_fork+0x10/0x1c
[   47.738202] Code: f90013b5 b9410fa1 1a9f0694 b50014c2 (b9400804)
[   47.744307] ---[ end trace dfeaed4c373a32da ]--

This could be triggered by firmware bug with bad IORT configuration,
or a NUMA node has no memory attaching to it, also with NR_CPUS less
than CPUs presented in MADT.

Make dev_set_proximity() with a return value, terminating device creation
if it return failure.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/arm64/iort.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e48894e002ba..c294c3490e66 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1232,21 +1232,30 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
 /*
  * set numa proximity domain for smmuv3 device
  */
-static void  __init arm_smmu_v3_set_proximity(struct device *dev,
+static int  __init arm_smmu_v3_set_proximity(struct device *dev,
 					      struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu_v3 *smmu;
 
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
-		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
+		int node = acpi_map_pxm_to_node(smmu->pxm);
+		if (node != NUMA_NO_NODE && !node_online(node))
+			return -EINVAL;
+
+		set_dev_node(dev, node);
 		pr_info("SMMU-v3[%llx] Mapped to Proximity domain %d\n",
 			smmu->base_address,
 			smmu->pxm);
 	}
+	return 0;
 }
 #else
-#define arm_smmu_v3_set_proximity NULL
+static int  __init arm_smmu_v3_set_proximity(struct device *dev,
+					      struct acpi_iort_node *node)
+{
+	return 0;
+}
 #endif
 
 static int __init arm_smmu_count_resources(struct acpi_iort_node *node)
@@ -1318,7 +1327,7 @@ struct iort_dev_config {
 	int (*dev_count_resources)(struct acpi_iort_node *node);
 	void (*dev_init_resources)(struct resource *res,
 				     struct acpi_iort_node *node);
-	void (*dev_set_proximity)(struct device *dev,
+	int (*dev_set_proximity)(struct device *dev,
 				    struct acpi_iort_node *node);
 };
 
@@ -1369,8 +1378,11 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	if (!pdev)
 		return -ENOMEM;
 
-	if (ops->dev_set_proximity)
-		ops->dev_set_proximity(&pdev->dev, node);
+	if (ops->dev_set_proximity) {
+		ret = ops->dev_set_proximity(&pdev->dev, node);
+		if (ret)
+			goto dev_put;
+	}
 
 	count = ops->dev_count_resources(node);
 
-- 
2.20.1
