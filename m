From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Sat, 21 Mar 2015 11:17:34 +0800
Message-ID: <550CE2CE.4080508@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org> <20150318190509.GM10863@arm.com> <550A4BFD.4070804@huawei.com> <20150320185400.GK1474@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36711 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbCUDRn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Mar 2015 23:17:43 -0400
Received: by pdbcz9 with SMTP id cz9so126021637pdb.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2015 20:17:43 -0700 (PDT)
In-Reply-To: <20150320185400.GK1474@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@l

+CC Parth Dixit, Stefano Stabellini.

On 2015=E5=B9=B403=E6=9C=8821=E6=97=A5 02:54, Will Deacon wrote:
> On Thu, Mar 19, 2015 at 04:09:33AM +0000, Hanjun Guo wrote:
>> On 2015/3/19 3:05, Will Deacon wrote:
>>> If you can get that in place, I'm not opposed to putting this into
>>> linux-next ahead of the firmware summit in San Jose next week. Note=
 that
>>> this is not a commitment for 4.1, since I'm keen to see the outcome=
s of
>>> next week before setting anything in stone.
>>
>> OK, I will stick to this mailing list and respond as soon as I can.
>
> This doesn't even build for me:
>
>
> $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-none-linux-gnu- allmodcon=
fig
> $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-none-linux-gnu- Image
>
> [...]
>
> In file included from drivers/xen/acpi.c:33:0:

Sorry, I didn't build ACPI with XEN enabled on ARM64.

> include/xen/acpi.h: In function =E2=80=98xen_acpi_sleep_register=E2=80=
=99:
> include/xen/acpi.h:102:3: error: =E2=80=98acpi_suspend_lowlevel=E2=80=
=99 undeclared (first use in this function)
>     acpi_suspend_lowlevel =3D xen_acpi_suspend_lowlevel;

acpi_suspend_lowlevel is defined only for X86 and IA64 for now.

>     ^
> include/xen/acpi.h:102:3: note: each undeclared identifier is reporte=
d only once for each function it appears in
> drivers/xen/acpi.c: In function =E2=80=98xen_acpi_notify_hypervisor_s=
tate=E2=80=99:
> drivers/xen/acpi.c:61:2: error: implicit declaration of function =E2=80=
=98HYPERVISOR_dom0_op=E2=80=99 [-Werror=3Dimplicit-function-declaration=
]
>    HYPERVISOR_dom0_op(&op);

And this is only for x86:
=2E/arch/x86/include/asm/xen/hypercall.h:HYPERVISOR_dom0_op(struct=20
xen_platform_op *platform_op)

>    ^
> cc1: some warnings being treated as errors
> make[2]: *** [drivers/xen/acpi.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers/xen] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
>
>
> Am I missing some other patches?

No, you miss nothing. Parth Dixit is still working on XEN ACPI for
ARM64, before it's in full function, how about introduce a Kconfig
CONFIG_XEN_ACPI and let it depends on x86? when XEN ACPI for ARM64
comes, we can enable ARM64 for CONFIG_XEN_ACPI and fix the problems
above.

Stefano, Parth, what do you think?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
