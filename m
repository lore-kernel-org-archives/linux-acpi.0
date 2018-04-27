From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
Date: Fri, 27 Apr 2018 14:08:14 +0100
Message-ID: <a00dd78c-6e94-26a2-1515-c677a032e6ce@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-5-jeremy.linton@arm.com>
 <16324b54-42d4-d9bc-6d57-de52431dc209@arm.com>
 <ee956bd3-37d7-b9ac-af55-dc297397476d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee956bd3-37d7-b9ac-af55-dc297397476d@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com, Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com, ard.biesheuvel@linaro.org
List-Id: linux-acpi@vger.kernel.org



On 26/04/18 19:33, Jeremy Linton wrote:
> Hi,
> 
> On 04/26/2018 05:27 AM, Sudeep Holla wrote:
>>
>>
>> On 26/04/18 00:31, Jeremy Linton wrote:
>>> Its helpful to be able to lookup the acpi_processor_id associated
>>> with a logical cpu. Provide an arm64 helper to do this.
>>>
>>
>> As I pointed out in the earlier version, this patch is not required.
>> The acpi_id stored in the acpi_processor can be used for this.
>> Won't the below change make it work ? I can't think of any reason why it
>> shouldn't.
> 
> So, I only noticed your previous email last night on the mail archive,
> as I was applying your review/ack tags and couldn't find a response for
> this patch, seem the spam/etc filters need some further tweaking!
>

Ah that's bad.

> At that point, I was pretty sure the suggestion wasn't going to work out
> of the box as a lot of this code is running fairly early in the boot
> process. I spent a bit of time and plugged the change in to verify that
> assertion, and yes the per_cpu processor/acpi bits aren't setup early
> enough to be used by much of this code. It is being called from
> init_cpu_topology()/smp_prepare_cpus() which precedes
> do_basic_setup/do_initcalls() which is what runs the acpi_init()
> sequence which ends up eventually allocating the required data
> structures. So without restructuring the core boot sequence, this seems
> like a reasonable solution.
> 

OK makes sense. I completely ignored topology related patches as I
haven't looked at them yet and assumed cacheinfo is the only user. Sorry
for that.

-- 
Regards,
Sudeep
