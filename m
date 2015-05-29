From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/6] x86, pmem: add PMEM API for persistent memory
Date: Thu, 28 May 2015 17:02:05 -0700
Message-ID: <CAPcyv4jCaLzikA5wG1HjRW0UXZ0csj2JfP_Bx78CNUmUXvWZ4Q@mail.gmail.com>
References: <1432852553-24865-1-git-send-email-ross.zwisler@linux.intel.com>
	<1432852553-24865-4-git-send-email-ross.zwisler@linux.intel.com>
	<5567A2C4.3040407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37792 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbbE2ACH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 May 2015 20:02:07 -0400
Received: by wifw1 with SMTP id w1so3302756wif.0
        for <linux-acpi@vger.kernel.org>; Thu, 28 May 2015 17:02:06 -0700 (PDT)
In-Reply-To: <5567A2C4.3040407@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>

On Thu, May 28, 2015 at 4:20 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 05/28/2015 03:35 PM, Ross Zwisler wrote:
>> Add a new PMEM API to x86, and allow for architectures that do not
>> implement this API.  Architectures that implement the PMEM API should
>> define ARCH_HAS_PMEM_API in their kernel configuration and must provide
>> implementations for persistent_copy(), persistent_flush() and
>> persistent_sync().
>
>>
>>  void clflush_cache_range(void *addr, unsigned int size);
>>
>
> No, no, no, no, no.  Include the proper header file.
>
>> +static inline void arch_persistent_flush(void *vaddr, size_t size)
>> +{
>> +     clflush_cache_range(vaddr, size);
>> +}
>
> Shouldn't this really be using clwb() -- we really need a
> clwb_cache_range() I guess?
>
> Incidentally, clflush_cache_range() seems to have the same flaw as the
> proposed use case for clwb() had... if the buffer is aligned it will
> needlessly flush the last line twice.  It should really look something
> like this (which would be a good standalone patch):
>
> void clflush_cache_range(void *vaddr, unsigned int size)
> {
>         void *vend = vaddr + size - 1;
>
>         mb();
>
>         vaddr = (void *)
>                 ((unsigned long)vaddr
>                  & ~(boot_cpu_data.x86_clflush_size - 1));
>
>         for (; vaddr < vend; vaddr += boot_cpu_data.x86_clflush_size)
>                 clflushopt(vaddr);
>
>         mb();
> }
> EXPORT_SYMBOL_GPL(clflush_cache_range);
>
> I also note that with your implementation we have a wmb() in
> arch_persistent_sync() and an mb() in arch_persistent_flush()... surely
> one is redundant?

Hmm, yes, but I believe Ross (on vacation now) was following the
precedent set by commit cd8ddf1a2800 "x86: clflush_page_range needs
mfence" whereby the api handles all necessary fencing internally.
Shall we introduce something like __unordered_clflush_cache_range()
for arch_persistent_flush() to use with the understanding it will be
following up with the wmb() in arch_persistent_sync()?
