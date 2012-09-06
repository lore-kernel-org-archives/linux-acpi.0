From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: CONFIG_NO_HZ + CONFIG_CPU_IDLE freeze the system (Was Re: [PATCH]
 acpi : remove power from acpi_processor_cx structure)
Date: Thu, 06 Sep 2012 22:35:44 +0200
Message-ID: <50490920.9070204@linaro.org>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org> <50485698.1070905@linaro.org> <50486B58.7000901@linaro.org> <201209062204.11288.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56545 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759858Ab2IFUft (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2012 16:35:49 -0400
Received: by eekc1 with SMTP id c1so887745eek.19
        for <linux-acpi@vger.kernel.org>; Thu, 06 Sep 2012 13:35:48 -0700 (PDT)
In-Reply-To: <201209062204.11288.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: xen-devel@lists.xensource.com, linaro-dev@lists.linaro.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09/06/2012 10:04 PM, Rafael J. Wysocki wrote:
> On Thursday, September 06, 2012, Daniel Lezcano wrote:
>> On 09/06/2012 09:54 AM, Daniel Lezcano wrote:
>>> On 09/05/2012 03:41 PM, Rafael J. Wysocki wrote:
>>>> On Saturday, September 01, 2012, Rafael J. Wysocki wrote:
>>>>> On Friday, August 31, 2012, Daniel Lezcano wrote:
>>>>>> On 07/24/2012 11:06 PM, Konrad Rzeszutek Wilk wrote:
>>>>>>> On Tue, Jul 24, 2012 at 11:12:29PM +0200, Daniel Lezcano wrote:
>>>>>>>> Remove the power field as it is not used.
>>>>>>>>
>>>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>>>> Acked.
>>>>>> Hi Rafael,
>>>>>>
>>>>>> I did not see this patch going in. Is it possible to merge it ?
>>>>> I think so.  I'll take care of it when I get back from LinuxCon/P=
lumbers Conf.
>>>>> (early next week).
>>>> Applied to the linux-next branch of the linux-pm.git tree as v3.7 =
material.
>>> Thanks Rafael.
>>>
>>>> Are there any other patches you want me to consider for v3.7?
>>> Yes please, I have the per cpu latencies ready to be submitted but =
I
>>> want to do extra testing before. Unfortunately, the linux-pm-next h=
angs
>>> at boot time on my intel dual core (not related to the patchset).
>>>
>>> I am git bisecting right now.
>>
>> I found the culprit. This is not related to the linux-pm tree but wi=
th
>> net-next.
>> The following patch introduced the issue.
>>
>> commit 6bdb7fe31046ac50b47e83c35cd6c6b6160a475d
>> Author: Amerigo Wang <amwang@redhat.com>
>> Date:   Fri Aug 10 01:24:50 2012 +0000
>>
>>     netpoll: re-enable irq in poll_napi()
>>   =20
>>     napi->poll() needs IRQ enabled, so we have to re-enable IRQ befo=
re
>>     calling it.
>>   =20
>>     Cc: David Miller <davem@davemloft.net>
>>     Signed-off-by: Cong Wang <amwang@redhat.com>
>>     Signed-off-by: David S. Miller <davem@davemloft.net>
>>
>> AFAICS, it has been fixed by commit
>> 072a9c48600409d72aeb0d5b29fbb75861a06631 which is not yet in linux-p=
m-next.
>=20
> If it is present in the current Linus' tree, you can just pull this o=
ne
> and merge linux-pm-next into it.  It should merge without conflicts.

Ok, thanks.

>> I fall into this issue because NETCONSOLE is set, disabling it allow=
ed
>> me to go further.
>>
>> Unfortunately I am facing to some random freeze on the system which
>> seems to be related to CONFIG_NO_HZ=3Dy and CONFIG_CPU_IDLE=3Dy.
>>
>> Disabling one of them, make the freezes to disappear.
>>
>> Is it a known issue ?
>=20
> Well, there are systems having problems with this configuration, but =
they
> should be exceptional.  What system is that?

It is a laptop T61p with a Core 2 Duo T9500. Nothing exceptional I
believe. Maybe someone got the same issue ?

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
