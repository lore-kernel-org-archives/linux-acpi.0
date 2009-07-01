From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] Work around negative s16 battery current on Acer
Date: Wed, 01 Jul 2009 22:38:04 +0400
Message-ID: <4A4BAD0C.9020302@suse.de>
References: <4A4BA8F9.9070803@marcansoft.com> <20090701112958.1d24e06f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57798 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752056AbZGASiF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2009 14:38:05 -0400
In-Reply-To: <20090701112958.1d24e06f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hector Martin <hector@marcansoft.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

Andrew Morton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Wed, 01 Jul 2009 20:20:41 +0200
> Hector Martin <hector@marcansoft.com> wrote:
>=20
>> My Acer Aspire 8930G laptop reports the battery current as a 16-bit
>> signed negative when it is charging. It also reports it as 0x10000 w=
hen
>> the current is 0. This patch adds a quirk for this which takes the
>> absolute value of the reported current cast to an s16. This is a DSD=
T
>> bug present in the latest BIOS revision (the EC register is 16 bits
>> signed and the DSDT attempts to take the 16-bit two's complement of
>> this, which works for discharge but not charge. It also breaks zero
>> values because a 32-bit register is used and the high bits aren't th=
rown
>> away).
>>
>> I've enabled this for all Acer systems which report in mA units. Thi=
s
>> should be safe since it won't break compliant systems unless they re=
port
>> a current above 32A, which is insane.
>>
>>
>> ...
>>
>> +++ a/drivers/acpi/battery.c
>> @@ -85,6 +85,10 @@ static const struct acpi_device_id batte
>> =20
>>  MODULE_DEVICE_TABLE(acpi, battery_device_ids);
>> =20
>> +/* For buggy DSDTs that report negative 16-bit values for either ch=
arging
>> + * or discharging and/or report 0 as 65536 due to bad math.
>> + */
>> +#define QUIRK_SIGNED16_CURRENT 0x0001
>> =20
>>  struct acpi_battery {
>>  	struct mutex lock;
>> @@ -112,6 +116,7 @@ struct acpi_battery {
>>  	int state;
>>  	int power_unit;
>>  	u8 alarm_present;
>> +	long quirks;
>>  };
>> =20
>>  #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat=
);
>> @@ -390,6 +395,10 @@ static int acpi_battery_get_state(struct
>>  				 state_offsets, ARRAY_SIZE(state_offsets));
>>  	battery->update_time =3D jiffies;
>>  	kfree(buffer.pointer);
>> +
>> +	if (battery->quirks & QUIRK_SIGNED16_CURRENT)
>> +		battery->current_now =3D abs((s16)battery->current_now);
>> +
>>  	return result;
>=20
> acpi_battery has no field `current_now' in 2.6.30 or 2.6.31-rc1.  Whi=
ch
> kernel version are you patching here?
>=20
>=20
> Also, I wonder if we need a quirk.  Is a "negative" value _ever_
> correct?  If not, could we do the negation unconditionally?
>=20
The problem is that the variable is s64 and not "negative" value is rel=
ated to s16 portion of it.
It's possible to do this only for "current" mode, in "power" mode value=
s of "negative" s16 range may be valid positive values.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
