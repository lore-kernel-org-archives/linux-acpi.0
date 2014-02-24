From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 2/5] ACPI / processor_core: Rework _PDC related stuff
 to make it more arch-independent
Date: Mon, 24 Feb 2014 14:57:05 +0800
Message-ID: <530AED41.4060407@linaro.org>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org> <3459962.GkY99aHQbc@vostro.rjw.lan> <20140221182424.GA5751@arm.com> <1408521.4TEdKhuRp5@vostro.rjw.lan> <F980FA86-6705-4A71-956C-EA2DBD787199@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:51606 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaBXG5M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Feb 2014 01:57:12 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so6169164pbb.9
        for <linux-acpi@vger.kernel.org>; Sun, 23 Feb 2014 22:57:12 -0800 (PST)
In-Reply-To: <F980FA86-6705-4A71-956C-EA2DBD787199@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Joe Perches <joe@perches.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On 2014-2-22 18:33, Catalin Marinas wrote:
> On 21 Feb 2014, at 23:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
>> On Friday, February 21, 2014 06:24:24 PM Catalin Marinas wrote:
>>> On Wed, Feb 19, 2014 at 01:50:22AM +0100, Rafael J. Wysocki wrote:
>>>> On Wednesday, February 19, 2014 12:23:55 AM Hanjun Guo wrote:
>>>>> _PDC related stuff in processor_core.c is little bit X86/IA64 dep=
endent,
>>>>> rework the code to make it more arch-independent, no functional c=
hange
>>>>> in this patch.
>>>>>
>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>>>>
>>>> I've queued up patches [1,3-5/5] from this series for 3.15 (modulo=
 changelog
>>>> modifications), but this one should be CCed to the x86 and ia64 ma=
intainers.
>>>
>>> Thanks for taking these patches. I would however hold onto patch 3/=
5 as
>>> this is still under discussion. Basically for patches specific to A=
RM
>>> ACPI I would really like to see more acks before being merged as th=
at's
>>> a new thing for us.
>>
>> OK, I'll drop [3/5] for now, then.
>=20
> Thanks (it=92s only temporary ;)).
>=20
>> I'm wondering, though, whose ACKs I should be waiting for before app=
lying those
>> patches?
>=20
> Good question ;). In this particular case, there is an ongoing
> discussion between Hanjun and Sudeep. While there isn=92t anything
> major, I would like to see some agreement and potentially an Ack from
> the other party involved in the discussion (Sudeep).
>=20
> There are other patches that are not specific to ARM, so it=92s
> really your decision. As for the general ARM(64) ACPI case, I don=92t
> think we have anyone in charge with deciding what=92s correct or not
> (BTW, who are the people active both in the _ARM_ Linux kernel commun=
ity
> and the ACPI standardisation forum?).

I'm in ASWG (ACPI spec working group) under UEFI, and Al Stone and Char=
les
(+cc Charles) are also in this forum.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
