From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v3] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Thu, 27 Apr 2017 09:45:25 -0400
Message-ID: <x49y3umufpm.fsf@segfault.boston.devel.redhat.com>
References: <149307780135.7155.11108531648914675756.stgit@dwillia2-desk3.amr.corp.intel.com>
        <149315140303.23340.14688142799059150805.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49zif23nvl.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jQXRQVHnNMqJDrwSMM=1kJx_7sWifUN-u1yusVCZ0roQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754102AbdD0Np2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 09:45:28 -0400
In-Reply-To: <CAPcyv4jQXRQVHnNMqJDrwSMM=1kJx_7sWifUN-u1yusVCZ0roQ@mail.gmail.com>
        (Dan Williams's message of "Wed, 26 Apr 2017 16:00:04 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dan Williams <dan.j.williams@intel.com> writes:

> On Wed, Apr 26, 2017 at 1:38 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>>> The nvdimm_flush() mechanism helps to reduce the impact of an ADR
>>> (asynchronous-dimm-refresh) failure. The ADR mechanism handles flushing
>>> platform WPQ (write-pending-queue) buffers when power is removed. The
>>> nvdimm_flush() mechanism performs that same function on-demand.
>>>
>>> When a pmem namespace is associated with a block device, an
>>> nvdimm_flush() is triggered with every block-layer REQ_FUA, or REQ_FLUSH
>>> request. These requests are typically associated with filesystem
>>> metadata updates. However, when a namespace is in device-dax mode,
>>> userspace (think database metadata) needs another path to perform the
>>> same flushing. In other words this is not required to make data
>>> persistent, but in the case of metadata it allows for a smaller failure
>>> domain in the unlikely event of an ADR failure.
>>>
>>> The new 'flush' attribute is visible when the individual DIMMs backing a
>>> given interleave-set are described by platform firmware. In ACPI terms
>>> this is "NVDIMM Region Mapping Structures" and associated "Flush Hint
>>> Address Structures". Reads return "1" if the region supports triggering
>>> WPQ flushes on all DIMMs. Reads return "0" the flush operation is a
>>> platform nop, and in that case the attribute is read-only.
>>
>> I can make peace with exposing this to userspace, though I am mostly
>> against its use.  However, sysfs feels like the wrong interface.
>> Believe it or not, I'd rather see this implemented as an ioctl.
>>
>> This isn't a NACK, it's me giving my opinion.  Do with it what you will.
>
> I hate ioctls with a burning passion so I can't get on board with that
> change, but perhaps the sentiment behind it is that this is too
> visible and too attractive being called "flush" in sysfs? Would a name
> more specific to the mechanism make it more palatable? Like
> "flush_hint_trigger" or "wpq_drain"?

The sentiment is that programs shouldn't have to grovel around in sysfs
to do stuff related to an open file descriptor or mapping.  I don't take
issue with the name.  I do worry that something like 'wpq_drain' may be
too platform specific, though.  The NVM Programming Model specification
is going to call this "deep flush", so maybe that will give you
some inspiration if you do want to change the name.

Cheers,
Jeff
