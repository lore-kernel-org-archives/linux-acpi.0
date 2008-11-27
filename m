From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/11] ACPI: delete OSI(Linux) DMI dmesg spam
Date: Thu, 27 Nov 2008 02:25:15 -0500
Message-ID: <a6e0887f21bbab337ee32d9c0a84d7c0b6e9141b.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbYK0HZe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAZ002BODYD532A@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:26 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Linux will continue to ignore OSI(Linux),
except for a white-list containing a few systems.

So delete the black-list,
and stop soliciting user-feedback on the console.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |  401 +---------------------------------------------
 drivers/acpi/osl.c       |  104 +++---------
 2 files changed, 30 insertions(+), 475 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index ea92bac..09c6980 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -176,16 +176,6 @@ static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
 	acpi_dmi_osi_linux(1, d);	/* enable */
 	return 0;
 }
-static int __init dmi_disable_osi_linux(const struct dmi_system_id *d)
-{
-	acpi_dmi_osi_linux(0, d);	/* disable */
-	return 0;
-}
-static int __init dmi_unknown_osi_linux(const struct dmi_system_id *d)
-{
-	acpi_dmi_osi_linux(-1, d);	/* unknown */
-	return 0;
-}
 static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
 {
 	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
@@ -193,295 +183,21 @@ static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
 	return 0;
 }
 
-/*
- * Most BIOS that invoke OSI(Linux) do nothing with it.
- * But some cause Linux to break.
- * Only a couple use it to make Linux run better.
- *
- * Thus, Linux should continue to disable OSI(Linux) by default,
- * should continue to discourage BIOS writers from using it, and
- * should whitelist the few existing systems that require it.
- *
- * If it appears clear a vendor isn't using OSI(Linux)
- * for anything constructive, blacklist them by name to disable
- * unnecessary dmesg warnings on all of their products.
- */
-
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
-	/*
-	 * Disable OSI(Linux) warnings on all "Acer, inc."
-	 *
-	 * _OSI(Linux) disables the latest Windows BIOS code:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 3100"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5050"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5580"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 3010"),
-	 * _OSI(Linux) effect unknown:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Ferrari 5000"),
-	 */
-	/*
-	 * note that dmi_check_system() uses strstr()
-	 * to match sub-strings rather than !strcmp(),
-	 * so "Acer" below matches "Acer, inc." above.
-	 */
-	/*
-	 * Disable OSI(Linux) warnings on all "Acer"
-	 *
-	 * _OSI(Linux) effect unknown:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720Z"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5520"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 6460"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 7510"),
-	 *
-	 * _OSI(Linux) is a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5315"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Extensa 5220"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Acer",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "Apple Computer, Inc."
-	 * Disable OSI(Linux) warnings on all "Apple Inc."
-	 *
-	 * _OSI(Linux) confirmed to be a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBook1,1"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBook2,1"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro2,2"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro3,1"),
-	 * _OSI(Linux) effect unknown:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacPro2,1"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro1,1"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Apple",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Apple"),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "BenQ"
-	 *
-	 * _OSI(Linux) confirmed to be a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Joybook S31"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "BenQ",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "BenQ"),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "Clevo Co."
-	 *
-	 * _OSI(Linux) confirmed to be a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "M570RU"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Clevo",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Clevo Co."),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "COMPAL"
-	 *
-	 * _OSI(Linux) confirmed to be a NOP:
-	 * DMI_MATCH(DMI_BOARD_NAME, "HEL8X"),
-	 * _OSI(Linux) unknown effect:
-	 * DMI_MATCH(DMI_BOARD_NAME, "IFL91"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Compal",
-	.matches = {
-		     DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
-		},
-	},
-	{ /* OSI(Linux) touches USB, unknown side-effect */
-	.callback = dmi_disable_osi_linux,
-	.ident = "Dell Dimension 5150",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Dell DM051"),
-		},
-	},
-	{ /* OSI(Linux) is a NOP */
-	.callback = dmi_disable_osi_linux,
-	.ident = "Dell i1501",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1501"),
-		},
-	},
-	{ /* OSI(Linux) effect unknown */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell Latitude D830",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D830"),
-		},
-	},
-	{ /* OSI(Linux) effect unknown */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell OptiPlex GX620",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex GX620"),
-		},
-	},
-	{ /* OSI(Linux) causes some USB initialization to not run */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell OptiPlex 755",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 755"),
-		},
-	},
-	{ /* OSI(Linux) effect unknown */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell PE 1900",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1900"),
-		},
-	},
-	{ /* OSI(Linux) is a NOP */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell PE 1950",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1950"),
-		},
-	},
-	{ /* OSI(Linux) is a NOP */
-	.callback = dmi_disable_osi_linux,
-	.ident = "Dell PE R200",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R200"),
-		},
-	},
-	{ /* OSI(Linux) touches USB */
-	.callback = dmi_disable_osi_linux,
-	.ident = "Dell PR 390",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 390"),
-		},
-	},
-	{ /* OSI(Linux) touches USB */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell PR 390",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 690"),
-		},
-	},
-	{ /* OSI(Linux) unknown - ASL looks benign, but may effect dock/SMM */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell PR M4300",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision M4300"),
-		},
-	},
-	{ /* OSI(Linux) is a NOP */
-	.callback = dmi_disable_osi_linux,
-	.ident = "Dell Vostro 1000",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Vostro   1000"),
-		},
-	},
-	{ /* OSI(Linux) effect unknown */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell PE SC440",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge SC440"),
-		},
-	},
-	{ /* OSI(Linux) effect unknown */
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Dialogue Flybook V5",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dialogue Technology Corporation"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Flybook V5"),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "FUJITSU SIEMENS"
-	 *
-	 * _OSI(Linux) disables latest Windows BIOS code:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pa 2510"),
-	 * _OSI(Linux) confirmed to be a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pi 1536"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pi 1556"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Xi 1546"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
-	 * _OSI(Linux) unknown effect:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Amilo M1425"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Amilo Si 1520"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Fujitsu Siemens",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-		},
-	},
 	{
 	.callback = dmi_disable_osi_vista,
 	.ident = "Fujitsu Siemens",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-	 	     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
 		},
 	},
