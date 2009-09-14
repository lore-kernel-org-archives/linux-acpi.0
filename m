From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 1/3] hp-wmi: fix rfkill memory leak on unload
Date: Mon, 14 Sep 2009 12:43:51 +0200
Message-ID: <1252925033-29696-2-git-send-email-corentincj@iksaif.net>
References: <1252925033-29696-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755238AbZINKvc@vger.kernel.org>
In-Reply-To: <1252925033-29696-1-git-send-email-corentincj@iksaif.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Johannes Berg <johannes@sipsolutions.net>, Corentin Chary <corentincj@iksaif.net>
List-Id: linux-acpi@vger.kernel.org

rfkill_unregister() should always be followed by rfkill_destroy()
In this case, rfkill_destroy was called two times on wifi_rfkill and
never on bluetooth_rfkill.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/hp-wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index a2ad53e..a750192 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -502,7 +502,7 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
 	}
 	if (bluetooth_rfkill) {
 		rfkill_unregister(bluetooth_rfkill);
-		rfkill_destroy(wifi_rfkill);
+		rfkill_destroy(bluetooth_rfkill);
 	}
 	if (wwan_rfkill) {
 		rfkill_unregister(wwan_rfkill);
-- 
1.6.4.2
