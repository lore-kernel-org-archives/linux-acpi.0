From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/2] libnvdimm, region: fix flush hint detection crash
Date: Wed, 26 Apr 2017 13:04:23 -0700
Message-ID: <CAPcyv4g8Y_h3AmgPWBBK7=FOOschc+Z3Nh-9Otx8mAoBthv3=Q@mail.gmail.com>
References: <149307779085.7155.436029631521340565.stgit@dwillia2-desk3.amr.corp.intel.com>
 <149307779612.7155.12969380677038292861.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49bmrj9cqj.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33727 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754156AbdDZUEZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2017 16:04:25 -0400
Received: by mail-oi0-f42.google.com with SMTP id y11so14338105oie.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2017 13:04:24 -0700 (PDT)
In-Reply-To: <x49bmrj9cqj.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Wed, Apr 26, 2017 at 12:43 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> In the case where a dimm does not have any associated flush hints the
>> ndrd->flush_wpq array may be uninitialized leading to crashes with the
>> following signature:
>>
>>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
>>  IP: region_visible+0x10f/0x160 [libnvdimm]
>>
>>  Call Trace:
>>   internal_create_group+0xbe/0x2f0
>>   sysfs_create_groups+0x40/0x80
>>   device_add+0x2d8/0x650
>>   nd_async_device_register+0x12/0x40 [libnvdimm]
>>   async_run_entry_fn+0x39/0x170
>>   process_one_work+0x212/0x6c0
>>   ? process_one_work+0x197/0x6c0
>>   worker_thread+0x4e/0x4a0
>>   kthread+0x10c/0x140
>>   ? process_one_work+0x6c0/0x6c0
>>   ? kthread_create_on_node+0x60/0x60
>>   ret_from_fork+0x31/0x40
>
> Sorry for being dense, but I'm having a tough time connecting the dots,
> here.  How does region_visible trip over the missing (not uninitialized,
> you're actually walking off the end of the structure) wpq_flush array?

So, you're not dense, or you're at least as equally dense as me,
because I didn't immediately understand where this failure was coming
from either. I just happened to trigger it while running patch2 and
thought the current code just looked unsafe by inspection.

> Anyway, the fix looks valid.
>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Thanks!
