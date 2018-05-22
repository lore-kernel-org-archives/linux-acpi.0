From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v6 2/2] acpi: apei: Do not panic() on PCIe errors reported
 through GHES
Date: Tue, 22 May 2018 10:18:02 -0500
Message-ID: <cf2e0a02-fb99-efde-0b41-63585c9d8844@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-3-mr.nuke.me@gmail.com>
 <CAJZ5v0h+U1zNK+LdOH_pU7kb+c6VK7erZCRqaV2WauDE2cwc6w@mail.gmail.com>
 <5a72a503-e8d5-c317-89b4-86e574c48064@gmail.com>
 <50e318d3-b581-ad8b-d0e3-3e6c7b0da080@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50e318d3-b581-ad8b-d0e3-3e6c7b0da080@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 05/22/2018 10:15 AM, Tyler Baicar wrote:
> On 5/22/2018 10:32 AM, Alex G. wrote:
>> I think the biggest problem is having a policy to panic on "fatal"
>> errors, instead of letting the error handler make that decision. I'd
>> much rather kill that stupid policy, but people seem to like it for some
>> reason.
>>
> You can get around that panic and still have the error handled as
> AER_FATAL in
> the current code. Your FW needs to mark the error as RECOVERABLE and then
> set the CPER_SEC_RESET flag.

Of course, that would be ideal. But experience shows that firmware
doesn't do this. That's the whole point: firmware sends questionable data.

Alex

> https://elixir.bootlin.com/linux/v4.17-rc6/source/drivers/acpi/apei/ghes.c#L450
> 
> 
> Thanks,
> Tyler
> 
