From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 4/4] mfd: syscon: add ACPI support
Date: Mon, 07 Dec 2015 09:47:43 +0100
Message-ID: <2666629.mh0RnUHbhb@wuerfel>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com> <20151203155612.GA2935@red-moon> <56652409.8070905@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:64523 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbbLGIs0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2015 03:48:26 -0500
In-Reply-To: <56652409.8070905@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Graeme Gregory <gg@slimlogic.co.uk>, Hanjun Guo <hanjun.guo@linaro.org>

On Monday 07 December 2015 14:15:37 Kefeng Wang wrote:
> On 2015/12/3 23:56, Lorenzo Pieralisi wrote:
> > On Thu, Dec 03, 2015 at 09:01:11PM +0800, Kefeng Wang wrote:
> >> Hi Graeme, Arnd, and Lorenzo,
> >>
> >> Firstly, we absolutely agree with the point which use AML to do so=
me "special"
> >> initialisation and configuration.
> >=20
> > Good.
> >=20
> >> SAS and NIC driver were accepted by linux in hisilicon hip05 chip,=
 and the drivers
> >> reset the control by syscon, we want to use "_RST" method, which i=
s introduced by
> >> ACPI 6.0 spec in "7.3.25 _RST (Device Reset)", is it reasonable an=
d standard for us?
> >=20
> > Can you point me at the drivers you are referring to please ?
>=20
> SAS=EF=BC=9A https://lkml.org/lkml/2015/11/17/572
>       [PATCH v5 19/32] scsi: hisi_sas: add v1 HW initialisation code
>       static int reset_hw_v1_hw(struct hisi_hba *hisi_hba);
>=20
> HNS=EF=BC=9A drivers/net/ethernet/hisilicon/hns_mdio.c
>       static int hns_mdio_reset(struct mii_bus *bus)=EF=BC=9B

It seems that there is some commonality in here that there is more than
one device reset in this system control unit.

I'd suggest moving this out into a proper reset driver that of course
then has to be based on syscon for DT based systems so it doesn't confl=
ict
with the other random stuff in the syscon space, and for backwards
compatibiltiy with old kernels that only know about the syscon based re=
set
you have currently implemented.

If there are additional devices that also use the same syscon node for
reset, they should of course only use the device_reset() method.

> >> But here is a scene, we can not find a suitable way to support ACP=
I. There is no
> >> independent memory region in some module(the driver not upstreamed=
), that is,
> >> when write and read the module's register, we must r/w by syscon. =
Any advice?
> >=20
> > What do you mean ? You mean that the reset control is a piece of HW
> > that is shared between multiple "components" ? What's your concern
> > about AML code driving those registers here ?
>=20
> This is unrelated to reset control.
>=20
> I mean we have some driver(not upstreamed), like LLC(last level cache=
), when access the register
> of llc, we need help through syscon, because the llc has no independe=
nt registers region , steps
> of Read and Write register in those drivers is shown below,
>=20
>  1) get the syscon base;
>  2) configure and choose the module which need to be accessed;
>  3) R/W the value from the syscon, that is, get/set the value from/to=
 llc;
>=20
> Every read and write the register in those drivers, we must through s=
yscon. That is why we need
> syscon to support ACPI.

last level cache is something that should go through architecture code,
it has no business in syscon anyway. What do you control with this anyw=
ay?
AFAIK, ARMv8 has architected instructions to control caches and doesn't
need to talk to a cache controller the way we used to do on v6 and olde=
r v7
based systems.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
