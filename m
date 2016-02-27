From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v3 1/2] gpio: designware: switch device node to fwnode
Date: Sat, 27 Feb 2016 15:15:40 +0800
Message-ID: <56D14D1C.6090706@huawei.com>
References: <1456317210-42742-1-git-send-email-qiujiang@huawei.com>
 <1456317210-42742-2-git-send-email-qiujiang@huawei.com>
 <CAHp75Vd4dNJpuiMMizYbOpv+pZd30RcNA+kPoF6_4Vukk62iFw@mail.gmail.com>
 <56CEEC58.9050303@huawei.com>
 <CAHp75Vecxx+YBrZ9d4oZzqS_X3cxUQ4UaSvjqjhuaoJ4O9xauw@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:15633 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933AbcB0HQE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Feb 2016 02:16:04 -0500
In-Reply-To: <CAHp75Vecxx+YBrZ9d4oZzqS_X3cxUQ4UaSvjqjhuaoJ4O9xauw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

=E5=9C=A8 2016/2/25 21:43, Andy Shevchenko =E5=86=99=E9=81=93:
> On Thu, Feb 25, 2016 at 1:58 PM, Jiang Qiu <qiujiang@huawei.com> wrot=
e:
>> =E5=9C=A8 2016/2/24 21:46, Andy Shevchenko =E5=86=99=E9=81=93:
>>> On Wed, Feb 24, 2016 at 2:33 PM, qiujiang <qiujiang@huawei.com> wro=
te:
>=20
>>>  - why do you use fwnode_*() instead of device_property_*() calls?
>>> What prevents us to move to device property API directly?
>> Yes, it looks more reasonable by using devce_property. Howerver,
>> device_get_child_node_count was used here to find each child node. T=
his
>> API output the fwnode_handle for each child node directly, but devic=
e
>> property APIs need 'dev' data instead. Actually, the effects of fwno=
de_*()
>> and device_*() are the same. So, I used fwnode_*() APIs here.
>=20
> Right, looks okay then.
>=20
>>>> -       node =3D dev->of_node;
>>>> -       if (!IS_ENABLED(CONFIG_OF_GPIO) || !node)
>>>> +       if (!IS_ENABLED(CONFIG_OF_GPIO) || !(dev->of_node))
>>>>                 return ERR_PTR(-ENODEV);
>>>
>>> So, since you converted to fwnode, do you still need this check?
>>>
>> Although this patch coverted device node to fwnode, only DTs binding=
 was
>> supported here, and patch2 support ACPI will remove this check.
>=20
> Yes, but like I said below device_get_child_node_count() will take
> care of that, will it?
Right, device_get_child_node_count() will take of it, this should be re=
moved.
>=20
>>>>
>>>> -       nports =3D of_get_child_count(node);
>>>> +       nports =3D device_get_child_node_count(dev);
>>>>         if (nports =3D=3D 0)
>>>>                 return ERR_PTR(-ENODEV);
>>>
>>> ...I think this one fail if it will not found any child.
>> This one fail? yes, it will return to failure.
>> I am not very clear here.
>=20
> See above.
Here, device_get_child_node_count will return ZERO if there is not any =
child.
So, I think this will work ok, will it?
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
