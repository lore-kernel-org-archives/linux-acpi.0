From: Ingo Molnar <mingo@elte.hu>
Subject: Re: today's linux-next fails to boot
Date: Sat, 12 Jul 2008 06:47:07 +0200
Message-ID: <20080712044707.GA6675@elte.hu>
References: <4877400B.1000400@gmail.com> <20080711190749.GB21758@elte.hu> <200807112306.39455.rjw@sisk.pl> <200807120250.16459.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200807120250.16459.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, =?iso-8859-1?B?VPZy9ms=?= Edwin <edwintorok@gmail.com>, linux-next@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Vegard Nossum <vegard.nossum@gmail.com>, Andreas Herrmann <andreas.herrmann3@amd.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Hi Ingo,
> 
> On Friday, 11 of July 2008, Rafael J. Wysocki wrote:
> > On Friday, 11 of July 2008, Ingo Molnar wrote:
> > > 
> > > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> [--snip--]
> > 
> > Well, it turns out that linux-next from today doesn't boot on my box too
> > (64-bit) and I don't see anything obviously suspicious.  Bisection time.
> 
> I have identified the source of the breakage on my box, but I don't 
> really think it's the same problem that Edwin is observing.
> 
> Namely, it turns out that some code in arch/x86/kernel/acpi/boot.c, as 
> in today's linux-next, doesn't really make sense, because we have two 
> conflicting DMA-based quirks in there for the same set of boxes (HP 
> nx6325 and nx6125) and one of them actually breaks my box.
> 
> I have reported that already, but it probably got lost somewhere.
> 
> Below is a patch that fixes things for me, on top of today's 
> linux-next. Please apply.

thanks Rafael, i have applied your fix to tip/x86/core and to 
auto-x86-next as well.

what happened is a case of too many fixes for the same problem :-/

	Ingo
