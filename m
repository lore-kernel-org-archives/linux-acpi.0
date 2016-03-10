From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/3] gpio: designware: convert device node to fwnode
Date: Thu, 10 Mar 2016 22:27:19 +0200
Message-ID: <CAHp75VfGJZnOWUdZkjCbraupg=KUw2-jhtiRHLxrT2uUwJdvow@mail.gmail.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
	<1457077474-124064-2-git-send-email-qiujiang@huawei.com>
	<CANk1AXRTvSRZkWMQf03Ty+ouxcJDpD-hJ9tjXSqh5Z0OzOhk+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:32783 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbcCJU1U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 15:27:20 -0500
In-Reply-To: <CANk1AXRTvSRZkWMQf03Ty+ouxcJDpD-hJ9tjXSqh5Z0OzOhk+w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Tull <delicious.quinoa@gmail.com>
Cc: qiujiang <qiujiang@huawei.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

On Thu, Mar 10, 2016 at 9:09 PM, Alan Tull <delicious.quinoa@gmail.com> wrote:
> On Fri, Mar 4, 2016 at 1:44 AM, qiujiang <qiujiang@huawei.com> wrote:
>> This patch converts device node to fwnode in
>> dwapb_port_property for designware gpio driver,
>> so as to provide a unified data structure for DT
>> and ACPI bindings.
>>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: qiujiang <qiujiang@huawei.com>

>> @@ -496,18 +492,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>                  * Only port A can provide interrupts in all configurations of
>>                  * the IP.
>>                  */
>> -               if (pp->idx == 0 &&
>> -                   of_property_read_bool(port_np, "interrupt-controller")) {
>> -                       pp->irq = irq_of_parse_and_map(port_np, 0);
>> +               if (dev->of_node && pp->idx == 0 &&
>> +                       of_property_read_bool(to_of_node(fwnode),
>> +                               "interrupt-controller")) {
>
> Hi Qiujiang,
>
> Is there a reason to use "of_property_read_bool" here instead of
> "device_property_read_bool" or similar?

Yeah, this patch looks unfinished.

This should be
     if (pp->idx == 0 &&  fwnode_property_read_bool(fwnode,
"interrupt-controller")) {

>
> Alan
>
>> +                       pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);

But here should be common method called which takes fwnode on input.

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
>> +               pp->name        = to_of_node(fwnode)->full_name;

Also those two should be device property source agnostic. That's what
I tried to tell earlier.

-- 
With Best Regards,
Andy Shevchenko
