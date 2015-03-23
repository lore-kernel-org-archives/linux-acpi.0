From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Mon, 23 Mar 2015 18:32:35 +0000
Message-ID: <alpine.DEB.2.02.1503231822520.7982@kaball.uk.xensource.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <20150318190509.GM10863@arm.com> <550A4BFD.4070804@huawei.com>
 <20150320185400.GK1474@arm.com> <550CE2CE.4080508@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="1342847746-577813448-1427135555=:7982"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:33170 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbbCWSdv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2015 14:33:51 -0400
In-Reply-To: <550CE2CE.4080508@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>lin

--1342847746-577813448-1427135555=:7982
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 21 Mar 2015, Hanjun Guo wrote:
> +CC Parth Dixit, Stefano Stabellini.
>=20
> On 2015=E5=B9=B403=E6=9C=8821=E6=97=A5 02:54, Will Deacon wrote:
> > On Thu, Mar 19, 2015 at 04:09:33AM +0000, Hanjun Guo wrote:
> > > On 2015/3/19 3:05, Will Deacon wrote:
> > > > If you can get that in place, I'm not opposed to putting this into
> > > > linux-next ahead of the firmware summit in San Jose next week. Note=
 that
> > > > this is not a commitment for 4.1, since I'm keen to see the outcome=
s of
> > > > next week before setting anything in stone.
> > >=20
> > > OK, I will stick to this mailing list and respond as soon as I can.
> >=20
> > This doesn't even build for me:
> >=20
> >=20
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-none-linux-gnu- allmodconfi=
g
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-none-linux-gnu- Image
> >=20
> > [...]
> >=20
> > In file included from drivers/xen/acpi.c:33:0:
>=20
> Sorry, I didn't build ACPI with XEN enabled on ARM64.
>=20
> > include/xen/acpi.h: In function =E2=80=98xen_acpi_sleep_register=E2=80=
=99:
> > include/xen/acpi.h:102:3: error: =E2=80=98acpi_suspend_lowlevel=E2=80=
=99 undeclared (first
> > use in this function)
> >     acpi_suspend_lowlevel =3D xen_acpi_suspend_lowlevel;
>=20
> acpi_suspend_lowlevel is defined only for X86 and IA64 for now.
>=20
> >     ^
> > include/xen/acpi.h:102:3: note: each undeclared identifier is reported =
only
> > once for each function it appears in
> > drivers/xen/acpi.c: In function =E2=80=98xen_acpi_notify_hypervisor_sta=
te=E2=80=99:
> > drivers/xen/acpi.c:61:2: error: implicit declaration of function
> > =E2=80=98HYPERVISOR_dom0_op=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> >    HYPERVISOR_dom0_op(&op);
>=20
> And this is only for x86:
> ./arch/x86/include/asm/xen/hypercall.h:HYPERVISOR_dom0_op(struct
> xen_platform_op *platform_op)
>=20
> >    ^
> > cc1: some warnings being treated as errors
> > make[2]: *** [drivers/xen/acpi.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [drivers/xen] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [drivers] Error 2
> >=20
> >=20
> > Am I missing some other patches?
>=20
> No, you miss nothing. Parth Dixit is still working on XEN ACPI for
> ARM64, before it's in full function, how about introduce a Kconfig
> CONFIG_XEN_ACPI and let it depends on x86? when XEN ACPI for ARM64
> comes, we can enable ARM64 for CONFIG_XEN_ACPI and fix the problems
> above.
>=20
> Stefano, Parth, what do you think?
=20
To be precise, Parth is working on ACPI enablement for the Xen
hypervisor at the moment (on the Xen tree), I don't think he has any
patches for Linux (Dom0 is the key use case). The two works could be
carried on in parallel, even though you would obviously need Parth's Xen
patches to test the Linux side.

That said, I am OK with disabling ACPI for Xen on ARM and ARM64 for now
-- I wouldn't want to cause any significant delays to your patch series.
--1342847746-577813448-1427135555=:7982--
