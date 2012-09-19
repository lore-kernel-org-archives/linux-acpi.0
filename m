From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] cpuidle : remove unused ref count function
Date: Wed, 19 Sep 2012 21:56:16 +0200
Message-ID: <505A2360.7000500@linaro.org>
References: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org> <201209192149.38164.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56558 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2IST4U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Sep 2012 15:56:20 -0400
Received: by bkwj10 with SMTP id j10so752653bkw.19
        for <linux-acpi@vger.kernel.org>; Wed, 19 Sep 2012 12:56:19 -0700 (PDT)
In-Reply-To: <201209192149.38164.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, lenb@kernel.org

On 09/19/2012 09:49 PM, Rafael J. Wysocki wrote:
> On Wednesday, September 19, 2012, Daniel Lezcano wrote:
>> These two functions are never used.
> This is not the case.  pm_genpd_attach_cpuidle() and
> pm_genpd_detach_cpuidle() use them.
>
> Please be more careful.

Oops, sorry.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/driver.c |   29 +----------------------------
>>  include/linux/cpuidle.h  |    4 ----
>>  2 files changed, 1 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
>> index 58bf3b1..40cd3f3 100644
>> --- a/drivers/cpuidle/driver.c
>> +++ b/drivers/cpuidle/driver.c
>> @@ -16,7 +16,6 @@
>> =20
>>  static struct cpuidle_driver *cpuidle_curr_driver;
>>  DEFINE_SPINLOCK(cpuidle_driver_lock);
>> -int cpuidle_driver_refcount;
>> =20
>>  static void __cpuidle_register_driver(struct cpuidle_driver *drv)
>>  {
>> @@ -90,34 +89,8 @@ void cpuidle_unregister_driver(struct cpuidle_dri=
ver *drv)
>>  	}
>> =20
>>  	spin_lock(&cpuidle_driver_lock);
>> -
>> -	if (!WARN_ON(cpuidle_driver_refcount > 0))
>> -		cpuidle_curr_driver =3D NULL;
>> -
>> +	cpuidle_curr_driver =3D NULL;
>>  	spin_unlock(&cpuidle_driver_lock);
>>  }
>> =20
>>  EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
>> -
>> -struct cpuidle_driver *cpuidle_driver_ref(void)
>> -{
>> -	struct cpuidle_driver *drv;
>> -
>> -	spin_lock(&cpuidle_driver_lock);
>> -
>> -	drv =3D cpuidle_curr_driver;
>> -	cpuidle_driver_refcount++;
>> -
>> -	spin_unlock(&cpuidle_driver_lock);
>> -	return drv;
>> -}
>> -
>> -void cpuidle_driver_unref(void)
>> -{
>> -	spin_lock(&cpuidle_driver_lock);
>> -
>> -	if (!WARN_ON(cpuidle_driver_refcount <=3D 0))
>> -		cpuidle_driver_refcount--;
>> -
>> -	spin_unlock(&cpuidle_driver_lock);
>> -}
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 279b1ea..5abf62b 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -145,8 +145,6 @@ extern void disable_cpuidle(void);
>>  extern int cpuidle_idle_call(void);
>>  extern int cpuidle_register_driver(struct cpuidle_driver *drv);
>>  extern struct cpuidle_driver *cpuidle_get_driver(void);
>> -extern struct cpuidle_driver *cpuidle_driver_ref(void);
>> -extern void cpuidle_driver_unref(void);
>>  extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
>>  extern int cpuidle_register_device(struct cpuidle_device *dev);
>>  extern void cpuidle_unregister_device(struct cpuidle_device *dev);
>> @@ -169,8 +167,6 @@ static inline int cpuidle_idle_call(void) { retu=
rn -ENODEV; }
>>  static inline int cpuidle_register_driver(struct cpuidle_driver *dr=
v)
>>  {return -ENODEV; }
>>  static inline struct cpuidle_driver *cpuidle_get_driver(void) {retu=
rn NULL; }
>> -static inline struct cpuidle_driver *cpuidle_driver_ref(void) {retu=
rn NULL; }
>> -static inline void cpuidle_driver_unref(void) {}
>>  static inline void cpuidle_unregister_driver(struct cpuidle_driver =
*drv) { }
>>  static inline int cpuidle_register_device(struct cpuidle_device *de=
v)
>>  {return -ENODEV; }
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
