From: Andi Kleen <andi@firstfloor.org>
Subject: Re: swiotlb detection should be memory hotplug aware ?
Date: Wed, 28 Jul 2010 13:09:57 +0200
Message-ID: <8739v3kgl6.fsf@basil.nowhere.org>
References: <4C49A83C.8070203@linux.intel.com>
	<20100723145945.GA31857@phenom.dumpdata.com>
	<4C49B3F5.3030904@linux.intel.com>
	<20100728190939D.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100728190939D.fujita.tomonori@lab.ntt.co.jp> (FUJITA
	Tomonori's message of "Wed, 28 Jul 2010 19:10:19 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: ak@linux.intel.com, konrad.wilk@oracle.com, akataria@vmware.com, lenb@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, petr@vmware.com
List-Id: linux-acpi@vger.kernel.org

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:
>
>> The other problem is that using only  two bits for the needed address 
>> space is also extremly
>> inefficient (4GB and 16MB on x86). Really want masks everywhere and 
>> optimize for the
>> actual requirements.
>
> swiotlb doesn't allocate GFP_DMA memory. It handles only GFP_DMA32.

I was lumping GFP_DMA and swiotlb together here. The
pci_alloc_consistent() function uses both interchangedly.
They really effectively are the same thing these days
and just separated by historical accident.


> I have a half-baked patch for it. I'll send it later.

The problem are still the *_map users which usually cannot sleep,
and then it's difficult to grow.
For *_alloc it's relatively easy and to some extend already 
implemented.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
