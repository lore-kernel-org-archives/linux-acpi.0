From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Mon, 24 Apr 2017 12:43:56 -0400
Message-ID: <x4960htg3hv.fsf@segfault.boston.devel.redhat.com>
References: <149281853758.22910.2919981036906495309.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49d1c1g4ba.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jYAM73HUOU15ok1F91y+A6OEbSXrwBVStz7ewhmsnJsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S974863AbdDXQn6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Apr 2017 12:43:58 -0400
In-Reply-To: <CAPcyv4jYAM73HUOU15ok1F91y+A6OEbSXrwBVStz7ewhmsnJsA@mail.gmail.com>
        (Dan Williams's message of "Mon, 24 Apr 2017 09:36:47 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Apr 24, 2017 at 9:26 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>>> The nvdimm_flush() mechanism helps to reduce the impact of an ADR
>>> (asynchronous-dimm-refresh) failure. The ADR mechanism handles flushing
>>> platform WPQ (write-pending-queue) buffers when power is removed. The
>>> nvdimm_flush() mechanism performs that same function on-demand.
>>>
>>> When a pmem namespace is associated with a block device, an
>>> nvdimm_flush() is triggered with every block-layer REQ_FUA, or REQ_FLUSH
>>> request. However, when a namespace is in device-dax mode, or namespaces
>>> are disabled, userspace needs another path.
>>>
>>> The new 'flush' attribute is visible when it can be determined that the
>>> interleave-set either does, or does not have DIMMs that expose WPQ-flush
>>> addresses, "flush-hints" in ACPI NFIT terminology. It returns "1" and
>>> flushes DIMMs, or returns "0" the flush operation is a platform nop.
>>>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> NACK.  This should function the same way it does for a pmem device.
>> Wire up sync.
>
> We don't have dirty page tracking for device-dax, without that I don't
> think we should wire up the current sync calls.

Why not?  Device dax is meant for the "flush from userspace" paradigm.
There's enough special casing around device dax that I think you can get
away with implementing *sync as call to nvdimm_flush.

> I do think we need a more sophisticated sync syscall interface
> eventually that can select which level of flushing is being performed
> (page cache vs cpu cache vs platform-write-buffers).

I don't.  I think this whole notion of flush, and flush harder is
brain-dead.  How do you explain to applications when they should use
each one?

> Until then I think this sideband interface makes sense and sysfs is
> more usable than an ioctl.

Well, if you're totally against wiring up sync, then I say we forget
about the deep flush completely.  What's your use case?

Cheers,
Jeff
