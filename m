From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Useless thermal acpi driver ?
Date: Mon, 21 Dec 2009 19:06:11 -0600
Message-ID: <4B301B83.1010207@gmail.com>
References: <20091209232608.25aed4ca@werewolf.home>	<4B20483C.6090309@gmail.com>	<alpine.LFD.2.00.0912110122570.24891@localhost.localdomain>	<20091211094515.4b4872ef@werewolf.home>	<alpine.LFD.2.00.0912142159540.9446@localhost.localdomain> <20091215234619.62d0ebc1@werewolf.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55292 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbZLVBGO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 20:06:14 -0500
In-Reply-To: <20091215234619.62d0ebc1@werewolf.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On 12/15/2009 04:46 PM, J.A. Magall=F3n wrote:
> On Mon, 14 Dec 2009 22:00:25 -0500 (EST), Len Brown<lenb@kernel.org> =
 wrote:
>
>> this DSDT returns a constant temperature, always:
>>
>>              Method (_TMP, 0, NotSerialized)
>>              {
>>                  Return (0x0BB8)
>>              }
>>
>>
>> so in this case, Linux is just reporting the (lack of) news:-)
>>
>
> So, lets see...:
>
> - Someone decided ACPI is the only-real-good-way
> - Only a few devices are ported to ACPI
> - The old way is unusable
> - We can not return to the old way

You can return to the "old way", that's what acpi_enforce_resources=3Dl=
ax=20
is for. It won't be any more dangerous than it was before. The problem=20
is that there's no way (at least, no simple one, it seems) to know if=20
the BIOS is really going to access those registers it indicates it=20
might. There are systems where it indeed does access them and this=20
breaks things badly (causing problems like spurious thermal shutdowns).

What is the error that prevents w83627hf from loading? It might be=20
useful to find what reference in the AML causes the detection that it=20
may access the device registers.
=09
>
> So, any solution ? Thermal ACPI info in this boards (and I suspect in=
 many
> others) is useless. We can not disable that part of ACPI, we can not =
enable
> sensors. So no thermal monitoring.
> Nice.
>
> Ayways, as in this case the ACPI part does not any real work, is stil=
l
> present the problem of two drivers poking the same hardware or could =
I use
> that 'lax' trick ?
>
> And second, can the traditional sensor drivers be ported to offer an =
ACPI
> device replacing the default one, or is that a stupid question ?

It wouldn't make any sense. An ACPI driver would have to access some=20
interface that the BIOS ACPI AML code provides to access the sensor=20
data. Presumably this BIOS doesn't provide such an interface. (The only=
=20
such interface other than the standard ACPI thermal zone interface that=
=20
I'm aware of is the ATK0110 interface used on a lot of Asus motherboard=
s.)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
