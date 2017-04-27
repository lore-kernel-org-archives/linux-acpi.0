From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm, pmem: fix badblocks notification crash
Date: Thu, 27 Apr 2017 15:26:49 -0700
Message-ID: <CAPcyv4jFk2nAdhViv_3CWQ7UxE=OCYro-d2OW-yAFAsxVUQWZw@mail.gmail.com>
References: <149333101097.4714.1923436715100717938.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1493331874.30303.1.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33719 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbdD0W0u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2017 18:26:50 -0400
Received: by mail-io0-f182.google.com with SMTP id k87so38761399ioi.0
        for <linux-acpi@vger.kernel.org>; Thu, 27 Apr 2017 15:26:50 -0700 (PDT)
In-Reply-To: <1493331874.30303.1.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>

On Thu, Apr 27, 2017 at 3:25 PM, Kani, Toshimitsu <toshi.kani@hpe.com> wrote:
> On Thu, 2017-04-27 at 15:10 -0700, Dan Williams wrote:
>> The nd_pmem_notify() routine is called whenever an ARS
>> (address-range-scrub) completes to communicate results to the
>> per-namespace badblocks instances.
>>
>> When the namespace is in btt mode we crash because we do not allocate
>> a struct pmem_device instance in that case. Resulting in the
>> following crash signature:
>>
>>  BUG: unable to handle kernel NULL pointer dereference at
>> 0000000000000030
>>  IP: nd_pmem_notify+0x30/0xf0 [nd_pmem]
>>  Call Trace:
>>   nd_device_notify+0x40/0x50
>>   child_notify+0x10/0x20
>>   device_for_each_child+0x50/0x90
>>   nd_region_notify+0x20/0x30
>>   nd_device_notify+0x40/0x50
>>   nvdimm_region_notify+0x27/0x30
>>   acpi_nfit_scrub+0x341/0x590 [nfit]
>>   process_one_work+0x197/0x450
>>   worker_thread+0x4e/0x4a0
>>   kthread+0x109/0x140
>>
>> Given that we don't even populate the btt badblocks instance, just
>> return early and skip the device to region lookup.
>
> We populate the btt badblocks into nsio->bb, and check/clear them in
> nsio_rw_bytes().

Argh, yes, we don't populate them out to the disk badblocks. I'll go
with your patch.
