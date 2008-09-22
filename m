From: Holger Macht <hmacht@suse.de>
Subject: Re: [patch 4/11]makeing dock driver supports bay and battery
	hotplug
Date: Mon, 22 Sep 2008 12:58:08 +0200
Message-ID: <20080922105808.GC26633@homac.suse.de>
References: <1219889038.29375.29.camel@sli10-desk.sh.intel.com> <200809182116.58202.trenn@suse.de> <1222046694.7241.3.camel@sli10-desk.sh.intel.com> <200809221117.45245.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:54739 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbYIVK6Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 06:58:16 -0400
Content-Disposition: inline
In-Reply-To: <200809221117.45245.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

On Mon 22. Sep - 11:17:42, Thomas Renninger wrote:
> On Monday 22 September 2008 03:24:54 Shaohua Li wrote:
> > On Thu, 2008-09-18 at 13:16 -0600, Thomas Renninger wrote:
> > > On Thursday 18 September 2008 19:10:02 Thomas Renninger wrote:
> ...
> > > Above is still valid.
> >
> > No, this doesn't work. there isn't a acpi_device because battery is
> > absent when this is called, but I could add CID support.
> I don't know whether there are devices with battery ID in the CID list.
> With or without the workaround (rewriting cid checking) it's not perfect.
> 
> This is an issue I tried to solve years ago.
> Ignoring not present devices is wrong IMO.
> The whole current design destroys hotplug integration and results in more
> and more workarounds (acpi_memoryhotplug and container driver are nice 
> examples).
> One has to be careful that only _STA and no other functions are called, but 
> not present devices should still get registered in some way and somone (the 
> driver itself or maybe better the ACPI subsytem and introduce .notify driver 
> ops) should listen on Notify AML calls.
> Please tell me if someone looks at this again or has ideas/concerns. I always 
> wanted to and will at some point, but still don't have the time.
> 
> > > Some of the patches looked like it would be worth for .27, but it's too
> > > late now anyway and the problem I hoped it could fix (kacpid utilizes
> > > 100% of CPU after suspend, due to _STA -> notify loop) is not solved by
> > > these according to Holger.
> >
> > Yes, this patch set just fixed some bugs. Is there a bugzilla for this
> > issue I can look at?
> [Bug 401740] kacpi* eat a lot of cpu after s2disk
> https://bugzilla.novell.com/show_bug.cgi?id=401740

The patch series fixes this bug on the Dell D620 I have here. It's more an
design problem we are seeing here, of which I could not find the root
cause yet. The single fixup patches do not help. So maybe there is a
little chance that we still get this patchset in...

Regards,
	Holger
