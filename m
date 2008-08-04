From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Mon, 4 Aug 2008 15:30:17 +0200
Message-ID: <20080804133017.GC2383@corsac.net>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <200808041220.29892.trenn@suse.de> <20080804103929.GC28887@corsac.net> <200808041319.44362.trenn@suse.de> <20080804132450.GA3703@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:59512 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbYHDNaU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Aug 2008 09:30:20 -0400
Content-Disposition: inline
In-Reply-To: <20080804132450.GA3703@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Mon, Aug 04, 2008 at 02:24:50PM +0100, Matthew Garrett wrote:
> On Mon, Aug 04, 2008 at 01:19:42PM +0200, Thomas Renninger wrote:
> 
> > I just tried to find them in the tree that I thought Matthew stated that they 
> > are queued their in the master branch:
> > git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> 
> It got dropped after the vblank IRQ rewrite code got merged. I'll have 
> it remerged today.

Hmhm so I should cherry-pick those patches (when merged) from drm-2.6 to
linux-acpi-2.6/test plus the previously attached patch from Thomas?

Cheers,
-- 
Yves-Alexis
