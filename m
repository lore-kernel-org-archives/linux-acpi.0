From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Mon, 24 Apr 2017 10:43:41 -0700
Message-ID: <CAPcyv4jiPfUNR9jFtjGgmfaMWLboVzW9gHmFBtykR+C4pDae2g@mail.gmail.com>
References: <149281853758.22910.2919981036906495309.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49d1c1g4ba.fsf@segfault.boston.devel.redhat.com> <CAPcyv4jYAM73HUOU15ok1F91y+A6OEbSXrwBVStz7ewhmsnJsA@mail.gmail.com>
 <x4960htg3hv.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33569 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972770AbdDXRnm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2017 13:43:42 -0400
Received: by mail-oi0-f43.google.com with SMTP id y11so111643409oie.0
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2017 10:43:42 -0700 (PDT)
In-Reply-To: <x4960htg3hv.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>

[ adding Christoph ]

On Mon, Apr 24, 2017 at 9:43 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Mon, Apr 24, 2017 at 9:26 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
>>> Dan Williams <dan.j.williams@intel.com> writes:
>>>
>>>> The nvdimm_flush() mechanism helps to reduce the impact of an ADR
>>>> (asynchronous-dimm-refresh) failure. The ADR mechanism handles flushing
>>>> platform WPQ (write-pending-queue) buffers when power is removed. The
>>>> nvdimm_flush() mechanism performs that same function on-demand.
>>>>
>>>> When a pmem namespace is associated with a block device, an
>>>> nvdimm_flush() is triggered with every block-layer REQ_FUA, or REQ_FLUSH
>>>> request. However, when a namespace is in device-dax mode, or namespaces
>>>> are disabled, userspace needs another path.
>>>>
>>>> The new 'flush' attribute is visible when it can be determined that the
>>>> interleave-set either does, or does not have DIMMs that expose WPQ-flush
>>>> addresses, "flush-hints" in ACPI NFIT terminology. It returns "1" and
>>>> flushes DIMMs, or returns "0" the flush operation is a platform nop.
>>>>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>
>>> NACK.  This should function the same way it does for a pmem device.
>>> Wire up sync.
>>
>> We don't have dirty page tracking for device-dax, without that I don't
>> think we should wire up the current sync calls.
>
> Why not?  Device dax is meant for the "flush from userspace" paradigm.
> There's enough special casing around device dax that I think you can get
> away with implementing *sync as call to nvdimm_flush.

I think its an abuse of fsync() and gets in the way of where we might
take userspace-pmem-flushing with new sync primitives as proposed here
[1].

I'm also conscious of the shade that hch threw the last time I tried
to abuse an existing syscall for device-dax [2].

>> I do think we need a more sophisticated sync syscall interface
>> eventually that can select which level of flushing is being performed
>> (page cache vs cpu cache vs platform-write-buffers).
>
> I don't.  I think this whole notion of flush, and flush harder is
> brain-dead.  How do you explain to applications when they should use
> each one?

You never need to use this mechanism to guarantee persistence, which
is counter to what fsync() is defined to provide. This mechanism is
only there to backstop against potential ADR failures.

>> Until then I think this sideband interface makes sense and sysfs is
>> more usable than an ioctl.
>
> Well, if you're totally against wiring up sync, then I say we forget
> about the deep flush completely.  What's your use case?

The use case is device-dax users that want to reduce the impact of an
ADR failure. Which also assumes that the platform has mechanisms to
communicate ADR failure. This is not an interface I expect to be used
for general purpose applications. All of those should be depending
solely on ADR semantics.

[1]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg444842.html
[2]: https://lists.01.org/pipermail/linux-nvdimm/2016-December/008299.html
