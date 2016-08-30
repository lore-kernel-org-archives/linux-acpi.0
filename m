From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: DAX can not work on virtual nvdimm device
Date: Tue, 30 Aug 2016 10:09:01 -0700
Message-ID: <CAPcyv4hrFSxNcmmVLVZT4fK3+hspPCDKW0rVBj1=3GkJRgZ29Q@mail.gmail.com>
References: <436d7526-bf06-633d-afce-4333552d9e31@linux.intel.com>
 <CAPcyv4hVgi6Hw8Beg=Nt78+U0QNJN9mBGWEp3V6bg86NaM3Q6Q@mail.gmail.com>
 <20160819183047.GA7216@linux.intel.com> <600ac51c-0f61-6e53-9bfa-669c85494d1f@linux.intel.com>
 <20160829193014.GB16738@linux.intel.com> <61d5c470-a8bf-86d5-d1fe-b4b577a85967@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36848 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756559AbcH3RJD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2016 13:09:03 -0400
Received: by mail-oi0-f54.google.com with SMTP id f189so34922654oig.3
        for <linux-acpi@vger.kernel.org>; Tue, 30 Aug 2016 10:09:02 -0700 (PDT)
In-Reply-To: <61d5c470-a8bf-86d5-d1fe-b4b577a85967@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Yumei Huang <yuhuang@redhat.com>, KVM <kvm@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Aug 29, 2016 at 11:53 PM, Xiao Guangrong
<guangrong.xiao@linux.intel.com> wrote:
>
>
> On 08/30/2016 03:30 AM, Ross Zwisler wrote:
>
>>
>> Can you please verify that you are using "usable" memory for your memmap?
>> All
>> the details are here:
>>
>>
>> https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel_parameter_for_pmem_on_your_system
>
>
> Sure.
>
> This is the BIOS E820 info in the guest:
>
> e820: BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
> BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
> BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000083fffffff] usable
> NX (Execute Disable) protection: active
> e820: user-defined physical RAM map:
> user: [mem 0x0000000000000000-0x000000000009fbff] usable
> user: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> user: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> user: [mem 0x0000000000100000-0x00000000bffdefff] usable
> user: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
> user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> user: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> user: [mem 0x0000000100000000-0x000000027fffffff] usable
> user: [mem 0x0000000280000000-0x00000003ffffffff] persistent (type 12)
> user: [mem 0x0000000400000000-0x000000083fffffff] usable
>
> So that the memory we used to emulate PMEM split the 'usable' region.
>
>>
>> My guess is that Boaz was correct, and that your memmap is off using
>> addresses
>> that don't actually map to memory.
>
>
> I do not think so. :(
>
> I did mmap-write and mmap-read test, the data written by mmap-write can be
> correctly read out, so that the backend memory is really existing.
>

Can you post your exact reproduction steps?  This test is not failing for me.
