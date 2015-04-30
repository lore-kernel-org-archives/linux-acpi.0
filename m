From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/2] arm/arm64: ACPI: Introduce CONFIG_ACPI_MUST_HAVE_CCA
Date: Thu, 30 Apr 2015 14:50:18 +0100
Message-ID: <20150430135018.GH32373@arm.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430315049-4663-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150429140445.GA18867@e104818-lin.cambridge.arm.com>
 <5540EB27.8060507@amd.com>
 <20150429144232.GC18867@e104818-lin.cambridge.arm.com>
 <55423261.4050008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35863 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbbD3NuX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Apr 2015 09:50:23 -0400
Content-Disposition: inline
In-Reply-To: <55423261.4050008@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "al.stone@linaro.org" <al.stone@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>, "msalter@redhat.com" <msalter@redhat.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, Apr 30, 2015 at 02:47:13PM +0100, Hanjun Guo wrote:
> On 2015=E5=B9=B404=E6=9C=8829=E6=97=A5 22:42, Catalin Marinas wrote:
> > On Wed, Apr 29, 2015 at 09:31:03AM -0500, Suravee Suthikulpanit wro=
te:
> >> On 04/29/2015 09:04 AM, Catalin Marinas wrote:
> >>> On Wed, Apr 29, 2015 at 08:44:08AM -0500, Suravee Suthikulpanit w=
rote:
> >>> Any plans for ACPI on 32-bit ARM?
> >>
> >> Not that I am aware, but I could be totally wrong. The reason I am=
 adding
> >> this here for 32-bit ARM is because the ACPI spec mentioned this.
> >>
> >> If you think this is not necessary until we introduce ACPI for ARM=
32, it can
> >> be removed.
> >
> > I think it should be removed (as long as ACPI cannot be selected on
> > arm32).
>=20
> I agree.
>=20
> Now there is no plan for ARM32 ACPI as I know, ACPI for ARM targets
> for ARM64 based enterprise system at now.

While we're at it, do we *really* need to support CONFIG_ACPI_PROCFS_PO=
WER
on arm64? It's a deprecated /proc/acpi interface and it would be nice t=
o
avoid introducing deprecated behaviour if we can avoid it.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
