From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] libnvdimm, pmem: clear poison on write
Date: Thu, 10 Mar 2016 16:50:36 -0800
Message-ID: <CAPcyv4gK1Tdpy9_tO=NwPF=4pYcp5Nx8fxaPE5hGNXr2Hr7cBg@mail.gmail.com>
References: <20160308224713.16298.33547.stgit@dwillia2-desk3.jf.intel.com>
	<20160308224729.16298.49406.stgit@dwillia2-desk3.jf.intel.com>
	<1457656781.4525.36.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35861 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932893AbcCKAuh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 19:50:37 -0500
Received: by mail-ob0-f171.google.com with SMTP id m7so98286244obh.3
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2016 16:50:37 -0800 (PST)
In-Reply-To: <1457656781.4525.36.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Mar 10, 2016 at 4:39 PM, Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
> On Tue, 2016-03-08 at 14:47 -0800, Dan Williams wrote:
>> If a write is directed at a known bad block perform the following:
>>
>> 1/ write the data
>>
>> 2/ send a clear poison command
>>
>> 3/ invalidate the poison out of the cache hierarchy
>>
>> Cc: <x86@kernel.org>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  arch/x86/include/asm/pmem.h |    5 +++++
>>  drivers/nvdimm/bus.c        |   46
>> +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/nvdimm/nd.h         |    2 ++
>>  drivers/nvdimm/pmem.c       |   29 ++++++++++++++++++++++++++-
>>  include/linux/pmem.h        |   19 ++++++++++++++++++
>>  5 files changed, 100 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/pmem.h b/arch/x86/include/asm/pmem.h
>> index c57fd1ea9689..bf8b35d2035a 100644
>> --- a/arch/x86/include/asm/pmem.h
>> +++ b/arch/x86/include/asm/pmem.h
>
> <>
>
>>  static int pmem_do_bvec(struct pmem_device *pmem, struct page *page,
>>                       unsigned int len, unsigned int off, int rw,
>>                       sector_t sector)
>>  {
>>       int rc = 0;
>> +     bool bad_pmem = false;
>>       void *mem = kmap_atomic(page);
>>       phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
>>       void __pmem *pmem_addr = pmem->virt_addr + pmem_off;
>>
>> +     if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
>> +             bad_pmem = true;
>> +
>>       if (rw == READ) {
>> -             if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
>> +             if (unlikely(bad_pmem))
>>                       rc = -EIO;
>>               else {
>>                       memcpy_from_pmem(mem + off, pmem_addr, len);
>> @@ -81,6 +104,10 @@ static int pmem_do_bvec(struct pmem_device *pmem,
>> struct page *page,
>>       } else {
>>               flush_dcache_page(page);
>>               memcpy_to_pmem(pmem_addr, mem + off, len);
>> +             if (unlikely(bad_pmem)) {
>> +                     pmem_clear_poison(pmem, pmem_off, len);
>> +                     memcpy_to_pmem(pmem_addr, mem + off, len);
>> +             }
>>       }
>
> Just noticed this -- why do we memcpy_to_pmem twice in the error case?
> Sh
> ouldn't it be:
>
>         if (unlikely(bad_pmem))
>                 pmem_clear_poison(pmem, pmem_off, len);
>         memcpy_to_pmem(pmem_addr, mem + off, len);
>

There is an open question of whether clear_poison implementations
guarantee determinant data after clear, or otherwise guarantee that
the data written before the clear_poison stays in place.  So I write
twice to cover all those bases.  Probably deserves a comment.
