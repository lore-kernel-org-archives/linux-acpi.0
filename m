From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/5] acpi : remove power from acpi_processor_cx structure
Date: Fri, 13 Jul 2012 09:36:26 +0200
Message-ID: <4FFFCFFA.8020505@linaro.org>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org> <1342127026-1526-4-git-send-email-daniel.lezcano@linaro.org> <20120713001701.GB13574@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42343 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab2GMHgb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jul 2012 03:36:31 -0400
Received: by eaak11 with SMTP id k11so958989eaa.19
        for <linux-acpi@vger.kernel.org>; Fri, 13 Jul 2012 00:36:30 -0700 (PDT)
In-Reply-To: <20120713001701.GB13574@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: rjw@sisk.pl, lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On 07/13/2012 02:17 AM, Konrad Rzeszutek Wilk wrote:
> On Thu, Jul 12, 2012 at 11:03:45PM +0200, Daniel Lezcano wrote:
>> Remove the power field as it is not used.
>>
> It looks to be used in drivers/xen/xen-acpi-processor.c.

Right, the field is assigned but not used AFAICT.

 dst_cx->power =3D cx->power;

Did you see it used in another place ?

Thanks
  -- Daniel

> I could emulate some value and stick it in there.. but I am
> more curious - what is the intent of this value?
>=20
>=20
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/acpi/processor_idle.c |    2 --
>>  include/acpi/processor.h      |    1 -
>>  2 files changed, 0 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
>> index d044588..99ba58f 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -485,8 +485,6 @@ static int acpi_processor_get_power_info_cst(str=
uct acpi_processor *pr)
>>  		if (obj->type !=3D ACPI_TYPE_INTEGER)
>>  			continue;
>> =20
>> -		cx.power =3D obj->integer.value;
>> -
>>  		current_count++;
>>  		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
>> =20
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index 0957457..87bb9d7 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -58,7 +58,6 @@ struct acpi_processor_cx {
>>  	u32 address;
>>  	u8 entry_method;
>>  	u32 latency;
>> -	u32 power;
>>  	u64 time;
>>  	u8 bm_sts_skip;
>>  	char desc[ACPI_CX_DESC_LEN];
>> --=20
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


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
