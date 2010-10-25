From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Mon, 25 Oct 2010 16:43:55 +0800
Message-ID: <1287996235.2862.314.camel@yhuang-dev>
References: <20101021201916.9220.5711.stgit@bob.kio>
	 <1287716220.2862.57.camel@yhuang-dev>
	 <1287717372.8722.954.camel@sli10-conroe.sh.intel.com>
	 <201010221110.01582.bjorn.helgaas@hp.com>
	 <20101025083404.GA30292@gargoyle.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:29203 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884Ab0JYIoA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 04:44:00 -0400
In-Reply-To: <20101025083404.GA30292@gargoyle.fritz.box>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Li, Shaohua" <shaohua.li@intel.com>, Myron Stowe <myron.stowe@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2010-10-25 at 16:34 +0800, Andi Kleen wrote:
> > On ia64 (which also uses ACPI), kmap_atomic_pfn() also requires
> > a struct page.  An ia64-specific version that doesn't need a struct
> > page would be trivial, but I still don't know how to make it work on
> > x86_64.
> 
> Doing a struct page less kmap_atomic() shouldn't be too hard 
> on x86 either.
> 
> Just to avoid problems with concurrency you likely need per 
> CPU mappings.

One issue is PAT management, like in general ioremap implementation
(reserve_memtype).

Best Regards,
Huang Ying


