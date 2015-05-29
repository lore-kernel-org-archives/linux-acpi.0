From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/6] pmem: add force casts to avoid __iomem annotation
Date: Fri, 29 May 2015 05:53:00 -0700
Message-ID: <CAPcyv4jzpzbPmp6DXXz+fwiDOm9CWJJftF-9708bcFcY6ut6rw@mail.gmail.com>
References: <1432852553-24865-1-git-send-email-ross.zwisler@linux.intel.com>
	<1432852553-24865-2-git-send-email-ross.zwisler@linux.intel.com>
	<CAPcyv4iY5DSw-wf5kaKOXZk0qx9CZttU9X35i+gGwd6EYB=hbw@mail.gmail.com>
	<1432899584.4282.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33677 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbbE2MxB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2015 08:53:01 -0400
Received: by wgez8 with SMTP id z8so61852490wge.0
        for <linux-acpi@vger.kernel.org>; Fri, 29 May 2015 05:53:00 -0700 (PDT)
In-Reply-To: <1432899584.4282.2.camel@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <zwisler@gmail.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>

On Fri, May 29, 2015 at 4:39 AM, Ross Zwisler <zwisler@gmail.com> wrote:
> On Thu, 2015-05-28 at 15:47 -0700, Dan Williams wrote:
>> On Thu, May 28, 2015 at 3:35 PM, Ross Zwisler
>> <ross.zwisler@linux.intel.com> wrote:
>> > Even though we use ioremap_nocache() to map our persistent memory
>> > in the
>> > pmem driver, the memory we are mapping behaves like normal memory
>> > and
>> > not I/O memory in that it can be accessed using regular memcpy()
>> > operations and doesn't need to go through memcpy_toio() and
>> > memcpy_fromio().  Force casting the pointers received from
>> > ioremap_nocache() and given to iounmap() gives us the correct
>> > behavior
>> > and makes sparse happy.
>> >
>> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> > Cc: Dan Williams <dan.j.williams@intel.com>
>> > Cc: linux-nvdimm@lists.01.org
>> > ---
>> >  drivers/block/nd/pmem.c | 7 ++++---
>> >  1 file changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/block/nd/pmem.c b/drivers/block/nd/pmem.c
>> > index 5e8c9c629f22..a8712e41e7f5 100644
>> > --- a/drivers/block/nd/pmem.c
>> > +++ b/drivers/block/nd/pmem.c
>> > @@ -163,7 +163,8 @@ static struct pmem_device *pmem_alloc(struct
>> > device *dev, struct resource *res,
>> >          * of the CPU caches in case of a crash.
>> >          */
>> >         err = -ENOMEM;
>> > -       pmem->virt_addr = ioremap_nocache(pmem->phys_addr, pmem
>> > ->size);
>> > +       pmem->virt_addr = (__force void *)ioremap_nocache(pmem
>> > ->phys_addr,
>> > +                       pmem->size);
>>
>> I think I'd rather see casting when ->virt_addr is used (the
>> __io_virt() helper can be used to make this a tad cleaner), or
>> provide
>> ioremap apis that don't attach __iomem to their return value.
>>  Because
>> in this and other cases ioremap() is being on non "i/o" memory.
>
> The reason that I thought this was cleaner was that now when you look
> at the pmem->virt_addr definition it is just a clean void* with no
> annotations.  This correctly describes the memory to the user (it's
> usable as regular memory, it's in the kernel address space, etc.).
>
> Having the pointer itself annotated with __iomem feels weird to me
> because a random well meaning user could incorrectly try to use it as
> I/O memory.

pmem->virt_addr does not leak outside the driver to random well
meaning users.  I think we have two options, provide physical address
remap helpers from the outset (memremap()?) that don't attach __iomem,
or put the casts on the non-iomem usages.
