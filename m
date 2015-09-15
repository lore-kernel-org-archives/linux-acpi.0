From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms using 'global_lock'
Date: Tue, 15 Sep 2015 14:04:58 +0530
Message-ID: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36578 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbIOIfH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2015 04:35:07 -0400
Received: by padhk3 with SMTP id hk3so170252653pad.3
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2015 01:35:07 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, arnd@arndb.de, Viresh Kumar <viresh.kumar@linaro.org>, stable@vger.kernel.org, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

global_lock is defined as an unsigned long and accessing only its lower
32 bits from sysfs is incorrect, as we need to consider other 32 bits
for big endian 64 bit systems.

Fix that by making global_lock an u32 instead.

Cc: <stable@vger.kernel.org>  # v4.1+
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Its marked just for # v4.1+, because arm64 has the first 64 big-endian
platform with ACPI. And ACPI support for that is mainlined recently
only (Arnd Bergmann).

Another thing worth noticing is that, global_lock is getting an unsigned
long long value assigned to it in ec_parse_device() and this is what
Arnd had to say about that:

"I think that's fine, it does this because the _GLP variable in ACPI is
defined as an u64. And that's what happens on 32-bit architectures
anyway."

This patch should go via GregKH, as the second patch has dependency on
it.

V2->V3:
- Moved this out in a separate patch, so that it can be backported.
---
 drivers/acpi/ec_sys.c   | 2 +-
 drivers/acpi/internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index b4c216bab22b..bea8e425a8de 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -128,7 +128,7 @@ static int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
 	if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
 		goto error;
 	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
-				 (u32 *)&first_ec->global_lock))
+				 &first_ec->global_lock))
 		goto error;
 
 	if (write_support)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9e426210c2a8..9db196de003c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -138,7 +138,7 @@ struct acpi_ec {
 	unsigned long gpe;
 	unsigned long command_addr;
 	unsigned long data_addr;
-	unsigned long global_lock;
+	u32 global_lock;
 	unsigned long flags;
 	unsigned long reference_count;
 	struct mutex mutex;
-- 
2.4.0

