From: nokos@gmx.net
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 2
Date: Fri, 01 Aug 2008 11:29:58 +0200
Message-ID: <1217582998.25329.22.camel@earth.gruber.myown>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
	 <1217399377.23004.0.camel@hidalgo>  <200807301106.40521.trenn@suse.de>
	 <1217518335.12217.24.camel@earth.gruber.myown>
	 <1217554098.2969.152.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:39339 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751747AbYHAJc6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2008 05:32:58 -0400
In-Reply-To: <1217554098.2969.152.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Jesse Barnes <jbarnes@virtuousgeek.org>

Am Freitag, den 01.08.2008, 09:28 +0800 schrieb Zhang Rui:
> > 
> > BTW. the DRDY detection (for IGD) works ... now I have to find the IGD
> > patches ... couldn't find them on the list and the version of
> > linux-next
> > I tried didn't contain anything which looked like it.
> You can get them here.
> http://cgit.freedesktop.org/mesa/drm/diff/?id=dfd441cf964f20e4a761cb8490d7cd82cf32e7b9
> 
> don't know if this is the latest version, cc Matthew and Jessie.

I tried, but was quite entirely unsuccessful in applying the patch to a
recent linux-next so for now the only solution for me is (since Thomas
patch disables a functional fujitsu-laptop backlight control in favor of
a non-functional acpi_video backlight control) to blacklist:

--- video_detect.c      2008-07-31 17:20:59.540059897 +0200
+++ video_detect.c      2008-08-01 10:42:06.817046615 +0200
@@ -157,6 +159,11 @@ long acpi_video_get_capabilities(acpi_ha
                 *              ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
                 *}
                 */
+               if (dmi_name_in_vendors("FUJITSUSIEMENS") && 
+                                dmi_name_in_vendors("LIFEBOOKS6410")) {
+                       acpi_video_support |=
+                               ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
+               }
        } else {
                status = acpi_bus_get_device(graphics_handle, &tmp_dev);
                if (ACPI_FAILURE(status)) {


Peter


