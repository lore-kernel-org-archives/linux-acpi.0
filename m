From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
Date: Wed, 2 May 2018 17:35:50 -0500
Message-ID: <5078f4ac-74e7-aad3-1e0d-4de5da31d3c4@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
 <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
 <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <Mark.Rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com, Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>, austinwc@codeaurora.org, tnowicki@caviumnetwo
List-Id: linux-acpi@vger.kernel.org

Hi,

On 05/02/2018 03:24 AM, Rafael J. Wysocki wrote:
> On Tue, May 1, 2018 at 4:46 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 26/04/18 00:31, Jeremy Linton wrote:
>>> Propagate the topology information from the PPTT tree to the
>>> cpu_topology array. We can get the thread id and core_id by assuming
>>> certain levels of the PPTT tree correspond to those concepts.
>>> The package_id is flagged in the tree and can be found by calling
>>> find_acpi_cpu_topology_package() which terminates
>>> its search when it finds an ACPI node flagged as the physical
>>> package. If the tree doesn't contain enough levels to represent
>>> all of the requested levels then the root node will be returned
>>> for all subsequent levels.
>>>
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> [..]
>>
>>> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>>>         * Discard anything that was parsed if we hit an error so we
>>>         * don't use partial information.
>>>         */
>>> -     if (of_have_populated_dt() && parse_dt_topology())
>>> +     if ((!acpi_disabled) && parse_acpi_topology())
>>
>> [nit] not sure if extra () is need above,
> 
> No, it isn't.
> 
>> but I am fine either way.
> 
> The redundant parens need to go away, really.
> 

Yah, I missed this one, is there a linter everyone is using that finds 
these?

Thanks,
