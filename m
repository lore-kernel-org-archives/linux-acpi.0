From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Mon, 5 Jan 2015 11:05:33 +0000
Message-ID: <20150105110533.GA14967@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
 <54A90A4C.60908@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:55184 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbAELF4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jan 2015 06:05:56 -0500
Content-Disposition: inline
In-Reply-To: <54A90A4C.60908@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Kangkang.Shen@huawe

On Sun, Jan 04, 2015 at 09:39:24AM +0000, Hanjun Guo wrote:
> On 2014=E5=B9=B412=E6=9C=8825=E6=97=A5 01:18, Catalin Marinas wrote:
> [...]
> >
> > In addition to the above and _DSD requirements/banning, I would als=
o add
> > some clear statements around:
> >
> > _OSC: only global/published capabilities are allowed. For
> > device-specific _OSC we need a process or maybe we can ban them ent=
irely
> > and rely on _DSD once we clarify the process.
> >
> > _OSI: firmware must not check for certain _OSI strings. Here I'm no=
t
> > sure what we would have to do for ARM Linux. Reporting "Windows" do=
es
> > not make any sense but not reporting anything can, as Matthew Garre=
tt
> > pointed out, can be interpreted by firmware as "Linux". In addition=
 to
> > any statements in this document, I suggest you patch
> > drivers/acpi/acpica/utosi.c accordingly, maybe report "Linux" for A=
RM
> > and print a kernel warning so that we notice earlier.
> >
> > ACPI_OS_NAME: this is globally defined as "Microsoft Windows NT". I=
t
> > doesn't make much sense in the ARM context. Could we change it to
> > "Linux" when CONFIG_ARM64?
>=20
> We will work on this both on ASWG and linux ACPI driver side, as Dong
> and Charles pointed out, _OSI things can be solved in ACPI spec, when
> that is done, we can modify the kernel driver to fix the problems abo=
ve.

Which driver?

What about ACPI_OS_NAME? Would you suggest it is fine to report
"Microsoft Windows NT" on an ARM system? That _OS_ not _OSI.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
