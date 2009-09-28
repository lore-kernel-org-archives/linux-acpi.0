From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [git pull request] ACPI & driver patches for Linux-2.6.32-rc0
Date: Tue, 29 Sep 2009 00:44:05 +0400
Message-ID: <4AC12015.4040508@suse.de>
References: <alpine.LFD.2.00.0909190237560.22030@localhost.localdomain> <4ABCB2CA.4020709@mandriva.org> <d3f22a0909261902o5e48c2a0lab56fca21edf8c5b@mail.gmail.com> <1254016503.17697.21.camel@minggr.sh.intel.com> <alpine.LFD.2.00.0909270348570.16783@localhost.localdomain> <4AC11A0F.2030806@mandriva.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:56184 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752286AbZI1UoE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2009 16:44:04 -0400
In-Reply-To: <4AC11A0F.2030806@mandriva.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Backlund <tmb@mandriva.org>
Cc: Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Thomas Backlund =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Len Brown wrote:
>>>> This gets my laptop flooding logs with:
>>
>>>>> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl=
]=20
>>>>> (20090903/evregion-424)
>>>>> ACPI Error (psparse-0537): Method parse/execution failed=20
>>>>> [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
>>>>> ACPI Error (psparse-0537): Method parse/execution failed=20
>>>>> [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
>>>>> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
>>
>>> Could you do a bisect?
>>
>> In particular, please try the 2.6.31 versio of drivers/acpi/ec.c
>>
>=20
> Hi,
>=20
> in order to get the 2.6.31 version of ec.c to build I had to apply a=20
> small patch:
>=20
>> --- linux-acpi/drivers/acpi/ec.c.orig    2009-09-10 01:13:59.0000000=
00=20
>> +0300
>> +++ linux-acpi/drivers/acpi/ec.c    2009-09-28 21:09:15.359406828 +0=
300
>> @@ -42,6 +42,7 @@
>>  #include <asm/io.h>
>>  #include <acpi/acpi_bus.h>
>>  #include <acpi/acpi_drivers.h>
>> +#include <linux/dmi.h>
>> =20
>>  #define ACPI_EC_CLASS            "embedded_controller"
>>  #define ACPI_EC_DEVICE_NAME        "Embedded Controller"
>> @@ -1078,7 +1079,6 @@ static struct acpi_driver acpi_ec_driver
>>          .add =3D acpi_ec_add,
>>          .remove =3D acpi_ec_remove,
>>          .start =3D acpi_ec_start,
>> -        .stop =3D acpi_ec_stop,
>>          .suspend =3D acpi_ec_suspend,
>>          .resume =3D acpi_ec_resume,
>>          },
>=20
> After that  it built and the errors are gone.
>=20
> Now this is a Acer TravelMate 5720G laptop with the latest 1.35 bios.
> Distro is Mandriva Linux Cooker, and arch is x86_64
>=20
> Attached is output of "grep ACPI /var/log/dmesg"
> dmesg-acpi-20090903
> - all acpi patches as of 2.6.32-rc1
This one does not have errors you've mentioned earlier, could you find =
dmesg with them?
>=20
> dmesg-acpi-20090903-ec-2.6.31
> - all acpi patches as of 2.6.32-rc1
> - ec.c from 2.6.31.1
>=20
>=20
> Should I start bisecting, or do you have any other suggestion?
There is only one patch which touch ec.c, 2a84cb9852f52c0cd1c48bca41a87=
92d44ad06cc. You may try to revert it, and see.


Regards,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
