From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v9 18/21] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY
 if ACPI is enabled on ARM64
Date: Tue, 10 Mar 2015 14:16:46 +0000
Message-ID: <20150310141645.GA25123@red-moon>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-19-git-send-email-hanjun.guo@linaro.org>
 <20150306174715.GA26888@e102568-lin.cambridge.arm.com>
 <54FEE227.4000808@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42981 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011AbbCJOQz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2015 10:16:55 -0400
Content-Disposition: inline
In-Reply-To: <54FEE227.4000808@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.

On Tue, Mar 10, 2015 at 12:23:03PM +0000, Hanjun Guo wrote:
> On 2015=E5=B9=B403=E6=9C=8807=E6=97=A5 01:47, Lorenzo Pieralisi wrote=
:
> > On Wed, Feb 25, 2015 at 08:39:58AM +0000, Hanjun Guo wrote:
> >> From: Al Stone <al.stone@linaro.org>
> >>
> >> ACPI reduced hardware mode is disabled by default, but ARM64
> >> can only run properly in ACPI hardware reduced mode, so select
> >> ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.
> >
> > Agreed. This will remove unneeded acpica code. I think though,
> > you should also check the FADT flag HW_REDUCED_ACPI at boot to
> > make sure that the tables are HW reduced compliant. I am flagging
>=20
> Agreed, I will add that check on top of this patch set. We explicitly
> stated that we are using hardware reduced mode on ARM64 in the doc, s=
o,=20
> how about print some warning message and go on with the boot if we
> got the wrong flag HW_REDUCED_ACPI at boot?

Why would be boot if the ACPI tables are not HW_REDUCED_ACPI compliant =
?

To look for trouble :) ? arm64 does not support any other ACPI model,
the missing flag should disable ACPI IMO on arm64.

You could add a check in this patch same place where you check
the FADT version and be done with this.

Thank you !
Lorenzo

> > this up because I noticed code in core code (not guarded by
> > ifdef) that checks:
> >
> > acpi_gbl_reduced_hardware
> >
> > and if it is not set it goes on instantiating fixed HW devices.
> >
> > drivers/acpi/scan.c:2567
> >
> > It is just a heads up, I think it is harmless, but one thing is
> > removing acpica code on ACPI HW reduced only, the other is to make
> > sure the kernel does not try to use ACPI HW features that acpica
> > can't support.
>=20
> I agree, need some cleanups for the ACPICA code I think, and this
> was raised about 1 and half years ago and Intel folks need more
> consideration on that [1].
>=20
> [1]: http://comments.gmane.org/gmane.linux.acpi.devel/63844
>=20
> Thanks
> Hanjun
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
