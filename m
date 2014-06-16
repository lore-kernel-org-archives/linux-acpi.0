From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Mon, 16 Jun 2014 10:12:27 +0800
Message-ID: <539E528B.90908@intel.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com> <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com> <53995488.20308@intel.com> <alpine.DEB.2.02.1406120025050.23724@chino.kir.corp.google.com> <53996152.2000407@intel.com> <alpine.DEB.2.02.1406121415150.8305@chino.kir.corp.google.com> <539A60FC.1050301@intel.com> <alpine.DEB.2.02.1406131445130.31981@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57340 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbaFPCNU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jun 2014 22:13:20 -0400
In-Reply-To: <alpine.DEB.2.02.1406131445130.31981@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2014=E5=B9=B406=E6=9C=8814=E6=97=A5 05:46, David Rientjes wrote:
> On Fri, 13 Jun 2014, Lan Tianyu wrote:
>=20
>> How about this?
>>
>> -       result =3D acpi_battery_update(battery, false);
>> -       if (result)
>> +
>> +       /*
>> +        * Some machines'(E,G Lenovo Z480) ECs are not stable
>> +        * during boot up and this causes battery driver fails to be
>> +        * probed due to failure of getting battery information
>> +        * from EC sometimes. After several retries, the operation
>> +        * may work. So add retry code here and 20ms sleep between
>> +        * every retries.
>> +        */
>> +       while (acpi_battery_update(battery, false) && retry--)
>> +               msleep(20);
>> +       if (!retry) {
>> +               result =3D -ENODEV;
>>                 goto fail;
>> +       }
>> +
>=20
> I think you want --retry and not retry--.

My original purpose is to retry 5 times after the first try fails.
If use "--retry" here, it just retries 4 times.

>  Otherwise it's possible for the=20
> final call to acpi_battery_update() to succeed and now it's returning=
=20
> -ENODEV.
>=20

Yes, it maybe and I will change code like the following.

while ((result =3D acpi_battery_update(battery, false)) && retry--)
       msleep(20);
if (result)
       goto fail;


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
