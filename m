From: Luca Bruno <lucab@debian.org>
Subject: [PATCH] ACPI / PM: Do not save/restore NVS on Sony Vaio VPCEB1J1E
Date: Wed,  6 Jul 2011 08:58:00 +0200
Message-ID: <1309935480-3865-1-git-send-email-lucab@debian.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-93-93-202-11.planetacomnetwork.com ([93.93.202.11]:46145
	"EHLO mail.unstable.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab1GFHER (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2011 03:04:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

Sony Vaio VPCEB1J1E requires acpi_sleep=nonvs for correct
suspend/resume. This model is similar to the VPCEB1Z1E, already
blacklisted. Blacklisting this one too.

Signed-off-by: Luca Bruno <lucab@debian.org>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 6c94960..96f55c5 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -406,6 +406,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	},
 	{
 	.callback = init_nvs_nosave,
+	.ident = "Sony Vaio VPCEB1J1E",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEB1J1E"),
+		},
+	},
+	{
+	.callback = init_nvs_nosave,
 	.ident = "Sony Vaio VPCEB1Z1E",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-- 
1.7.5.4

