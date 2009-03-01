From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 9/9] [sony-laptop] add Sony Vaio VGN-SR19 support
Date: Sun,  1 Mar 2009 13:40:45 +0900
Message-ID: <1235882445-2404-10-git-send-email-malattia@linux.it>
References: <1235882445-2404-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48645
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373AbZCAEuS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2009 23:50:18 -0500
In-Reply-To: <1235882445-2404-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Wolfram Strepp <wstrepp@gmx.de>, Mattia Dongili <malattia@linux.it>

From: Wolfram Strepp <wstrepp@gmx.de>

I have a Sony Vaio VGN-SR19XN, running with Debian Lenny,
and i had a problem with some function keys: Backlight Up/Down
(Fn-F5/F6), Hibernate (Fn-F12), and some others, were not working.
I have described the problem in detail here (at the bottom):
https://bugs.launchpad.net/ubuntu/+source/acpi-support/+bug/251665

Signed-off-by: Wolfram Strepp <wstrepp@gmx.de>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 021c9d2..f0db14f 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -921,6 +921,15 @@ static const struct dmi_system_id sony_nc_ids[] = {
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-Z"),
 			},
 		},
+		{
+			.ident = "Sony Vaio SR Series",
+			.callback = sony_SNC_enable_cb,
+			.driver_data = sony_SNC_events,
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR"),
+			},
+		},
 		{ }
 };
 
-- 
1.6.1.3

