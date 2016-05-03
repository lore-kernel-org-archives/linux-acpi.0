From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [PATCH v10 1/3] gpio: dwapb: remove name from dwapb_port_property
Date: Tue, 3 May 2016 11:38:36 +0800
Message-ID: <57281D3C.5020503@huawei.com>
References: <1461835923-68492-1-git-send-email-qiujiang@huawei.com>
 <1461835923-68492-2-git-send-email-qiujiang@huawei.com>
 <CACRpkdaS3+6ZJS0MJk-j4J3j2mKC-MULgCbS8Dqy=4_toy-x9Q@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:21910 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbcECDjQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 May 2016 23:39:16 -0400
In-Reply-To: <CACRpkdaS3+6ZJS0MJk-j4J3j2mKC-MULgCbS8Dqy=4_toy-x9Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>

=E5=9C=A8 4/29/2016 5:22 PM, Linus Walleij =E5=86=99=E9=81=93:
> On Thu, Apr 28, 2016 at 11:32 AM, Jiang Qiu <qiujiang@huawei.com> wro=
te:
>=20
>> This patch removed the name property from dwapb_port_property.
>> The name property is redundant, since we can get this info
>> from dwapb_gpio dev node.
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Jiang Qiu <qiujiang@huawei.com>
>=20
> Hmmm just applied another version. Oh well, applying this
> instead.

Hi, Linux, many thanks for applying.
>=20
> Yours,
> Linus Walleij
>=20
> .
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
