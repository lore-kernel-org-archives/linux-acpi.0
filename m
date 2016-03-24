From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v5 1/3] gpio: designware: convert device node to fwnode
Date: Thu, 24 Mar 2016 09:24:29 +0800
Message-ID: <56F341CD.2050300@huawei.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
 <1457077474-124064-2-git-send-email-qiujiang@huawei.com>
 <CANk1AXRTvSRZkWMQf03Ty+ouxcJDpD-hJ9tjXSqh5Z0OzOhk+w@mail.gmail.com>
 <CAHp75VfGJZnOWUdZkjCbraupg=KUw2-jhtiRHLxrT2uUwJdvow@mail.gmail.com>
 <56F28107.6090305@huawei.com>
 <CANk1AXSJQh4VovcBVqvt=s4f7yBVLLyhG3js4o1HDNW80u-=JQ@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CANk1AXSJQh4VovcBVqvt=s4f7yBVLLyhG3js4o1HDNW80u-=JQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alan Tull <delicious.quinoa@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, atull <atull@opensource.altera.com>
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2016/3/24 0:20, Alan Tull =E5=86=99=E9=81=93:
> On Wed, Mar 23, 2016 at 6:41 AM, Jiang Qiu <qiujiang@huawei.com> wrot=
e:
>> =E5=9C=A8 2016/3/11 4:27, Andy Shevchenko =E5=86=99=E9=81=93:
>>> On Thu, Mar 10, 2016 at 9:09 PM, Alan Tull <delicious.quinoa@gmail.=
com> wrote:
>>>> On Fri, Mar 4, 2016 at 1:44 AM, qiujiang <qiujiang@huawei.com> wro=
te:
>>>>> This patch converts device node to fwnode in
>>>>> dwapb_port_property for designware gpio driver,
>>>>> so as to provide a unified data structure for DT
>>>>> and ACPI bindings.
>>>>>
>>>>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>>>>> @@ -496,18 +492,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>>>>>                  * Only port A can provide interrupts in all conf=
igurations of
>>>>>                  * the IP.
>>>>>                  */
>>>>> -               if (pp->idx =3D=3D 0 &&
>>>>> -                   of_property_read_bool(port_np, "interrupt-con=
troller")) {
>>>>> -                       pp->irq =3D irq_of_parse_and_map(port_np,=
 0);
>>>>> +               if (dev->of_node && pp->idx =3D=3D 0 &&
>>>>> +                       of_property_read_bool(to_of_node(fwnode),
>>>>> +                               "interrupt-controller")) {
>>>> Hi Qiujiang,
>>>>
>>>> Is there a reason to use "of_property_read_bool" here instead of
>>>> "device_property_read_bool" or similar?
>>> Yeah, this patch looks unfinished.
>>>
>>> This should be
>>>      if (pp->idx =3D=3D 0 &&  fwnode_property_read_bool(fwnode,
>>> "interrupt-controller")) {
>> Hi, Alan, Andy, Mika,
>>
>> Many thanks for help me review this patchset.
>>
>> I tried to use a unified interface to parse the interrupts resource =
in DT and ACPI,
>> but it looks difficult because of the hierarchy device node structur=
e as follow:
>>
>> pc_gpio1: gpio@802f0000 {
>>             #address-cells =3D <1>;
>>             #size-cells =3D <0>;
>>             compatible =3D "snps,dw-apb-gpio";
>>             reg =3D <0x0 0x802f0000 0x0 0x10000>;
>>
>>             porta: gpio-controller@0 {
>>                 compatible =3D "snps,dw-apb-gpio-port";
>>                 gpio-controller;
>>                 #gpio-cells =3D <2>;
>>                 snps,nr-gpios =3D <32>;
>>                 reg =3D <0>;
>>                 interrupt-controller;
>>                 #interrupt-cells =3D <2>;
>>                 interrupts =3D <0 313 4>;
>>             };
>> };
>>
>> According to the designware gpio databook, each GPIO controller incl=
udes 4 ports
>> (porta,b,c,d), only porta can be a interrupt controller. So, I moved=
 the interrupts
>> resource to the parent node from porta in ACPI.
>>
>> Device(GPI0) {
>>         Name(_HID, "HISI0181")
>>         Name(_ADR, 0) // _ADR: Address
>>         Name(_UID, 0)
>>
>>         Name (_CRS, ResourceTemplate ()  {
>>             Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
>>             Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusiv=
e,,,)  {344} //moved here
>>         })
>>
>>         Device(PRTa) {
>>             Name (_DSD, Package () {
>>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                 Package () {
>>                     Package () {"reg",0},
>>                     Package () {"snps,nr-gpios",32},
>>                 }
>>             })
>>         }
>> }
>>
>> That is to say, if GPI0 should be a interrupt controller, the child =
node PRTa must be
>> present first, then add the interrupt resource to the parent node GP=
I0 scope.
>>
>> Dose this proposal sounds ok? if yes, we can do that for DT. If not,=
 there can only
>> keep two branches to parse the IRQ resource, and the code looks stra=
nge.
> Hi Jiang,
>
> Are you suggesting a change for the DT to make it similar to the ACPI
> case?  DT changes create unexpected breakages when people upgrade
> their kernel even if the change is minor.  How bad will the code look
> if you implement it as the two separate code paths as you suggest?
>
> Alan

Agreed. It would better do not make any change for DT if possible. If k=
eeping the
two separate code paths, as presented above, I have to do those check l=
ike
"if (dev->of_node)" and covert back the fwnode to of_node, so as to par=
se IRQ
resource in DT. Andy think this patch looks unfinished if used to_of_no=
de.

Andy, do you think it acceptable if keeping two separate paths for DT a=
nd ACPI?

>> That would be great if I can get some help from you.
>>
>> Best Regards
>> Jiang
>>>> Alan
>>>>
>>>>> +                       pp->irq =3D irq_of_parse_and_map(to_of_no=
de(fwnode), 0);
>>> But here should be common method called which takes fwnode on input=
=2E
>>>
>>>>>                         if (!pp->irq) {
>>>>>                                 dev_warn(dev, "no irq for bank %s=
\n",
>>>>> -                                        port_np->full_name);
>>>>> +                                        to_of_node(fwnode)->full=
_name);
>>>>>                         }
>>>>>                 }
>>>>>
>>>>>                 pp->irq_shared  =3D false;
>>>>>                 pp->gpio_base   =3D -1;
>>>>> -               pp->name        =3D port_np->full_name;
>>>>> +               pp->name        =3D to_of_node(fwnode)->full_name=
;
>>> Also those two should be device property source agnostic. That's wh=
at
>>> I tried to tell earlier.
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>


--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
