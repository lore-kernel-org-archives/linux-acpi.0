From: akpm@osdl.org
Subject: [patch 03/14] acpi: fix boot with acpi=off
Date: Mon, 14 Aug 2006 22:37:22 -0700
Message-ID: <200608150537.k7F5bM6t011533@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:43657 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965088AbWHOFha (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 01:37:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz

From: Pavel Machek <pavel@ucw.cz>

With acpi=off and acpi_ac/battery compiled into kernel, acpi breaks
boot. This fixes it.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/ac.c      |    2 ++
 drivers/acpi/battery.c |    3 +++
 2 files changed, 5 insertions(+)

diff -puN drivers/acpi/ac.c~acpi-fix-boot-with-acpi=off drivers/acpi/ac.c
--- a/drivers/acpi/ac.c~acpi-fix-boot-with-acpi=off
+++ a/drivers/acpi/ac.c
@@ -285,6 +285,8 @@ static int __init acpi_ac_init(void)
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
diff -puN drivers/acpi/battery.c~acpi-fix-boot-with-acpi=off drivers/acpi/battery.c
--- a/drivers/acpi/battery.c~acpi-fix-boot-with-acpi=off
+++ a/drivers/acpi/battery.c
@@ -757,6 +757,9 @@ static int __init acpi_battery_init(void
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return -ENODEV;
_
