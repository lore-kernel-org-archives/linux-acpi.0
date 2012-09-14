From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/3] acpi : remove pointless variable initialization
Date: Fri, 14 Sep 2012 11:25:36 +0200
Message-ID: <1347614736-9553-3-git-send-email-daniel.lezcano@linaro.org>
References: <1347614736-9553-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42472 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758542Ab2INJZp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Sep 2012 05:25:45 -0400
Received: by weyx8 with SMTP id x8so2266494wey.19
        for <linux-acpi@vger.kernel.org>; Fri, 14 Sep 2012 02:25:44 -0700 (PDT)
In-Reply-To: <1347614736-9553-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

The 'errata' variable is a global variable which is set to zero,
no need to do that with a memset in the init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_driver.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 9c9288b..e78c2a5 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -905,8 +905,6 @@ static int __init acpi_processor_init(void)
 	if (acpi_disabled)
 		return 0;
 
-	memset(&errata, 0, sizeof(errata));
-
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0)
 		return result;
-- 
1.7.5.4

