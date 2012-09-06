From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/5][RFC] cpuidle : add a pointer for cpuidle_state in
 the cpuidle_device
Date: Thu, 06 Sep 2012 14:47:06 +0200
Message-ID: <50489B4A.7030905@linaro.org>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org> <1343213162-8064-4-git-send-email-daniel.lezcano@linaro.org> <20120903151639.GL3589@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61226 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2IFMrT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2012 08:47:19 -0400
Received: by eekc1 with SMTP id c1so674172eek.19
        for <linux-acpi@vger.kernel.org>; Thu, 06 Sep 2012 05:47:18 -0700 (PDT)
In-Reply-To: <20120903151639.GL3589@tbergstrom-lnx.Nvidia.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On 09/03/2012 05:16 PM, Peter De Schrijver wrote:
> On Wed, Jul 25, 2012 at 12:46:00PM +0200, Daniel Lezcano wrote:
>> This patch adds a pointer to the cpuidle_state array in the cpuidle_=
device
>> structure. When the cpuidle_device is initialized, the pointer is as=
signed
>> from the driver's cpuidle states array.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle.c |    1 +
>>  include/linux/cpuidle.h   |    1 +
>>  2 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index d6a533e..42b1a8a 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -305,6 +305,7 @@ int cpuidle_enable_device(struct cpuidle_device =
*dev)
>>  		return -EIO;
>>  	if (!dev->state_count)
>>  		dev->state_count =3D drv->state_count;
>> +	dev->states =3D drv->states;
>=20
> This should only be done when dev->state_count =3D=3D 0 no?

Right. In acpi/processor_idle.c, the state count for the device is
initialized and I overwritten this value in all the cases, but this not
right. I removed the initialization in acpi because it is pointless and
moved this line to do the 'if' block as you mentioned.

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
