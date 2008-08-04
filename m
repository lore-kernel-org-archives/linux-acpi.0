From: Thomas Renninger <trenn@suse.de>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPIdrivers - version 4
Date: Mon, 4 Aug 2008 15:40:04 +0200
Message-ID: <200808041540.06023.trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <20080804132450.GA3703@srcf.ucam.org> <20080804133017.GC2383@corsac.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44853 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbYHDNkJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Aug 2008 09:40:09 -0400
In-Reply-To: <20080804133017.GC2383@corsac.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Monday 04 August 2008 15:30:17 Yves-Alexis Perez wrote:
> On Mon, Aug 04, 2008 at 02:24:50PM +0100, Matthew Garrett wrote:
> > On Mon, Aug 04, 2008 at 01:19:42PM +0200, Thomas Renninger wrote:
> > > I just tried to find them in the tree that I thought Matthew stated
> > > that they are queued their in the master branch:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> >
> > It got dropped after the vblank IRQ rewrite code got merged. I'll have
> > it remerged today.
>
> Hmhm so I should cherry-pick those patches (when merged) from drm-2.6 to
> linux-acpi-2.6/test plus the previously attached patch from Thomas?

Best just try Matthews, together with mine which went into Andi's test tree 
(version 4).
The additional patch I sent today is only needed if Matthew's does not work 
for you and you want to try acpi_backlight=vendor on an IGD ThinkPad device.

But instead of trying the additional one, we should find out why Matthew's 
things do not work (hopefully they do work). You already correctly stated: 
video.ko is the way to go for your machine.
When say in -rc5 you still have problems, the additional one can be 
tested/added, so that all the rest does not need to be reverted and we do not 
get regressions in 2.6.27.

       Thomas
