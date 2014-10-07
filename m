From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/44] memory: emif: Use API function to determine poweroff capability
Date: Mon,  6 Oct 2014 22:28:04 -0700
Message-ID: <1412659726-29957-3-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40210 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbaJGF3S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Oct 2014 01:29:18 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XbNKn-002a56-8L
	for linux-acpi@vger.kernel.org; Tue, 07 Oct 2014 05:29:17 +0000
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-cris-kernel@axis.com, linux-efi@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org, openipmi-developer@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>, Santosh

Use have_kernel_poweroff() to determine if the kernel is able
to power off the system.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/memory/emif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 04644e7..acd830a 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1053,10 +1053,10 @@ static irqreturn_t emif_threaded_isr(int irq, void *dev_id)
 		dev_emerg(emif->dev, "SDRAM temperature exceeds operating limit.. Needs shut down!!!\n");
 
 		/* If we have Power OFF ability, use it, else try restarting */
-		if (pm_power_off) {
+		if (have_kernel_poweroff()) {
 			kernel_power_off();
 		} else {
-			WARN(1, "FIXME: NO pm_power_off!!! trying restart\n");
+			WARN(1, "FIXME: NO kernel poweroff capability!!! trying restart\n");
 			kernel_restart("SDRAM Over-temp Emergency restart");
 		}
 		return IRQ_HANDLED;
-- 
1.9.1

