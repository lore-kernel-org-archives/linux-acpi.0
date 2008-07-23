From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: acpi based pci gap calculation  - v3
Date: Wed, 23 Jul 2008 10:52:22 -0700
Message-ID: <200807231052.22806.jbarnes@virtuousgeek.org>
References: <1216148382.6135.21.camel@alok-dev1> <200807230958.32898.jbarnes@virtuousgeek.org> <1216833034.6354.12.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1216833034.6354.12.camel@alok-dev1>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: akataria@vmware.com
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Len <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, TJ <linux@tjworld.net>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, July 23, 2008 10:10 am Alok Kataria wrote:
> Hi Jesse,
>
> On Wed, 2008-07-23 at 09:58 -0700, Jesse Barnes wrote:
> > On Tuesday, July 22, 2008 3:52 pm Alok Kataria wrote:
> > > So the gap that we had calculated first i.e. from e820_setup_gap did
> > > contain a collision i.e. though a resource was reserved from
> > > [0xf0000000 - 0xf7ffffff] our gap calculation doesn't take that into
> > > account.  My patch fixes this issue.
> > >
> > > So, IMHO this is a BUG and should be fixed. Please let me know your
> > > views.
> >
> > Yes, there's a conflict there, but on many machines it's probably a
> > harmless one.  My main concerns are these:
> >   1) it changes long standing behavior and doesn't fix any real reported
> > bugs I'm aware of (feel free to point me at some)
>
> The problem that I see is with Memory Hotadd, though my BIOS exports the
> correct SRAT table and tells the OS that some regions are hot pluggable,
> PCI gap calculation ignores that info and assigns some "option ROMS" in
> hot pluggable memory region.
>
> Because of this when i try to hot add memory, the OS sees a resource
> allocation conflict and bails out. Which shouldn't have happened,
> right ?

Ah ok, so you've got a real problem here.  And I don't deny that there's a 
conflict that we should fix.

> >   2) it looks like it will dramatically reduce the available PCI resource
> >      space on at least some platforms, and that space is already scarce
> > in our current scheme
>
> IMO, these gaps are used only for the option ROMS or hot pluggable
> devices which in itself are rare. So its not like we are reducing the
> whole available PCI resource space, but only the space that is needed by
> these optional ROMS.
> And i think its inevitable if we have to remove these conflicts with any
> other subsystem.

Actually we have other allocations.  In many cases the BIOS won't assign MMIO 
resources, so we do it at boot time.  Most of the open PCI bugs we have today 
are resource allocation failures, and not just for ROMs, so hopefully you can 
understand my worry.  Using all available gaps rather than just the largest 
seems like the obvious first step to increasing our available space, and 
would give us more leeway to avoid stomping on other reserved space.

Jesse
