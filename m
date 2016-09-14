From: Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC PATCH v2 11/11] irqchip: mbigen: promote mbigen init
Date: Wed, 14 Sep 2016 22:21:19 +0800
Message-ID: <1473862879-7769-12-git-send-email-guohanjun@huawei.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

mbigen is an irqchip and it needs to be probed before
devices, same logic is used for SMMU and etc., let's
use arch_initcall instead of platform init for mbigen.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ma Jun <majun258@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-mbigen.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index ca6add1..3a33de6 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -374,7 +374,11 @@ static struct platform_driver mbigen_platform_driver = {
 	.probe			= mbigen_device_probe,
 };
 
-module_platform_driver(mbigen_platform_driver);
+static __init int mbigen_init(void)
+{
+	return platform_driver_register(&mbigen_platform_driver);
+}
+arch_initcall(mbigen_init);
 
 MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
 MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
-- 
1.7.12.4
