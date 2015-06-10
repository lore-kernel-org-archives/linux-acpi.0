From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 0/3] Add NUMA support for NVDIMM devices
Date: Wed, 10 Jun 2015 08:57:50 -0700
Message-ID: <CAPcyv4h1ak0YUnS1=RZzKjgbpSAV5hrm0NCiwg_Nmp4zKob8kg@mail.gmail.com>
References: <1433891440-3515-1-git-send-email-toshi.kani@hp.com>
	<x494mmfwoch.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <x494mmfwoch.fsf@segfault.boston.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Toshi Kani <toshi.kani@hp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 10, 2015 at 8:54 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Toshi Kani <toshi.kani@hp.com> writes:
>
>> Since NVDIMMs are installed on memory slots, they expose the NUMA
>> topology of a platform.  This patchset adds support of sysfs
>> 'numa_node' to I/O-related NVDIMM devices under /sys/bus/nd/devices.
>> This enables numactl(8) to accept 'block:' and 'file:' paths of
>> pmem and btt devices as shown in the examples below.
>>   numactl --preferred block:pmem0 --show
>>   numactl --preferred file:/dev/pmem0s --show
>>
>> numactl can be used to bind an application to the locality of
>> a target NVDIMM for better performance.  Here is a result of fio
>> benchmark to ext4/dax on an HP DL380 with 2 sockets for local and
>> remote settings.
>>
>>   Local [1] :  4098.3MB/s
>>   Remote [2]:  3718.4MB/s
>>
>> [1] numactl --preferred block:pmem0 --cpunodebind block:pmem0 fio <fs-on-pmem0>
>> [2] numactl --preferred block:pmem1 --cpunodebind block:pmem1 fio <fs-on-pmem0>
>
> Did you post the patches to numactl somewhere?
>

numactl already supports this today.
