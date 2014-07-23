From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/NVS: Not save NVS region for new machines to accelerate
 S3
Date: Wed, 23 Jul 2014 13:35:25 +0800
Message-ID: <53CF499D.7020304@intel.com>
References: <1405662922-23606-1-git-send-email-tianyu.lan@intel.com> <1466357.PZLf9xnT2g@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466357.PZLf9xnT2g@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B407=E6=9C=8823=E6=97=A5 07:40, Rafael J. Wysocki wrote:
> On Friday, July 18, 2014 01:55:22 PM Lan Tianyu wrote:
>> NVS region is saved and restored unconditionally for machines withou=
t
>> nvs_nosave quirk during S3. Tested some new machines and the operati=
on
>> is not necessary. Saving NVS region also affects S2RAM speed. The ti=
me of
>> NVS saving and restoring depends on the size of NVS region and it co=
nsumes
>> 7~10ms normally.
>>
>> This patch is to make machines produced from 2012 to now not saving =
NVS region
>> to accelerate S3.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/sleep.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index b3e3cc7..896d8be 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -322,7 +322,12 @@ static struct dmi_system_id acpisleep_dmi_table=
[] __initdata =3D {
>> =20
>>  static void acpi_sleep_dmi_check(void)
>>  {
>> +	int year;
>> +
>>  	dmi_check_system(acpisleep_dmi_table);
>> +
>> +	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year >=3D 20=
12)
>> +		acpi_nvs_nosave_s3();
>=20
> I'd prefer the ordering here to be different so that individual quirk=
s
> could be used to change the date-based wholesale behavior.

Ok. I will update soon.

>=20
>>  }
>> =20
>>  /**
>>
>=20


--=20
Best regards
Tianyu Lan
