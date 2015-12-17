From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V2 05/10] irqchip, gicv3, its: Mark its_init() and its children as __init
Date: Thu, 17 Dec 2015 12:52:08 +0100
Message-ID: <1450353133-15992-6-git-send-email-tn@semihalf.com>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450353133-15992-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com, Tomasz Nowicki <tn@semihalf.com>
List-Id: linux-acpi@vger.kernel.org

gicv3_init_bases() is the only caller for its_init(),
also it is a __init function, so mark its_init() as __init too,
then recursively mark the functions called as __init.

This will help to introduce ITS initialization using ACPI tables as
we will use acpi_table_parse_entries family functions there which
belong to __init section as well.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7ca7f9a..2bbed18 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -669,7 +669,7 @@ static int its_chunk_to_lpi(int chunk)
 	return (chunk << IRQS_PER_CHUNK_SHIFT) + 8192;
 }
 
-static int its_lpi_init(u32 id_bits)
+static int __init its_lpi_init(u32 id_bits)
 {
 	lpi_chunks = its_lpi_to_chunk(1UL << id_bits);
 
@@ -1424,7 +1424,8 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
-static int its_probe(struct device_node *node, struct irq_domain *parent)
+static int __init its_probe(struct device_node *node,
+			    struct irq_domain *parent)
 {
 	struct resource res;
 	struct its_node *its;
@@ -1585,7 +1586,7 @@ static struct of_device_id its_device_id[] = {
 	{},
 };
 
-int its_init(struct device_node *node, struct rdists *rdists,
+int __init its_init(struct device_node *node, struct rdists *rdists,
 	     struct irq_domain *parent_domain)
 {
 	struct device_node *np;
-- 
1.9.1
