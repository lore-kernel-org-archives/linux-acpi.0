From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Sun, 30 Sep 2012 18:34:31 +0200
Message-ID: <50687497.9040205@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <5066C246.1050003@gmail.com> <50673394.5030502@linaro.org> <201209300007.49771.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59698 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab2I3Qeg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Sep 2012 12:34:36 -0400
Received: by eekb15 with SMTP id b15so2052768eek.19
        for <linux-acpi@vger.kernel.org>; Sun, 30 Sep 2012 09:34:34 -0700 (PDT)
In-Reply-To: <201209300007.49771.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On 09/30/2012 12:07 AM, Rafael J. Wysocki wrote:
> On Saturday, September 29, 2012, Daniel Lezcano wrote:
>> On 09/29/2012 11:41 AM, Francesco Lavra wrote:
>>> Hi,
>> Hi Francesco,
>>
>> thanks for reviewing the patch.
>>
>>>>  static ssize_t show_current_driver(struct device *dev,
>>>>  				   struct device_attribute *attr,
>>>>  				   char *buf)
>>>>  {
>>>> -	ssize_t ret;
>>>> -	struct cpuidle_driver *cpuidle_driver =3D cpuidle_get_driver();
>>>> +	struct cbarg cbarg =3D { .buf =3D buf };
>>> cbarg.count should be initialized to 0.
>> Actually, with this initialization, all the fields will be initializ=
ed
>> to 0, except 'buf'.
> However, it would be good to initialize count explicitly so as to sho=
w
> that we care about the initial value of it.

Ok, I will change that in a V2.

Rafael, you're right, this approach makes more sense IMO.

Thanks
-- Daniel

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
