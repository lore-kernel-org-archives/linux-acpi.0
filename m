From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 5/5] acpi_video: Don't handle ACPI brightness notifications by default
Date: Thu,  7 Mar 2013 13:39:40 -0600
Message-ID: <1362685180-7768-5-git-send-email-seth.forshee@canonical.com>
References: <20130307193812.GD24233@thinkpad-t410>
 <1362685180-7768-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49304 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab3CGTjz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Mar 2013 14:39:55 -0500
In-Reply-To: <1362685180-7768-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Seth Forshee <seth.forshee@canonical.com>

Windows 8 requires all backlight interfaces to report 101 brightness
values, and as a result we're starting to see machines with that many
brightness levels in _BCL. For machines which send these notifications
when the brightness up/down keys are pressed this means a lot of key
presses to get any kind of noticeable change in brightness.

For a while now we've had the ability to disable in-kernel handling of
notifications via the video.brightness_switch_enabled parameter. Change
this to default to off, and let userspace choose more reasonable
increments for changing the brightness.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/acpi/video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 6a19bf7..431b22e 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -69,7 +69,7 @@ MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
-static bool brightness_switch_enabled = 1;
+static bool brightness_switch_enabled = 0;
 module_param(brightness_switch_enabled, bool, 0644);
 
 /*
-- 
1.7.9.5

