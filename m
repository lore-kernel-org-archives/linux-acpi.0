From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 1/2] ACPI / dock: Remove the redundant if (acpi_disabled) check
Date: Fri,  6 Dec 2013 00:03:40 +0800
Message-ID: <1386259421-10320-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36171 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402Ab3LEQDx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 11:03:53 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so24684032pdj.23
        for <linux-acpi@vger.kernel.org>; Thu, 05 Dec 2013 08:03:52 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, patches@linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

acpi_dock_init() will only be called in acpi_scan_init(),
and the code logic shows that if (acpi_disabled) is redundant:

acpi_init();
	if (acpi_disabled) return;
	acpi_scan_init();
		acpi_dock_init();
			if (acpi_disabled) /* redundant */
				return;

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---

This patch set is inspired by Rob's question for my ACPI ARM64
core patches :)

 drivers/acpi/dock.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 8da6be9..61d0c3f 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -893,9 +893,6 @@ find_dock_and_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 void __init acpi_dock_init(void)
 {
-	if (acpi_disabled)
-		return;
-
 	/* look for dock stations and bays */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 		ACPI_UINT32_MAX, find_dock_and_bay, NULL, NULL, NULL);
-- 
1.7.9.5

