From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: acpi based pci gap calculation  - v3
Date: Tue, 15 Jul 2008 13:28:00 -0700
Message-ID: <200807151328.00739.jbarnes@virtuousgeek.org>
References: <1216148382.6135.21.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762830AbYGOU2g@vger.kernel.org>
In-Reply-To: <1216148382.6135.21.camel@alok-dev1>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: akataria@vmware.com
Cc: ak@linux.intel.com, Ingo Molnar <mingo@elte.hu>, "Brown, Len" <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, TJ <linux@tjworld.net>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 15, 2008 11:59 am Alok Kataria wrote:
> Hi Andi,
>
> I don't see this patch being applied in any of the tree yet.
> Resending this incase you guys might have missed it.
> I assume this will go through the ACPI tree.
>
> The need for this patch was explained in
> http://marc.info/?l=linux-kernel&m=121441818818598&w=2
>
> The v2 patch was discussed in
> http://marc.info/?l=linux-acpi&m=121433339619175&w=2
>
> I then sent a incremental patch on top of v2 to fix some conditions and
> handle the change in the e820_search_gap interface.
>
> In this v3 patch, i have folded the incremental fix into the v2 patch.
> Please apply this.

This should probably go to linux-pci too.

I wonder if this is stable enough to go into 2.6.27?  Most of the PCI bugs we 
have at the moment are related to PCI resource allocation failures.  My hope 
is that finding more space will fix most of them.  Assuming this patch 
doesn't have any dependencies, I can put it in my linux-next branch.

Also, TJ was working on something similar; any comments TJ?

Thanks,
Jesse
