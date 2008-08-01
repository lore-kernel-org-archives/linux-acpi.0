From: nokos@gmx.net
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 2
Date: Fri, 01 Aug 2008 10:25:30 +0200
Message-ID: <1217579130.25329.12.camel@earth.gruber.myown>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
	 <1217399377.23004.0.camel@hidalgo>  <200807301106.40521.trenn@suse.de>
	 <1217518335.12217.24.camel@earth.gruber.myown>
	 <1217554098.2969.152.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:51651 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868AbYHAI2a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2008 04:28:30 -0400
In-Reply-To: <1217554098.2969.152.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Jesse Barnes <jbarnes@virtuousgeek.org>

Am Freitag, den 01.08.2008, 09:28 +0800 schrieb Zhang Rui:
> On Thu, 2008-07-31 at 23:32 +0800, nokos@gmx.net wrote:
> > Hi Thomas
> > 
> > probably you might want to change in acpi_is_video_device:
> > 
> > --- video_detect.c 2008-07-31 17:20:59.540059897 +0200
> > +++ video_detect.c 2008-07-31 17:22:15.752034851 +0200
> > @@ -93,8 +93,10 @@
> >                 video_caps |= ACPI_VIDEO_IGD;
> >         }
> > 
> > -       acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle,
> > ACPI_UINT32_MAX,
> > +        if (video_caps) {
> > +               acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle,
> > ACPI_UINT32_MAX,
> >                             acpi_backlight_cap_match, &video_caps,
> > NULL);
> > +        }
> > 
> >         return video_caps;
> >  }
> No.
> For a video bus device, video_caps can never be 0 here.
> 

Exactly, but acpi_is_video_device is called for every possible device in
the system, so there are a lot of subtree scans for devices which are
definitely no video devices (in my case 100 devices get scanned and
about 400 checks for backlight_cap) which produce a lot of useless logs
with debug_level=0x1f. With the if (video_caps) the namespace wlking is
restricted to devices where there is a chance of being a video device. 

> > otherwise the whole ACPI namespace is scanned several times and this
> > restricts the scanning only on those subtrees where the head might be
> > a
> > video device
> > 
> > 
> > BTW. the DRDY detection (for IGD) works ... now I have to find the IGD
> > patches ... couldn't find them on the list and the version of
> > linux-next
> > I tried didn't contain anything which looked like it.
> You can get them here.
> http://cgit.freedesktop.org/mesa/drm/diff/?id=dfd441cf964f20e4a761cb8490d7cd82cf32e7b9

thanks
Peter

> don't know if this is the latest version, cc Matthew and Jessie.
> 
> thanks,
> rui
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

