From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] acpi : remove power from acpi_processor_cx structure
Date: Fri, 31 Aug 2012 20:53:05 +0200
Message-ID: <50410811.70500@linaro.org>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org> <20120724210629.GA1149@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37435 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab2HaSxJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2012 14:53:09 -0400
Received: by dady13 with SMTP id y13so2139491dad.19
        for <linux-acpi@vger.kernel.org>; Fri, 31 Aug 2012 11:53:08 -0700 (PDT)
In-Reply-To: <20120724210629.GA1149@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, xen-devel@lists.xensource.com, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On 07/24/2012 11:06 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Jul 24, 2012 at 11:12:29PM +0200, Daniel Lezcano wrote:
>> Remove the power field as it is not used.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Acked.

Hi Rafael,

I did not see this patch going in. Is it possible to merge it ?

Thanks in advance
-- Daniel

>> ---
>>  drivers/acpi/processor_idle.c    |    2 --
>>  drivers/xen/xen-acpi-processor.c |    1 -
>>  include/acpi/processor.h         |    1 -
>>  3 files changed, 0 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
>> index e589c19..90582fb 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -483,8 +483,6 @@ static int acpi_processor_get_power_info_cst(str=
uct acpi_processor *pr)
>>  		if (obj->type !=3D ACPI_TYPE_INTEGER)
>>  			continue;
>> =20
>> -		cx.power =3D obj->integer.value;
>> -
>>  		current_count++;
>>  		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
>> =20
>> diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi=
-processor.c
>> index 7ff2569..7ef9c1d 100644
>> --- a/drivers/xen/xen-acpi-processor.c
>> +++ b/drivers/xen/xen-acpi-processor.c
>> @@ -98,7 +98,6 @@ static int push_cxx_to_hypervisor(struct acpi_proc=
essor *_pr)
>> =20
>>  		dst_cx->type =3D cx->type;
>>  		dst_cx->latency =3D cx->latency;
>> -		dst_cx->power =3D cx->power;
>> =20
>>  		dst_cx->dpcnt =3D 0;
>>  		set_xen_guest_handle(dst_cx->dp, NULL);
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index 64ec644..db427fa 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -59,7 +59,6 @@ struct acpi_processor_cx {
>>  	u8 entry_method;
>>  	u8 index;
>>  	u32 latency;
>> -	u32 power;
>>  	u8 bm_sts_skip;
>>  	char desc[ACPI_CX_DESC_LEN];
>>  };
>> --=20
>> 1.7.5.4
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>


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
