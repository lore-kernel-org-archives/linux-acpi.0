From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree II
Date: Thu, 30 Mar 2006 23:25:22 +0900
Message-ID: <20060330232522.f9259d93.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060322030208.30e3581e.akpm@osdl.org>
	<20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com>
	<20060322192134.GA44212@muc.de>
	<20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com>
	<20060323000759.GB71469@muc.de>
	<20060323093609.8eb03249.kamezawa.hiroyu@jp.fujitsu.com>
	<20060323024306.GA90581@muc.de>
	<20060323125942.2facb79b.kamezawa.hiroyu@jp.fujitsu.com>
	<20060330134133.GB80060@muc.de>
	<20060330225459.c2c53dbe.kamezawa.hiroyu@jp.fujitsu.com>
	<20060330141811.GA84501@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10975 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932227AbWC3O00 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Mar 2006 09:26:26 -0500
In-Reply-To: <20060330141811.GA84501@muc.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com

On 30 Mar 2006 16:18:11 +0200
Andi Kleen <ak@muc.de> wrote:

> On Thu, Mar 30, 2006 at 10:54:59PM +0900, KAMEZAWA Hiroyuki wrote:
> > On 30 Mar 2006 15:41:33 +0200
> > Andi Kleen <ak@muc.de> wrote:
> > 
> > > 
> > > Hi,
> > > 
> > > I started to implement your suggestion now.
> > > 
> > > But one problem I noticed and I don't see how the current sparsemem code
> > > handles correctly is that it makes no attempt to handle hotadd
> > > areas that cross zone boundaries. Is there code somewhere that rejects
> > > them?
> > > 
> > 
> > add_memory() selects a zone which pages are added, before adding memory regardless
> > of its address. Now this is hard-coded.
> > 
> > ia64 adds memory to NORMAL.
> > i386 adds memory to HIGHMEM.
> > x86_64 adds memory to NORMAL.
> 
> Yes but what stops ACPI from trying to add memory that crosses 
> a zone? (e.g. from 2GB to 6GB) 
> 
2GB to 6GB pages are all added to NORMAL, not DMA32. (2.6.16)
If this is not sane, x86_64's add_memory should have to check address of start/end.



> > 
> > if x86_64 people wants to add memory to DMA32 or some other zone, please add code.
> 
> I added a check for it in the reserve hotadd code now.
> 
great. I'll look into x86_64's add_memory() (with CONFIG_MEMORY_HOTPLUG=y) 
and fix it if I can.

Thanks,
- Kame


