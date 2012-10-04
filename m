From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Thu, 04 Oct 2012 16:26:49 +0200
Message-ID: <506D9CA9.8000308@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <1348526634-19029-5-git-send-email-daniel.lezcano@linaro.org> <20121004141425.GK13834@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47467 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964963Ab2JDO0y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Oct 2012 10:26:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so348746bkc.19
        for <linux-acpi@vger.kernel.org>; Thu, 04 Oct 2012 07:26:53 -0700 (PDT)
In-Reply-To: <20121004141425.GK13834@tbergstrom-lnx.Nvidia.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On 10/04/2012 04:14 PM, Peter De Schrijver wrote:
> On Tue, Sep 25, 2012 at 12:43:54AM +0200, Daniel Lezcano wrote:
>> With the tegra3 and the big.LITTLE [1] new architectures, several cp=
us
>> with different characteristics (latencies and states) can co-exists =
on the
>> system.
>>
>> The cpuidle framework has the limitation of handling only identical =
cpus.
>>
>> This patch removes this limitation by introducing the multiple drive=
r support
>> for cpuidle.
>>
>> This option is configurable at compile time and should be enabled fo=
r the
>> architectures mentioned above. So there is no impact for the other p=
latforms
>> if the option is disabled. The option defaults to 'n'. Note the mult=
iple drivers
>> support is also compatible with the existing drivers, even if just o=
ne driver is
>> needed, all the cpu will be tied to this driver using an extra small=
 chunk of
>> processor memory.
>>
>> The multiple driver support use a per-cpu driver pointer instead of =
a global
>> variable and the accessor to this variable are done from a cpu conte=
xt.
>>
>> In order to keep the compatibility with the existing drivers, the fu=
nction
>> 'cpuidle_register_driver' and 'cpuidle_unregister_driver' will regis=
ter
>> the specified driver for all the cpus.
>>
>> The sysfs output for the 'current_driver' is changed when this optio=
n is
>> set by giving the drivers per cpu.
>>
>> eg.
>> cpu0: acpi_idle
>> cpu1: acpi_idle
>>
>=20
> Is this allowed? I thought sysfs files can output only 1 line of data=
?

Ah yeah :)

Does it make sense to put the following files:

/sys/devices/system/cpu/cpu0/cpuidle/driver
 =3D> acpi_idle
/sys/devices/system/cpu/cpu1/cpuidle/driver
 =3D> acpi_idle

and the content of the file:

/sys/devices/system/cpu/cpuidle/current_driver will show the driver
associated with current cpu ?


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
