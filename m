From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/6] x86, pmem: add PMEM API for persistent memory
Date: Thu, 28 May 2015 16:20:36 -0700
Message-ID: <5567A2C4.3040407@zytor.com>
References: <1432852553-24865-1-git-send-email-ross.zwisler@linux.intel.com> <1432852553-24865-4-git-send-email-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:54005 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891AbbE1XVC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 May 2015 19:21:02 -0400
In-Reply-To: <1432852553-24865-4-git-send-email-ross.zwisler@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@ml01.01.org
Cc: Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org

On 05/28/2015 03:35 PM, Ross Zwisler wrote:
> Add a new PMEM API to x86, and allow for architectures that do not
> implement this API.  Architectures that implement the PMEM API should
> define ARCH_HAS_PMEM_API in their kernel configuration and must provide
> implementations for persistent_copy(), persistent_flush() and
> persistent_sync().

>  
>  void clflush_cache_range(void *addr, unsigned int size);
>  

No, no, no, no, no.  Include the proper header file.

> +static inline void arch_persistent_flush(void *vaddr, size_t size)
> +{
> +	clflush_cache_range(vaddr, size);
> +}

Shouldn't this really be using clwb() -- we really need a
clwb_cache_range() I guess?

Incidentally, clflush_cache_range() seems to have the same flaw as the
proposed use case for clwb() had... if the buffer is aligned it will
needlessly flush the last line twice.  It should really look something
like this (which would be a good standalone patch):

void clflush_cache_range(void *vaddr, unsigned int size)
{
        void *vend = vaddr + size - 1;

        mb();

	vaddr = (void *)
		((unsigned long)vaddr
		 & ~(boot_cpu_data.x86_clflush_size - 1));

        for (; vaddr < vend; vaddr += boot_cpu_data.x86_clflush_size)
                clflushopt(vaddr);

        mb();
}
EXPORT_SYMBOL_GPL(clflush_cache_range);

I also note that with your implementation we have a wmb() in
arch_persistent_sync() and an mb() in arch_persistent_flush()... surely
one is redundant?

	-hpa


