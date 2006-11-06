From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: acpiphp makes noise on every lid close/open
Date: Mon, 6 Nov 2006 17:47:44 -0200
Message-ID: <20061106194744.GA12458@khazad-dum.debian.net>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061106132903.GA25257@khazad-dum.debian.net> <20061106191351.GA1642@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34486 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752745AbWKFTrv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Nov 2006 14:47:51 -0500
Content-Disposition: inline
In-Reply-To: <20061106191351.GA1642@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Seyfried <seife@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Mon, 06 Nov 2006, Stefan Seyfried wrote:
> On Mon, Nov 06, 2006 at 11:29:03AM -0200, Henrique de Moraes Holschuh wrote:
> > > > > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > > > > it has no hotpluggable slots.
> > 
> > What about the internal mini PCI express slots (where the Intel 3945ABG
> > device and EVDO wwwan cards are plugged)?
> 
> These are not in the media bay. I'd also guess that they are not
> hotpluggable.

They are hotplug buses.  But the buses themselves are always there (and not
hotplugged. i.e. the bus doesn't appear and disappear).  Whether they should
be bothering acpiphp, I don't know.  

You have a lot of buses that support hotplugging in the X60, and at least
one is certainly exported to the dock unless IBM/Lenovo changed completely
the way they make docks, which I very much doubt.  That was the information
I was trying to convey.   As I said, I don't know if *these* buses should be
bothering acpiphp or not.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
