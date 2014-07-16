From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend] acpi-video: Add use_native_backlight quirk for HP ProBook 4540s
Date: Wed, 16 Jul 2014 13:28:34 +0200
Message-ID: <1405510114-13437-2-git-send-email-hdegoede@redhat.com>
References: <1405510114-13437-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36857 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932961AbaGPL2k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 07:28:40 -0400
In-Reply-To: <1405510114-13437-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org

As reported here:
https://bugzilla.redhat.com/show_bug.cgi?id=1025690
This is yet another model which needs this quirk.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 2fb589e..3a4a3ef 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -656,6 +656,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	.callback = video_set_use_native_backlight,
+	.ident = "HP ProBook 4540s",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "HP ProBook 4540s"),
+		},
+	},
+	{
+	.callback = video_set_use_native_backlight,
 	.ident = "HP ProBook 2013 models",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-- 
2.0.0

