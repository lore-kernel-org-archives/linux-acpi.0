From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use
 arch_timer_acpi_init()
Date: Mon, 9 Dec 2013 10:37:43 -0800
Message-ID: <20131209183743.GA27562@quad.lixom.net>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org>
 <1386069328-22502-3-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com>
 <529DE21E.4080707@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:37021 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761302Ab3LISj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2013 13:39:58 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so5618348pde.6
        for <linux-acpi@vger.kernel.org>; Mon, 09 Dec 2013 10:39:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <529DE21E.4080707@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Patch Tracking <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Tue, Dec 03, 2013 at 09:52:30PM +0800, Hanjun Guo wrote:
> On 2013=E5=B9=B412=E6=9C=8803=E6=97=A5 20:27, Linus Walleij wrote:
> >On Tue, Dec 3, 2013 at 12:15 PM, Hanjun Guo <hanjun.guo@linaro.org> =
wrote:
> >
> >>+       /* if can't be initialised from DT, try ACPI way */
> >>+       if (!arch_timer_get_rate())
> >>+               arch_timer_acpi_init();
> >>+
> >>         arch_timer_rate =3D arch_timer_get_rate();
> >This looks a bit fragile. Having a call like arch_timer_get_rate()
> >to check whether there is a DT node for the timer doesn't seem
> >right, can you refactor the code to provide some
> >has_arch_timer_node() or similar call instead, so it's a bit easier
> >to understand & maintain at least?
>=20
> Good point, thanks for the guidance.
> I will introduce has_arch_timer_node() as you said and use
> it as follows:
>=20
> if (has_arch_timer_node())
> clocksource_of_init();
> esle
> arch_timer_acpi_init(); /* try ACPI way */
>=20
> Is this make sense to you?

Even when we boot with ACPI, the boot stub will still create a minimal
DTB. We should just make sure that the clocksource (which will be
architectured timers anyway, I believe?) is described in that stub.

I would rather do that than have dual-path booting in the lowlevel setu=
p, it
increases test requirements and makes it hard for someone without ACPI =
hardware
to check for regressions in this code, etc.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