+
 	/*
-	 * Disable OSI(Linux) warnings on all "Hewlett-Packard"
-	 *
-	 * _OSI(Linux) confirmed to be a NOP:
-	 * .ident = "HP Pavilion tx 1000"
-	 * DMI_MATCH(DMI_BOARD_NAME, "30BF"),
-	 * .ident = "HP Pavilion dv2000"
-	 * DMI_MATCH(DMI_BOARD_NAME, "30B5"),
-	 * .ident = "HP Pavilion dv5000",
-	 * DMI_MATCH(DMI_BOARD_NAME, "30A7"),
-	 * .ident = "HP Pavilion dv6300 30BC",
-	 * DMI_MATCH(DMI_BOARD_NAME, "30BC"),
-	 * .ident = "HP Pavilion dv6000",
-	 * DMI_MATCH(DMI_BOARD_NAME, "30B7"),
-	 * DMI_MATCH(DMI_BOARD_NAME, "30B8"),
-	 * .ident = "HP Pavilion dv9000",
-	 * DMI_MATCH(DMI_BOARD_NAME, "30B9"),
-	 * .ident = "HP Pavilion dv9500",
-	 * DMI_MATCH(DMI_BOARD_NAME, "30CB"),
-	 * .ident = "HP/Compaq Presario C500",
-	 * DMI_MATCH(DMI_BOARD_NAME, "30C6"),
-	 * .ident = "HP/Compaq Presario F500",
-	 * DMI_MATCH(DMI_BOARD_NAME, "30D3"),
-	 * _OSI(Linux) unknown effect:
-	 * .ident = "HP Pavilion dv6500",
-	 * DMI_MATCH(DMI_BOARD_NAME, "30D0"),
+	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
+	 * Linux ignores it, except for the machines enumerated below.
 	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Hewlett-Packard",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		},
-	},
+
 	/*
 	 * Lenovo has a mix of systems OSI(Linux) situations
 	 * and thus we can not wildcard the vendor.
@@ -519,113 +235,6 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 		},
 	},
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Lenovo 3000 V100",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "LENOVO3000 V100"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Lenovo 3000 N100",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "LG Electronics"
-	 *
-	 * _OSI(Linux) confirmed to be a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "P1-J150B"),
-	 * with DMI_MATCH(DMI_BOARD_NAME, "ROCKY"),
-	 *
-	 * unknown:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "S1-MDGDG"),
-	 * with DMI_MATCH(DMI_BOARD_NAME, "ROCKY"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "LG",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
-		},
-	},
-	/* NEC - OSI(Linux) effect unknown */
-	{
-	.callback = dmi_unknown_osi_linux,
-	.ident = "NEC VERSA M360",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "NEC Computers SAS"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "NEC VERSA M360"),
-		},
-	},
-	/* Panasonic */
-	{
-	.callback = dmi_unknown_osi_linux,
-	.ident = "Panasonic",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
-			/* Toughbook CF-52 */
-		     DMI_MATCH(DMI_PRODUCT_NAME, "CF-52CCABVBG"),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "Samsung Electronics"
-	 *
-	 * OSI(Linux) disables PNP0C32 and other BIOS code for Windows:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "R40P/R41P"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "R59P/R60P/R61P"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Samsung",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "Sony Corporation"
-	 *
-	 * _OSI(Linux) is a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NR11S_S"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ38GP_C"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ650N"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-TZ21MN_N"),
-	 * _OSI(Linux) unknown effect:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ11M"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Sony",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-		},
-	},
-	/*
-	 * Disable OSI(Linux) warnings on all "TOSHIBA"
-	 *
-	 * _OSI(Linux) breaks sound (bugzilla 7787):
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P100"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P105"),
-	 * _OSI(Linux) is a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A100"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A210"),
-	 * _OSI(Linux) unknown effect:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A135"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A200"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P205"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U305"),
-	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Toshiba",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		},
-	},
 	{}
 };
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 4be2521..c811142 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -35,7 +35,6 @@
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
-#include <linux/dmi.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
 #include <linux/acpi.h>
@@ -97,54 +96,44 @@ static DEFINE_SPINLOCK(acpi_res_lock);
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
 
 /*
- * "Ode to _OSI(Linux)"
+ * The story of _OSI(Linux)
  *
- * osi_linux -- Control response to BIOS _OSI(Linux) query.
+ * From pre-history through Linux-2.6.22,
+ * Linux responded TRUE upon a BIOS OSI(Linux) query.
  *
- * As Linux evolves, the features that it supports change.
- * So an OSI string such as "Linux" is not specific enough
- * to be useful across multiple versions of Linux.  It
- * doesn't identify any particular feature, interface,
- * or even any particular version of Linux...
+ * Unfortunately, reference BIOS writers got wind of this
+ * and put OSI(Linux) in their example code, quickly exposing
+ * this string as ill-conceived and opening the door to
+ * an un-bounded number of BIOS incompatibilities.
  *
- * Unfortunately, Linux-2.6.22 and earlier responded "yes"
- * to a BIOS _OSI(Linux) query.  When
- * a reference mobile BIOS started using it, its use
- * started to spread to many vendor platforms.
- * As it is not supportable, we need to halt that spread.
+ * For example, OSI(Linux) was used on resume to re-POST a
+ * video card on one system, because Linux at that time
+ * could not do a speedy restore in its native driver.
+ * But then upon gaining quick native restore capability,
+ * Linux has no way to tell the BIOS to skip the time-consuming
+ * POST -- putting Linux at a permanent performance disadvantage.
+ * On another system, the BIOS writer used OSI(Linux)
+ * to infer native OS support for IPMI!  On other systems,
+ * OSI(Linux) simply got in the way of Linux claiming to
+ * be compatible with other operating systems, exposing
+ * BIOS issues such as skipped device initialization.
  *
- * Today, most BIOS references to _OSI(Linux) are noise --
- * they have no functional effect and are just dead code
- * carried over from the reference BIOS.
- *
- * The next most common case is that _OSI(Linux) harms Linux,
- * usually by causing the BIOS to follow paths that are
- * not tested during Windows validation.
- *
- * Finally, there is a short list of platforms
- * where OSI(Linux) benefits Linux.
- *
- * In Linux-2.6.23, OSI(Linux) is first disabled by default.
- * DMI is used to disable the dmesg warning about OSI(Linux)
- * on platforms where it is known to have no effect.
- * But a dmesg warning remains for systems where
- * we do not know if OSI(Linux) is good or bad for the system.
- * DMI is also used to enable OSI(Linux) for the machines
- * that are known to need it.
+ * So "Linux" turned out to be a really poor chose of
+ * OSI string, and from Linux-2.6.23 onward we respond FALSE.
  *
  * BIOS writers should NOT query _OSI(Linux) on future systems.
- * It will be ignored by default, and to get Linux to
- * not ignore it will require a kernel source update to
- * add a DMI entry, or a boot-time "acpi_osi=Linux" invocation.
+ * Linux will complain on the console when it sees it, and return FALSE.
+ * To get Linux to return TRUE for your system  will require
+ * a kernel source update to add a DMI entry,
+ * or boot with "acpi_osi=Linux"
  */
