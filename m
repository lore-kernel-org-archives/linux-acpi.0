From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v7 01/15] ACPI: IORT: fix the indentation in iort_scan_node()
Date: Wed, 11 Jan 2017 23:06:25 +0800
Message-ID: <1484147199-4267-2-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34791 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764327AbdAKPHp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2017 10:07:45 -0500
Received: by mail-pf0-f176.google.com with SMTP id 127so62951513pfg.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 07:07:43 -0800 (PST)
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Matthias Brugger <mbrugger@suse.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Hanjun Guo <hanjun.guo@linaro.org>

The indentation is wrong when return the iort_node, fix it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ba156c5..ce3084b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -225,7 +225,7 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
 
 		if (iort_node->type == type &&
 		    ACPI_SUCCESS(callback(iort_node, context)))
-				return iort_node;
+			return iort_node;
 
 		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 					 iort_node->length);
-- 
1.9.1

