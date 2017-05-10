From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] Revert "ACPI / button: Change default behavior to lid_init_state=open"
Date: Wed, 10 May 2017 18:12:40 +0200
Message-ID: <20170510161240.13229-3-benjamin.tissoires@redhat.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752929AbdEJQM4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 May 2017 12:12:56 -0400
In-Reply-To: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>
Cc: Jiri Eischmann <jeischma@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This reverts commit 77e9a4aa9de10cc1418bf9a892366988802a8025.

Even if the method implementation can be buggy on some platform,
the "open" choice is worse. It breaks docking stations basically
and there is no way to have a user-space hwdb to fix that.

On the contrary, it's rather easy in user-space to have a hwdb
with the problematic platforms. Then, libinput (1.7.0+) can fix
the state of the LID switch for us: you need to set the udev
property LIBINPUT_ATTR_LID_SWITCH_RELIABILITY to 'write_open'.

When libinput detects internal keyboard events, it will
overwrite the state of the switch to open, making it reliable
again. Given that logind only checks the LID switch value after
a timeout, we can assume the user will use the internal keyboard
before this timeout expires.

For example, such a hwdb entry is:

libinput:name:*Lid Switch*:dmi:*svnMicrosoftCorporation:pnSurface3:*
 LIBINPUT_ATTR_LID_SWITCH_RELIABILITY=write_open

Link: https://bugzilla.gnome.org/show_bug.cgi?id=782380
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/acpi/button.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 6d5a8c1..e19f530 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -113,7 +113,7 @@ struct acpi_button {
 
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
-static u8 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
+static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
 
 static unsigned long lid_report_interval __read_mostly = 500;
 module_param(lid_report_interval, ulong, 0644);
-- 
2.9.3

