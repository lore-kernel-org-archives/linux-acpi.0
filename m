From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 5/8] eeepc-laptop: remove redundant rfkill_set_sw_state in
 resume handler
Date: Sun, 02 Aug 2009 16:56:51 +0100
Message-ID: <4A75B743.2040705@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35842 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbZHBP4w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 11:56:52 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so2535576ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2009 08:56:52 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

rfkill_set_sw_state() will already be called by eeepc_rfkill_hotplug().

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 298dac9..7f7573a 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -835,8 +835,7 @@ static int eeepc_hotk_resume(struct acpi_device *device)
 		wlan = get_acpi(CM_ASL_WLAN);
 		set_acpi(CM_ASL_WLAN, wlan);
 
-		rfkill_set_sw_state(ehotk->wlan_rfkill, wlan != 1);
-
+		/* Refresh both rfkill state and pci hotplug */
 		eeepc_rfkill_hotplug();
 	}
 
-- 
1.6.3.2

