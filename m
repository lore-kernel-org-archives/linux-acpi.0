From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v2 rebased] ACPI / video: Add systems that
 should favor native backlight interface
Date: Thu, 21 Nov 2013 13:29:09 +0800
Message-ID: <528D9A25.6040503@intel.com>
References: <1381498066-16011-1-git-send-email-aaron.lu@intel.com>	
	<2140073.U60XyxRqVZ@vostro.rjw.lan> <5268D6BB.3010207@intel.com>	
	<1382682925.3328.4.camel@ThinkPad-X230.localdomain>	
	<526DCFD7.7060002@intel.com> <87fvrl7r6g.fsf@intel.com>	
	<526F615D.2090602@intel.com> <5285BA38.6080804@intel.com>
	<1384980982.3487.3.camel@ThinkPad-X230.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1384980982.3487.3.camel@ThinkPad-X230.localdomain>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Cc: James Hogan <james@albanarts.com>, Mike Galbraith <bitbucket@online.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <matthew.garrett@nebula.com>, linux-acpi@vger.kernel.org, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, Martin Steigerwald <Martin@lichtvoll.de>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?UTF-8?B?SsO2cmcgT3R0ZQ==?= <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Kevin Smith <thirdwiggin@gmail.com>, Peter Weber <bugs@ttyhoney.com>, Joerg Platte <jplatte@naasa.net>, Seth Forshee <seth.forshee@canonical.com>, Lennart Poettering <lennart@poettering.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Theodore Tso <tytso@mit.edu>, "Rafael J. Wysocki" <rjw@rjwysock>
List-Id: linux-acpi@vger.kernel.org

On 11/21/2013 04:56 AM, Igor Gnatenko wrote:
> Any news here? If no - I think we need re-send patch as new..

Since the v2 patch can't apply cleanly on top of pm's -next tree, I
think it's worth a re-send, so here it comes.

---
Subject: [PATCH] ACPI / video: Add systems that should favor native backlight
 interface
From: Aaron Lu <aaron.lu@intel.com>
Date: Thu, 21 Nov 2013 11:24:48 +0800

Some system's ACPI video backlight control interface is broken and the
native backlight control interface should be used by default. This patch
sets the use_native_backlight parameter to true for those systems so
that video backlight control interface will not be created. To be
specific, the ThinkPad T430s/X230, Lenovo Yoga 13, Dell Inspiron 7520
and Acer Aspire 5733Z are added here, if they appear in some other DMI
table before, they are removed from there.

Note that the user specified kernel cmdline option will always have the
highest priority, i.e. if use_native_backlight=0 is specified and the
system is in the DMI table, the video module will not skip registering
backlight interface for it.

Thinkpad T430s:
Reported-by: Theodore Tso <tytso@mit.edu>
Reported-and-tested-by: Peter Weber <bugs@ttyhoney.com>
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=51231
Thinkpad X230:
Reported-and-tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=51231
Lenovo Yoga 13:
Reported-by: Lennart Poettering <lennart@poettering.net>
Reported-and-tested-by: Kevin Smith <thirdwiggin@gmail.com>
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=63811
Dell Inspiron 7520:
Reported-by: Rinat Ibragimov <ibragimovrinat@mail.ru>
Acer Aspire 5733Z:
Reported-by: <sov.info@mail.ru>
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=62941

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/blacklist.c    |  8 ------
 drivers/acpi/video.c        | 65 +++++++++++++++++++++++++++++++++++++++++----
 drivers/acpi/video_detect.c |  8 ------
 3 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 078c4f7fe2dd..2b6a76b6d59a 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -261,14 +261,6 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{
 	.callback = dmi_disable_osi_win8,
-	.ident = "Dell Inspiron 15R SE",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7520"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
 	.ident = "ThinkPad Edge E530",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 995e91bcb97b..7dc6071a04b6 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -82,11 +82,12 @@ static bool allow_duplicates;
 module_param(allow_duplicates, bool, 0644);
 
 /*
- * For Windows 8 systems: if set ture and the GPU driver has
- * registered a backlight interface, skip registering ACPI video's.
+ * For Windows 8 systems: used to decide if video module
+ * should skip registering backlight interface of its own.
  */
-static bool use_native_backlight = false;
-module_param(use_native_backlight, bool, 0644);
+static int use_native_backlight_param = -1;
+module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
+static bool use_native_backlight_dmi = false;
 
 static int register_count;
 static struct mutex video_list_lock;
@@ -232,9 +233,17 @@ static int acpi_video_get_next_level(struct acpi_video_device *device,
 static int acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
 
+static bool acpi_video_use_native_backlight(void)
+{
+	if (use_native_backlight_param != -1)
+		return use_native_backlight_param;
+	else
+		return use_native_backlight_dmi;
+}
+
 static bool acpi_video_verify_backlight_support(void)
 {
-	if (acpi_osi_is_win8() && use_native_backlight &&
+	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
 	    backlight_device_registered(BACKLIGHT_RAW))
 		return false;
 	return acpi_video_backlight_support();
@@ -399,6 +408,12 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init video_set_use_native_backlight(const struct dmi_system_id *d)
+{
+	use_native_backlight_dmi = true;
+	return 0;
+}
+
 static struct dmi_system_id video_dmi_table[] __initdata = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
@@ -443,6 +458,46 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720"),
 		},
 	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad T430s",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430s"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad X230",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "Lenovo Yoga 13",
+	 .matches = {
+		 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		 DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo IdeaPad Yoga 13"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "Dell Inspiron 7520",
+	 .matches = {
+		 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		 DMI_MATCH(DMI_PRODUCT_VERSION, "Inspiron 7520"),
+		},
+	},
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "Acer Aspire 5733Z",
+	 .matches = {
+		 DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		 DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5733Z"),
+		},
+	},
 	{}
 };
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 84875fd4c74f..b6399343de51 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -168,14 +168,6 @@ static struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
 		},
 	},
-	{
-	.callback = video_detect_force_vendor,
-	.ident = "Lenovo Yoga 13",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo IdeaPad Yoga 13"),
-		},
-	},
 	{ },
 };
 
-- 
1.8.3.1
