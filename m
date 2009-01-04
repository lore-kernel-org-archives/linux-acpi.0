From: nokos@gmx.net
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Add BL power, LED control and
Date: Sun, 04 Jan 2009 17:30:45 +0100
Message-ID: <1231086645.2512.9.camel@earth.gruber.myown>
References: <200901032237.n03MbfOf018915@mercury.physics.adelaide.edu.au>
	 <495FED5A.5090102@linx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:54351 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962AbZADQa4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jan 2009 11:30:56 -0500
In-Reply-To: <495FED5A.5090102@linx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony@linx.net
Cc: Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Hi


Am Samstag, den 03.01.2009, 22:57 +0000 schrieb Tony Vroon:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Peter Gruber wrote:
> > Tested it on the S6410, and works as expected
> 
> On the subject of the S6410 (and S6420, which I have), I believe I can
> simplify the backlight handling a *LOT*. Peter, to confirm that, could

On the subject of removing stuff I think we can definitely remove the
BLNF checking stuff (since the "empty table signature support" is in the
acpi-implementation of the kernel for some time now)


Peter

diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
index a7dd3e9..7839367 100644
--- a/drivers/misc/fujitsu-laptop.c
+++ b/drivers/misc/fujitsu-laptop.c
@@ -438,8 +438,6 @@ static void dmi_check_cb_common(const struct dmi_system_id *id)
        int have_blnf;
        printk(KERN_INFO "fujitsu-laptop: Identified laptop model '%s'.\n",
               id->ident);
-       have_blnf = ACPI_SUCCESS
-           (acpi_get_handle(NULL, "\\_SB.PCI0.GFX0.LCD.BLNF", &handle));
        if (use_alt_lcd_levels == -1) {
                vdbg_printk(FUJLAPTOP_DBG_TRACE, "auto-detecting usealt\n");
                use_alt_lcd_levels = 1;
@@ -447,12 +445,12 @@ static void dmi_check_cb_common(const struct dmi_system_id *id)
        if (disable_brightness_keys == -1) {
                vdbg_printk(FUJLAPTOP_DBG_TRACE,
                            "auto-detecting disable_keys\n");
-               disable_brightness_keys = have_blnf ? 1 : 0;
+               disable_brightness_keys = 1;
        }
        if (disable_brightness_adjust == -1) {
                vdbg_printk(FUJLAPTOP_DBG_TRACE,
                            "auto-detecting disable_adjust\n");
-               disable_brightness_adjust = have_blnf ? 0 : 1;
+               disable_brightness_adjust = 0;
        }
 }
 



