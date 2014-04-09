From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH 1/7] apei, mce: Call MCE-specific code only for X86 architecture.
Date: Wed,  9 Apr 2014 17:14:29 +0200
Message-ID: <1397056476-9183-2-git-send-email-tomasz.nowicki@linaro.org>
References: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:46036 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964806AbaDIPOU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2014 11:14:20 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so2002825eek.37
        for <linux-acpi@vger.kernel.org>; Wed, 09 Apr 2014 08:14:18 -0700 (PDT)
In-Reply-To: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, bp@suse.de, m.chehab@samsung.com
Cc: linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

This commit is dealing with MCE code in:
- hest.c
Move acpi_disable_cmcff flag to hest_parse_cmc() and makes
that depend on CONFIG_X86_MCE so that we do not have to maintain
acpi_disable_cmcff for architectures which do not support MCE.
Also, wrap architectural MCE header inside #ifdef CONFIG_X86_MCE.

- ghes.c
Wrap architectural MCE header inside #ifdef CONFIG_X86_MCE similar to rest
of the MCE code in this file.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/apei/ghes.c |    2 ++
 drivers/acpi/apei/hest.c |    8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index dab7cb7..f7edffc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -49,7 +49,9 @@
 #include <linux/aer.h>
 
 #include <acpi/ghes.h>
+#ifdef CONFIG_X86_MCE
 #include <asm/mce.h>
+#endif
 #include <asm/tlbflush.h>
 #include <asm/nmi.h>
 
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index f5e37f3..98db702 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -36,7 +36,9 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <acpi/apei.h>
+#ifdef CONFIG_X86_MCE
 #include <asm/mce.h>
+#endif
 
 #include "apei-internal.h"
 
@@ -133,6 +135,9 @@ static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
 	struct acpi_hest_ia_corrected *cmc;
 	struct acpi_hest_ia_error_bank *mc_bank;
 
+	if (acpi_disable_cmcff)
+		return 1;
+
 	if (hest_hdr->type != ACPI_HEST_TYPE_IA32_CORRECTED_CHECK)
 		return 0;
 
@@ -263,8 +268,7 @@ void __init acpi_hest_init(void)
 		goto err;
 	}
 
-	if (!acpi_disable_cmcff)
-		apei_hest_parse(hest_parse_cmc, NULL);
+	apei_hest_parse(hest_parse_cmc, NULL);
 
 	if (!ghes_disable) {
 		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
-- 
1.7.9.5

