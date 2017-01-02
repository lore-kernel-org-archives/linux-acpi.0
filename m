From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v6 11/14] msi: platform: make platform_msi_create_device_domain() ACPI aware
Date: Mon,  2 Jan 2017 21:31:42 +0800
Message-ID: <1483363905-2806-12-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34894 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933135AbdABNeI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jan 2017 08:34:08 -0500
Received: by mail-pg0-f47.google.com with SMTP id i5so139269372pgh.2
        for <linux-acpi@vger.kernel.org>; Mon, 02 Jan 2017 05:34:02 -0800 (PST)
In-Reply-To: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, charles.garcia-tobin@arm.com, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>

With the platform msi domain created for ITS, irqchip such as
mbi-gen connecting ITS, which needs ctreate its own irqdomain.

Fortunately with the platform msi support upstreamed by Marc,
we just need to add minor code to make it run properly.

platform_msi_create_device_domain() is almost ready for ACPI use
except of_node_to_fwnode() is for dt only, make it ACPI aware then
things will work in both DTS and ACPI.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Majun <majun258@huawei.com>
Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
1.9.1

