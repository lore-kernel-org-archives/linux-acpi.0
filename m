From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Fri, 22 Oct 2010 11:10:01 -0600
Message-ID: <201010221110.01582.bjorn.helgaas@hp.com>
References: <20101021201916.9220.5711.stgit@bob.kio> <1287716220.2862.57.camel@yhuang-dev> <1287717372.8722.954.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:9190 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab0JVRLW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2010 13:11:22 -0400
In-Reply-To: <1287717372.8722.954.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Myron Stowe <myron.stowe@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>

On Thursday, October 21, 2010 09:16:12 pm Shaohua Li wrote:
> On Fri, 2010-10-22 at 10:57 +0800, Huang, Ying wrote:
> > On Fri, 2010-10-22 at 10:43 +0800, Li, Shaohua wrote:
> > > On Fri, 2010-10-22 at 04:23 +0800, Myron Stowe wrote:
> > > > ACPI's system event related IRQ handing accesses specific fixed
> > > > hardware registers; namely PM1a event, PM1b event, GPE0, and GPE1
> > > > which are declared in the FADT.  If these registers are backed by
> > > > MMIO, as opposed to I/O port space, accessing them within interrupt
> > > > context will incur a panic since acpi_read() and acpi_write() end up
> > > > calling ioremap(), which may block to allocate memory - BZ 18012.
> > > since you just access several bytes mmio in interrupt context, can't you
> > > use kmap_atomic_pfn() here?
> > 
> > On x86_64, kmap_atomic_pfn() is defined as kmap_atomic(), which requires
> > struct page for the physical address. But the MMIO address may have no
> > struct page.

I really like this idea because we could get rid of the list and
all the RCU stuff, but I don't see how to make it work yet.

On ia64 (which also uses ACPI), kmap_atomic_pfn() also requires
a struct page.  An ia64-specific version that doesn't need a struct
page would be trivial, but I still don't know how to make it work on
x86_64.

> ok, can we add a new entry in fix map and the entry is dedicated for
> mmio mapping? The ioremap list looks like a hack.

Fixmap is arch-specific and there's no ia64 implementation, so I
don't think we can use it here.

Bjorn
