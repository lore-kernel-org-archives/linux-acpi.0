From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/5] acpi : remove latency_ticks from acpi_processor_cx
 structure
Date: Thu, 12 Jul 2012 22:47:48 +0200
Message-ID: <4FFF37F4.3060002@linaro.org>
References: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org> <201207122234.12851.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44281 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab2GLUrx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2012 16:47:53 -0400
Received: by eekb15 with SMTP id b15so766666eek.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2012 13:47:51 -0700 (PDT)
In-Reply-To: <201207122234.12851.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On 07/12/2012 10:34 PM, Rafael J. Wysocki wrote:
> On Thursday, July 12, 2012, Daniel Lezcano wrote:
>> Remove the latency_ticks field as it is not used.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Thanks for the patches, but can you please repost them to
> linux-pm@vger.kernel.org so that they are included into the kernel.or=
g
> Patchwork?  They will be much easier to review and handle then.
>=20
> And please CC linux-acpi@vger.kernel.org for all ACPI-related patches=
 in the
> future.

Yes, sure. Sorry for that.

Thanks
  -- Daniel

>> ---
>>  drivers/acpi/processor_idle.c |    2 --
>>  include/acpi/processor.h      |    1 -
>>  2 files changed, 0 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
>> index b894627..9ef007d 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -583,7 +583,6 @@ static void acpi_processor_power_verify_c3(struc=
t acpi_processor *pr,
>>  	 */
>>  	cx->valid =3D 1;
>> =20
>> -	cx->latency_ticks =3D cx->latency;
>>  	/*
>>  	 * On older chipsets, BM_RLD needs to be set
>>  	 * in order for Bus Master activity to wake the
>> @@ -616,7 +615,6 @@ static int acpi_processor_power_verify(struct ac=
pi_processor *pr)
>>  			if (!cx->address)
>>  				break;
>>  			cx->valid =3D 1;=20
>> -			cx->latency_ticks =3D cx->latency; /* Normalize latency */
>>  			break;
>> =20
>>  		case ACPI_STATE_C3:
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index ac3bff6..19423c3 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -59,7 +59,6 @@ struct acpi_processor_cx {
>>  	u8 entry_method;
>>  	u8 index;
>>  	u32 latency;
>> -	u32 latency_ticks;
>>  	u32 power;
>>  	u32 usage;
>>  	u64 time;
>>
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
