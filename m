From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 5/5][RFC] cpuidle : add cpuidle_register_states function
Date: Fri, 31 Aug 2012 23:21:14 +0200
Message-ID: <50412ACA.6080500@linaro.org>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org> <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org> <20120810171736.GA12151@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45504 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab2HaVVQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2012 17:21:16 -0400
Received: by pbbrr13 with SMTP id rr13so5454386pbb.19
        for <linux-acpi@vger.kernel.org>; Fri, 31 Aug 2012 14:21:16 -0700 (PDT)
In-Reply-To: <20120810171736.GA12151@e102568-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On 08/10/2012 07:17 PM, Lorenzo Pieralisi wrote:
> Hi Daniel,
>=20
> thanks for this patchset.
>=20
> On Wed, Jul 25, 2012 at 11:46:02AM +0100, Daniel Lezcano wrote:
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
>=20
> Is this function supposed to be called after cpuidle_device registrat=
ion ?
> I think so since at registration time the dev->states pointers are al=
l
> initialized to point to the driver state array, which is global and n=
ot
> really what we want.
>=20
> Unless this function is called on the cpu that requires swapping the =
state
> pointer, I think it is unsafe to register a different state pointer
> without a minimal level of locking (or disabling idle and renabling i=
dle)
> since the update of dev->states and dev->state_count is not atomic.
> Maybe it is implicit but it should be documented somehow to define
> cpuidle_register_states(...) proper usage.

Hi Lorenzo,

Yes, you are right. I will add the cpuidle lock.

Thanks !

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
