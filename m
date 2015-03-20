From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Fri, 20 Mar 2015 18:54:00 +0000
Message-ID: <20150320185400.GK1474@arm.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <20150318190509.GM10863@arm.com>
 <550A4BFD.4070804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41086 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbbCTSyH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Mar 2015 14:54:07 -0400
Content-Disposition: inline
In-Reply-To: <550A4BFD.4070804@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.or

On Thu, Mar 19, 2015 at 04:09:33AM +0000, Hanjun Guo wrote:
> On 2015/3/19 3:05, Will Deacon wrote:
> > If you can get that in place, I'm not opposed to putting this into
> > linux-next ahead of the firmware summit in San Jose next week. Note=
 that
> > this is not a commitment for 4.1, since I'm keen to see the outcome=
s of
> > next week before setting anything in stone.
>=20
> OK, I will stick to this mailing list and respond as soon as I can.

This doesn't even build for me:


$ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-none-linux-gnu- allmodconfi=
g
$ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-none-linux-gnu- Image

[...]

In file included from drivers/xen/acpi.c:33:0:
include/xen/acpi.h: In function =E2=80=98xen_acpi_sleep_register=E2=80=99=
:
include/xen/acpi.h:102:3: error: =E2=80=98acpi_suspend_lowlevel=E2=80=99=
 undeclared (first use in this function)
   acpi_suspend_lowlevel =3D xen_acpi_suspend_lowlevel;
   ^
include/xen/acpi.h:102:3: note: each undeclared identifier is reported =
only once for each function it appears in
drivers/xen/acpi.c: In function =E2=80=98xen_acpi_notify_hypervisor_sta=
te=E2=80=99:
drivers/xen/acpi.c:61:2: error: implicit declaration of function =E2=80=
=98HYPERVISOR_dom0_op=E2=80=99 [-Werror=3Dimplicit-function-declaration=
]
  HYPERVISOR_dom0_op(&op);
  ^
cc1: some warnings being treated as errors
make[2]: *** [drivers/xen/acpi.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/xen] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2


Am I missing some other patches?

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
