From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Sun, 04 Jan 2015 17:39:24 +0800
Message-ID: <54A90A4C.60908@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org> <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62427 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbADJjq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jan 2015 04:39:46 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so26740058pad.13
        for <linux-acpi@vger.kernel.org>; Sun, 04 Jan 2015 01:39:46 -0800 (PST)
In-Reply-To: <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Kangkang.Shen@huawe

On 2014=E5=B9=B412=E6=9C=8825=E6=97=A5 01:18, Catalin Marinas wrote:
[...]
>
> In addition to the above and _DSD requirements/banning, I would also =
add
> some clear statements around:
>
> _OSC: only global/published capabilities are allowed. For
> device-specific _OSC we need a process or maybe we can ban them entir=
ely
> and rely on _DSD once we clarify the process.
>
> _OSI: firmware must not check for certain _OSI strings. Here I'm not
> sure what we would have to do for ARM Linux. Reporting "Windows" does
> not make any sense but not reporting anything can, as Matthew Garrett
> pointed out, can be interpreted by firmware as "Linux". In addition t=
o
> any statements in this document, I suggest you patch
> drivers/acpi/acpica/utosi.c accordingly, maybe report "Linux" for ARM
> and print a kernel warning so that we notice earlier.
>
> ACPI_OS_NAME: this is globally defined as "Microsoft Windows NT". It
> doesn't make much sense in the ARM context. Could we change it to
> "Linux" when CONFIG_ARM64?

We will work on this both on ASWG and linux ACPI driver side, as Dong
and Charles pointed out, _OSI things can be solved in ACPI spec, when
that is done, we can modify the kernel driver to fix the problems above=
=2E

>
> Compatibility with older kernels: ACPI firmware must work, even thoug=
h
> not fully optimal, with the earliest kernel version implementing the
> targeted ACPI spec. There may be a need for new drivers but otherwise
> adding things like CPU power management should not break older kernel
> versions. In addition, the ACPI firmware must also work with the late=
st
> kernel version.

It should be, and I think that's why we need ACPI (or DT) here :)

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
