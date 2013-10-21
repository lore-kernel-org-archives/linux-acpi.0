From: Vincent Blut <vincent.debian@free.fr>
Subject: Re: [REGRESSION/PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime
 UX31A
Date: Mon, 21 Oct 2013 23:21:06 +0200
Message-ID: <52659AC2.4030909@free.fr>
References: <1382307388.4030.30.camel@lamella> <52648906.4030203@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:58618 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab3JUVFf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Oct 2013 17:05:35 -0400
In-Reply-To: <52648906.4030203@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org, felipe.contreras@gmail.com, rafael.j.wysocki@intel.com

Le 21/10/2013 03:53, Aaron Lu a =C3=A9crit :
> On 10/21/2013 06:16 AM, Vincent Blut wrote:
>>
>>> Since v3.7 the acpi backlight driver doesn't work at all on this ma=
chine
>>> because presumably the ACPI code contains stub code when Windows 8 =
OSI is
>>> reported.
>>>
>>> The commit ea45ea7 (in v3.11-rc2) tried to fix this problem by usin=
g the intel
>>> backlight driver, however, on this machine it turns the backlight c=
ompletely
>>> off when it reaches level 0%, after which the user might have a lot=
 trouble
>>> trying to bring it back.
>>>
>>> This patch fixes both regressions by blacklisting the win8 OSI, so =
we are back
>>> to v3.6 behavior, and it should remain that way until the intel bac=
klight
>>> driver is fixed.
>>>
>>> Since v3.7, users have been forced to fix the initial regression by=
 modifying
>>> the boot arguments [1].
>>>
>>> [1] https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@xxxxxxxxx>
>>> ---
>>>  drivers/acpi/blacklist.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
>>> index cb96296..a404127 100644
>>> --- a/drivers/acpi/blacklist.c
>>> +++ b/drivers/acpi/blacklist.c
>>> @@ -192,6 +192,12 @@ static int __init dmi_disable_osi_win7(const s=
truct dmi_system_id *d)
>>>  	acpi_osi_setup("!Windows 2009");
>>>  	return 0;
>>>  }
>>> +static int __init dmi_disable_osi_win8(const struct dmi_system_id =
*d)
>>> +{
>>> +	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
>>> +	acpi_osi_setup("!Windows 2012");
>>> +	return 0;
>>> +}
>>> =20
>>>  static struct dmi_system_id acpi_osi_dmi_table[] __initdata =3D {
>>>  	{
>>> @@ -267,6 +273,14 @@ static struct dmi_system_id acpi_osi_dmi_table=
[] __initdata =3D {
>>>  		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P305D"),
>>>  		},
>>>  	},
>>> +	{
>>> +	.callback =3D dmi_disable_osi_win8,
>>> +	.ident =3D "ASUS Zenbook Prime UX31A",
>>> +	.matches =3D {
>>> +		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>> +		     DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
>>> +		},
>>> +	},
>>> =20
>>>  	/*
>>>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>>> --=20
>>> 1.8.3.4
>>
>> Felipe, Rafa=C3=ABl,
>>
>> I wonder if this quirk is still needed=E2=80=BD I'm the owner of an =
Asus UX31A and of course,
>> I used to set acpi_osi=3D"!Windows 2012" on the kernel command line =
in order to change
>> the backlight level. *However* since Linux 3.11, this kernel paramet=
er is not needed
>> anymore to influence it. The following commit seems to be the one th=
at fixed (or at=20
>> least inhibited) the issue:
>>
>> commit	efaa14c7e981bdf8d3c8d39d3ed12bdc60faabb8
>> ACPI / video: no automatic brightness changes by win8-compatible fir=
mware
>>
>> Indeed, I reverted it on top of 3.11.6 and I can't change the backli=
ght level anymore
>> on this system!
>>
>> Please see [1] for more information on what does that commit change =
in the way to control
>> the backlight level.
>>
>> So, is this inherent to my system? thought?
>=20
> I don't think ASUS UX31A needs that quirk anymore.

Hi Aaron,

Thanks for your answer. Btw I'd like to know if there is a reason that
you didn't cc your patch (commit efaa14c7) to <stable@vger.kernel.org>,
however I didn't test if it'd apply cleanly!

>=20
> Thanks,
> Aaron
>=20
>>
>> Cheers,
>> Vincent
>>
>> [1]http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D702188
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
