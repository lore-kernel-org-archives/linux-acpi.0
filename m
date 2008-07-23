From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: acpi based pci gap calculation  - v3
Date: Wed, 23 Jul 2008 09:58:32 -0700
Message-ID: <200807230958.32898.jbarnes@virtuousgeek.org>
References: <1216148382.6135.21.camel@alok-dev1> <200807221450.52114.jbarnes@virtuousgeek.org> <1216767168.5693.31.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1216767168.5693.31.camel@alok-dev1>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: akataria@vmware.com
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Brown@vger.kernel.org, Len <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, TJ <linux@tjworld.net>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 22, 2008 3:52 pm Alok Kataria wrote:
> In the log that you sent me, please note the following debug messages
> -------
> E820_DEBUG: Searching for gap between (0x00000000 - 0x100000000)
> E820_DEBUG: Found gap starting at 0xbf000000 size 0x40f00000
> Allocating PCI resources starting at c0000000 (gap: bf000000:40f00000)
> -------
>
> This is the gap that was allocated by walking just the e820_map
>
> With my changes we query the _CRS resource and get following info
> ------
> ACPI_DEBUG start_addr 0xf8000000 gapsize 0x00400000 address_length
> 0x06b00000 end_addr is 0xfeb00000
> E820_DEBUG: Searching for gap between (0xf8000000 - 0xfeb00000)
> E820_DEBUG: Found gap at start starting at 0x100000000 size 0x07f00000
> ACPI_DEBUG start_addr 0xbf000000 gapsize 0x07f00000 address_length
> 0x31000000 end_addr is 0xf0000000
> E820_DEBUG: Searching for gap between (0xbf000000 - 0xf0000000)
> E820_DEBUG: Found gap starting at 0xbf000000 size 0x31000000
> ------
>
> So there are 2 producer regions one from [0xBF000000 - 0xF0000000] and
> another from [0xF8000000 - 0xFEB00000]. That means BIOS has reserved the
> area from [0xF0000000 - 0xF7FFFFFF] for some other resource.
> If you look a little below in the log there is this
>
> ----
> system 00:01: iomem range 0xf0000000-0xf7ffffff has been reserved
> ----
>
> So the gap that we had calculated first i.e. from e820_setup_gap did
> contain a collision i.e. though a resource was reserved from
> [0xf0000000 - 0xf7ffffff] our gap calculation doesn't take that into
> account.  My patch fixes this issue.
>
> So, IMHO this is a BUG and should be fixed. Please let me know your
> views.

Yes, there's a conflict there, but on many machines it's probably a harmless 
one.  My main concerns are these:
  1) it changes long standing behavior and doesn't fix any real reported bugs
     I'm aware of (feel free to point me at some)
  2) it looks like it will dramatically reduce the available PCI resource
     space on at least some platforms, and that space is already scarce in our
     current scheme

So basically, I'm just feeling very conservative about any changes to resource 
allocation, that's all.

If this change were coupled with one that allowed us to exploit more available 
address space for PCI resources I'd feel much more comfortable about it, 
which is why I'm so interested in TJ's work (/me goes off to read his wiki 
now).

Thanks,
Jesse
