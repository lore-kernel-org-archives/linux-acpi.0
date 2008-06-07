From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: ACPI PM: Add DMI quirk list for ACPI 1.0 suspend order
Date: Sat, 7 Jun 2008 12:21:55 +0100
Message-ID: <200806071221.56373.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:57681 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbYFGLWG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2008 07:22:06 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

There are a few BIOS' that we know of already that need to use the
ACPI 1.0 suspend order. This appears to be only be a small minority of
mostly nVidia based systems.

Based on observation of Windows behaviour, it's clear that Windows is
also doing maintaining its own list of broken hardware that needs this
workaround.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---
This doesn't include the other two (or was it three?) systems that we know of
that need this quirk, as we'll need the DMI data for those (and I don't think
we have that yet?).

This applies on top of Rafael's "ACPI PM: Add possibility to change suspend
sequence" patch.

 drivers/acpi/sleep/main.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)


diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index edfeeb0..15fc48d 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -281,6 +281,24 @@ static struct platform_suspend_ops acpi_suspend_ops_old = {
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };
+
+static int __init init_old_suspend_ordering(const struct dmi_system_id *d)
+{
+	old_suspend_ordering = true;
+	return 0;
+}
+
+static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
+	{
+	.callback = init_old_suspend_ordering,
+	.ident = "Abit KN9 (nForce4 variant)",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "http://www.abit.com.tw/"),
+		DMI_MATCH(DMI_BOARD_NAME, "KN9 Series(NF-CK804)"),
+		},
+	},
+	{},
+};
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
@@ -507,6 +525,8 @@ int __init acpi_sleep_init(void)
 	u8 type_a, type_b;
 #ifdef CONFIG_SUSPEND
 	int i = 0;
+
+	dmi_check_system(acpisleep_dmi_table);
 #endif
 
 	if (acpi_disabled)
