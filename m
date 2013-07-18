From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Fix PATCH] ACPI / video: ignore BIOS initial backlight value
 for Fujitsu E753
Date: Thu, 18 Jul 2013 09:12:15 +0800
Message-ID: <51E740EF.5010700@intel.com>
References: <1373940441-21875-1-git-send-email-tianyu.lan@intel.com> <5965989.OyGfl3xY1D@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5146 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab3GRBTz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jul 2013 21:19:55 -0400
In-Reply-To: <5965989.OyGfl3xY1D@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On 2013=E5=B9=B407=E6=9C=8818=E6=97=A5 06:35, Rafael J. Wysocki wrote:
> On Tuesday, July 16, 2013 10:07:21 AM tianyu.lan@intel.com wrote:
>> From: Lan Tianyu <tianyu.lan@intel.com>
>>
>> The BIOS of FUjitsu E753 reports an incorrect initial backlight valu=
e
>> for WIN8 compatible OS, causing backlight dark during startup. This
>> patch ignores the incorrect initial value from BIOS.
>>
>> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=3D60161
>> Reported-and-tested-by: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.=
com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>=20
> Queued up as a fix for 3.11.
>=20
> What's the oldest mainline kernel release this patch is applicable to=
?

This should be backport to 3.7+ kernel.

Cc: <stable@vger.kernel.org> # 3.7+

>=20
> Rafael
>=20
>=20
>> ---
>>  drivers/acpi/video.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 5d7075d..e441876 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -450,6 +450,14 @@ static struct dmi_system_id video_dmi_table[] _=
_initdata =3D {
>>  	},
>>  	{
>>  	 .callback =3D video_ignore_initial_backlight,
>> +	 .ident =3D "Fujitsu E753",
>> +	 .matches =3D {
>> +		DMI_MATCH(DMI_BOARD_VENDOR, "FUJITSU"),
>> +		DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E753"),
>> +		},
>> +	},
>> +	{
>> +	 .callback =3D video_ignore_initial_backlight,
>>  	 .ident =3D "HP Pavilion dm4",
>>  	 .matches =3D {
>>  		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
>>


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
