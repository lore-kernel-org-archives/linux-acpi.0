From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 1/3] ACPI/Thermal: Remove the unused lock of struct acpi_thermal
Date: Thu, 15 Aug 2013 08:28:58 +0800
Message-ID: <520C20CA.5060403@intel.com>
References: <1376485239-18312-1-git-send-email-tianyu.lan@intel.com> <4D68720C2E767A4AA6A8796D42C8EB59D135EA@BGSMSX103.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49215 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758345Ab3HOAh2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Aug 2013 20:37:28 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59D135EA@BGSMSX103.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

On 2013=E5=B9=B408=E6=9C=8815=E6=97=A5 01:05, R, Durgadoss wrote:
>=20
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of tianyu.lan@intel.com
>> Sent: Wednesday, August 14, 2013 6:31 PM
>> To: rjw@sisk.pl; lenb@kernel.org
>> Cc: Lan, Tianyu; linux-acpi@vger.kernel.org; Zhang, Rui
>> Subject: [PATCH 1/3] ACPI/Thermal: Remove the unused lock of struct
>> acpi_thermal
>>
>> From: Lan Tianyu <tianyu.lan@intel.com>
>>
>> The acpi_thermal->lock now just is initialized when thermal zone dev=
ice
>> is added and destroyed when thermal zone is removed. Never being use=
d
>> any other places. So remove it.
>>
>=20
> Hi Tianyu,
>=20
> Very Nice catch. All three patches look fine to me.
> For all three,
> Acked-by: Durgadoss R <durgadoss.r@intel.com>

Thanks for Acks.

>=20
> Thanks,
> Durga
>=20
>> Acked-by: Zhang Rui <rui.zhang@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/thermal.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>> index a3e38a0..850818d 100644
>> --- a/drivers/acpi/thermal.c
>> +++ b/drivers/acpi/thermal.c
>> @@ -190,7 +190,6 @@ struct acpi_thermal {
>>  	struct thermal_zone_device *thermal_zone;
>>  	int tz_enabled;
>>  	int kelvin_offset;
>> -	struct mutex lock;
>>  };
>>
>>  /* ----------------------------------------------------------------=
----------
>> @@ -1088,8 +1087,6 @@ static int acpi_thermal_add(struct acpi_device=
 *device)
>>  	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
>>  	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
>>  	device->driver_data =3D tz;
>> -	mutex_init(&tz->lock);
>> -
>>
>>  	result =3D acpi_thermal_get_info(tz);
>>  	if (result)
>> @@ -1122,7 +1119,6 @@ static int acpi_thermal_remove(struct acpi_dev=
ice
>> *device)
>>  	tz =3D acpi_driver_data(device);
>>
>>  	acpi_thermal_unregister_thermal_zone(tz);
>> -	mutex_destroy(&tz->lock);
>>  	kfree(tz);
>>  	return 0;
>>  }
>> --
>> 1.8.4.rc0.1.g8f6a3e5.dirty
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
