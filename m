From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param
	and dmi list to force rsdt
Date: Tue, 21 Oct 2008 13:46:15 -0200
Message-ID: <20081021154615.GA21989@khazad-dum.debian.net>
References: <200810192350.57993.trenn@suse.de> <200810211625.47889.rjw@sisk.pl> <20081021142956.GA29837@srcf.ucam.org> <200810211710.32384.rjw@sisk.pl> <20081021152755.GA30633@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60007 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753927AbYJUPqY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 11:46:24 -0400
Content-Disposition: inline
In-Reply-To: <20081021152755.GA30633@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, 21 Oct 2008, Matthew Garrett wrote:
> Right, but in this case we understand the root cause of the problem - we 
> behave differently to Windows in a very specific way. What we don't 
> understand are the precise circumstances in which Windows behaves that 
> way. It could be that Vista always uses the 64-bit addresses if 
> available, and in that case this is the best possible solution. But it 
> could also be that Vista swaps addresses based on whether _INI requests 
> the Vista OSI or not. It could be that Vista uses the 32-bit addresses 
> on 32-bit CPUs. Or where the addresses differ and there's a valid 32-bit 
> entry, perhaps they use that. When there's a simple test to perform, we 
> should do that before adding a static list.
> 
> > > See the number of people who reported that acpi_apic_instance made a
> > > difference, or even the fact that Thomas included a bunch of systems with no
> > > real assurance that they were hit by this.
> > 
> > Hm, this is not a good thing.  Is there any reliable way to verify that?
> 
> We can verify whether the addresses are actually different, but it's 
> possible that that's harmless on some machines. However, history 
> suggests that there's a placebo effect in adding boot options...

This is all nice and true, HOWEVER apparently all of us lack the hardware
and lab setup to perform the testing.   And I haven't seen anyone publish
clear instructions we could ask a Vista user to do, either.

So, can we please commit these patches, with the T4x BIOSes removed from the
DMI list already?  We already know the R40e and R50e are borked, we have a
patch that fixes them *cleanly* and completely safely (no side-effects on
any other box).  There is no excuse not to apply it since we do NOT have
anything better on hand, NOR are we going to be able to produce better
patches anytime soon.

If someone manages to set up a lab to do testing, or manages to ask someone
else who has deep knowledge of how Microsoft made Vista behave on border
conditions, he can send us better information, and a general solution can be
deployed and the band-aid DMI table, removed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
