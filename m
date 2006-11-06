From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: acpiphp makes noise on every lid close/open
Date: Mon, 6 Nov 2006 11:29:03 -0200
Message-ID: <20061106132903.GA25257@khazad-dum.debian.net>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753082AbWKFN3K@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061106092117.GB2175@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> > > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > > it has no hotpluggable slots.

What about the internal mini PCI express slots (where the Intel 3945ABG
device and EVDO wwwan cards are plugged)?

Also, ThinkWiki lists this machine as one that has a CardBus slot.  A photo
I found also shows this cardbus slot, left side near palm rest, right above
a SD card slot.  According to Lenovo, it appears that this cardbus slot is
also a 34mm express card slot, which would account for a PCIe x1 hotplug bus
and a USB2 hotplug bus in addition to the PCI (pccard) hotplug bus.

And it is extremely likely that this notebook exposes either PCI or PCIe
lanes to the dock station.  Whether they implemented PCIe or PCI slots in
the dock is another story, of course...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
