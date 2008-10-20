From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param
	and dmi list to force rsdt
Date: Mon, 20 Oct 2008 16:05:15 -0200
Message-ID: <20081020180515.GI18277@khazad-dum.debian.net>
References: <200810192350.57993.trenn@suse.de> <20081020010142.GB32675@srcf.ucam.org> <200810201843.10507.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47975 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752084AbYJTSFV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2008 14:05:21 -0400
Content-Disposition: inline
In-Reply-To: <200810201843.10507.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Mon, 20 Oct 2008, Thomas Renninger wrote:
> On Monday 20 October 2008 03:01:42 Matthew Garrett wrote:
> > On Sun, Oct 19, 2008 at 11:50:55PM +0200, Thomas Renninger wrote:
> > > Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
> > >
> > > References: http://bugzilla.kernel.org/show_bug.cgi?id=8246
> > >
> > > Blacklist R40e, R51e and T40, T40p, T41, T41p, T42, T42p, R50 and R50p
> > > ThinkPads to use the RSDT instead of the XSDT.
> >
> > I'm very sceptical about this. All of these machines were released years
> > before Vista, which makes me unsure about the diagnosis that this is
> > something to do with Vista readyness.
> 
> I sent you a link to BIOS updates where the last changelog entry stated VISTA 
> support. Hmm, I double checked R40e and R50e and there is nothing about VISTA 
> support.
> Nevertheless, this would mean the addresses used by Linux are not supported.

Correct.  They're not, and latent ACPI BIOS bugs make this painful for Linux
(and probably would cause trouble for a modern Windows if you even could
install it on those boxes).

So, it might well be that issues don't show up on Windows in the R40e and
R50e because it is an *OLD* version of Windows that just plain doesn't touch
the broken stuff, AFAIK.  Heck, I am not sure if the R40e even can run XP,
let alone Vista...

> XP uses the 32 bit adresses. Vista the 64 bit adresses.

Don't touch 64bit addresses on ACPI BIOSes that are too old to support Vista
is about the only heuristic I can imagine that would work, here.  But that's
likely going to cover too many machines that didn't need the quirk.

> Could you please point to a specific problem you have with the patches, these 
> are safe, tested and verified fixes.

Well, *I* don't have a problem with them now that you removed the T4x/R51
from the DMI list.  BTW: it could very well be that the T4x/R51 needs to be
in there, but it should be tested directly, as they use a different BIOS.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
