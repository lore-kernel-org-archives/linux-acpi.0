From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] asus-laptop: change light sens default values.
Date: Mon,  7 Dec 2009 22:05:50 +0100
Message-ID: <1260219950-28577-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:59437 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932191AbZLGVFC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Dec 2009 16:05:02 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, stable@kernel.org, Thomas Renninger <trenn@suse.de>, =?UTF-8?q?Peter=20K=C3=BCppers?= <peter-mailbox@web.de>, Michael Franzl <michaelfranzl@gmx.at>, Ian Turner <vectro@vectro.org>

The light sensor disable brightness key and
/sys/class/backlight/ control. There was a lot of report
from users who didn't understand why they couldn't change their
brightness, including:
* https://bugs.launchpad.net/bugs/222171
* https://bugzilla.novell.com/show_bug.cgi?id=3D514747
* http://bugzilla.kernel.org/show_bug.cgi?id=3D13671

Now the light sensor is disabled, and if the user want to enable
it, the level should be ok.

The funny thing is that comments where ok, not code.

Cc: stable@kernel.org
Cc: Thomas Renninger <trenn@suse.de>
Cc: Peter K=C3=BCppers <peter-mailbox@web.de>
Cc: Michael Franzl <michaelfranzl@gmx.at>
Cc: Ian Turner <vectro@vectro.org>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/=
asus-laptop.c
index b39d2bb..849359a 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1283,8 +1283,8 @@ static int asus_hotk_add(struct acpi_device *devi=
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
1.6.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
