Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1B49B1FE;
	Tue,  1 Sep 2026 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287058; cv=none; b=HcXk49o50fevnYhsHl65xhgMmYaYBCJ+5yY3iK+6XnCRsufaBWxiJJzvKguwZt0iKkwSBX0ej7LerfU5N6vgF3AnTGMuU0l9RCt6NQLWarOj6cjQcIUpMJ7f+EoBb8MorNfrL6pf6ZY8tmHLe/QhxKBxPAvGjsFLcm/yJcp+TDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287058; c=relaxed/simple;
	bh=raMtJFV9r1wpJ/ssJ/bywt4l9/jc3Smdoe/AlbFwX90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aOF1ZMXqKi8eMlQz7BTZVqq6dzJt2qP1ZN6WvPjf0lWbWCJzGpLMEtI5kzjjxdQZJj+MEKPrjxWofjXCN6uH5/iL644b4QGaaYAALwkBukKs1GJAeOXTm3TPbWwAg8SBbYKVkyaFf7L3NC/I54V8hDGy70Rkd5q8tZWaxHeXFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRE2UZwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRE2UZwf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28CA0C2BCF5;
	Tue,  1 Sep 2026 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788287058;
	bh=raMtJFV9r1wpJ/ssJ/bywt4l9/jc3Smdoe/AlbFwX90=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uRE2UZwf6MEnYslBZ6vDbmYU/N7+JMtaiY7gCpP12t/kX8dl7Q1eAz0uDQ4R1JFHR
	 Gl8DOnqJlX9KgEZRfUFNglkbswgm7Npv4ZKBrbKrSJ17Doc9xBMOkaIgEER1g+Jd9j
	 0YaMLGilC/T+N3LIevdyeAgtx0ZgxBDWjO6/20YuAE1ECSNC0MeTWEUBIahGyvRB/Y
	 UU7Uk3DBVj8nVB6OM/rvKSCDgkHXCLs0iNAU9uscpZ0Ab5Cm1DISignNIqjnC2VxU5
	 bUP+qEsnvlD6zGAZKi8rKCeuuhAyDtHhqG9hqxDAqllUb7Z+ddEKDyne56Nh5Q1faH
	 QOZisH5KGQHvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA0EC61DD3;
	Tue,  1 Sep 2026 18:24:18 +0000 (UTC)
From: George Kokolakis via B4 Relay <devnull+george.kokolakis.ece.gmail.com@kernel.org>
Date: Tue, 01 Sep 2026 21:24:14 +0300
Subject: [PATCH] ACPI: PM: Use EFI power off on Lenovo ThinkPad T14 Gen 5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix-thinkpad-t14-gen5-efi-poweroff-v1-1-7f766dc13ee9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE0Yl2oC/x2NywqEMAwAf0VyNtC61tevLHsINtUgtKUVVxD/3
 eJxGJi5IHMSzjBVFyQ+JEvwBXRdwbySXxjFFoZGNZ0alUYnJ+6r+C2SxV23uLA3yE4whj+n4Bw
 O/UCfubVkyEAJxVT0+U6+v/t+AEHMSI90AAAA
To: rafael@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788287057; l=3071;
 i=george.kokolakis.ece@gmail.com; s=kernel-20260901;
 h=from:subject:message-id;
 bh=eB+R26itJ2JkTVFa+VyNE4Mw+wr0JpISWwRbkykFcQw=;
 b=aSci7cGWGfRq3MarVunw1Msq3HGDWZbbRiXQRA3urKl1v3DbiAHzC4FBhgvUbWczAKlBytAdU
 Lz8Shk+Jny/Ax6FZsxQ/UjkLuAKUTR/95kAdax752IRfkyvJn34lvEc
X-Developer-Key: i=george.kokolakis.ece@gmail.com; a=ed25519;
 pk=vZ27t8agUnF5GcuvLoIUzClMG59D0bvQE7GXXdwXJ9I=
X-Endpoint-Received: by B4 Relay for
 george.kokolakis.ece@gmail.com/kernel-20260901 with auth_id=995
X-Original-From: George Kokolakis <george.kokolakis.ece@gmail.com>
Reply-To: george.kokolakis.ece@gmail.com

From: George Kokolakis <george.kokolakis.ece@gmail.com>

A Lenovo ThinkPad T14 Gen 5 (type 21ML) powers back on immediately
after an orderly ACPI S5 shutdown.  This was reproduced with BIOS
N47ET29W 1.18 and Ubuntu kernel 7.0.0-30-generic.

A standalone UEFI application invoking ResetSystem(EfiResetShutdown)
leaves the same machine powered off.  A DMI-scoped test module that
skips the ACPI S5 power-off preparation handler and invokes ResetSystem
at the final sys-off stage also leaves it off during an ordinary
userspace shutdown.

Mark ACPI S5 unusable for power-off on this model.  This makes the
existing x86 EFI code register its higher-priority EFI shutdown handler.
Do not register the two ACPI power-off handlers when the quirk is active,
but retain ACPI S5 preparation for restart.

Link: https://bugs.launchpad.net/bugs/2162837
Cc: stable@vger.kernel.org
Signed-off-by: George Kokolakis <george.kokolakis.ece@gmail.com>
---
 drivers/acpi/sleep.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 132a9df984..d14833eb59 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -27,7 +27,7 @@
 #include "sleep.h"
 
 /*
- * Some HW-full platforms do not have _S5, so they may need
+ * Some HW-full platforms do not have a usable _S5, so they may need
  * to leverage efi power off for a shutdown.
  */
 bool acpi_no_s5;
@@ -173,6 +173,12 @@ static int __init init_default_s3(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init init_no_s5(const struct dmi_system_id *d)
+{
+	acpi_no_s5 = true;
+	return 0;
+}
+
 static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -407,6 +413,14 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
 		},
 	},
+	{
+	.callback = init_no_s5,
+	.ident = "Lenovo ThinkPad T14 Gen 5 (21ML)",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "21ML"),
+		},
+	},
 	{},
 };
 
@@ -1117,13 +1131,15 @@ int __init acpi_sleep_init(void)
 	if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
 		sleep_states[ACPI_STATE_S5] = 1;
 
-		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF_PREPARE,
-					 SYS_OFF_PRIO_FIRMWARE,
-					 acpi_power_off_prepare, NULL);
+		if (!acpi_no_s5) {
+			register_sys_off_handler(SYS_OFF_MODE_POWER_OFF_PREPARE,
+						 SYS_OFF_PRIO_FIRMWARE,
+						 acpi_power_off_prepare, NULL);
 
-		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
-					 SYS_OFF_PRIO_FIRMWARE,
-					 acpi_power_off, NULL);
+			register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+						 SYS_OFF_PRIO_FIRMWARE,
+						 acpi_power_off, NULL);
+		}
 
 		/*
 		 * Windows uses S5 for reboot, so some BIOSes depend on it to

---
base-commit: 786262be6048deab760f68c8acc2c85607165894
change-id: 20260901-fix-thinkpad-t14-gen5-efi-poweroff-878a3c4da5a5

Best regards,
-- 
George Kokolakis <george.kokolakis.ece@gmail.com>


