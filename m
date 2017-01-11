From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v7 04/15] irqchip: gic-v3-its: keep the head file include in alphabetic order
Date: Wed, 11 Jan 2017 23:06:28 +0800
Message-ID: <1484147199-4267-5-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36250 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764405AbdAKPIL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2017 10:08:11 -0500
Received: by mail-pf0-f171.google.com with SMTP id 189so50726766pfu.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 07:08:11 -0800 (PST)
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Matthias Brugger <mbrugger@suse.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Hanjun Guo <hanjun.guo@linaro.org>

Rearrange header file includes to alphabetic order. As acpi_iort.h
includes acpi.h so remove the duplidate acpi.h inclusion as well.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 69b040f..f471939 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -15,14 +15,13 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
-#include <linux/acpi_iort.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
-- 
1.9.1

