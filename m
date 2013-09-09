From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH 2/4] ACPI/Resource: Add address translation support
Date: Mon, 09 Sep 2013 10:18:42 +0800
Message-ID: <522D3002.5050304@intel.com>
References: <1378477486-8758-1-git-send-email-tianyu.lan@intel.com> <1378477486-8758-3-git-send-email-tianyu.lan@intel.com> <12539726.iB4h1i35EF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21632 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab3IIC14 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Sep 2013 22:27:56 -0400
In-Reply-To: <12539726.iB4h1i35EF@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, yinghai@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2013=E5=B9=B409=E6=9C=8807=E6=97=A5 08:15, Rafael J. Wysocki wrote:
> On Friday, September 06, 2013 10:24:44 AM Lan Tianyu wrote:
>> According ACPI 5.0 spec Section 19.1.8
>> "For bridges, translate addresses across the bridge, this is the
>> offset that must be added to the address on the secondary side
>> to obtain the address on the primary side. Non-bridge devices
>> must list 0."
>=20
> Can you please have a look into the previous versions of the spec and=
 double
> check that this change won't confuse systems that implement them?
>=20

Hi Rafael:
         I check all versions. This part has existed and not been
changed since ACPI 1.0.

> Otherwise it looks OK to me.
>=20
> Thanks,
> Rafael
>=20
>=20
>> This patch is to add address translation offset to the start/end
>> of struct resource in the acpi_dev_resource_address_space().
>> Further more, non-bridge device's translation_offset should 0.
>> So this change will affect other devices.
>>
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/resource.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 929f416..84bc3db 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -192,8 +192,8 @@ bool acpi_dev_resource_address_space(struct acpi=
_resource *ares,
>>  	if (ACPI_FAILURE(status))
>>  		return true;
>> =20
>> -	res->start =3D addr.minimum;
>> -	res->end =3D addr.maximum;
>> +	res->start =3D addr.minimum + addr.translation_offset;
>> +	res->end =3D addr.maximum + addr.translation_offset;
>>  	window =3D addr.producer_consumer =3D=3D ACPI_PRODUCER;
>> =20
>>  	switch(addr.resource_type) {
>>


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
