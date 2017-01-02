From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v6 08/14] ACPI: ARM64: IORT: rework iort_node_get_id()
Date: Mon,  2 Jan 2017 21:31:39 +0800
Message-ID: <1483363905-2806-9-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36213 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933059AbdABNdk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jan 2017 08:33:40 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so73235868pfz.3
        for <linux-acpi@vger.kernel.org>; Mon, 02 Jan 2017 05:33:40 -0800 (PST)
In-Reply-To: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, charles.garcia-tobin@arm.com, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>

iort_node_get_id() has two output, one is the mapped ids,
the other is the referenced parent node which is returned
from the function.

For now we need a API just return its parent node for
single mapping, so just update this function slightly then
reuse it later.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Majun <majun258@huawei.com>
Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/arm64/iort.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ab7bae7..bc68d93 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -347,7 +347,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
-			*id_out = map[index].output_base;
+			if (id_out)
+				*id_out = map[index].output_base;
 			return parent;
 		}
 	}
-- 
1.9.1

