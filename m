From: Corentin Chary <corentin.chary@gmail.com>
Subject: [PATCH 3/3] platform/x86: fix asus_laptop.wled_type description
Date: Mon, 20 Aug 2012 23:01:52 +0200
Message-ID: <1345496512-11780-4-git-send-email-corentin.chary@gmail.com>
References: <1345496512-11780-1-git-send-email-corentin.chary@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35891 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab2HTVCQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Aug 2012 17:02:16 -0400
In-Reply-To: <1345496512-11780-1-git-send-email-corentin.chary@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Maxim Nikulin <m.a.nikulin@gmail.com>, "Maxim A. Nikulin" <M.A.Nikulin@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg@redhat.com>, acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Maxim Nikulin <m.a.nikulin@gmail.com>

MODULE_PARM_DESC for wlan_status is further in the same file

Signed-off-by: Maxim A. Nikulin <M.A.Nikulin@gmail.com>
Signed-off-by: Corentin Chary <corentin.chary@gmail.com>
---
 drivers/platform/x86/asus-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 110c777..4b568df 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -85,7 +85,7 @@ static char *wled_type = "unknown";
 static char *bled_type = "unknown";
 
 module_param(wled_type, charp, 0444);
-MODULE_PARM_DESC(wlan_status, "Set the wled type on boot "
+MODULE_PARM_DESC(wled_type, "Set the wled type on boot "
 		 "(unknown, led or rfkill). "
 		 "default is unknown");
 
-- 
1.7.9.5

