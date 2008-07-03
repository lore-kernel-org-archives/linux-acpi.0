From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] cleanup e820_setup_gap v2
Date: Thu, 3 Jul 2008 15:00:35 +0200
Message-ID: <20080703130035.GA23060@elte.hu>
References: <1214333310.27577.26.camel@promb-2n-dhcp368.eng.vmware.com> <20080625160817.GC24967@elte.hu> <1214416962.27577.74.camel@promb-2n-dhcp368.eng.vmware.com> <86802c440806261101k78c5057id8ca0649188bd132@mail.gmail.com> <20080703125227.GA14082@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761551AbYGCNBV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080703125227.GA14082@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: akataria@vmware.com, "lenb@kernel.org" <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > > e820_search_gap also take a end_addr parameter to limit search 
> > > from start_addr to end_addr.
> > >
> > > Signed-off-by: AloK N Kataria <akataria@vmware.com>
> > 
> > Acked-by: Yinghai Lu <yhlu.kernel@gmail.com>
> 
> applied to tip/x86/unify-setup - thanks!

hm, it doesnt work too well:

  arch/x86/pci/acpi.c: In function 'search_gap':
  arch/x86/pci/acpi.c:130: error: too few arguments to function 'e820_search_gap'

was i supposed to revert:

| commit 2c0262493239814b06a8aaabd1cf09b2f8fa3519
| Author: Alok Kataria <akataria@vmware.com>
| Date:   Tue Jun 24 11:48:46 2008 -0700
|
|    acpi based pci gap caluculation v2

?

	Ingo
