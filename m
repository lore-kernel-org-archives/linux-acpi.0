From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/4] cpuidle - support multiple drivers at a time
Date: Thu, 04 Oct 2012 16:27:53 +0200
Message-ID: <506D9CE9.5040603@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <20121004141646.GL13834@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59357 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964963Ab2JDO17 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Oct 2012 10:27:59 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so349554bkc.19
        for <linux-acpi@vger.kernel.org>; Thu, 04 Oct 2012 07:27:58 -0700 (PDT)
In-Reply-To: <20121004141646.GL13834@tbergstrom-lnx.Nvidia.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On 10/04/2012 04:16 PM, Peter De Schrijver wrote:
> On Tue, Sep 25, 2012 at 12:43:50AM +0200, Daniel Lezcano wrote:
>> The discussion about having different cpus on the system with
>> different latencies bring us to a first attemp by adding a
>> pointer in the cpuidle_device to the states array.
>>
>> But as Rafael suggested, it would make more sense to create a
>> driver per cpu [1].
>>
>> This patch adds support for multiple cpuidle drivers.
>>
>> It creates a per cpu cpuidle driver pointer.
>>
>> In order to not break the different drivers, the function cpuidle_re=
gister_driver
>> assign for each cpu, the driver.
>>
>> The multiple driver support is optional and if it is not set, the cp=
uide driver
>> core code remains the same (except some code reorganisation).
>>
>> I did the following tests compiled, booted, tested without/with CONF=
IG_CPU_IDLE,
>> with/without CONFIG_CPU_IDLE_MULTIPLE_DRIVERS.
>>
>> Tested on Core2 Duo T9500 with acpi_idle [and intel_idle]
>> Tested on ARM Dual Cortex-A9 U8500 (aka Snowball)
>>
>=20
> Tested on Cardhu (Tegra30).
>=20
> Besides the possibly problem with the sysfs format:
>=20
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Thanks a lot Peter for testing and reviewing the patchset.

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
