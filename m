From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 01/32] apple-gmux: Stop using acpi_video_dmi_demote_vendor()
Date: Wed, 10 Jun 2015 15:01:01 +0200
Message-ID: <1433941292-21530-2-git-send-email-hdegoede@redhat.com>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

acpi_video_dmi_demote_vendor() is going away as part of the cleanup of
the code for determinging which backlight class driver(s) to register.

The call to acpi_video_dmi_demote_vendor() was meant to undo the call to
acpi_video_dmi_promote_vendor() when the gmux device is removed, this is
questionable though since the promote call sets a flag, not a counter, so
the demote call may undo a promoto done elsewhere. Moreover in practice
this is a nop since the gmux device is never removed, and the flag is only
checked when acpi/video.ko gets loaded, so even if the user manually
removes apple-gmux the demote call is still a nop as video.ko will already
have loaded by this time.

Also note that none of the other users of acpi_video_dmi_promote_vendor()
use acpi_video_dmi_demote_vendor().

If we ever encounter a system with a gmux where the acpi-video interface
should be used, then the proper fix would be to dmi-blacklist the gmux
driver on that system.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/apple-gmux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 45032ce..a7f6412 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -645,7 +645,6 @@ static void gmux_remove(struct pnp_dev *pnp)
 	apple_gmux_data = NULL;
 	kfree(gmux_data);
 
-	acpi_video_dmi_demote_vendor();
 	acpi_video_register();
 	apple_bl_register();
 }
-- 
2.4.2
