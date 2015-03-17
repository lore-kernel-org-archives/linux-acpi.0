From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [update][PATCH v10 06/21] ACPI / sleep: Introduce CONFIG_ACPI_GENERIC_SLEEP
Date: Tue, 17 Mar 2015 15:33:30 +0100
Message-ID: <16235723.xVJ1Rfp9tM@vostro.rjw.lan>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org> <10995588.scpoK3KRg2@vostro.rjw.lan> <5507A91A.1090206@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49888 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752916AbbCQOJh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2015 10:09:37 -0400
In-Reply-To: <5507A91A.1090206@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Zhangdianfang <zhangdianfang@huawei.com>

On Tuesday, March 17, 2015 12:10:02 PM Hanjun Guo wrote:
> On 2015/3/17 11:23, Rafael J. Wysocki wrote:
> > On Tuesday, March 17, 2015 10:36:47 AM Hanjun Guo wrote:
> >> On 2015/3/17 10:28, Rafael J. Wysocki wrote:
> >>> On Tuesday, March 17, 2015 09:08:45 AM Hanjun Guo wrote:
> >>>> On 2015/3/17 7:15, Rafael J. Wysocki wrote:
> >>>>> On Monday, March 16, 2015 08:14:52 PM Hanjun Guo wrote:
> >>>>>> On 2015=E5=B9=B403=E6=9C=8814=E6=97=A5 05:49, Rafael J. Wysock=
i wrote:
> >>>>>>> On Friday, March 13, 2015 04:14:29 PM Hanjun Guo wrote:
> >>>> [...]
> >>>>>>>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> >>>>>>>> index 074e52b..e8728d7 100644
> >>>>>>>> --- a/arch/ia64/Kconfig
> >>>>>>>> +++ b/arch/ia64/Kconfig
> >>>>>>>> @@ -10,6 +10,7 @@ config IA64
> >>>>>>>>   	select ARCH_MIGHT_HAVE_PC_SERIO
> >>>>>>>>   	select PCI if (!IA64_HP_SIM)
> >>>>>>>>   	select ACPI if (!IA64_HP_SIM)
> >>>>>>>> +	select ACPI_GENERIC_SLEEP if ACPI
> >>>>>>>>   	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
> >>>>>>>>   	select HAVE_UNSTABLE_SCHED_CLOCK
> >>>>>>>>   	select HAVE_IDE
> >>>>>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >>>>>>>> index b7d31ca..9804431 100644
> >>>>>>>> --- a/arch/x86/Kconfig
> >>>>>>>> +++ b/arch/x86/Kconfig
> >>>>>>>> @@ -22,6 +22,7 @@ config X86_64
> >>>>>>>>   ### Arch settings
> >>>>>>>>   config X86
> >>>>>>>>   	def_bool y
> >>>>>>>> +	select ACPI_GENERIC_SLEEP if ACPI
> >>>>>>> One more nit.  If you did
> >>>>>>>
> >>>>>>> +	select ACPI_GENERIC_SLEEP if ACPI_SLEEP
> >>>>>>>
> >>>>>>> here (and above for ia64), you'd avoid having to make ACPI_SL=
EEP
> >>>>>>> depend on ACPI_GENERIC_SLEEP which goes somewhat backwards.
> >>>>>> In sleep.c,
> >>>>>>
> >>>>>> #ifdef CONFIG_ACPI_SLEEP
> >>>>>> acpi_target_system_state()
> >>>>>> {
> >>>>>> }
> >>>>>> #endif
> >>>>>>
> >>>>>> and CONFIG_ACPI_SLEEP depends on SUSPEND || HIBERNATION,
> >>>>>> which one of them will be enabled on ARM64 so ACPI_SLEEP
> >>>>>> will also enabled too.
> >>>>>>
> >>>>>> So if we
> >>>>>>
> >>>>>> +select ACPI_GENERIC_SLEEP if ACPI_SLEEP
> >>>>>>
> >>>>>> and
> >>>>>>
> >>>>>> +acpi-$(CONFIG_ACPI_GENERIC_SLEEP) +=3D sleep.o
> >>>>>>
> >>>>>> it will lead to errors for acpi_target_system_state() that
> >>>>>> is declared but not defined, so I will keep the code as
> >>>>>> it is, what do you think?
> >>>>> No, we need to hash this out.  Having two different Kconfig opt=
ions meaning
> >>>>> almost the same thing (ACPI_SLEEP and ACPI_GENERIC_SLEEP) is be=
yond ugly.
> >>>>>
> >>>>> Do you need ACPI_SLEEP on ARM64 at all?
> >>>> No, at least for now we don't need it, the spec for sleep is not=
 ready for
> >>>> ARM64 arch, so ACPI_SLEEP will not work at all on ARM64.
> >>> Well, so what about selecting ACPI_SLEEP from the architectures t=
hat use it?
> >> Do you mean remove CONFIG_ACPI_GENERIC_SLEEP and
> >>
> >> +acpi-$(CONFIG_ACPI_SLEEP) +=3D sleep.o
> >>
> >> as well (also need to remove duplicate #ifdef CONFIG_ACPI_SLEEP in=
 sleep.c if
> >> we doing so)?
> > Well, almost.  There is one problem with that, becuase sleep.c cont=
ains code
> > outside of the ACPI_SLEEP-dependent blocks.  That code is used for =
powering
> > off ACPI platforms.
> >
> > I guess you don't want that code on ARM too, right?
>=20
> Yes, you are right.
>=20
> >
> > Perhaps we can use ACPI_REDUCED_HARDWARE_ONLY for that?  ARM64 will=
 be the
>=20
> Sorry, I can't fully understand your intention here, could you please
> explain it more?
>=20
> Let me guess a little bit. Do you mean use ACPI_REDUCED_HARDWARE_ONLY=
 for
> powering off ACPI platforms? if so, I guess it's not a good idea, ACP=
I spec
> only says that S4BIOS is not supported on HW-reduced ACPI platforms, =
S5
> has no such limitation, if I miss something here, please let me know.

OK, so in your current patch, please replace ACPI_GENERIC_SLEEP with
ACPI_SYSTEM_POWER_STATES_SUPPORT and all should be clear.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
