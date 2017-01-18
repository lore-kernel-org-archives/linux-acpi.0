From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v8 12/15] msi: platform: make platform_msi_create_device_domain() ACPI aware
Date: Wed, 18 Jan 2017 20:55:02 +0800
Message-ID: <1484744105-53140-13-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:2977 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754168AbdARNB6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2017 08:01:58 -0500
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Matthias Brugger <mbrugger@suse.com>, Wei Xu <xuwei5@hisilicon.com>, Ming Lei <tom.leiming@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

The irqdomain creation is carried out in:

platform_msi_create_device_domain()

relies on the fwnode_handle interrupt controller token to associate the
interrupt controller with a specific irqdomain. Current code relies on
the OF layer to retrieve a fwnode_handle for the device representing the
interrupt controller from its device->of_node pointer.  This makes
platform_msi_create_device_domain() DT specific whilst it really is not
because after the merge of commit f94277af03ea ("of/platform: Initialise
dev->fwnode appropriately") the fwnode_handle can easily be retrieved
from the dev->fwnode pointer in a firmware agnostic way.

Update platform_msi_create_device_domain() to retrieve the interrupt
controller fwnode_handle from the dev->fwnode pointer so that it can
be used seamlessly in ACPI and DT systems.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg KH <gregkh@linuxfoundation.org>
---
 drivers/base/platform-msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index be6a599..035ca3b 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -345,8 +345,7 @@ struct irq_domain *
 
 	data->host_data = host_data;
 	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
-					     of_node_to_fwnode(dev->of_node),
-					     ops, data);
+					     dev->fwnode, ops, data);
 	if (!domain)
 		goto free_priv;
 
-- 
1.7.12.4

