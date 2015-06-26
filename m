From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 16/17] libnvdimm: Add sysfs numa_node to NVDIMM devices
Date: Fri, 26 Jun 2015 08:26:44 -0700
Message-ID: <CAPcyv4iBhyGzwwtmqdWMOPLTzt3QXz5nPXgcniVCmU0Ybxa_PA@mail.gmail.com>
References: <20150625090554.40066.69562.stgit@dwillia2-desk3.jf.intel.com>
	<20150625093743.40066.92148.stgit@dwillia2-desk3.jf.intel.com>
	<1435285301.11808.381.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:32935 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbbFZP0p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2015 11:26:45 -0400
Received: by wgck11 with SMTP id k11so91403935wgc.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2015 08:26:44 -0700 (PDT)
In-Reply-To: <1435285301.11808.381.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Jens Axboe <axboe@kernel.dk>, Boaz Harrosh <boaz@plexistor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Thu, Jun 25, 2015 at 7:21 PM, Toshi Kani <toshi.kani@hp.com> wrote:
> On Thu, 2015-06-25 at 05:37 -0400, Dan Williams wrote:
>> From: Toshi Kani <toshi.kani@hp.com>
>>
>> Add support of sysfs 'numa_node' to I/O-related NVDIMM devices
>> under /sys/bus/nd/devices, regionN, namespaceN.0, and bttN.
>> When bttN is not set up, its numa_node returns -1 (NUMA_NO_NODE).
>>
>> An example of numa_node values on a 2-socket system with a single
>> NVDIMM range on each socket is shown below.
>>   /sys/bus/nd/devices
>>   |-- btt0/numa_node:-1
>>   |-- btt1/numa_node:0
>>   |-- namespace0.0/numa_node:0
>>   |-- namespace1.0/numa_node:1
>>   |-- region0/numa_node:0
>>   |-- region1/numa_node:1
>>
>> These numa_node files are then linked under the block class of
>> their device names.
>>   /sys/class/block/pmem0/device/numa_node:0
>>   /sys/class/block/pmem0s/device/numa_node:0
>>   /sys/class/block/pmem1/device/numa_node:1
>>
>> This enables numactl(8) to accept 'block:' and 'file:' paths of
>> pmem and btt devices as shown in the examples below.
>>   numactl --preferred block:pmem0 --show
>>   numactl --preferred file:/dev/pmem0s --show
>>
>> Signed-off-by: Toshi Kani <toshi.kani@hp.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Can you please update the commit log with the following?  It reflects
> the changes in sysfs btt files.

Done, thanks!
