From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v3] libnvdimm, region: sysfs trigger for nvdimm_flush()
Date: Thu, 27 Apr 2017 14:41:08 -0400
Message-ID: <x49d1bxsngb.fsf@segfault.boston.devel.redhat.com>
References: <149307780135.7155.11108531648914675756.stgit@dwillia2-desk3.amr.corp.intel.com>
        <149315140303.23340.14688142799059150805.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49zif23nvl.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jQXRQVHnNMqJDrwSMM=1kJx_7sWifUN-u1yusVCZ0roQ@mail.gmail.com>
        <x49y3umufpm.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jOP6fhk4wXahdEWH2O_93LQe9yzrWYZatSXXDwEk5OBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031925AbdD0SlL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 14:41:11 -0400
In-Reply-To: <CAPcyv4jOP6fhk4wXahdEWH2O_93LQe9yzrWYZatSXXDwEk5OBA@mail.gmail.com>
        (Dan Williams's message of "Thu, 27 Apr 2017 09:56:44 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dan Williams <dan.j.williams@intel.com> writes:

>> The sentiment is that programs shouldn't have to grovel around in sysfs
>> to do stuff related to an open file descriptor or mapping.  I don't take
>> issue with the name.  I do worry that something like 'wpq_drain' may be
>> too platform specific, though.  The NVM Programming Model specification
>> is going to call this "deep flush", so maybe that will give you
>> some inspiration if you do want to change the name.
>
> I'll change to "deep_flush", and I quibble that this is related to a
> single open file descriptor or mapping. It really is a "region flush"
> for giving extra protection for global metadata, but the persistence
> of individual fds or mappings is handled by ADR. I think an ioctl
> might give the false impression that every time you flush a cacheline
> to persistence you need to call the ioctl.

fsync, for example, may affect more than one fd--all data in the drive
write cache will be flushed.  I don't see how this is so different.  I
think a sysfs file is awkward because it requires an application to
chase down the correct file in the sysfs hierarchy.  If the application
already has an open fd or a mapping, it should be able to operate on
that.

As for confusion on when to use the interface, I think that's inevitable
no matter how it's implemented.  We're introducing a flush type that has
never been exposed before, and we're not giving any information on how
likely an ADR failure is, or how expensive this flush will be.

Cheers,
Jeff
