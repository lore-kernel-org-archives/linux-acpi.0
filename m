From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Ghost Lid switch on Baytrail tablet
Date: Tue, 21 Jul 2015 13:55:37 +0800
Message-ID: <55ADDED9.8060901@intel.com>
References: <1437266568.3512.10.camel@hadess.net>
 <1AE640813FDE7649BE1B193DEA596E8802738695@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60088 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbbGUFy3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jul 2015 01:54:29 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802738695@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Bastien Nocera <hadess@hadess.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "dev@mgautier.fr" <dev@mgautier.fr>

On 07/21/2015 09:30 AM, Zheng, Lv wrote:
> Hi,
>=20
> If the issue is already identified and confirmed:
> For example, you've confirmed the QR_EC(0x14) can only arrive when th=
e keyboard accessory is plugged in.
> Then please ignore my previous reply.
> I don't have idea about handling a LID that always returns "closed" w=
hen the keyboard accessory is not plugged in.

Perhaps the LID status should be ignored when the device is in tablet
mode?

In the meantime, I took a look at two tablets here: ASUS T100 and Onda
V975W, both are baytrail-T tablet while the T100 has a keyboard dock.
=46or T100, its _LID return the value of GPO2.LIDZ, which has an initia=
l
value of 1: "Name(LIDZ, One)" and on LID events, LIDZ will be assigned
proper value; and for Onda V975W, it doesn't define the LID acpi device=
=2E
So these two devices don't have this problem.

-Aaron

>=20
> Thanks
> -Lv
>=20
>> From: Zheng, Lv
>> Sent: Tuesday, July 21, 2015 8:23 AM
>>
>> Hi,
>>
>> The _LID returns LIDS:
>>         Device (LID)
>>         {
>>             Name (_HID, EisaId ("PNP0C0D") /* Lid Device */)  // _HI=
D: Hardware ID
>>             Name (LIDS, Zero)
>>             Method (_LID, 0, NotSerialized)  // _LID: Lid Status
>>             {
>>                 Return (LIDS) /* \_SB_.LID_.LIDS */
>>             }
>>         }
>> All LIDS related code can be found:
>> 	Line 132:         LIDS,   8,
>> 	Line 5400:                         PARM |=3D (LIDS << 0x10)
>> 	Line 5566:                         PARM =3D (LIDS << 0x08)
>> 	Line 11792:             ^^LID.LIDS =3D Zero
>> *	Line 11802:             ^^LID.LIDS =3D One
>> 	Line 11906:             Name (LIDS, Zero)
>> 	Line 11909:                 Return (LIDS) /* \_SB_.LID_.LIDS */
>> The value is only set by Q14 (marked by * above):
>>         Method (Q14, 0, NotSerialized)
>>         {
>>             P8XH (One, 0xBB)
>>             P8XH (Zero, 0x14)
>>             ^^LID.LIDS =3D One
>>             Notify (LID, 0x80) // Status Change
>>             P8XH (One, 0xBB)
>>             P8XH (Zero, 0xA4)
>>         }
>> If QR_EC(0x14) cannot arrive to the OSPMs as early as possible, then=
 the default LIDS=3D0 value may cause problem.
>> We need EC debug log to track if QR_EC(0x14) can arrive earlier.
>>
>> You can uncomment the following line from drivers/acpi/ec.c and rebu=
ild the kernel:
>> /* #define DEBUG */
>>
>> Send the dmesg output (before suspending) to us.
>>
>> Thanks and best regards
>> -Lv
>>
>>> -----Original Message-----
>>> From: Bastien Nocera [mailto:hadess@hadess.net]
>>> Sent: Sunday, July 19, 2015 8:43 AM
>>> To: Rafael J. Wysocki; Len Brown; linux-acpi@vger.kernel.org; linux=
-kernel@vger.kernel.org
>>> Cc: dev@mgautier.fr
>>> Subject: Ghost Lid switch on Baytrail tablet
>>>
>>> Hey,
>>>
>>> This tablet:
>>> http://www.amazon.com/WinBook-10-1-Inch-Windows-full-size-Display/d=
p/B00N9ZG5U2/
>>> doesn't have a physical lid switch unless you plug the keyboard acc=
essory to it.
>>>
>>> But it thinks that there is a lid, and that it's closed, making log=
ind
>>> suspend the machine after about 30 seconds.
>>>
>>> I'm currently testing this on a 4.0 kernel, as there have been
>>> regressions on Baytrail with 4.1 and 4.2rcs.
>>>
>>> The DSDT for that tablet:
>>> https://people.gnome.org/~hadess/Winbook%20TW100%20DSDT.dsl
>>>
>>> Any ideas how to handle this sort of device?
>>>
>>> Cheers
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
i=EF=BF=BDb=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=
=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj=
:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!=EF=BF=BDi
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
