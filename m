From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 0/7] ACPI: Memory Mapped I/O (MMIO) pre-mapping
Date: Fri, 22 Oct 2010 10:43:07 +0800
Message-ID: <1287715387.8722.950.camel@sli10-conroe.sh.intel.com>
References: <20101021201916.9220.5711.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41354 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab0JVCnI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Oct 2010 22:43:08 -0400
In-Reply-To: <20101021201916.9220.5711.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "Huang, Ying" <ying.huang@intel.com>

On Fri, 2010-10-22 at 04:23 +0800, Myron Stowe wrote:
> ACPI's system event related IRQ handing accesses specific fixed
> hardware registers; namely PM1a event, PM1b event, GPE0, and GPE1
> which are declared in the FADT.  If these registers are backed by
> MMIO, as opposed to I/O port space, accessing them within interrupt
> context will incur a panic since acpi_read() and acpi_write() end up
> calling ioremap(), which may block to allocate memory - BZ 18012.
since you just access several bytes mmio in interrupt context, can't you
use kmap_atomic_pfn() here?

