From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH] CPPC: Fix potential ptr leak
Date: Fri, 23 Oct 2015 05:02:52 -0400
Message-ID: <1445590972-12331-1-git-send-email-ashwin.chaugule@linaro.org>
References: <20151022194928.GA24403@mwanda>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33436 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbJWJC7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Oct 2015 05:02:59 -0400
Received: by wijp11 with SMTP id p11so67662029wij.0
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2015 02:02:58 -0700 (PDT)
In-Reply-To: <20151022194928.GA24403@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael@kernel.org, dan.carpenter@oracle.com
Cc: linux-acpi@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

The patch 337aadff8e45: "ACPI: Introduce CPU performance controls
using CPPC" from Oct 2, 2015, leads to the following static checker
warning:

        drivers/acpi/cppc_acpi.c:527 acpi_cppc_processor_probe()
        warn: overwrite may leak 'cpc_ptr'

Fix warning by removing bogus per cpu ptr dereference.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/cppc_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 0bbf84b..8ca4c2c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -524,7 +524,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	return 0;
 
 out_free:
-	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
 	kfree(cpc_ptr);
 
 out_buf_free:
-- 
1.9.1

