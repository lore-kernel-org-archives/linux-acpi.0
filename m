From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Mon, 16 Jun 2014 10:43:31 +0800
Message-ID: <539E59D3.7080508@intel.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com> <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com> <53995488.20308@intel.com> <alpine.DEB.2.02.1406120025050.23724@chino.kir.corp.google.com> <53996152.2000407@intel.com> <alpine.DEB.2.02.1406121415150.8305@chino.kir.corp.google.com> <539A60FC.1050301@intel.com> <alpine.DEB.2.02.1406131445130.31981@chino.kir.corp.google.com> <539E528B.90908@intel.com> <1AE640813FDE7649BE1B193DEA596E880262DA59@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8227 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbaFPCof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jun 2014 22:44:35 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880262DA59@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: David Rientjes <rientjes@google.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "naszar@ya.ru" <naszar@ya.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2014=E5=B9=B406=E6=9C=8816=E6=97=A5 10:35, Zheng, Lv wrote:
> Hi,
>=20
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger=
=2Ekernel.org] On Behalf Of Lan Tianyu
>> Sent: Monday, June 16, 2014 10:12 AM
>> To: David Rientjes
>> Cc: rjw@rjwysocki.net; lenb@kernel.org; naszar@ya.ru; linux-acpi@vge=
r.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information =
if failed during probing
>>
>> On 2014=E5=B9=B406=E6=9C=8814=E6=97=A5 05:46, David Rientjes wrote:
>>> On Fri, 13 Jun 2014, Lan Tianyu wrote:
>>>
>>>> How about this?
>>>>
>>>> -       result =3D acpi_battery_update(battery, false);
>>>> -       if (result)
>>>> +
>>>> +       /*
>>>> +        * Some machines'(E,G Lenovo Z480) ECs are not stable
>=20
> Just a reminder.
>=20
> This statement may not be true.
> The issue may be caused by the EC driver itself.
> So we need to investigate.

Not sure. The bug doesn't happen every time. 5-10% during boot up.

>=20
>>>> +        * during boot up and this causes battery driver fails to =
be
>>>> +        * probed due to failure of getting battery information
>>>> +        * from EC sometimes. After several retries, the operation
>>>> +        * may work. So add retry code here and 20ms sleep between
>>>> +        * every retries.
>>>> +        */
>>>> +       while (acpi_battery_update(battery, false) && retry--)
>=20
> If EC hardware is stable, why we need to do retry here?
>=20

Yes, if it can work normally every time, we don't need retry here.


> Thanks and best regards
> -Lv
>=20
>>>> +               msleep(20);
>>>> +       if (!retry) {
>>>> +               result =3D -ENODEV;
>>>>                 goto fail;
>>>> +       }
>>>> +
>>>
>>> I think you want --retry and not retry--.
>>
>> My original purpose is to retry 5 times after the first try fails.
>> If use "--retry" here, it just retries 4 times.
>>
>>>  Otherwise it's possible for the
>>> final call to acpi_battery_update() to succeed and now it's returni=
ng
>>> -ENODEV.
>>>
>>
>> Yes, it maybe and I will change code like the following.
>>
>> while ((result =3D acpi_battery_update(battery, false)) && retry--)
>>        msleep(20);
>> if (result)
>>        goto fail;
>>
>>
>> --
>> Best regards
>> Tianyu Lan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
