From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
Date: Wed, 16 May 2018 10:24:54 +0200
Message-ID: <CAJZ5v0jE4JJbcK-BiFg_JVf00JZCvbMFRnrkTdJTOwz0vW_ZMg@mail.gmail.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180511235807.30834-6-jeremy.linton@arm.com>
 <CAJZ5v0h4OeTaG2h0Q1c8zX93tici_nfLftpEyKWSkXoztHuUDg@mail.gmail.com> <7cefb087-f41a-0a73-ef77-b560d338be4b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7cefb087-f41a-0a73-ef77-b560d338be4b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <Mark.Rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com, Len Brown <lenb@kern>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 15, 2018 at 11:42 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
>
> On 05/12/2018 05:09 AM, Rafael J. Wysocki wrote:
>>
>> On Sat, May 12, 2018 at 1:58 AM, Jeremy Linton <jeremy.linton@arm.com>
>> wrote:
>>>

[cut]

>>
>>
>> I don't think you really need the explicit type cast here and above,
>> but that's very minor.
>>
>>> +}
>>
>>
>> Please feel free to add
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> to the patch and route it through the arch tree as needed.
>
>
> Thanks for looking at this (and the ack of course)!
>
> As an FYI, the in my build without the type cast, the
> -Werror=incompatible-pointer-types (sourced from the root Makefile) triggers
> an error.

Fair enough.
