From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
Date: Wed, 16 May 2018 11:56:26 +0100
Message-ID: <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <Mark.Rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, Palmer Dabbelt <palmer@sifive.com>, Len Brown <lenb@kernel.org>, John Garry <joh>
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

On 15/05/18 20:32, Andy Shevchenko wrote:
> On Tue, May 15, 2018 at 8:15 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> On 05/11/2018 06:57 PM, Jeremy Linton wrote:
> 
>>>   -     cache_size = of_get_property(this_leaf->of_node, propname, NULL);
>>> +       cache_size = of_get_property(np, propname, NULL);
>>>         if (cache_size)
>>>                 this_leaf->size = of_read_number(cache_size, 1);
> 
> Can't you switch to of_read_property_uXX() variant here?
> 

This patch is just changing the first argument to the calls. So if we
need to change, it has to be separate patch.

Now, we can use of_property_read_u64() but is there any particular
reason you mention that ? One reason I can see is that we can avoid
making explicit of_get_property call. Just wanted to the motive before I
can write the patch.

-- 
Regards,
Sudeep
