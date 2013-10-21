From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [REGRESSION/PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime
 UX31A
Date: Mon, 21 Oct 2013 09:53:10 +0800
Message-ID: <52648906.4030203@intel.com>
References: <1382307388.4030.30.camel@lamella>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46118 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101Ab3JUBwe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Oct 2013 21:52:34 -0400
In-Reply-To: <1382307388.4030.30.camel@lamella>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vincent Blut <vincent.debian@free.fr>, linux-acpi@vger.kernel.org
Cc: felipe.contreras@gmail.com, rafael.j.wysocki@intel.com

On 10/21/2013 06:16 AM, Vincent Blut wrote:
>=20
>> Since v3.7 the acpi backlight driver doesn't work at all on this mac=
hine
>> because presumably the ACPI code contains stub code when Windows 8 O=
SI is
>> reported.
>>
>> The commit ea45ea7 (in v3.11-rc2) tried to fix this problem by using=
 the intel
>> backlight driver, however, on this machine it turns the backlight co=
mpletely
>> off when it reaches level 0%, after which the user might have a lot =
trouble
>> trying to bring it back.
>>
>> This patch fixes both regressions by blacklisting the win8 OSI, so w=
e are back
>> to v3.6 behavior, and it should remain that way until the intel back=
light
>> driver is fixed.
>>
>> Since v3.7, users have been forced to fix the initial regression by =
modifying
>> the boot arguments [1].
>>
>> [1] https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@xxxxxxxxx>
>> ---
>>  drivers/acpi/blacklist.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
>> index cb96296..a404127 100644
>> --- a/drivers/acpi/blacklist.c
>> +++ b/drivers/acpi/blacklist.c
>> @@ -192,6 +192,12 @@ static int __init dmi_disable_osi_win7(const st=
ruct dmi_system_id *d)
>>  	acpi_osi_setup("!Windows 2009");
>>  	return 0;
>>  }
>> +static int __init dmi_disable_osi_win8(const struct dmi_system_id *=
d)
>> +{
>> +	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
>> +	acpi_osi_setup("!Windows 2012");
>> +	return 0;
>> +}
>> =20
>>  static struct dmi_system_id acpi_osi_dmi_table[] __initdata =3D {
>>  	{
>> @@ -267,6 +273,14 @@ static struct dmi_system_id acpi_osi_dmi_table[=
] __initdata =3D {
>>  		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P305D"),
>>  		},
>>  	},
>> +	{
>> +	.callback =3D dmi_disable_osi_win8,
>> +	.ident =3D "ASUS Zenbook Prime UX31A",
>> +	.matches =3D {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +		     DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
>> +		},
>> +	},
>> =20
>>  	/*
>>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>> --=20
>> 1.8.3.4
>=20
> Felipe, Rafa=C3=ABl,
>=20
> I wonder if this quirk is still needed=E2=80=BD I'm the owner of an A=
sus UX31A and of course,
> I used to set acpi_osi=3D"!Windows 2012" on the kernel command line i=
n order to change
> the backlight level. *However* since Linux 3.11, this kernel paramete=
r is not needed
> anymore to influence it. The following commit seems to be the one tha=
t fixed (or at=20
> least inhibited) the issue:
>=20
> commit	efaa14c7e981bdf8d3c8d39d3ed12bdc60faabb8
> ACPI / video: no automatic brightness changes by win8-compatible firm=
ware
>=20
> Indeed, I reverted it on top of 3.11.6 and I can't change the backlig=
ht level anymore
> on this system!
>=20
> Please see [1] for more information on what does that commit change i=
n the way to control
> the backlight level.
>=20
> So, is this inherent to my system? thought?

I don't think ASUS UX31A needs that quirk anymore.

Thanks,
Aaron

>=20
> Cheers,
> Vincent
>=20
> [1]http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D702188
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
