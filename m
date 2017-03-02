From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 4/4] acpi: Move the verification of duplicate proc_id
 from booting time to hot-plug time
Date: Thu, 2 Mar 2017 16:20:41 +0800
Message-ID: <50d8e0f6-ab69-49ea-9319-4dfea223f260@cn.fujitsu.com>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1487580471-17665-5-git-send-email-douly.fnst@cn.fujitsu.com>
 <alpine.DEB.2.20.1703011212450.4005@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1703011212450.4005@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@kernel.org, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, xiaolong.ye@intel.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi tglx,

At 03/01/2017 07:26 PM, Thomas Gleixner wrote:
> On Mon, 20 Feb 2017, Dou Liyang wrote:
>
> Please make your subject line short and a precise summary phrase, not an
> overlong sentence.
>
>> After we revert the the mapping of "cpuid <-> nodeid" fixed at the
>> booting time. and do it at the hot-plug time. we should also do the
>> verification of duplicate proc_id at the time.
>
> The revert is completely irrelevant to this change, really. The reference
> is just confusing.
>

Yes, Maybe I should split them like before.


>> The patch rename the verfication function and move it to
>> drivers/acpi::acpi_processor_get_info.
>
> See previous mails ....
>
> Let me give you another changelog example:
>

Thanks again.

> Subject: acpi/processor: Check for duplicate processor ids at hotplug time
>
>   The check for duplicate processor ids happens at boot time based on the
>   ACPI table contents, but the final sanity checks for a processor happen
>   at hotplug time.
>
>   At hotplug time, where the physical information is available, which might
>   differ from the ACPI table information, a check for duplicate processor
>   ids is missing.
>
>   Add it to the hotplug checks and rename the function so it better
>   reflects its purpose.
>
> Hmm?

Yes, thanks again. I learned a lot in that patchset.

>
>>
>> -bool __init acpi_processor_validate_proc_id(int proc_id)
>> +bool duplicate_processor_id(int proc_id)
>
> Please keep the acpi_ prefix. acpi_duplicate_processor_id().

OK, I will.

Thanks,

	Liyang.
>
> Thanks,
>
> 	tglx
>
>
>
