From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: dwapb: convert device node to fwnode
Date: Wed, 30 Mar 2016 14:38:02 +0300
Message-ID: <CAHp75VcDAg_aXt7ej-_zXxHMXJohRM9ErQkJQS_ryekD-7V=zw@mail.gmail.com>
References: <1458959496-57455-1-git-send-email-qiujiang@huawei.com>
	<1458959496-57455-2-git-send-email-qiujiang@huawei.com>
	<CANk1AXT5yHMwPJ7=0kSZKr+eHHdC1QXQVgstQ6QhFbUPSKuD+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CANk1AXT5yHMwPJ7=0kSZKr+eHHdC1QXQVgstQ6QhFbUPSKuD+A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alan Tull <delicious.quinoa@gmail.com>
Cc: qiujiang <qiujiang@huawei.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, atull <atull@opensource.altera.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 29, 2016 at 7:30 PM, Alan Tull <delicious.quinoa@gmail.com> wrote:
> On Fri, Mar 25, 2016 at 9:31 PM, qiujiang <qiujiang@huawei.com> wrote:
>
>> -               if (pp->idx == 0 &&
>> -                   of_property_read_bool(port_np, "interrupt-controller")) {
>> -                       pp->irq = irq_of_parse_and_map(port_np, 0);
>> +               if (dev->of_node && pp->idx == 0 &&
>> +                       fwnode_property_read_bool(fwnode,
>> +                                                 "interrupt-controller")) {
>> +                       pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
>>                         if (!pp->irq) {
>>                                 dev_warn(dev, "no irq for bank %s\n",
>> -                                        port_np->full_name);
>> +                                        to_of_node(fwnode)->full_name);
>>                         }
>>                 }
>>
>>                 pp->irq_shared  = false;
>>                 pp->gpio_base   = -1;
>> -               pp->name        = port_np->full_name;
>> +               if (dev->of_node)
>> +                       pp->name = to_of_node(fwnode)->full_name;
>
> Hi Jiang,
>
> I tested lightly on a CycloneV and it worked fine (with device tree).
>
> One suggestion for both patches: you could remove name from struct
> dwapb_port_property and get rid of pp->name and nobody would miss it.
> All it is used for is some dev_err's so the device info gets printed
> anyway.  For example (if I leave the irq out of the DT)
>
> gpio-dwapb ff708000.gpio: no irq for bank /soc/gpio@ff708000/gpio-controller@0
>
> is redundant.  The only additional info here from the name is the port
> index.  That could be added to the messages without having to get the
> name through the two property/of methods.
>

Good suggestion! That'll make patches and code cleaner.

Perhaps separate prepended  patch?

-- 
With Best Regards,
Andy Shevchenko
