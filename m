From: nokos@gmx.net
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
Date: Wed, 16 Jul 2008 16:12:20 +0200
Message-ID: <1216217540.15766.2.camel@earth.gruber.myown>
References: <200807152355.m6FNtMO7026981@turbo.physics.adelaide.edu.au>
	 <1216174369.1617.169.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:34383 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753491AbYGPOM2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 10:12:28 -0400
In-Reply-To: <1216174369.1617.169.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: nokos@gmx.net, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

Am Mittwoch, den 16.07.2008, 10:12 +0800 schrieb Zhang Rui:
> On Wed, 2008-07-16 at 09:25 +0930, Jonathan Woithe wrote:
> > > > It is likely that everything works out with video.ko then.
> > > > If not, with a patch I sent recently you should switch off Windows osi strings 
> > > > with:
> > > > acpi_osi=windows_false   (preferred)
> > > > or (already works)
> > > > acpi_osi="!Windows 2006"
> > > 
> > > disabling windows_osi disables backlight through video.ko and everything
> > > works fine with fujitsu_laptop (also brightness-buttons since ACPI then
> > > generates events on the fujitsu device) but some other ACPI stuff is
> > > disabled too (extended battery status etc...)
> > 
> > As per my previous email, the fact that this works is probably because in
> > this instance acpi_video_backlight_support() returns false and allows
> > fujitsu-laptop to set up its backlight control functions.
> 
> Peter,
> can you attach the acpidump output please?
> you can use the latest pmtools at
> http://www.lesswatts.org/patches/linux_acpi/

already in http://bugzilla.kernel.org/show_bug.cgi?id=10454



