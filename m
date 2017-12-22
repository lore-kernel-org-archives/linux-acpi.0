From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / video: Default lcd_only to true on Win8 ready and newer machines
Date: Fri, 22 Dec 2017 13:34:37 +0100
Message-ID: <20171222123437.9421-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdLVMek (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Dec 2017 07:34:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

We're seeing a lot of bogus backlight interfaces on newer machines without
a LCD such as desktops, servers and HDMI sticks. This causes userspace to
show a non-functional brightness slider in e.g. the GNOME3 system menu,
which is undesirable. More in general we should simply just not register
a non functional backlight interface.

Checking the lcd flag causes the bogus acpi_video backlight interfaces to
go away (on the machines this was tested on).

This commit enables the lcd_only option by default on any machines which
are win8 ready, fixing this.

This is not entirely without risk of regressions, but video_detect.c
already prefers native-backlight interfaces over the acpi_video one
on win8 ready machines, calling acpi_video_unregister_backlight() as soon
as a native interface shows up. This is done because the acpi backlight
interface often is broken on win8 ready machines, because win8 does not
seem to actually use it.

So in practice we already end up not registering the acpi backlight
interface on (most) win8 ready machines with a LCD panel, thus this commit
does not change anything for (most) machines with a LCD panel and on
machines without a LCD panel we actually don't want to register any
backlight interfaces.

This has been tested on the following machines and fixes a bogus backlight
interface showing up there:
-Desktop with an Asrock B150M Pro4S/D3 m.b. using i5-6500 builtin gfx
-Intel Compute Stick STK1AW32SC
-Meegopad T08 HDMI stick

Bogus backlight interfaces have also been reported on:
-Desktop with Asus H87I-Plus m.b.
-Desktop with ASRock B75M-ITX m.b.
-Desktop with Gigabyte Z87-D3HP m.b.
-Dell PowerEdge T20 desktop

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1097436
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1133327
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1133329
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1133646
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0972ec0e2eb8..a83239507041 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -80,8 +80,8 @@ MODULE_PARM_DESC(report_key_events,
 static bool device_id_scheme = false;
 module_param(device_id_scheme, bool, 0444);
 
-static bool only_lcd = false;
-module_param(only_lcd, bool, 0444);
+static int only_lcd = -1;
+module_param(only_lcd, int, 0444);
 
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
@@ -2136,6 +2136,16 @@ int acpi_video_register(void)
 		goto leave;
 	}
 
+	/*
+	 * We're seeing a lot of bogus backlight interfaces on newer machines
+	 * without a LCD such as desktops, servers and HDMI sticks. Checking
+	 * the lcd flag fixes this, so enable this on any machines which are
+	 * win8 ready (where we also prefer the native backlight driver, so
+	 * normally the acpi_video code should not register there anyways).
+	 */
+	if (only_lcd == -1)
+		only_lcd = acpi_osi_is_win8() ? 1 : 0;
+
 	dmi_check_system(video_dmi_table);
 
 	ret = acpi_bus_register_driver(&acpi_video_bus);
-- 
2.14.3

