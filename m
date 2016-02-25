From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v3 1/2] gpio: designware: switch device node to fwnode
Date: Thu, 25 Feb 2016 19:58:16 +0800
Message-ID: <56CEEC58.9050303@huawei.com>
References: <1456317210-42742-1-git-send-email-qiujiang@huawei.com>
 <1456317210-42742-2-git-send-email-qiujiang@huawei.com>
 <CAHp75Vd4dNJpuiMMizYbOpv+pZd30RcNA+kPoF6_4Vukk62iFw@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:58958 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760135AbcBYL6n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2016 06:58:43 -0500
In-Reply-To: <CAHp75Vd4dNJpuiMMizYbOpv+pZd30RcNA+kPoF6_4Vukk62iFw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

=E5=9C=A8 2016/2/24 21:46, Andy Shevchenko =E5=86=99=E9=81=93:
> On Wed, Feb 24, 2016 at 2:33 PM, qiujiang <qiujiang@huawei.com> wrote=
:
>> This patch switch device node to fwnode in dwapb_port_property,
>> so as to apply a unified data structure for DT and ACPI.
>>
>> This change also needs to be done in intel_quark_i2c_gpio driver,
>> since it depends on gpio-dwapb driver.
>>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: qiujiang <qiujiang@huawei.com>
>=20
> Yes, something like this.
> Though I have questions:
>  - why do you use fwnode_*() instead of device_property_*() calls?
> What prevents us to move to device property API directly?
Yes, it looks more reasonable by using devce_property. Howerver,
device_get_child_node_count was used here to find each child node. This
API output the fwnode_handle for each child node directly, but device
property APIs need 'dev' data instead. Actually, the effects of fwnode_=
*()
and device_*() are the same. So, I used fwnode_*() APIs here.

If there is any other more way to traverse child nodes, let me know.
Thank you.
>=20
>> -       gpio->domain =3D irq_domain_add_linear(node, ngpio,
>> -                                            &irq_generic_chip_ops, =
gpio);
>> +       gpio->domain =3D irq_domain_create_linear(fwnode, ngpio,
>> +                                                &irq_generic_chip_o=
ps, gpio);
>=20
> Are they equivalent?
Yes, they are equivalent.
>=20
>> @@ -415,7 +415,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio=
 *gpio,
>>         }
>>
>>  #ifdef CONFIG_OF_GPIO
>> -       port->gc.of_node =3D pp->node;
>> +       port->gc.of_node =3D to_of_node(pp->fwnode);
>=20
> If fwnode is not OF one?
> Perhaps, something like ... =3D is_of_node() ? to_of_node() : NULL;
>=20
The way you suggested is more resonable, I will fixed it in next versio=
n.
>=20
>> -       node =3D dev->of_node;
>> -       if (!IS_ENABLED(CONFIG_OF_GPIO) || !node)
>> +       if (!IS_ENABLED(CONFIG_OF_GPIO) || !(dev->of_node))
>>                 return ERR_PTR(-ENODEV);
>=20
> So, since you converted to fwnode, do you still need this check?
>
Although this patch coverted device node to fwnode, only DTs binding wa=
s
supported here, and patch2 support ACPI will remove this check.
>>
>> -       nports =3D of_get_child_count(node);
>> +       nports =3D device_get_child_node_count(dev);
>>         if (nports =3D=3D 0)
>>                 return ERR_PTR(-ENODEV);
>=20
> ...I think this one fail if it will not found any child.
This one fail? yes, it will return to failure.
I am not very clear here.
>=20
>> -               if (of_property_read_u32(port_np, "reg", &pp->idx) |=
|
>> +               if (fwnode_property_read_u32(fwnode, "reg", &pp->idx=
) ||
>=20
> device_property_*() ?
>=20
>>                     pp->idx >=3D DWAPB_MAX_PORTS) {
>>                         dev_err(dev, "missing/invalid port index for=
 %s\n",
>> -                               port_np->full_name);
>> +                               to_of_node(fwnode)->full_name);
>=20
> If it's not OF?
This is checked above, and patch2 will remove it.
>=20
>> -               if (of_property_read_u32(port_np, "snps,nr-gpios",
>> +               if (fwnode_property_read_u32(fwnode, "snps,nr-gpios"=
,
>=20
> Ditto.
>=20
>>                                          &pp->ngpio)) {
>>                         dev_info(dev, "failed to get number of gpios=
 for %s\n",
>> -                                port_np->full_name);
>> +                                to_of_node(fwnode)->full_name);
>=20
> Ditto.
>=20
>>                 if (pp->idx =3D=3D 0 &&
>> -                   of_property_read_bool(port_np, "interrupt-contro=
ller")) {
>> -                       pp->irq =3D irq_of_parse_and_map(port_np, 0)=
;
>> +                       of_property_read_bool(to_of_node(fwnode),
>> +                               "interrupt-controller")) {
>=20
> device_property_*() ?
>=20
>> +                       pp->irq =3D irq_of_parse_and_map(to_of_node(=
fwnode), 0);
>>                         if (!pp->irq) {
>>                                 dev_warn(dev, "no irq for bank %s\n"=
,
>> -                                        port_np->full_name);
>> +                                        to_of_node(fwnode)->full_na=
me);
>>                         }
>>                 }
>>
>>                 pp->irq_shared  =3D false;
>>                 pp->gpio_base   =3D -1;
>> -               pp->name        =3D port_np->full_name;
>> +               pp->name =3D to_of_node(fwnode)->full_name;
>>         }
>>
>>         return pdata;
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
