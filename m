From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V1 05/10] irqchip, gicv3,
 its: Mark its_init() and its children as __init
Date: Thu, 15 Oct 2015 16:05:14 +0200
Message-ID: <1444917919-21152-6-git-send-email-tn@semihalf.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444917919-21152-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com
Cc: Suravee.Suthikulpanit@amd.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, ddaney.cavm@gmail.com, Tomasz Nowicki <tn@semihalf.com>, linux-arm-kernel@lists.infradead.org
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
index 9640e4d..7a1a682 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -666,7 +666,7 @@ static int its_chunk_to_lpi(int chunk)
 	return (chunk << IRQS_PER_CHUNK_SHIFT) + 8192;
 }
 
-static int its_lpi_init(u32 id_bits)
+static int __init its_lpi_init(u32 id_bits)
 {
 	lpi_chunks = its_lpi_to_chunk(1UL << id_bits);
 
@@ -1373,7 +1373,8 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
-static int its_probe(struct device_node *node, struct irq_domain *parent)
+static int __init its_probe(struct device_node *node,
+			    struct irq_domain *parent)
 {
 	struct resource res;
 	struct its_node *its;
@@ -1532,7 +1533,7 @@ static struct of_device_id its_device_id[] = {
 	{},
 };
 
-int its_init(struct device_node *node, struct rdists *rdists,
+int __init its_init(struct device_node *node, struct rdists *rdists,
 	     struct irq_domain *parent_domain)
 {
 	struct device_node *np;
-- 
1.9.1
