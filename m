From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] ACPI / idle: Move idle_boot_override out of the arch directory
Date: Tue, 21 Jan 2014 00:34:24 +0100
Message-ID: <1945528.uEVBjXteWy@vostro.rjw.lan>
References: <1389924207-7360-1-git-send-email-hanjun.guo@linaro.org> <5375666.26CZK1LlZA@vostro.rjw.lan> <52DD2DE9.9060202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58279 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753678AbaATXUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jan 2014 18:20:17 -0500
In-Reply-To: <52DD2DE9.9060202@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Mark Rutland <Mark.Rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linaro-acpi@lists.lin

On Monday, January 20, 2014 10:08:41 PM Hanjun Guo wrote:
> On 2014=E5=B9=B401=E6=9C=8818=E6=97=A5 21:47, Rafael J. Wysocki wrote=
:
> > On Saturday, January 18, 2014 11:52:18 AM Hanjun Guo wrote:
> >> On 2014-1-18 11:45, Hanjun Guo wrote:
> >>> On 2014-1-17 20:06, Sudeep Holla wrote:
> >>>> On 17/01/14 02:03, Hanjun Guo wrote:
> >>>>> Move idle_boot_override out of the arch directory to be a singl=
e enum
> >>>>> including both platforms values, this will make it rather easie=
r to
> >>>>> avoid ifdefs around which definitions are for which processor i=
n
> >>>>> generally used ACPI code.
> >>>>>
> >>>>> IDLE_FORCE_MWAIT for IA64 is not used anywhere, so romove it.
> >>>>>
> >>>>> No functional change in this patch.
> >>>>>
> >>>>> Suggested-by: Alan <gnomes@lxorguk.ukuu.org.uk>
> >>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>>>> ---
> >> [...]
> >>>>> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> >>>>> index 03e235ad..e324561 100644
> >>>>> --- a/include/linux/cpu.h
> >>>>> +++ b/include/linux/cpu.h
> >>>>> @@ -220,6 +220,14 @@ void cpu_idle(void);
> >>>>>  =20
> >>>>>   void cpu_idle_poll_ctrl(bool enable);
> >>>>>  =20
> >>>>> +enum idle_boot_override {
> >>>>> +	IDLE_NO_OVERRIDE =3D 0,
> >>>>> +	IDLE_HALT,
> >>>>> +	IDLE_NOMWAIT,
> >>>>> +	IDLE_POLL,
> >>>>> +	IDLE_POWERSAVE_OFF
> >>>>> +};
> >>>>> +
> >>>> I do understand the idea behind this change, but IMO HALT and MW=
AIT are x86
> >>>> specific and may not make sense for other architectures.
> >>> yes, this is the strange part, the value is arch-dependent.
> >>>
> >>>> It will also require every architecture using ACPI to export
> >>>> boot_option_idle_override which may not be really required.
> >>> so, how about forget this patch and move boot_option_idle_overrid=
e
> >>> related code into arch directory such as arch/x86/acpi/boot.c for
> >>> x86?
> >> The general idea is that we can move all the arch-dependent codes
> >> in ACPI driver to arch directory, then make codes in drivers/acpi/
> >> arch independent.
> > Well, MWAIT is arch-dependent, so I'm not sure how IDLE_NOMWAIT fit=
s into
> > include/linux/cpu.h?
>=20
> So you will not happy with this patch and should find another solutio=
n?

No, I'm not happy with it.

If you want to move that to an arch-agnostic header, the symbol names c=
annot
be arch-dependent any more.

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
