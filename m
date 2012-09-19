From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] cpuidle : rename function name "__cpuidle_register_driver"
Date: Wed, 19 Sep 2012 22:00:52 +0200
Message-ID: <505A2474.7090705@linaro.org>
References: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org> <1348075369-16451-2-git-send-email-daniel.lezcano@linaro.org> <201209192151.03236.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61772 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2ISUA5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Sep 2012 16:00:57 -0400
Received: by bkwj10 with SMTP id j10so754996bkw.19
        for <linux-acpi@vger.kernel.org>; Wed, 19 Sep 2012 13:00:56 -0700 (PDT)
In-Reply-To: <201209192151.03236.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, lenb@kernel.org

On 09/19/2012 09:51 PM, Rafael J. Wysocki wrote:
> On Wednesday, September 19, 2012, Daniel Lezcano wrote:
>> Clarify the purpose of the function by changing its name and
>> move the condition out of this function.
> Why exactly are you removing the condition?

I just moved the condition out from the function and called it when the
condition is true.

	if (!drv->power_specified)
		set_power_states(drv);


But please, drop this patch too. I noticed there is an overlap with the
next patch I have in my series but not published.

Accidentally I removed "cpuidle_curr_driver =3D drv;"

Sorry for the inconvenience. Time for me to go to bed :)



>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/driver.c |   15 ++++++++-------
>>  1 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
>> index 40cd3f3..774d2cb 100644
>> --- a/drivers/cpuidle/driver.c
>> +++ b/drivers/cpuidle/driver.c
>> @@ -17,9 +17,10 @@
>>  static struct cpuidle_driver *cpuidle_curr_driver;
>>  DEFINE_SPINLOCK(cpuidle_driver_lock);
>> =20
>> -static void __cpuidle_register_driver(struct cpuidle_driver *drv)
>> +static void set_power_states(struct cpuidle_driver *drv)
>>  {
>>  	int i;
>> +
>>  	/*
>>  	 * cpuidle driver should set the drv->power_specified bit
>>  	 * before registering if the driver provides
>> @@ -34,10 +35,8 @@ static void __cpuidle_register_driver(struct cpui=
dle_driver *drv)
>>  	 * an power value of -1.  So we use -2, -3, etc, for other
>>  	 * c-states.
>>  	 */
>> -	if (!drv->power_specified) {
>> -		for (i =3D CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++)
>> -			drv->states[i].power_usage =3D -1 - i;
>> -	}
>> +	for (i =3D CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++)
>> +		drv->states[i].power_usage =3D -1 - i;
>>  }
>> =20
>> =20
>> @@ -58,8 +57,10 @@ int cpuidle_register_driver(struct cpuidle_driver=
 *drv)
>>  		spin_unlock(&cpuidle_driver_lock);
>>  		return -EBUSY;
>>  	}
>> -	__cpuidle_register_driver(drv);
>> -	cpuidle_curr_driver =3D drv;
>> +
>> +	if (!drv->power_specified)
>> +		set_power_states(drv);
>> +
>>  	spin_unlock(&cpuidle_driver_lock);
>> =20
>>  	return 0;
>>
>
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
