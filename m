From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Mon, 25 Oct 2010 10:34:04 +0200
Message-ID: <20101025083404.GA30292@gargoyle.fritz.box>
References: <20101021201916.9220.5711.stgit@bob.kio>
 <1287716220.2862.57.camel@yhuang-dev>
 <1287717372.8722.954.camel@sli10-conroe.sh.intel.com>
 <201010221110.01582.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14971 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab0JYIbp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 04:31:45 -0400
Content-Disposition: inline
In-Reply-To: <201010221110.01582.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Shaohua Li <shaohua.li@intel.com>, "Huang, Ying" <ying.huang@intel.com>, Myron Stowe <myron.stowe@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> On ia64 (which also uses ACPI), kmap_atomic_pfn() also requires
> a struct page.  An ia64-specific version that doesn't need a struct
> page would be trivial, but I still don't know how to make it work on
> x86_64.

Doing a struct page less kmap_atomic() shouldn't be too hard 
on x86 either.

Just to avoid problems with concurrency you likely need per 
CPU mappings.

-Andi

