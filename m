From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v5 1/3] gpio: designware: convert device node to fwnode
Date: Fri, 11 Mar 2016 08:48:09 +0800
Message-ID: <56E215C9.8030208@huawei.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
 <1457077474-124064-2-git-send-email-qiujiang@huawei.com>
 <CANk1AXRTvSRZkWMQf03Ty+ouxcJDpD-hJ9tjXSqh5Z0OzOhk+w@mail.gmail.com>
 <CAHp75VfGJZnOWUdZkjCbraupg=KUw2-jhtiRHLxrT2uUwJdvow@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:12453 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932893AbcCKAuY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 19:50:24 -0500
In-Reply-To: <CAHp75VfGJZnOWUdZkjCbraupg=KUw2-jhtiRHLxrT2uUwJdvow@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

=E5=9C=A8 2016/3/11 4:27, Andy Shevchenko =E5=86=99=E9=81=93:
> On Thu, Mar 10, 2016 at 9:09 PM, Alan Tull <delicious.quinoa@gmail.co=
m> wrote:
>> On Fri, Mar 4, 2016 at 1:44 AM, qiujiang <qiujiang@huawei.com> wrote=
:
>>> This patch converts device node to fwnode in
>>> dwapb_port_property for designware gpio driver,
>>> so as to provide a unified data structure for DT
>>> and ACPI bindings.
>>>
>>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>>> @@ -496,18 +492,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>>                  * Only port A can provide interrupts in all config=
urations of
>>>                  * the IP.
>>>                  */
>>> -               if (pp->idx =3D=3D 0 &&
>>> -                   of_property_read_bool(port_np, "interrupt-contr=
oller")) {
>>> -                       pp->irq =3D irq_of_parse_and_map(port_np, 0=
);
>>> +               if (dev->of_node && pp->idx =3D=3D 0 &&
>>> +                       of_property_read_bool(to_of_node(fwnode),
>>> +                               "interrupt-controller")) {
>> Hi Qiujiang,
>>
>> Is there a reason to use "of_property_read_bool" here instead of
>> "device_property_read_bool" or similar?
> Yeah, this patch looks unfinished.
>
> This should be
>      if (pp->idx =3D=3D 0 &&  fwnode_property_read_bool(fwnode,
> "interrupt-controller")) {
Yes, agreed, "to_of_node" will never appear in this patch : )
>> Alan
>>
>>> +                       pp->irq =3D irq_of_parse_and_map(to_of_node=
(fwnode), 0);
> But here should be common method called which takes fwnode on input.
Agreed.
>
>>>                         if (!pp->irq) {
>>>                                 dev_warn(dev, "no irq for bank %s\n=
",
>>> -                                        port_np->full_name);
>>> +                                        to_of_node(fwnode)->full_n=
ame);
>>>                         }
>>>                 }
>>>
>>>                 pp->irq_shared  =3D false;
>>>                 pp->gpio_base   =3D -1;
>>> -               pp->name        =3D port_np->full_name;
>>> +               pp->name        =3D to_of_node(fwnode)->full_name;
> Also those two should be device property source agnostic. That's what
> I tried to tell earlier.
Agreed.
Thanks, Jiang

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
