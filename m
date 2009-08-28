From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 07/24] eeepc-laptop: check the 3G rfkill state on resume
Date: Fri, 28 Aug 2009 14:56:38 +0200
Message-ID: <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.10]:6644 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbZH1NDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:41 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2205.sfr.fr (SMTP Server) with ESMTP id 2DAEF7000C20
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:43 +0200 (CEST)
In-Reply-To: <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

All the rfkill devices are treated as "persistent", 3G is no exception.
This means their state may change over hibernation.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 7f7573a..8a32004 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -842,6 +842,9 @@ static int eeepc_hotk_resume(struct acpi_device *device)
 	if (ehotk->bluetooth_rfkill)
 		rfkill_set_sw_state(ehotk->bluetooth_rfkill,
 				    get_acpi(CM_ASL_BLUETOOTH) != 1);
+	if (ehotk->wwan3g_rfkill)
+		rfkill_set_sw_state(ehotk->wwan3g_rfkill,
+				    get_acpi(CM_ASL_3G) != 1);
 
 	return 0;
 }
-- 
1.6.4


