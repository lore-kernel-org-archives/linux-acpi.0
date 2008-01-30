From: xuqiang <likes@huawei.com>
Subject: Re: Re: an error an bug
Date: Wed, 30 Jan 2008 16:46:26 +0800
Message-ID: <0JVG006G88DEB9@szxml04-in.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [61.144.161.55] ([61.144.161.55]:28131 "EHLO
	szxga03-in.huawei.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756147AbYA3Isc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2008 03:48:32 -0500
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0JVG00C8F8DGHK@szxga03-in.huawei.com> for
 linux-acpi@vger.kernel.org; Wed, 30 Jan 2008 16:46:28 +0800 (CST)
Received: from huawei.com ([172.24.1.24])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0JVG00GGP8DE27@szxga03-in.huawei.com> for
 linux-acpi@vger.kernel.org; Wed, 30 Jan 2008 16:46:27 +0800 (CST)
Received: from x52952 ([10.161.58.135])
 by szxml04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTPA id <0JVG006G48DEB9@szxml04-in.huawei.com> for
 linux-acpi@vger.kernel.org; Wed, 30 Jan 2008 16:46:26 +0800 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi@linux.intel.com" <acpi@linux.intel.com>

Alexey Starikovskiy,=C4=FA=BA=C3=A3=A1

	ok, I will get all needed information. But can you tell me what [\_SB_=
=2ERPME] [\_SB_.RDPE] and [\_GPE._L18] mean? =20

=3D=3D=3D=3D=3D=3D=3D 2008-01-30 11:33:00 =C4=FA=D4=DA=C0=B4=D0=C5=D6=D0=
=D0=B4=B5=C0=A3=BA=3D=3D=3D=3D=3D=3D=3D

>Hi Likes,
>
>What kernel are you using?
>Please open bug in bugzilla.kernel.org for ACPI and provide all needed=
=20
>information, including dmesg (from the beginning) and acpidump.
>
>xuqiang wrote:
>> hi,all:
>>    an error happened. in an hour, more than 30 million lines were re=
peated and writed to /var/log/messages and /var/log/warn.
>> Jan  1 05:08:06 bond0 kernel:     ACPI-0347: *** Error: Handler for =
[SystemMemory] returned AE_NO_MEMORY
>> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execu=
tion failed [\_SB_.RDPE] (Node cdf7aec0), AE_NO_MEMORY
>> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execu=
tion failed [\_SB_.RPME] (Node cdf7ae20), AE_NO_MEMORY
>> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execu=
tion failed  (Node cdf7ad80), AE_NO_MEMORY
>> Jan  1 05:08:06 bond0 kernel:     ACPI-0295: *** Error: AE_NO_MEMORY=
 while evaluating method [_L18] for GPE[ 0]
>> ]
>>  where can I get enough information to understand the error or who c=
an tell me  what the method means?	=09
>>
>> likes
>> likes@huawei.com
>> 2008-01-30
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>  =20

=3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D=
 =3D =3D
		=09

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=D6=C2
=C0=F1=A3=A1
=20
				=20
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1xuqiang
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1likes@huawei.com
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12008-01-30



-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
