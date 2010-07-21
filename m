From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: swiotlb detection should be memory hotplug aware ?
Date: Wed, 21 Jul 2010 13:58:16 +0900
Message-ID: <20100721135750Z.fujita.tomonori@lab.ntt.co.jp>
References: <20100316124556.GA25340@phenom.dumpdata.com>
	<1268866113.20507.26.camel@ank32>
	<1279664097.21596.43.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:38240 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933495Ab0GUFDA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jul 2010 01:03:00 -0400
In-Reply-To: <1279664097.21596.43.camel@ank32.eng.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akataria@vmware.com
Cc: konrad.wilk@oracle.com, fujita.tomonori@lab.ntt.co.jp, ak@linux.intel.com, lenb@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, petr@vmware.com

On Tue, 20 Jul 2010 15:14:57 -0700
Alok Kataria <akataria@vmware.com> wrote:

> Reviving a 4 month old thread. 
> I am still waiting for any clues on this question below. 

Basically, you want to add hot-plug memory and enable swiotlb, right?

We can't start swiotlb reliably after a system starts.

See dma32_reserve_boatmen() and dma32_free_bootmem(). What we do is
reserving huge memory in DMA32 zone for swiotlb and releasing it if we
find that we don't need swiotlb. We can't find enough memory for
swiotlb in dma32 after a system starts.
