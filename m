From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: acpi based pci gap calculation  - v3
Date: Tue, 15 Jul 2008 15:53:39 -0700
Message-ID: <200807151553.41403.jbarnes@virtuousgeek.org>
References: <1216148382.6135.21.camel@alok-dev1> <200807151328.00739.jbarnes@virtuousgeek.org> <1216155256.6135.25.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1216155256.6135.25.camel@alok-dev1>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: akataria@vmware.com
Cc: "ak@linux.intel.com" <ak@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, "Brown, Len" <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, TJ <linux@tjworld.net>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 15, 2008 1:54 pm Alok Kataria wrote:
> I have tested it with couple of different BIOS settings and it seems to
> work as it should.
>
> > Most of the PCI bugs we
> > have at the moment are related to PCI resource allocation failures.  My
> > hope is that finding more space will fix most of them.  Assuming this
> > patch doesn't have any dependencies, I can put it in my linux-next
> > branch.
>
> No dependencies, I had added a function e820_search_gap which is used by
> this patch. This function is already in the mainline tree.
> Thanks for applying.

Ok, I stuffed it in my linux-next branch.  I'll let it sit there for a day or 
so though, just to shake out any build problems etc. in linux-next before 
asking Linus to pull the whole lot.

Thanks,
Jesse
