From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 3/3] eeepc-laptop: allow rfkill hotplug to work on the 900A model
Date: Sat, 29 Aug 2009 10:28:31 +0200
Message-ID: <1251534511-8479-3-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0908281524080.27023@localhost.localdomain>
 <1251534511-8479-1-git-send-email-corentincj@iksaif.net>
 <1251534511-8479-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp23.services.sfr.fr ([93.17.128.20]:59673 "EHLO
	smtp23.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbZH2I3d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Aug 2009 04:29:33 -0400
In-Reply-To: <1251534511-8479-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The 900A provides hotplug notifications on a different ACPI object to
other models.

Reported-by: Trevor <trevor.chart@gmail.com>
Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 6f9a448..da3c08b 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -981,6 +981,7 @@ static void eeepc_backlight_exit(void)
 
 static void eeepc_rfkill_exit(void)
 {
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P5");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
 	if (ehotk->wlan_rfkill) {
@@ -1101,6 +1102,7 @@ static int eeepc_rfkill_init(struct device *dev)
 	if (result == -EBUSY)
 		result = 0;
 
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P5");
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
 	/*
-- 
1.6.4.1


