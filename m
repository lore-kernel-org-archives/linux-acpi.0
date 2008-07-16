From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
Date: Wed, 16 Jul 2008 12:00:32 +0930 (CST)
Message-ID: <200807160230.m6G2UWKj001807@turbo.physics.adelaide.edu.au>
References: <1216174369.1617.169.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:57958 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751382AbYGPCbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2008 22:31:09 -0400
In-Reply-To: <1216174369.1617.169.camel@rzhang-dt> from "Zhang Rui" at Jul 16, 2008 10:12:49 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, nokos@gmx.net, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

> > > Perhaps there is a way to disable the dysfunctional backlight stuff in 
> > > video.ko but retain the ACPI video event handling?!
> > 
> > The problem with doing this is that it's only the platform-specific drivers
> > which have the knowledge as to whether this is necessary or not.  video.ko
> > would therefore have to query each loaded platform-specific module which
> > seems messy to me.  If video.ko was loaded before the relevant
> > platform-specific module it gets even messier.  I guess we could add a
> > video.ko function like acpi_video_backlight_disable() which platform modules
> > could call if they choose to handle the backlight.  However, this seems
> > suboptimal to since it means video.ko sets up a backlight interface only to
> > have to tear it down again soon after.  I guess it's no worse than setting
> > up a backlight interface which never gets used though.
> > 
> > The fundamental problem as I see at this point it is that the new
> > acpi_video_backlight_support() function returns true on Fujitsu S-series
> > laptops because the ACPI environment looks "right" from video.ko's point of
> > view.  However, it's clear that the desired registers/methods - although
> > present - are completely non-functional in these laptops so in reality
> > video.ko cannot handle the backlight in this case.  Unless video.ko
> > hooks into the Fujitsu-specific registers (which defeats the modularity of
> > hardware-specific modules) this won't change.
> 
> IMO, In this case, we should add a dmi check in video_detect.c and set
> acpi_backlight=vendor for this laptop, both before acpi video and
> fujitsu laptop driver is loaded.

That could work.  Keeping in mind that I'm yet to test the S7020 against
this patch though, what if it turns out that this problem affects most
Fujitsu laptops?  One wouldn't want dozens of model-specific checks in
video_detect.c, but I guess it may be possible to come up with a
sufficiently general DMI check that matched all such laptops.

Regards
  jonathan
