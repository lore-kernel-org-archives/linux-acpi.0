From: Len Brown <lenb@kernel.org>
Subject: [PATCH 081/103] asus-laptop: change light sens default values.
Date: Wed, 16 Dec 2009 03:36:32 -0500
Message-ID: <d951d4cc84e8b5ddb8e0ab81cf6a72cc73fdd668.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61822 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762134AbZLPMGW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:06:22 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:06:04 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, stable@kernel.org, Thomas Renninger <trenn@suse.de>, =?UTF-8?q?Peter=20K=C3=BCppers?= <peter-mailbox@web.de>, Michael Franzl <michaelfranzl@gmx.at>, Ian Turner <vectro@vectro.org>, Len Brown <len.brown@intel.com>

=46rom: Corentin Chary <corentincj@iksaif.net>

The light sensor disable brightness key and
/sys/class/backlight/ control. There was a lot of report
from users who didn't understand why they couldn't change their
brightness, including:

https://bugs.launchpad.net/bugs/222171
https://bugzilla.novell.com/show_bug.cgi?id=3D514747
http://bugzilla.kernel.org/show_bug.cgi?id=3D13671
http://bugzilla.kernel.org/show_bug.cgi?id=3D14432

Now the light sensor is disabled, and if the user want to enable
it, the level should be ok.

The funny thing is that comments where ok, not code.

Cc: stable@kernel.org
Cc: Thomas Renninger <trenn@suse.de>
Cc: Peter K=C3=BCppers <peter-mailbox@web.de>
Cc: Michael Franzl <michaelfranzl@gmx.at>
Cc: Ian Turner <vectro@vectro.org>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/asus-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/=
asus-laptop.c
index 3348cc6..61a1c75 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1290,8 +1290,8 @@ static int asus_hotk_add(struct acpi_device *devi=
ce)
 	hotk->ledd_status =3D 0xFFF;
=20
 	/* Set initial values of light sensor and level */
-	hotk->light_switch =3D 1;	/* Default to light sensor disabled */
-	hotk->light_level =3D 0;	/* level 5 for sensor sensitivity */
+	hotk->light_switch =3D 0;	/* Default to light sensor disabled */
+	hotk->light_level =3D 5;	/* level 5 for sensor sensitivity */
=20
 	if (ls_switch_handle)
 		set_light_sens_switch(hotk->light_switch);
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
