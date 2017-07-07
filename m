From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC v2 0/5] surface heterogeneous memory performance information
Date: Fri, 7 Jul 2017 09:19:49 -0700
Message-ID: <599ebf96-fc06-1478-b805-349d13a0e652@intel.com>
References: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
 <1499408836.23251.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1499408836.23251.3.camel@gmail.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Balbir Singh <bsingharora@gmail.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jerome Glisse <jglisse@redhat.com>, Len Brown <lenb@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, devel@acpica.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
List-Id: linux-acpi@vger.kernel.org

On 07/06/2017 11:27 PM, Balbir Singh wrote:
> On Thu, 2017-07-06 at 15:52 -0600, Ross Zwisler wrote:
>>   # grep . mem_tgt2/* mem_tgt2/local_init/* 2>/dev/null
>>   mem_tgt2/firmware_id:1

This is here for folks that know their platform and know exactly the
firmware ID (PXM in ACPI parlance) of a given piece of memory.  Without
this, we might be stuck with requiring the NUMA node ID that the kernel
uses to be bound 1:1 with the firmware ID.

>>   mem_tgt2/is_cached:0

This tells whether the memory is cached by some other memory.  MCDRAM is
an example of this.  It can be used as a high-bandwidth cache in front
of the lower-bandwidth DRAM.

This is referred to as "Memory Side Cache Information Structure" in the
ACPI spec: www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf

>>   mem_tgt2/is_enabled:1
>>   mem_tgt2/is_isolated:0

This one is described in detail in the ACPI spec.  It's called
"Reservation hint" in there.

>>   mem_tgt2/phys_addr_base:0x0
>>   mem_tgt2/phys_length_bytes:0x800000000
>>   mem_tgt2/local_init/read_bw_MBps:30720
>>   mem_tgt2/local_init/read_lat_nsec:100
>>   mem_tgt2/local_init/write_bw_MBps:30720
>>   mem_tgt2/local_init/write_lat_nsec:100
> 
> How to these numbers compare to normal system memory?

They're made up in this instance.  But, it's safe to expect 10x swings
in bandwidth in latency, both up and down.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
