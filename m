From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
Date: Tue, 15 May 2018 22:32:37 +0300
Message-ID: <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <Mark.Rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, Palmer Dabbelt <palmer@sifive.com>, Len Brown <lenb@kernel.org>, John Garry <joh>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 15, 2018 at 8:15 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 05/11/2018 06:57 PM, Jeremy Linton wrote:

>>   -     cache_size = of_get_property(this_leaf->of_node, propname, NULL);
>> +       cache_size = of_get_property(np, propname, NULL);
>>         if (cache_size)
>>                 this_leaf->size = of_read_number(cache_size, 1);

Can't you switch to of_read_property_uXX() variant here?

>> -               line_size = of_get_property(this_leaf->of_node, propname,
>> NULL);
>> +               line_size = of_get_property(np, propname, NULL);

Ditto.

>>   -     nr_sets = of_get_property(this_leaf->of_node, propname, NULL);
>> +       nr_sets = of_get_property(np, propname, NULL);
>>         if (nr_sets)
>>                 this_leaf->number_of_sets = of_read_number(nr_sets, 1);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
