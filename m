From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V3 04/10] irqchip / GICv3: remove gic root node in ITS
Date: Tue, 19 Jan 2016 14:11:17 +0100
Message-ID: <1453209083-3358-5-git-send-email-tn@semihalf.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453209083-3358-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com
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
