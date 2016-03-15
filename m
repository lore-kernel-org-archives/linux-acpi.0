From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v5 1/3] gpio: designware: convert device node to fwnode
Date: Tue, 15 Mar 2016 20:56:40 +0800
Message-ID: <56E80688.3030407@huawei.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
 <1457077474-124064-2-git-send-email-qiujiang@huawei.com>
 <CANk1AXRTvSRZkWMQf03Ty+ouxcJDpD-hJ9tjXSqh5Z0OzOhk+w@mail.gmail.com>
 <CAHp75VfGJZnOWUdZkjCbraupg=KUw2-jhtiRHLxrT2uUwJdvow@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [58.251.152.64] ([58.251.152.64]:59734 "EHLO
	szxga01-in.huawei.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcCOM5k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2016 08:57:40 -0400
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
> "interrupt-controller")) {=20
>> Alan
>>
>>> +                       pp->irq =3D irq_of_parse_and_map(to_of_node=
(fwnode), 0);
> But here should be common method called which takes fwnode on input.
Hi Alan, Andy,

There is some trouble to replace the interface irq_of_parse_and_map and=
 take
fwnode on input.

As far as I know, there are two common APIs to parse interrupt resource=
:
1) irq_of_parse_and_map() - It is a DT specific API, and have to use of=
_node as
input.

2) platform_get_irq() - It could be used to DT as well as ACPI, It need=
s platform_
device as input. In this driver, the DTs is defined as this:

pc_gpio0: gpio@802e0000 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        compatible =3D "snps,dw-apb-gpio";
                        reg =3D <0x0 0x802e0000 0x0 0x10000>;

                        porta: gpio-controller@0 {
                                compatible =3D "snps,dw-apb-gpio-port";
                                gpio-controller;
                                #gpio-cells =3D <2>;
                                snps,nr-gpios =3D <32>;
                                reg =3D <0>;
                                interrupt-controller;
                                #interrupt-cells =3D <2>;
                                interrupts =3D <0 312 4>;
                       };
 };

The compatible string, which is "snps,dw-apb-gpio", is only for the par=
ent node.
That is mean, there is no platform device for the child node, but the i=
nterrupt
resource is defined in child node.

Is there any other APIs can be used to parse interrupts resource using =
fwnode
as input?

Thanks, Jiang
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
>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
