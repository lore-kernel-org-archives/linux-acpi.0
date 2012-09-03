From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 5/5][RFC] cpuidle : add cpuidle_register_states function
Date: Mon, 03 Sep 2012 22:50:49 +0200
Message-ID: <50451829.1010304@linaro.org>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org> <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org> <20120903132245.GK3589@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55706 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab2ICUvJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2012 16:51:09 -0400
Received: by eaac11 with SMTP id c11so1730694eaa.19
        for <linux-acpi@vger.kernel.org>; Mon, 03 Sep 2012 13:51:07 -0700 (PDT)
In-Reply-To: <20120903132245.GK3589@tbergstrom-lnx.Nvidia.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On 09/03/2012 03:22 PM, Peter De Schrijver wrote:
> On Wed, Jul 25, 2012 at 12:46:02PM +0200, Daniel Lezcano wrote:
>> The tegra3 and big.LITTLE architecture have different cpu latencies.
>> This API allows to specify a different cpu latency for a specific cp=
u.
>>
>> With the previous patches, we use the per cpuidle device states poin=
ter,
>> this function overrides this pointer.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle.c |   17 +++++++++++++++++
>>  include/linux/cpuidle.h   |   10 +++++++---
>>  2 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 199878a..3b21b68 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -456,6 +456,23 @@ void cpuidle_unregister_device(struct cpuidle_d=
evice *dev)
>> =20
>>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
>> =20
>> +int cpuidle_register_states(struct cpuidle_device *dev,
>> +			    struct cpuidle_state *states,
>> +			    int state_count)
>> +{
>> +	if (!dev || !states)
>> +		return -EINVAL;
>> +
>> +	if (state_count <=3D 0)
>> +		return -EINVAL;
>> +
>> +	dev->states =3D states;
>> +	dev->state_count =3D state_count;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(cpuidle_register_state);
>> +
>>  #ifdef CONFIG_SMP
>> =20
>=20
> Looks good... apart from the fact that the function definition says
> cpuidle_register_stateS and the exported symbol is cpuidle_register_s=
tate...


Ok, fixed. Thanks !

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
