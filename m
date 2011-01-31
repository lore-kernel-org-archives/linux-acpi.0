From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.38-rc2: acpi backlight control missing
Date: Mon, 31 Jan 2011 23:01:29 +0100
Message-ID: <201101312301.29434.rjw@sisk.pl>
References: <1295693349.2120.3.camel@localhost.localdomain> <201101312139.03634.rjw@sisk.pl> <DB7A733A-D21A-4134-B50F-121CE2C179D3@m3y3r.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55231 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069Ab1AaWB5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Jan 2011 17:01:57 -0500
In-Reply-To: <DB7A733A-D21A-4134-B50F-121CE2C179D3@m3y3r.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, January 31, 2011, Thomas Meyer wrote:
> Am 31.01.2011 um 21:39 schrieb "Rafael J. Wysocki" <rjw@sisk.pl>:
> 
> > On Friday, January 28, 2011, Thomas Meyer wrote:
> >> Am Samstag, den 22.01.2011, 20:43 +0100 schrieb Rafael J. Wysocki:
> >>> On Saturday, January 22, 2011, Thomas Meyer wrote:
> >>>> with 2.6.38-rc2 the acpi backlight is gone:
> >>>> 
> >>>> any ideas?
> >>> 
> >>> Not really, but Matthew may have some (CCed).
> >> 
> >> Okay, found the problem.
> >> 
> >> This commit broke my backlight:
> >> 
> >> commit 677bd810eedce61edf15452491781ff046b92edc
> >> Author: Zhang Rui <rui.zhang@intel.com>
> >> Date:   Mon Dec 6 15:04:21 2010 +0800
> >> 
> >>    ACPI video: remove output switching control
> >> 
> >> This is because in function
> >> "acpi_is_video_device()" (drivers/acpi/video_detect.c) the backlight
> >> device is only checked when some video capabilities were found, but by
> >> removing the check for the VIDEO_OUTPUT_SWITCHING (that seems to be the
> >> only video capability on my system) the check for the backlight device
> >> isn't done anymore.
> >> 
> >> by reverting above commit, the backlight is back again.
> > 
> > Is it the same issue as https://bugzilla.kernel.org/show_bug.cgi?id=27702 ?
> 
> Yes, it is.
> 
> > In case it is, can you test the patch in there, please?
> > 
> 
> Didn't test the patch. But it should do the trick.

Great, thanks!

Rafael
