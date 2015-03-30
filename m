From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 13/23] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
Date: Mon, 30 Mar 2015 14:58:10 +0100
Message-ID: <20150330135810.GC5964@e104818-lin.cambridge.arm.com>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-14-git-send-email-hanjun.guo@linaro.org>
 <20150325172109.GJ14585@localhost>
 <551381CD.5010804@huawei.com>
 <55155DCA.3060006@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32795 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095AbbC3N6S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Mar 2015 09:58:18 -0400
Content-Disposition: inline
In-Reply-To: <55155DCA.3060006@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ashwin Chaugule <ashwinc@codeaurora.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Hanjun Guo <guohanjun@huawei.com>, Grant Likely <grant.likely@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 27, 2015 at 09:40:26PM +0800, Hanjun Guo wrote:
> On 2015=E5=B9=B403=E6=9C=8826=E6=97=A5 11:49, Hanjun Guo wrote:
> >On 2015/3/26 1:21, Catalin Marinas wrote:
> >>On Tue, Mar 24, 2015 at 10:02:46PM +0800, Hanjun Guo wrote:
> >>>--- a/drivers/acpi/acpi_processor.c
> >>>+++ b/drivers/acpi/acpi_processor.c
> >>>@@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct a=
cpi_processor *pr)
> >>>  	acpi_status status;
> >>>  	int ret;
> >>>
> >>>-	if (pr->phys_id =3D=3D -1)
> >>>+	if (pr->phys_id =3D=3D PHYS_CPUID_INVALID)
> >>>  		return -ENODEV;
> >>If PHYS_CPUID_INVALID is the same as INVALID_HWID, we should get ri=
d of
> >>the latter in the arm64 code (as a subsequent clean-up patch).
> >
> >OK, I'm preparing a patch set to introduce invalid_phys_cpuid() and =
invalid_logical_cpuid()
> >to remove the direct comparison of PHYS_CPUID_INVALID and -1 in ACPI=
 processor drivers,
> >which is suggested by Rafael, I will cleanup PHYS_CPUID_INVALID in t=
his patch set.
>=20
> I met difficulty to do so, because we use
>=20
> +#ifndef PHYS_CPUID_INVALID
> +typedef u32 phys_cpuid_t;
> +#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> +#endif
>=20
> in the common head file linux/acpi.h, we need macro
> PHYS_CPUID_INVALID to identify if phys_cpuid_t is typedefed
> for different arch, so if we want remove PHYS_CPUID_INVALID
> for ARM64, we need to got back to typedef phys_cpuid_t for
> each arch using ACPI. which means that

What I meant was removing INVALID_HWID from arm64 and always use the
PHYS_CPUID_INVALID but I think we should leave them as they are for now
since PHYS_CPUID_INVALID is defined in the asm/acpi.h file.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
