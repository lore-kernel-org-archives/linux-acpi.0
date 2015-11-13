From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH] CPPC: Use h/w reduced version of the PCCT structure
Date: Thu, 12 Nov 2015 19:52:30 -0500
Message-ID: <1447375950-3679-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33083 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbbKMAwn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 19:52:43 -0500
Received: by qkas77 with SMTP id s77so33217055qka.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2015 16:52:42 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

CPPC is enabled only on platforms which support
the h/w reduced ACPI specification. So use the h/w
reduced version of the PCCT consistently while
deferencing PCCT contents.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3c083d2..6730f96 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -304,7 +304,7 @@ EXPORT_SYMBOL_GPL(acpi_get_psd_map);
 
 static int register_pcc_channel(int pcc_subspace_idx)
 {
-	struct acpi_pcct_subspace *cppc_ss;
+	struct acpi_pcct_hw_reduced *cppc_ss;
 	unsigned int len;
 
 	if (pcc_subspace_idx >= 0) {
-- 
1.9.1

