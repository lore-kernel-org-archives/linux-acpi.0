From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 2/2] ACPI / sleep: Remove the redundant if (acpi_disabled) check
Date: Fri,  6 Dec 2013 00:03:41 +0800
Message-ID: <1386259421-10320-2-git-send-email-hanjun.guo@linaro.org>
References: <1386259421-10320-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:36448 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab3LEQE1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 11:04:27 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so26213224pbb.37
        for <linux-acpi@vger.kernel.org>; Thu, 05 Dec 2013 08:04:26 -0800 (PST)
In-Reply-To: <1386259421-10320-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, patches@linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

acpi_sleep_init() will only be called in acpi_bus_init(),
and the code logic shows that if (acpi_disabled) is redundant:

acpi_init();
	if (acpi_disabled) return;
	acpi_bus_init();
		acpi_sleep_init();
			if (acpi_disabled)
				return 0;

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/sleep.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 208ac8c..54ab266 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -802,9 +802,6 @@ int __init acpi_sleep_init(void)
 	char *pos = supported;
 	int i;
 
-	if (acpi_disabled)
-		return 0;
-
 	acpi_sleep_dmi_check();
 
 	sleep_states[ACPI_STATE_S0] = 1;
-- 
1.7.9.5

