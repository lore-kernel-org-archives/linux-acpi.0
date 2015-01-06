From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Tue, 6 Jan 2015 11:29:29 +0000
Message-ID: <20150106112929.GB8829@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
 <54A90A4C.60908@linaro.org>
 <20150105110533.GA14967@e104818-lin.cambridge.arm.com>
 <54ABC2CB.6@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:55793 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755292AbbAFL3m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jan 2015 06:29:42 -0500
Content-Disposition: inline
In-Reply-To: <54ABC2CB.6@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Kangkang.Shen@huawe

On Tue, Jan 06, 2015 at 11:11:07AM +0000, Hanjun Guo wrote:
> On 2015=E5=B9=B401=E6=9C=8805=E6=97=A5 19:05, Catalin Marinas wrote:
> > On Sun, Jan 04, 2015 at 09:39:24AM +0000, Hanjun Guo wrote:
> >> On 2014=E5=B9=B412=E6=9C=8825=E6=97=A5 01:18, Catalin Marinas wrot=
e:
> >> [...]
> >>>
> >>> In addition to the above and _DSD requirements/banning, I would a=
lso add
> >>> some clear statements around:
> >>>
> >>> _OSC: only global/published capabilities are allowed. For
> >>> device-specific _OSC we need a process or maybe we can ban them e=
ntirely
> >>> and rely on _DSD once we clarify the process.
> >>>
> >>> _OSI: firmware must not check for certain _OSI strings. Here I'm =
not
> >>> sure what we would have to do for ARM Linux. Reporting "Windows" =
does
> >>> not make any sense but not reporting anything can, as Matthew Gar=
rett
> >>> pointed out, can be interpreted by firmware as "Linux". In additi=
on to
> >>> any statements in this document, I suggest you patch
> >>> drivers/acpi/acpica/utosi.c accordingly, maybe report "Linux" for=
 ARM
> >>> and print a kernel warning so that we notice earlier.
> >>>
> >>> ACPI_OS_NAME: this is globally defined as "Microsoft Windows NT".=
 It
> >>> doesn't make much sense in the ARM context. Could we change it to
> >>> "Linux" when CONFIG_ARM64?
>=20
> I think we can introduce a Kconfig such as CONFIG_ACPI_OS_NAME_LINUX,
> selected by ARM64 and change ACPI_OS_NAME to "Linux" when
> CONFIG_ACPI_OS_NAME_LINUX defined. (we can not add CONFIG_ARM64 in
> ACPICA code directly since it will be used by windows too)
>=20
> some code like below:

This looks fine for me (with some minor comments below) but I'm not an
ACPI expert to say there wouldn't be any issues.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1f9a20..de567a3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1,5 +1,6 @@
>   config ARM64
>          def_bool y
> +       select ACPI_OS_NAME_LINUX if ACPI
>          select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>          select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>          select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 8951cef..11a10ac 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -369,6 +369,10 @@ config ACPI_REDUCED_HARDWARE_ONLY
>=20
>            If you are unsure what to do, do not enable this option.
>=20
> +config ACPI_OS_NAME_LINUX
> +       bool "Using Linux for _OS method" if EXPERT
> +       def_bool n

No need for a default n, it is off by default. Alternatively you could
say:

	default y if ARM64

> +
>   source "drivers/acpi/apei/Kconfig"
>=20
>   config ACPI_EXTLOG
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> index 5a0a3e5..db5e13e 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -69,7 +69,11 @@
>    * code that will not execute the _OSI method unless _OS matches th=
e=20
> string
>    * below.  Therefore, change this string at your own risk.
>    */
> +#ifndef ACPI_OS_NAME_USING_LINUX
>   #define ACPI_OS_NAME                    "Microsoft Windows NT"
> +#else
> +#define ACPI_OS_NAME                    "Linux"
> +#endif

Can you not use CONFIG_ACPI_OS_NAME_LINUX directly here without
introducing another macro?

> >> We will work on this both on ASWG and linux ACPI driver side, as D=
ong
> >> and Charles pointed out, _OSI things can be solved in ACPI spec, w=
hen
> >> that is done, we can modify the kernel driver to fix the problems =
above.
> >
> > Which driver?
>=20
> the ACPICA core driver as you suggested, sorry for the confusion.
>=20
> > What about ACPI_OS_NAME? Would you suggest it is fine to report
> > "Microsoft Windows NT" on an ARM system? That _OS_ not _OSI.
>=20
> No, not at all. I prefer "Linux"
> In include/acpi/acconfig.h, when ACPI_OS_NAME defined, it says:
> "OS name, used for the _OS object.  The _OS object is essentially
> obsolete,..."
> for some legacy reasons, we needed  "Microsoft Windows NT", but ACPI
> for ARM64 on linux is totally new, I think we can change it to
> "Linux" when CONFIG_ARM64 as you suggested.

We could ignore this change for now if we don't expect the _OS object t=
o
be used at all. But do we have any other way to check the AML code for
this? Would FWTS catch such obsolete cases?

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
