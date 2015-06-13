From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 07/12] ACPI / battery: mark DMI table as __initconst
Date: Sat, 13 Jun 2015 14:26:55 +0200
Message-ID: <1434198420-8519-8-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33947 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbFMM1T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:19 -0400
Received: by wgv5 with SMTP id 5so39179331wgv.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:18 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The bat_dmi_table[] DMI table is referenced from the __init function
acpi_battery_init_async() only. It and its referenced functions can
therefore be marked __initconst to free up ~1kB of runtime memory after
initialization is done.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/battery.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 309ba02d4eb8..9bc379c7de5f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1123,19 +1123,21 @@ static int battery_notify(struct notifier_block *nb,
 	return 0;
 }
 
-static int battery_bix_broken_package_quirk(const struct dmi_system_id *d)
+static int __init
+battery_bix_broken_package_quirk(const struct dmi_system_id *d)
 {
 	battery_bix_broken_package = 1;
 	return 0;
 }
 
-static int battery_notification_delay_quirk(const struct dmi_system_id *d)
+static int __init
+battery_notification_delay_quirk(const struct dmi_system_id *d)
 {
 	battery_notification_delay_ms = 1000;
 	return 0;
 }
 
-static struct dmi_system_id bat_dmi_table[] = {
+static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		.callback = battery_bix_broken_package_quirk,
 		.ident = "NEC LZ750/LS",
-- 
1.7.10.4

