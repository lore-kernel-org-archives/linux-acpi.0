From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 06/24] eeepc-laptop: remove redundant rfkill_set_sw_state in resume handler
Date: Fri, 28 Aug 2009 14:56:37 +0200
Message-ID: <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:61292 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZH1NDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:40 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id 5F30D7001EB5
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:42 +0200 (CEST)
In-Reply-To: <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

rfkill_set_sw_state() will already be called by eeepc_rfkill_hotplug().

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.4


