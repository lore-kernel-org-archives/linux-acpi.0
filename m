From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko
	is serving this functionality
Date: Wed, 16 Jul 2008 17:49:44 +0200
Message-ID: <20080716154944.GB21956@corsac.net>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <20080716124703.GA376@srcf.ucam.org> <20080716133839.GB3329@khazad-dum.debian.net> <200807161727.57026.trenn@suse.de> <20080716152938.GA8676@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:34531 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbYGPPts (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 11:49:48 -0400
Content-Disposition: inline
In-Reply-To: <20080716152938.GA8676@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Wed, Jul 16, 2008 at 04:29:39PM +0100, Matthew Garrett wrote:
> On Wed, Jul 16, 2008 at 05:27:55PM +0200, Thomas Renninger wrote:
> > On Wednesday 16 July 2008 15:38:39 Henrique de Moraes Holschuh wrote:
> > > On Wed, 16 Jul 2008, Matthew Garrett wrote:
> > > > On Wed, Jul 16, 2008 at 09:40:44AM -0300, Henrique de Moraes Holschuh 
> > wrote:
> > > > > One question: is there a good reason to actually have the hotkey
> > > > > handling for IGD mode directly in thinkpad-acpi?  We don't do it for
> > > > > Vista BIOS, video.ko doesn't do it either (anymore)... and I would make
> > > > > it configurable for IBM firmware if I could.
> > > >
> > > > No. There's no reason to have IGD handling in thinkpad-acpi at all.
> > I haven't seen the video driver on a T61 with Intel card doing proper 
> > backlight switching on the correct device yet.
> 
> The patch is queued and will be in 2.6.27. It's fine.

Does this mean that linux-next + the 2 generic patches + (fixed)
thinkpad-acpi one would be enough to test?

Cheers,
-- 
Yves-Alexis
