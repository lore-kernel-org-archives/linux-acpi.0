From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 17:27:55 +0200
Message-ID: <200807161727.57026.trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <20080716124703.GA376@srcf.ucam.org> <20080716133839.GB3329@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42373 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbYGPP2A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 11:28:00 -0400
In-Reply-To: <20080716133839.GB3329@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Wednesday 16 July 2008 15:38:39 Henrique de Moraes Holschuh wrote:
> On Wed, 16 Jul 2008, Matthew Garrett wrote:
> > On Wed, Jul 16, 2008 at 09:40:44AM -0300, Henrique de Moraes Holschuh 
wrote:
> > > One question: is there a good reason to actually have the hotkey
> > > handling for IGD mode directly in thinkpad-acpi?  We don't do it for
> > > Vista BIOS, video.ko doesn't do it either (anymore)... and I would make
> > > it configurable for IBM firmware if I could.
> >
> > No. There's no reason to have IGD handling in thinkpad-acpi at all.
I haven't seen the video driver on a T61 with Intel card doing proper 
backlight switching on the correct device yet.

> Then please leave that part out of the final patch.  It will make the
> patch a LOT simpler (no need to muck with anything hotkey_*).
Ok. Attached.

> But the observation about extending brightness_mode to
> force-select/unselect igdmode stands anyway.
Ok, that's fair enough.

I wonder whether we still need the BCL queries in thinkpad_acpi.c?
Shouldn't (at least in theory) all ThinkPads with generic backlight
functions work with video.ko now?

Maybe now it's a bit too soon, but getting rid of these functions would
be a nice cleanup.

Below one is compile tested...

        Thomas

----
thinkpad_acpi: fingers off backlight if video.ko is serving this functionality

Signed-off-by: Thomas Renninger <trenn@suse.de>

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index b596929..50da049 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -4750,17 +4750,26 @@ static int __init brightness_init(struct 
ibm_init_struct *iibm)
 	 */
 	b = tpacpi_check_std_acpi_brightness_support();
 	if (b > 0) {
-		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
-			printk(TPACPI_NOTICE
-			       "Lenovo BIOS switched to ACPI backlight "
-			       "control mode\n");
-		}
-		if (brightness_enable > 1) {
-			printk(TPACPI_NOTICE
-			       "standard ACPI backlight interface "
-			       "available, not loading native one...\n");
-			return 1;
-		}
+
+		if (acpi_video_backlight_support()) {
+			if (brightness_enable > 1) {
+				printk(TPACPI_NOTICE
+				       "Standard ACPI backlight interface "
+				       "available, not loading native one.\n");
+				return 1;
+			} else if (brightness_enable == 1) {
+				printk(TPACPI_NOTICE
+				       "Backlight control force, even standard "
+				       "ACPI backlight interface available\n");
+			}
+		} else {
+			if (brightness_enable > 1) {
+				printk(TPACPI_NOTICE
+				       "Standard ACPI backlight interface not "
+				       "available, thinkpad_acpi driver "
+				       "will take over control\n");
+			}
+ 		}
 	}
 
 	if (!brightness_enable) {
