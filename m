From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] acpi: battery: make warning greppable
Date: Fri, 13 Mar 2015 00:48:17 +0100
Message-ID: <1426204097-3024-1-git-send-email-martink@posteo.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:40992 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbbCLXsi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2015 19:48:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
I was so angry now, I had to write a change. Please keep things greppable and
save unnecessary questions and time this way.

 drivers/acpi/battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index d98ba43..baebd1a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -530,8 +530,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
 		(s16)(battery->rate_now) < 0) {
 		battery->rate_now = abs((s16)battery->rate_now);
-		printk_once(KERN_WARNING FW_BUG "battery: (dis)charge rate"
-			" invalid.\n");
+		printk_once(KERN_WARNING FW_BUG
+			    "battery: (dis)charge rate invalid.\n");
 	}
 
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
-- 
2.1.4