-#define OSI_LINUX_ENABLE 0
 
 static struct osi_linux {
 	unsigned int	enable:1;
 	unsigned int	dmi:1;
 	unsigned int	cmdline:1;
 	unsigned int	known:1;
-} osi_linux = { OSI_LINUX_ENABLE, 0, 0, 0};
+} osi_linux = { 0, 0, 0, 0};
 
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
@@ -1296,34 +1285,6 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 	return (AE_OK);
 }
 
-/**
- *	acpi_dmi_dump - dump DMI slots needed for blacklist entry
- *
- *	Returns 0 on success
- */
-static int acpi_dmi_dump(void)
-{
-
-	if (!dmi_available)
-		return -1;
-
-	printk(KERN_NOTICE PREFIX "DMI System Vendor: %s\n",
-		dmi_get_system_info(DMI_SYS_VENDOR));
-	printk(KERN_NOTICE PREFIX "DMI Product Name: %s\n",
-		dmi_get_system_info(DMI_PRODUCT_NAME));
-	printk(KERN_NOTICE PREFIX "DMI Product Version: %s\n",
-		dmi_get_system_info(DMI_PRODUCT_VERSION));
-	printk(KERN_NOTICE PREFIX "DMI Board Name: %s\n",
-		dmi_get_system_info(DMI_BOARD_NAME));
-	printk(KERN_NOTICE PREFIX "DMI BIOS Vendor: %s\n",
-		dmi_get_system_info(DMI_BIOS_VENDOR));
-	printk(KERN_NOTICE PREFIX "DMI BIOS Date: %s\n",
-		dmi_get_system_info(DMI_BIOS_DATE));
-
-	return 0;
-}
-
-
 /******************************************************************************
  *
  * FUNCTION:    acpi_os_validate_interface
@@ -1350,21 +1311,6 @@ acpi_os_validate_interface (char *interface)
 			osi_linux.cmdline ? " via cmdline" :
 			osi_linux.dmi ? " via DMI" : "");
 
-		if (!osi_linux.dmi) {
-			if (acpi_dmi_dump())
-				printk(KERN_NOTICE PREFIX
-					"[please extract dmidecode output]\n");
-			printk(KERN_NOTICE PREFIX
-				"Please send DMI info above to "
-				"linux-acpi@vger.kernel.org\n");
-		}
-		if (!osi_linux.known && !osi_linux.cmdline) {
-			printk(KERN_NOTICE PREFIX
-				"If \"acpi_osi=%sLinux\" works better, "
-				"please notify linux-acpi@vger.kernel.org\n",
-				osi_linux.enable ? "!" : "");
-		}
-
 		if (osi_linux.enable)
 			return AE_OK;
 	}
-- 
1.5.6.5

