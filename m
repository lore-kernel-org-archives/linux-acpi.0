From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/6] acpi : remove pointless cpuidle device state_count
 init
Date: Sun, 16 Sep 2012 22:38:49 +0200
Message-ID: <505638D9.80302@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <1347013172-12465-4-git-send-email-daniel.lezcano@linaro.org> <201209072350.50389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53887 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab2IPUiy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Sep 2012 16:38:54 -0400
Received: by bkwj10 with SMTP id j10so2154951bkw.19
        for <linux-acpi@vger.kernel.org>; Sun, 16 Sep 2012 13:38:52 -0700 (PDT)
In-Reply-To: <201209072350.50389.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On 09/07/2012 11:50 PM, Rafael J. Wysocki wrote:
> On Friday, September 07, 2012, Daniel Lezcano wrote:
>> The cpuidle core takes care of filling this field from drv->state_co=
unt.
>=20
> I'm not quite sure this is always valid.  If dev has already been
> initialized and dev->state_count is different from 0,
> cpuidle_enable_device() doesn't actually change it.
>=20
> Have you considered all of the possible scenarios?

Ok, there is the scenario where the ACPI supports _CST.
At runtime, ACPI may notify the OS a C-state changed for a specific cpu
and this is done through 'acpi_processor_cst_has_changed' followed by
'acpi_processor_setup_cpuidle_cx'.

So at the end, we could have different cpus with one cpu with less
C-states than the other, if I understood correctly ACPIspec30.pdf =3D>
page 262 :)

In conclusion, we should keep this variable filled from there and keep
this in mind in cpuidle.c in order to not break acpi in the future.
Maybe a comment in cpuidle.c would help ... especially with a single
C-state registration.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/acpi/processor_idle.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
>> index 084b1d2..fc4757e 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1035,8 +1035,6 @@ static int acpi_processor_setup_cpuidle_cx(str=
uct acpi_processor *pr)
>>  			break;
>>  	}
>> =20
>> -	dev->state_count =3D count;
>> -
>>  	if (!count)
>>  		return -EINVAL;
>> =20
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
