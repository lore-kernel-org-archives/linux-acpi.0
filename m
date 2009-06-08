From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: [PATCH] sony-laptop: no need to unblock rfkill on load
Date: Mon, 08 Jun 2009 11:31:11 +0100
Message-ID: <4A2CE86F.9040209@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The re-written rfkill core ensures rfkill devices are initialized to
the system default state.  The core calls set_block after registration
so the driver shouldn't need to.

Signed-off-by: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
---

This patch applies on top of the rfkill rewrite in the wireless-testing tree.

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index aec0b27..c1b21a4 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1114,7 +1114,6 @@ static int sony_nc_setup_rfkill(struct acpi_device *device,
 		return err;
 	}
 	sony_rfkill_devices[nc_type] = rfk;
-	sony_nc_rfkill_set((void *)nc_type, false);
 	return err;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
