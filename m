From: Loc Ho <lho@apm.com>
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Fri,  6 Nov 2015 17:51:58 -0700
Message-ID: <1446857519-5908-2-git-send-email-lho@apm.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34806 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbKGAwS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2015 19:52:18 -0500
Received: by padhx2 with SMTP id hx2so129878863pad.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2015 16:52:18 -0800 (PST)
In-Reply-To: <1446857519-5908-1-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dougthompson@xmission.com, bp@alien8.de, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>, Tuan Phan <tphan@apm.com>

The function acpi_gsi_to_irq should returns 0 on success as upper function
caller expect an 0 for sucesss.

Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/gsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index fa4585a..0ed1003 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -43,7 +43,7 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
  *
  * irq location updated with irq value [>0 on success, 0 on failure]
  *
- * Returns: linux IRQ number on success (>0)
+ * Returns: 0 on success
  *          -EINVAL on failure
  */
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
@@ -56,7 +56,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 	 * *irq == 0 means no mapping, that should
 	 * be reported as a failure
 	 */
-	return (*irq > 0) ? *irq : -EINVAL;
+	return (*irq > 0) ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 
-- 
1.7.1

