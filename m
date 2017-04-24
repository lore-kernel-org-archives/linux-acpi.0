From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Mon, 24 Apr 2017 09:36:47 -0700
Message-ID: <CAPcyv4jYAM73HUOU15ok1F91y+A6OEbSXrwBVStz7ewhmsnJsA@mail.gmail.com>
References: <149281853758.22910.2919981036906495309.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49d1c1g4ba.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35666 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S973372AbdDXQgt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2017 12:36:49 -0400
Received: by mail-oi0-f49.google.com with SMTP id j201so141468759oih.2
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2017 09:36:49 -0700 (PDT)
In-Reply-To: <x49d1c1g4ba.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 24, 2017 at 9:26 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> The nvdimm_flush() mechanism helps to reduce the impact of an ADR
>> (asynchronous-dimm-refresh) failure. The ADR mechanism handles flushing
>> platform WPQ (write-pending-queue) buffers when power is removed. The
>> nvdimm_flush() mechanism performs that same function on-demand.
>>
>> When a pmem namespace is associated with a block device, an
>> nvdimm_flush() is triggered with every block-layer REQ_FUA, or REQ_FLUSH
>> request. However, when a namespace is in device-dax mode, or namespaces
>> are disabled, userspace needs another path.
>>
>> The new 'flush' attribute is visible when it can be determined that the
>> interleave-set either does, or does not have DIMMs that expose WPQ-flush
>> addresses, "flush-hints" in ACPI NFIT terminology. It returns "1" and
>> flushes DIMMs, or returns "0" the flush operation is a platform nop.
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> NACK.  This should function the same way it does for a pmem device.
> Wire up sync.

We don't have dirty page tracking for device-dax, without that I don't
think we should wire up the current sync calls. I do think we need a
more sophisticated sync syscall interface eventually that can select
which level of flushing is being performed (page cache vs cpu cache vs
platform-write-buffers). Until then I think this sideband interface
makes sense and sysfs is more usable than an ioctl.
