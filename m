From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
Date: Mon, 21 May 2018 11:15:13 +0100
Message-ID: <90f9c7c6-b7ae-9e23-3e15-eec44ba39703@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
 <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com>
 <20180517154701.GA20281@e107155-lin>
 <CAHp75VfEYcPdECmDDOd8CLBBXGpcwSUGQRr0x8VTb1-7j51_0Q@mail.gmail.com>
 <7c9a4921-d4da-f1db-85ed-7d7f917be30c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7c9a4921-d4da-f1db-85ed-7d7f917be30c@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Jeremy Linton <jeremy.linton@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <Mark.Rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, Palmer Dabbelt <palmer@sifive.com>, Len
List-Id: linux-acpi@vger.kernel.org



On 21/05/18 10:27, Sudeep Holla wrote:
> 
> 
> On 18/05/18 22:50, Andy Shevchenko wrote:
>> On Thu, May 17, 2018 at 6:47 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>> Is below patch does what you were looking for ?
>>
>> Somewhat.
>> See below for some minors.
>>
> 
> Thanks
> 
>>> of_property_read_u64 searches for a property in a device node and read
>>> a 64-bit value from it. Instead of using of_get_property to get the
>>> property and then read 64-bit value using of_read_number, we can make
>>> use of of_property_read_u64.
>>
>> Suggested-by?
>>
> 
> Yes indeed, added it locally after I sent out this patch. Will send out
> a proper patch soon.
> 
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>>
>>> -       cache_size = of_get_property(np, propname, NULL);
>>> -       if (cache_size)
>>> -               this_leaf->size = of_read_number(cache_size, 1);
>>> +       if (!of_property_read_u64(np, propname, &cache_size))
>>> +               this_leaf->size = cache_size;
>>
>> I suppose it's something like this
>>
>> ret = of_property_...(..., &this_leaf->VAR);
>> if (ret)
>>  warning / set default / etc
> 
> OK, I do prefer this but once I was told not to use structure elements
> directly like that, but should be harmless in this particular case, will
> do so. 
> 

I spoke too early, I need to retain local u64 variable otherwise we get
incompatible pointer type(expected 'u64 *' but argument is of type
‘unsigned int *’) error with Werror=incompatible-pointer-types.

-- 
Regards,
Sudeep
