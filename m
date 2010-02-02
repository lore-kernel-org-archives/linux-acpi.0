From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 21/28] asus-laptop: add bluetooth keys found on M9V
Date: Tue,  2 Feb 2010 08:39:04 +0100
Message-ID: <1265096351-15239-22-git-send-email-corentincj@iksaif.net>
References: <1265096351-15239-1-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-2-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-3-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-4-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-5-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-6-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-7-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-8-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-9-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-10-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-11-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-12-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-13-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-14-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-15-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-16-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-17-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-18-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-19-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-20-git-send-email-corentincj@iksaif.net>
 <1265096351-15239-21-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:57689 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755734Ab0BBHlc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Feb 2010 02:41:32 -0500
In-Reply-To: <1265096351-15239-21-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Corentin Chary <corentincj@iksaif.net>

Reported by Andrey F. Ilchuk

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 8042568..4f3c467 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -272,6 +272,8 @@ static const struct key_entry asus_keymap[] = {
 	{KE_KEY, 0x62, { KEY_SWITCHVIDEOMODE } },
 	{KE_KEY, 0x63, { KEY_SWITCHVIDEOMODE } },
 	{KE_KEY, 0x6B, { KEY_F13 } }, /* Lock Touchpad */
+	{KE_KEY, 0x7E, { KEY_BLUETOOTH } },
+	{KE_KEY, 0x7D, { KEY_BLUETOOTH } },
 	{KE_KEY, 0x82, { KEY_CAMERA } },
 	{KE_KEY, 0x88, { KEY_WLAN  } },
 	{KE_KEY, 0x8A, { KEY_PROG1 } },
-- 
1.6.6.1

