From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 3/7] ACPI / processor_core: Rework _PDC related
 stuff to make it more arch-independent
Date: Wed, 04 Dec 2013 22:16:34 +0800
Message-ID: <529F3942.2020907@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org> <20131203165140.24a05540@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63346 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab3LDOQr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 09:16:47 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so23552173pbc.19
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 06:16:46 -0800 (PST)
In-Reply-To: <20131203165140.24a05540@alan.etchedpixels.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 00:51, One Thousand Gnomes wrote=
:
> On Wed,  4 Dec 2013 00:36:47 +0800
> Hanjun Guo <hanjun.guo@linaro.org> wrote:
>
>> _PDC related stuff in processor_core.c is little bit X86/IA64 depend=
ent,
>> rework the code to make it more arch-independent.
>>
>> The return value of acpi_processor_eval_pdc() should be 'acpi_status=
' but
>> defined as 'int', fix it too.
> Why not just define boot_options_idle_override as well. Then you can
> leave the code unchanged. Also more importantly you can have override
> values for ARM when it turns out you need those too and the logic wil=
l be
> the same for both processor families

There is a platform dependent head file such as pdc_intel.h which conta=
ins
some macros, some of those macros are used in arch-independent file pro=
cessor_core.c,
that's why I posted this patch.

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
