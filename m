From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Mon, 4 Aug 2008 15:47:11 +0200
Message-ID: <20080804134711.GD2383@corsac.net>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <20080804132450.GA3703@srcf.ucam.org> <20080804133017.GC2383@corsac.net> <200808041540.06023.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:56485 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbYHDNrN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Aug 2008 09:47:13 -0400
Content-Disposition: inline
In-Reply-To: <200808041540.06023.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

> > Hmhm so I should cherry-pick those patches (when merged) from drm-2.6 to
> > linux-acpi-2.6/test plus the previously attached patch from Thomas?
> 
> Best just try Matthews, together with mine which went into Andi's test tree 
> (version 4).
> The additional patch I sent today is only needed if Matthew's does not work 
> for you and you want to try acpi_backlight=vendor on an IGD ThinkPad device.

Ok so I'll cherry pick Matthew's patches, test and report back tonight.

> When say in -rc5 you still have problems, the additional one can be 
> tested/added, so that all the rest does not need to be reverted and we do not 
> get regressions in 2.6.27.


Hmh but linux-acpi-2.6/test is meant to be merged mainline for 2.6.27?

Cheers,
-- 
Yves-Alexis
