From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3] acpi: mv models with win8 brightness problems from win8 blacklist to use_native_backlight
Date: Mon, 14 Jul 2014 14:37:09 +0200
Message-ID: <1405341429-549-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37908 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843AbaGNMhT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2014 08:37:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

When the windows8 related backlight problems became evident, 2 approaches
were follow in parallel, one was to stop claiming to be windows 8 / 2012,
the other was to tell acpi_video to stop registering a backlight driver.

I've read all the threads and it seems that which approach ended up being
applied to which model laptop was never really a concious decision (AFAIK):

https://bugzilla.kernel.org/show_bug.cgi?id=51231
https://bugzilla.kernel.org/show_bug.cgi?id=60682

So lets move all the models which are only on the win8 blacklist because of
brightness issues to the use_native_backlight list, which is the smaller
hammer to use to solve the backlight issues.

Making this change is esp. attractive now that 3.16 has
video.use_native_brightness=1 by default. If that new default does not get
reverted because of regressions, then we can drop all the models
with a use_native_backlight quirk, greatly reducing the number of models we've
a quirk for.

Note: this is not tested on any of the affected models, this just seems like
the sensible thing to do.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--

Changes in v2: Rebased on top of v3.16-rc1
Changes in v3: The Dell Inspiron 7737 does not have a dmi_disable_osi_win8
quirk because of backlight reasons, but for other reasons, keep the quirk.
---
 drivers/acpi/blacklist.c | 68 ++----------------------------------------------
 drivers/acpi/video.c     | 68 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 3d8413d..36eb42e 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -247,75 +247,11 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 
 	/*
-	 * The following machines have broken backlight support when reporting
-	 * the Windows 2012 OSI, so disable it until their support is fixed.
+	 * These machines will power on immediately after shutdown when
+	 * reporting the Windows 2012 OSI.
 	 */
 	{
 	.callback = dmi_disable_osi_win8,
-	.ident = "ASUS Zenbook Prime UX31A",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad Edge E530",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad Edge E530",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad Edge E530",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Acer Aspire V5-573G",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Acer Aspire V5-572G",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad T431s",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "ThinkPad T430",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
 	.ident = "Dell Inspiron 7737",
 	.matches = {
 		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index e38c3b3..6194054 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -460,6 +460,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad X230",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
 	 .ident = "ThinkPad T430 and T430s",
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -468,10 +476,42 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	},
 	{
 	 .callback = video_set_use_native_backlight,
-	 .ident = "ThinkPad X230",
+	 .ident = "ThinkPad T430",
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad T431s",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad Edge E530",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad Edge E530",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad Edge E530",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
 		},
 	},
 	{
@@ -563,6 +603,30 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		},
 	},
 	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "Acer Aspire V5-572G",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "Acer Aspire V5-573G",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ASUS Zenbook Prime UX31A",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
+		},
+	},
+	{
 	.callback = video_set_use_native_backlight,
 	.ident = "HP ProBook 4340s",
 	.matches = {
-- 
2.0.0

