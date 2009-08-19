From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 2/2] eeepc-laptop: allow rfkill hotplug to work on the 900A
 model
Date: Wed, 19 Aug 2009 10:39:03 +0100
Message-ID: <4A8BC837.30206@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37535 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbZHSJjF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Aug 2009 05:39:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Trevor <trevor.chart@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

The 900A provides hotplug notifications on a different ACPI object to
other models.

Reported-by: Trevor <trevor.chart@gmail.com>
Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 36d613b..7528b4f 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -977,6 +977,7 @@ static void eeepc_backlight_exit(void)
 
 static void eeepc_rfkill_exit(void)
 {
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P5");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
 	if (ehotk->wlan_rfkill) {
@@ -1083,6 +1084,7 @@ static int eeepc_rfkill_init(struct device *dev)
 	if (result == -EBUSY)
 		result = 0;
 
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P5");
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
 	/*
-- 
1.6.3.2



