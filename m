From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v5 2/5] irqdomain: introduce is_fwnode_irqchip helper
Date: Tue, 8 Dec 2015 17:48:03 -0800
Message-ID: <1449625686-5594-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2on0093.outbound.protection.outlook.com ([207.46.100.93]:36016
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752594AbbLIBs2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2015 20:48:28 -0500
In-Reply-To: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Since there will be several places checking if fwnode.type
is equal FWNODE_IRQCHIP, this patch adds a convenient function
for this purpose.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic.c | 2 +-
 include/linux/irqdomain.h | 5 +++++
 kernel/irq/irqdomain.c    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index abf2ffa..fcd327f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -972,7 +972,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		return 0;
 	}
 
-	if (fwspec->fwnode->type == FWNODE_IRQCHIP) {
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
 		if(fwspec->param_count != 2)
 			return -EINVAL;
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a06feda..d72fabc 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -211,6 +211,11 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 	return node ? &node->fwnode : NULL;
 }
 
+static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
+{
+	return fwnode && fwnode->type == FWNODE_IRQCHIP;
+}
+
 static inline struct irq_domain *irq_find_matching_host(struct device_node *node,
 							enum irq_domain_bus_token bus_token)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 22aa961..7f34d98 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -70,7 +70,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 {
 	struct irqchip_fwid *fwid;
 
-	if (WARN_ON(fwnode->type != FWNODE_IRQCHIP))
+	if (WARN_ON(!is_fwnode_irqchip(fwnode)))
 		return;
 
 	fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
-- 
2.1.0

