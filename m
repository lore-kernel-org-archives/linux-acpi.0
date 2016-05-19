From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH] acpi/battery: Correctly serialise with the pending async probe
Date: Thu, 19 May 2016 09:11:52 +0100
Message-ID: <1463645512-29363-1-git-send-email-chris@chris-wilson.co.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36535 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbcESIMF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2016 04:12:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

async_synchronize_cookie() only serialises all tasks up to the specified
cookie, and importantly does not wait for the task corresponding with
the cookie. (This is so that it can be trivially used from inside the
async_func_t in order to serialise with all preceding tasks.) In order
to serialise with acpi_battery_init_async() we need to compensate and
pass in the next cookie instead.

The impact today is zero since performing an async_schedule() from inside
a module init function will trigger an async_synchronize_full() prior to
the module loader's completion. However, if the probe was moved to its
own unregistered async_domain, then the async_synchronize_cookie would
be replaced with an async_synchronize_full_domain.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b719ab3090bb..ab234791a0ba 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1316,7 +1316,7 @@ static int __init acpi_battery_init(void)
 
 static void __exit acpi_battery_exit(void)
 {
-	async_synchronize_cookie(async_cookie);
+	async_synchronize_cookie(async_cookie + 1);
 	acpi_bus_unregister_driver(&acpi_battery_driver);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_unlock_battery_dir(acpi_battery_dir);
-- 
2.8.1

