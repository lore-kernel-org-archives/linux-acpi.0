From: al.stone@linaro.org
Subject: [PATCH v6 6/6] ACPI: make sure ECs do not use the ACPI global lock
Date: Fri, 10 Jan 2014 15:52:20 -0700
Message-ID: <1389394340-2680-7-git-send-email-al.stone@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38748 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898AbaAJWwk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2014 17:52:40 -0500
Received: by mail-ie0-f171.google.com with SMTP id to1so1768958ieb.16
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jan 2014 14:52:39 -0800 (PST)
In-Reply-To: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

ACPI ECs (Embedded Controllers) are allowed to use the ACPI global
lock in legacy mode.  Since there is no global lock in hardware
reduced mode, make sure that ECs cannot inadvertently use it with
older ACPI tables that may have defined an _GLK method for the
EC device.  Since an individual lock can and should be defined for
each EC, access to each EC should still be properly controlled.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/ec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ba5b56d..3f15110 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -745,9 +745,17 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	if (ACPI_FAILURE(status))
 		return status;
 	ec->gpe = tmp;
-	/* Use the global lock for all EC transactions? */
+	/*
+	 * Use the global lock for all EC transactions?
+	 *
+	 * If ACPI is in hardware reduced mode, there is no global lock.
+	 * If a _GLK method is defined, it needs to be ignored, just
+	 * in case it returns "true", which could happen if the ASL is
+	 * written incorrectly.
+	 */
 	tmp = 0;
-	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
+	if (!acpi_gbl_reduced_hardware)
+		acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
 	ec->global_lock = tmp;
 	ec->handle = handle;
 	return AE_CTRL_TERMINATE;
-- 
1.8.4.2

