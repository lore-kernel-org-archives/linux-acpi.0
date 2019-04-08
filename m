From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] ACPI/IORT: Reject platform device creation on NUMA node
 mapping failure
Date: Mon, 8 Apr 2019 23:21:12 +0800
Message-ID: <20190408152112.42056-1-wangkefeng.wang@huawei.com>
References: <20190408104658.GB2727@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190408104658.GB2727@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

In a system where, through IORT firmware mappings, the SMMU device is
mapped to a NUMA node that is not online, the kernel bootstrap results
in the following crash:

  Unable to handle kernel paging request at virtual address 0000000000001388
  Mem abort info:
    ESR = 0x96000004
    Exception class = DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
  Data abort info:
    ISV = 0, ISS = 0x00000004
    CM = 0, WnR = 0
  [0000000000001388] user address but active_mm is swapper
  Internal error: Oops: 96000004 [#1] SMP
  Modules linked in:
  CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.0.0 #15
  pstate: 80c00009 (Nzcv daif +PAN +UAO)
  pc : __alloc_pages_nodemask+0x13c/0x1068
  lr : __alloc_pages_nodemask+0xdc/0x1068
  ...
  Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
  Call trace:
   __alloc_pages_nodemask+0x13c/0x1068
   new_slab+0xec/0x570
   ___slab_alloc+0x3e0/0x4f8
   __slab_alloc+0x60/0x80
   __kmalloc_node_track_caller+0x10c/0x478
   devm_kmalloc+0x44/0xb0
   pinctrl_bind_pins+0x4c/0x188
   really_probe+0x78/0x2b8
   driver_probe_device+0x64/0x110
   device_driver_attach+0x74/0x98
   __driver_attach+0x9c/0xe8
   bus_for_each_dev+0x84/0xd8
   driver_attach+0x30/0x40
   bus_add_driver+0x170/0x218
   driver_register+0x64/0x118
   __platform_driver_register+0x54/0x60
   arm_smmu_driver_init+0x24/0x2c
   do_one_initcall+0xbc/0x328
   kernel_init_freeable+0x304/0x3ac
   kernel_init+0x18/0x110
   ret_from_fork+0x10/0x1c
  Code: f90013b5 b9410fa1 1a9f0694 b50014c2 (b9400804)
  ---[ end trace dfeaed4c373a32da ]--

Change the dev_set_proximity() hook prototype so that it returns a
value and make it return failure if the PXM->NUMA-node mapping
corresponds to an offline node, fixing the crash.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Link: https://lore.kernel.org/linux-arm-kernel/20190315021940.86905-1-wangkefeng.wang@huawei.com/
---
v2->v3:
-Update changelog according to Lorenzo Pieralisi's comment and add acked-by.

 drivers/acpi/arm64/iort.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e48894e002ba..a46c2c162c03 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1232,18 +1232,24 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
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
+
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
 #define arm_smmu_v3_set_proximity NULL
@@ -1318,7 +1324,7 @@ struct iort_dev_config {
 	int (*dev_count_resources)(struct acpi_iort_node *node);
 	void (*dev_init_resources)(struct resource *res,
 				     struct acpi_iort_node *node);
-	void (*dev_set_proximity)(struct device *dev,
+	int (*dev_set_proximity)(struct device *dev,
 				    struct acpi_iort_node *node);
 };
 
@@ -1369,8 +1375,11 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
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
