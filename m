From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V2 04/10] irqchip / GICv3: remove gic root node in ITS
Date: Thu, 17 Dec 2015 12:52:07 +0100
Message-ID: <1450353133-15992-5-git-send-email-tn@semihalf.com>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450353133-15992-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, ddaney.cavm@gmail.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

The gic_root_node defined in ITS driver is not actually
used, and the ITS driver seems will not use it in the
future, so just remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e23d1d1..7ca7f9a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -97,7 +97,6 @@ struct its_device {
 
 static LIST_HEAD(its_nodes);
 static DEFINE_SPINLOCK(its_lock);
-static struct device_node *gic_root_node;
 static struct rdists *gic_rdists;
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
@@ -1602,8 +1601,6 @@ int its_init(struct device_node *node, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	gic_root_node = node;
-
 	its_alloc_lpi_tables();
 	its_lpi_init(rdists->id_bits);
 
-- 
1.9.1
