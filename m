From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / video: clean up DMI table for initial black screen
 problem
Date: Fri, 15 Nov 2013 11:24:37 +0800
Message-ID: <528593F5.2010901@intel.com>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>				<52818C87.8080606@intel.com>			 <CAJ=jqubGRRYuKF2yFsGYniKu5=PotL6OR3KYjhhz-Zsx5wT+iA@mail.gmail.com>			 <5282DEEE.1040804@intel.com> <1384429833.4103.23.camel@oberon.sagui.org>		 <52856DFE.3000003@intel.com> <1384478234.9557.1.camel@oberon.sagui.org>	 <5285798C.70506@intel.com> <1384479197.9557.3.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41610 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928Ab3KODXt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Nov 2013 22:23:49 -0500
In-Reply-To: <1384479197.9557.3.camel@oberon.sagui.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Gustavo Maciel Dias Vieira <gustavo@sagui.org>, Alex Hung <alex.hung@canonical.com>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

With commit 2c62333a408f "ACPI / video: Quirk initial backlight level 0"
we do not need to have the following systems in DMI table, so remove them.
HP Pavilion m4, HP 1000 Notebook PC, HP Pavilion g6 Notebook PC,
HP Pavilion dm4, Fujitsu E753, HP Folio 13-2000.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Alex Hung <alex.hung@canonical.com> # for HP 1000 Notebook PC
Tested-by: Gustavo Maciel Dias Vieira <gustavo@sagui.org> # for HP Pavilion dm4
---
Though I don't have test done for other models, their ACPI tables suggest
they have the same problem that should already be quirked by commit
2c62333a408f "ACPI / video: Quirk initial backlight level 0".

 drivers/acpi/video.c | 48 ------------------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 18dbdff4656e..4ccb89e5c4ad 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -456,54 +456,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720"),
 		},
 	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP Folio 13-2000",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13 - 2000 Notebook PC"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "Fujitsu E753",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "FUJITSU"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E753"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP Pavilion dm4",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dm4 Notebook PC"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP Pavilion g6 Notebook PC",
-	 .matches = {
-		 DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		 DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion g6 Notebook PC"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP 1000 Notebook PC",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP 1000 Notebook PC"),
-		},
-	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP Pavilion m4",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion m4 Notebook PC"),
-		},
-	},
 	{}
 };
 
-- 
1.8.3.1
