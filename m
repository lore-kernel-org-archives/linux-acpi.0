From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Sun, 8 Mar 2009 14:34:31 +0100
Message-ID: <20090308143431.53487bd0@mjolnir.ossman.eu>
References: <20081108213414.579e178d@mjolnir.drzeus.cx>
	<20081108233337.GA21200@gamma.logic.tuwien.ac.at>
	<20081114222557.04025d36@mjolnir.drzeus.cx>
	<20081025214602.GB27030@gamma.logic.tuwien.ac.at>
	<20081108213414.579e178d@mjolnir.drzeus.cx>
	<20081108233337.GA21200@gamma.logic.tuwien.ac.at>
	<20090127004840.GA7246@gamma.logic.tuwien.ac.at>
	<20090202204027.006bb2e2@mjolnir.drzeus.cx>
	<20090202235754.GA13222@gamma.logic.tuwien.ac.at>
	<20090221134821.7540c39d@mjolnir.ossman.eu>
	<20090224234414.GC19062@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:44604 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbZCHNei (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Mar 2009 09:34:38 -0400
In-Reply-To: <20090224234414.GC19062@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Wed, 25 Feb 2009 00:44:14 +0100
Norbert Preining <preining@logic.at> wrote:

> On Sa, 21 Feb 2009, Pierre Ossman wrote:
> > 
> > Most likely. You can dump the PCI config using lspci -xxx. Compare the
> > data for everything on the Ricoh device (not just the MMC interface)
> > and see if you can see a difference before and after suspend.
> 
> No difference, unfortunately. Absolutely no difference. The normal lspci
> shows me:
> ...
> 0b:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ba)
> 0b:04.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (rev 04)
> 0b:04.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 21)
> 0b:04.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter (rev 11)
> 
> So I called
> 	lspci -xxx -s 0b:04
> before and after suspend (before and after working state) and there is
> no difference at all.
> 
> Anything else one can dump/do?
> 

Not that I can think of, no. The interrupt control for these chips have
always been hidden in PCI config space, so this must be something new.

At this point I don't think I'm of much more use. See if the ACPI or PM
people can help you figure out what differs between a normal boot and a
resume. Once we know that we can fix up some voodoo that makes it work
every time.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
