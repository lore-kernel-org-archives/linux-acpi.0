From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Fri, 22 Oct 2010 10:57:00 +0800
Message-ID: <1287716220.2862.57.camel@yhuang-dev>
References: <20101021201916.9220.5711.stgit@bob.kio>
	 <1287715387.8722.950.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34759 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab0JVC5D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Oct 2010 22:57:03 -0400
In-Reply-To: <1287715387.8722.950.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Myron Stowe <myron.stowe@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>

On Fri, 2010-10-22 at 10:43 +0800, Li, Shaohua wrote:
> On Fri, 2010-10-22 at 04:23 +0800, Myron Stowe wrote:
> > ACPI's system event related IRQ handing accesses specific fixed
> > hardware registers; namely PM1a event, PM1b event, GPE0, and GPE1
> > which are declared in the FADT.  If these registers are backed by
> > MMIO, as opposed to I/O port space, accessing them within interrupt
> > context will incur a panic since acpi_read() and acpi_write() end up
> > calling ioremap(), which may block to allocate memory - BZ 18012.
> since you just access several bytes mmio in interrupt context, can't you
> use kmap_atomic_pfn() here?

On x86_64, kmap_atomic_pfn() is defined as kmap_atomic(), which requires
struct page for the physical address. But the MMIO address may have no
struct page.

Best Regards
Huang Ying


