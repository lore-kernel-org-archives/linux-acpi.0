From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use arch_timer_acpi_init()
Date: Tue, 3 Dec 2013 13:27:21 +0100
Message-ID: <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org>
	<1386069328-22502-3-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:54738 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab3LCM1V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Dec 2013 07:27:21 -0500
Received: by mail-oa0-f47.google.com with SMTP id k1so14894953oag.34
        for <linux-acpi@vger.kernel.org>; Tue, 03 Dec 2013 04:27:21 -0800 (PST)
In-Reply-To: <1386069328-22502-3-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Patch Tracking <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Tue, Dec 3, 2013 at 12:15 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:

> +       /* if can't be initialised from DT, try ACPI way */
> +       if (!arch_timer_get_rate())
> +               arch_timer_acpi_init();
> +
>         arch_timer_rate = arch_timer_get_rate();

This looks a bit fragile. Having a call like arch_timer_get_rate()
to check whether there is a DT node for the timer doesn't seem
right, can you refactor the code to provide some
has_arch_timer_node() or similar call instead, so it's a bit easier
to understand & maintain at least?

Yours,
Linus Walleij
