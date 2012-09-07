From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/6] acpi : remove pointless cpuidle device state_count init
Date: Fri,  7 Sep 2012 12:19:29 +0200
Message-ID: <1347013172-12465-4-git-send-email-daniel.lezcano@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46113 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651Ab2IGKTp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 06:19:45 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1284302bkw.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 03:19:44 -0700 (PDT)
In-Reply-To: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

The cpuidle core takes care of filling this field from drv->state_count.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 084b1d2..fc4757e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1035,8 +1035,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr)
 			break;
 	}
 
-	dev->state_count = count;
-
 	if (!count)
 		return -EINVAL;
 
-- 
1.7.5.4

