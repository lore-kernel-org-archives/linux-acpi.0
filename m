From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
Date: Thu, 22 Nov 2018 17:22:19 +0530
Message-ID: <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
References: <20181114224902.12082-1-keith.busch@intel.com>
 <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com>
 <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org



On 11/19/2018 11:07 PM, Dave Hansen wrote:
> On 11/18/18 9:44 PM, Anshuman Khandual wrote:
>> IIUC NUMA re-work in principle involves these functional changes
>>
>> 1. Enumerating compute and memory nodes in heterogeneous environment (short/medium term)
> 
> This patch set _does_ that, though.
> 
>> 2. Enumerating memory node attributes as seen from the compute nodes (short/medium term)
> 
> It does that as well (a subset at least).
> 
> It sounds like the subset that's being exposed is insufficient for yo
> We did that because we think doing anything but a subset in sysfs will
> just blow up sysfs:  MAX_NUMNODES is as high as 1024, so if we have 4
> attributes, that's at _least_ 1024*1024*4 files if we expose *all*
> combinations.
Each permutation need not be a separate file inside all possible NODE X
(/sys/devices/system/node/nodeX) directories. It can be a top level file
enumerating various attribute values for a given (X, Y) node pair based
on an offset something like /proc/pid/pagemap.

> 
> Do we agree that sysfs is unsuitable for exposing attributes in this manner?
> 

Yes, for individual files. But this can be worked around with an offset
based access from a top level global attributes file as mentioned above.
Is there any particular advantage of using individual files for each
given attribute ? I was wondering that a single unsigned long (u64) will
be able to pack 8 different attributes where each individual attribute
values can be abstracted out in 8 bits.
