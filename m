From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Sat, 29 Sep 2012 19:44:52 +0200
Message-ID: <50673394.5030502@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <1348526634-19029-5-git-send-email-daniel.lezcano@linaro.org> <5066C246.1050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63233 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370Ab2I2Ro4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Sep 2012 13:44:56 -0400
Received: by eekb15 with SMTP id b15so1879228eek.19
        for <linux-acpi@vger.kernel.org>; Sat, 29 Sep 2012 10:44:55 -0700 (PDT)
In-Reply-To: <5066C246.1050003@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Francesco Lavra <francescolavra.fl@gmail.com>
Cc: rjw@sisk.pl, lenb@kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On 09/29/2012 11:41 AM, Francesco Lavra wrote:
> Hi,

Hi Francesco,

thanks for reviewing the patch.

>>  static ssize_t show_current_driver(struct device *dev,
>>  				   struct device_attribute *attr,
>>  				   char *buf)
>>  {
>> -	ssize_t ret;
>> -	struct cpuidle_driver *cpuidle_driver =3D cpuidle_get_driver();
>> +	struct cbarg cbarg =3D { .buf =3D buf };
>=20
> cbarg.count should be initialized to 0.

Actually, with this initialization, all the fields will be initialized
to 0, except 'buf'.

Thanks
  -- Daniel

>> +	int ret;
>> =20
>> -	spin_lock(&cpuidle_driver_lock);
>> -	if (cpuidle_driver)
>> -		ret =3D sprintf(buf, "%s\n", cpuidle_driver->name);
>> -	else
>> -		ret =3D sprintf(buf, "none\n");
>> -	spin_unlock(&cpuidle_driver_lock);
>> +	ret =3D cpuidle_for_each_driver(each_driver_cb, &cbarg);
>> +	if (ret < 0)
>> +		return ret;
>> =20
>> -	return ret;
>> +	return cbarg.count;
>>  }
>=20
> --
> Francesco


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
