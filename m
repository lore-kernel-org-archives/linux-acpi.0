From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Wed, 17 Feb 2010 17:43:50 -0200
Message-ID: <20100217194350.GA24180@khazad-dum.debian.net>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
 <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
 <20100216154053.GA31195@srcf.ucam.org>
 <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain>
 <20100217143245.GA18411@srcf.ucam.org>
 <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain>
 <20100217183108.GA23189@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48307 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750851Ab0BQTny (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Feb 2010 14:43:54 -0500
Content-Disposition: inline
In-Reply-To: <20100217183108.GA23189@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, rjw@sisk.pl

On Wed, 17 Feb 2010, Matthew Garrett wrote:
> On Wed, Feb 17, 2010 at 01:24:58PM -0500, Len Brown wrote:
> > On Wed, 17 Feb 2010, Matthew Garrett wrote:
> > > We seem to have no good history of where these blacklist entries came 
> > > from, and we know that at least one of them is actively harmful. Perhaps 
> > > replace them with a debug statement on affected machines telling people 
> > > what they need to pass to restore the blacklist behaviour, and to let us 
> > > know if it's necessary?
> > 
> > Actually, it wasn't actively harmful until we broke "acpi=ht".
> > Indeed, it was actively helpful in pointing out that regression:-)
> 
> The machines in question are falling back to apm, so probably losing 
> some level of powersaving support. I'd say that's harmful :)

Well, on ThinkPads you probably want APM on the older models, for better
power savings and less surprise when trying to suspend to RAM or to disk.

> > The other entries in today's acpi_dmi_table[] are less clear
> > and should probably be modified only with some care...
> 
> At least one of them covers a single submodel in a range, despite them 
> all running the same BIOS. I'd really lean towards them being bogus at 
> this stage of the game.

On that, we do agree.  That ThinkPad entry is completely bogus, I vote that
we remove it if we're not going to fix it to apply to every ThinkPad with
that BIOS.

OTOH, every mention of the A22 I find in the network is coupled with
"acpi=off", which matches what I know about the ThinkPads before the A31p,
X31 and R40e/T40: they tend to work a lot better in APM mode.

There are reports of some bizarre stuff, such as A22m laptops powering up by
themselves some time after shutdown if ACPI is used, etc.  I would suggest
an ACPI cut-off date of 2005 (disable ACPI on anything older than 2005) for
IBM ThinkPads, but this is going to shut down ACPI from people that never
updated their firmware on some models that might be able to do ACPI
properly.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
