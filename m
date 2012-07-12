From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/5] acpi : remove index from acpi_processor_cx structure
Date: Thu, 12 Jul 2012 23:57:09 +0200
Message-ID: <4FFF4835.9030806@linaro.org>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org> <1342127026-1526-2-git-send-email-daniel.lezcano@linaro.org> <201207122344.27157.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50277 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932998Ab2GLV5Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2012 17:57:16 -0400
Received: by wibhr14 with SMTP id hr14so2700198wib.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2012 14:57:15 -0700 (PDT)
In-Reply-To: <201207122344.27157.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On 07/12/2012 11:44 PM, Rafael J. Wysocki wrote:
> On Thursday, July 12, 2012, Daniel Lezcano wrote:
>> Remove the index field. It could be given without adding extra
>> information in the cx structure.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> I'm not sure about this one.
>=20
> The code seems to be more straightforward without it, actually.
>=20
> Why exactly do you need to remove the field?

Actually, I am trying to cleaning up the different structure in the acp=
i
and clearly separate what is for cpuidle and what is for acpi.

I noticed there are some duplicated informations like the index and wha=
t
is described in the cx state.

I am trying to consolidate the code of the cpuidle drivers across the
different platform and I have to admit the processor_idle is the most
complicated as the cpuidle code is spreaded across different files
(processor_driver.c, processor.h, arch/x86/kernel/acpi/cstate.c, etc
=2E..). So these small patches are to litlle by little separate these t=
wo
subsystems (acpi and cpuidle) and have everything related to cpuidle
into the processor_idle file.

=46or this patch, it is right it seems to introduce more complexity but
the objective is to consolidate the code. I hope by cleaning the
different structures we will gain in readability.

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
