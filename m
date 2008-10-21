From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 16:01:55 +0200
Message-ID: <200810211601.56527.rjw@sisk.pl>
References: <200810192350.57993.trenn@suse.de> <20081021130836.GA28154@srcf.ucam.org> <200810211534.44226.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53452 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbYJUN5q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 09:57:46 -0400
In-Reply-To: <200810211534.44226.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tuesday, 21 of October 2008, Thomas Renninger wrote:
> On Tuesday 21 October 2008 15:08:36 Matthew Garrett wrote:
> > On Tue, Oct 21, 2008 at 03:05:33PM +0200, Thomas Renninger wrote:
> > > Even if this is not proven, the patchset should still go in to get the
> > > machines fixed for now and to easily test others, there was enough
> > > discussion around it.
> >
> > What do you mean, "fixed"? They all already work, even if it's in a
> > suboptimal way.
> 
> If C-states don't work and do work with a patch. I call the patch a fix.
> I also call the machine broken (even if it does boot) before and fixed 
> afterwards.

If not a fix, this certainly is improvement.

> I also call a machine broken which takes minutes to boot and fixed as soon as 
> the problem is solved and the machine is booting in a reasonable amount of 
> time.

I haven't followed the discussion closely, but IMO it's better to have the
machines in a usable state right now than wait for a "real fix" forever.

Moreover, as soon as the real fix is developed we can remove the DMI list.
Quite frankly, I don't see any downsides.

Thanks,
Rafael
