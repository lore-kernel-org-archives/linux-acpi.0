From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
Date: Fri, 06 Feb 2004 01:46:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <4022E3C8.4020704@wanadoo.es>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org> <1076026496.16107.23.camel@athlonxp.bradney.info> <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <4022E209.3040909@gmx.de>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Craig Bradney <cbradney@zip.com.au>, Andrew Morton <akpm@osdl.org>, david+challenge-response@blue-labs.org, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, a.verweij@student.tudelft.nl
List-Id: linux-acpi@vger.kernel.org

Prakash K. Cheemplavam wrote:

> Luis Miguel Garc=EDa wrote:
>
>> Craig Bradney wrote:
>>
>>>
>>>
>>>
>>> One day hopefully this will be sorted in the BIOSes and in mainline=
=2E I
>>> keep having to patch for every release (although as thats the only=20
>>> patch
>>> I have to do I'm sure there are many worse off than me). I use the =
3com
>>> n/w on my A7N8X Deluxe v2 BIOS 1007 so no need for nforcedeth.
>>>
>>> Best patches are at:
>>> http://lkml.org/lkml/2003/12/21/7
>>>
>>> Ive applied them to 2.6.0 and 2.6.1 and give no crashes and no heat
>>> issues.
>>
>
> Unfortunately that patch doesn't work for me. Still locks if I try=20
> APIC +CPU DIsc.
>
>>>
>>> (XP2600+ runs at 31/32C normal use and 38C compiling with Zalman co=
oler
>>> +exhaust fans in box)
>>>
>>> Craig
>>> =20
>>>
>> you mean 31 - 38 C readed from /proc/acpi/temp[........]????
>>
>> I'm having readings of 53 in idle and even 64 while compiling!! I=20
>> have no case fan, but I don't think it's so important for this bug=20
>> difference.
>
>
> The problem is, you cannot trust those infos esp not across board=20
> manufacturers. In case of Abit nearly every bios shows different=20
> values...
>
> I have an Athon XP running at 2.1Gz with 1.65vcore. Idle: 50=B0C (wit=
h=20
> CPU Disc usually about 44-40=B0C) and under load about 54=B0C. I am u=
sign=20
> a more or less self-made watercooling.
>
>
> Prakash
>

There is a way to "activate" cpu Disconnect? or it gets enabled by=20
simply applying it?

Yes, I have a Abit motherboards, perhaps it's the problem with the bios=
=2E
