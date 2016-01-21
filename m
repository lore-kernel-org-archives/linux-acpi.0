From: Loc Ho <lho@apm.com>
Subject: [PATCH v4 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Wed, 20 Jan 2016 17:17:38 -0700
Message-ID: <1453335459-3617-2-git-send-email-lho@apm.com>
References: <1453335459-3617-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36273 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbcAUARu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 19:17:50 -0500
Received: by mail-pf0-f174.google.com with SMTP id n128so12942156pfn.3
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2016 16:17:50 -0800 (PST)
In-Reply-To: <1453335459-3617-1-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, dougthompson@xmission.com, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-edac@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, patches@apm.com, Loc Ho <lho@apm.com>, Tuan Phan <tphan@apm.com>

The function acpi_gsi_to_irq must return 0 on success as the caller
ghes_probe expects an 0 for success. This change also matches x86
implementation.

Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/gsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index ee9e0f2..7b109bd 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -24,7 +24,7 @@ static struct fwnode_handle *acpi_gsi_domain_id;
  *
  * irq location updated with irq value [>0 on success, 0 on failure]
  *
- * Returns: linux IRQ number on success (>0)
+ * Returns: 0 on success
  *          -EINVAL on failure
  */
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
@@ -37,7 +37,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 	 * *irq == 0 means no mapping, that should
 	 * be reported as a failure
 	 */
-	return (*irq > 0) ? *irq : -EINVAL;
+	return (*irq > 0) ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 
-- 
1.7.1

