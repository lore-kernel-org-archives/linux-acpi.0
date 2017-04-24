From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Mon, 24 Apr 2017 10:07:12 -0700
Message-ID: <CAPcyv4hwAseE1NR75Zs9VMM3jiYszLFn9w6z9tzMYOFA4Dgpmw@mail.gmail.com>
References: <149281853758.22910.2919981036906495309.stgit@dwillia2-desk3.amr.corp.intel.com>
 <58FE2FCA.5050702@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35617 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S975397AbdDXRHN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2017 13:07:13 -0400
Received: by mail-oi0-f47.google.com with SMTP id j201so142576335oih.2
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2017 10:07:13 -0700 (PDT)
In-Reply-To: <58FE2FCA.5050702@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 24, 2017 at 10:03 AM, Linda Knippers <linda.knippers@hpe.com> wrote:
> On 04/21/2017 07:48 PM, Dan Williams wrote:
>> The nvdimm_flush() mechanism helps to reduce the impact of an ADR
>> (asynchronous-dimm-refresh) failure. The ADR mechanism handles flushing
>> platform WPQ (write-pending-queue) buffers when power is removed. The
>> nvdimm_flush() mechanism performs that same function on-demand.
>>
>> When a pmem namespace is associated with a block device, an
>> nvdimm_flush() is triggered with every block-layer REQ_FUA, or REQ_FLUSH
>> request. However, when a namespace is in device-dax mode, or namespaces
>> are disabled, userspace needs another path.
>
> Why would a user need to flush a disabled namespace?

For an application that wants to shutdown and sync. Basically I wanted
to make it clear that with this interface the buffers can be synced
regardless of any downstream namespace configuration or state.

>
>> The new 'flush' attribute is visible when it can be determined that the
>> interleave-set either does, or does not have DIMMs that expose WPQ-flush
>> addresses, "flush-hints" in ACPI NFIT terminology. It returns "1" and
>> flushes DIMMs, or returns "0" the flush operation is a platform nop.
>
> It seems a little odd to me that reading a read-only attribute both
> tells you that the device has flush hints and also triggers a flush.
> This means that anyone at any time can cause a flush.  Do we want that?

No, I'm making the change that Masayoshi-san suggested to move the
flush to a write operation... assuming we move forward given Jeff's
concern.
