From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 2/2] ACPI / trivial: Fix the return value type of acpi_processor_eval_pdc()
Date: Sat,  8 Feb 2014 20:46:26 +0800
Message-ID: <1391863586-3157-2-git-send-email-hanjun.guo@linaro.org>
References: <1391863586-3157-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60803 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaBHMrL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Feb 2014 07:47:11 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so4285157pab.19
        for <linux-acpi@vger.kernel.org>; Sat, 08 Feb 2014 04:47:11 -0800 (PST)
In-Reply-To: <1391863586-3157-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

The return value type of acpi_processor_eval_pdc() should be
'acpi_status' but defined as 'int', fix it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 849cfd6..46583d7 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -323,7 +323,7 @@ static struct acpi_object_list *acpi_processor_alloc_pdc(void)
  * _PDC is required for a BIOS-OS handshake for most of the newer
  * ACPI processor features.
  */
-static int
+static acpi_status
 acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 {
 	acpi_status status = AE_OK;
-- 
1.7.9.5

