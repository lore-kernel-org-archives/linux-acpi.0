From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] acpi : remove power from acpi_processor_cx structure
Date: Thu, 06 Sep 2012 09:54:00 +0200
Message-ID: <50485698.1070905@linaro.org>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org> <50410811.70500@linaro.org> <201209010754.58999.rjw@sisk.pl> <201209051541.58909.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59671 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab2IFHyF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2012 03:54:05 -0400
Received: by bkwj10 with SMTP id j10so642700bkw.19
        for <linux-acpi@vger.kernel.org>; Thu, 06 Sep 2012 00:54:04 -0700 (PDT)
In-Reply-To: <201209051541.58909.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xensource.com, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On 09/05/2012 03:41 PM, Rafael J. Wysocki wrote:
> On Saturday, September 01, 2012, Rafael J. Wysocki wrote:
>> On Friday, August 31, 2012, Daniel Lezcano wrote:
>>> On 07/24/2012 11:06 PM, Konrad Rzeszutek Wilk wrote:
>>>> On Tue, Jul 24, 2012 at 11:12:29PM +0200, Daniel Lezcano wrote:
>>>>> Remove the power field as it is not used.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>> Acked.
>>>
>>> Hi Rafael,
>>>
>>> I did not see this patch going in. Is it possible to merge it ?
>>
>> I think so.  I'll take care of it when I get back from LinuxCon/Plum=
bers Conf.
>> (early next week).
>=20
> Applied to the linux-next branch of the linux-pm.git tree as v3.7 mat=
erial.

Thanks Rafael.

> Are there any other patches you want me to consider for v3.7?

Yes please, I have the per cpu latencies ready to be submitted but I
want to do extra testing before. Unfortunately, the linux-pm-next hangs
at boot time on my intel dual core (not related to the patchset).

I am git bisecting right now.

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
