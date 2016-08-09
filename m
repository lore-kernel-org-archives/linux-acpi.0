From: Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC PATCH 09/10] irqchip: mbigen: introduce mbigen_of_create_domain()
Date: Tue, 9 Aug 2016 15:06:05 +0800
Message-ID: <1470726366-40809-10-git-send-email-guohanjun@huawei.com>
References: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Greg KH <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, agustinv@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, G Gregory <graeme.gregory@linaro.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Introduce mbigen_of_create_domain() to consolidate OF related
code and prepare for ACPI later.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-mbigen.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index c01ab41..9484ea0 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -236,27 +236,15 @@ static struct irq_domain_ops mbigen_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-static int mbigen_device_probe(struct platform_device *pdev)
+static int mbigen_of_create_domain(struct platform_device *pdev,
+				   struct mbigen_device *mgn_chip)
 {
-	struct mbigen_device *mgn_chip;
+	struct device *parent;
 	struct platform_device *child;
 	struct irq_domain *domain;
 	struct device_node *np;
-	struct device *parent;
-	struct resource *res;
 	u32 num_pins;
 
-	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
-	if (!mgn_chip)
-		return -ENOMEM;
-
-	mgn_chip->pdev = pdev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mgn_chip->base))
-		return PTR_ERR(mgn_chip->base);
-
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
@@ -280,6 +268,30 @@ static int mbigen_device_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
+	return 0;
+}
+
+static int mbigen_device_probe(struct platform_device *pdev)
+{
+	struct mbigen_device *mgn_chip;
+	struct resource *res;
+	int err;
+
+	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
+	if (!mgn_chip)
+		return -ENOMEM;
+
+	mgn_chip->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mgn_chip->base))
+		return PTR_ERR(mgn_chip->base);
+
+	err = mbigen_of_create_domain(pdev, mgn_chip);
+	if (err)
+		return err;
+
 	platform_set_drvdata(pdev, mgn_chip);
 	return 0;
 }
-- 
1.7.12.4
