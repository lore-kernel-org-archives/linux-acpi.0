From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Sat, 21 Mar 2015 15:03:26 +0800
Message-ID: <550D17BE.70009@huawei.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org> <20150318190509.GM10863@arm.com> <550A4BFD.4070804@huawei.com> <20150320185400.GK1474@arm.com> <550CE2CE.4080508@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <550CE2CE.4080508@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Parth Dixit <parth.dixit@linaro.org>, 'Stefano Stabellini' <stefano.stabellini@eu.citrix.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi
List-Id: linux-acpi@vger.kernel.org

On 2015/3/21 11:17, Hanjun Guo wrote:
> +CC Parth Dixit, Stefano Stabellini.
>
> On 2015=E5=B9=B403=E6=9C=8821=E6=97=A5 02:54, Will Deacon wrote:
>> On Thu, Mar 19, 2015 at 04:09:33AM +0000, Hanjun Guo wrote:
>>> On 2015/3/19 3:05, Will Deacon wrote:
>>>> If you can get that in place, I'm not opposed to putting this into
>>>> linux-next ahead of the firmware summit in San Jose next week. Not=
e that
>>>> this is not a commitment for 4.1, since I'm keen to see the outcom=
es of
>>>> next week before setting anything in stone.
>>>
>>> OK, I will stick to this mailing list and respond as soon as I can.
>>
>> This doesn't even build for me:
>>
>>
>> $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-none-linux-gnu- allmodco=
nfig
>> $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-none-linux-gnu- Image
>>
>> [...]
>>
>> In file included from drivers/xen/acpi.c:33:0:
>
> Sorry, I didn't build ACPI with XEN enabled on ARM64.
>
>> include/xen/acpi.h: In function =E2=80=98xen_acpi_sleep_register=E2=80=
=99:
>> include/xen/acpi.h:102:3: error: =E2=80=98acpi_suspend_lowlevel=E2=80=
=99 undeclared (first use in this function)
>>     acpi_suspend_lowlevel =3D xen_acpi_suspend_lowlevel;
>
> acpi_suspend_lowlevel is defined only for X86 and IA64 for now.
>
>>     ^
>> include/xen/acpi.h:102:3: note: each undeclared identifier is report=
ed only once for each function it appears in
>> drivers/xen/acpi.c: In function =E2=80=98xen_acpi_notify_hypervisor_=
state=E2=80=99:
>> drivers/xen/acpi.c:61:2: error: implicit declaration of function =E2=
=80=98HYPERVISOR_dom0_op=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
>>    HYPERVISOR_dom0_op(&op);
>
> And this is only for x86:
> ./arch/x86/include/asm/xen/hypercall.h:HYPERVISOR_dom0_op(struct xen_=
platform_op *platform_op)
>
>>    ^
>> cc1: some warnings being treated as errors
>> make[2]: *** [drivers/xen/acpi.o] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [drivers/xen] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [drivers] Error 2
>>
>>
>> Am I missing some other patches?
>
> No, you miss nothing. Parth Dixit is still working on XEN ACPI for
> ARM64, before it's in full function, how about introduce a Kconfig
> CONFIG_XEN_ACPI and let it depends on x86? when XEN ACPI for ARM64
> comes, we can enable ARM64 for CONFIG_XEN_ACPI and fix the problems
> above.
>
> Stefano, Parth, what do you think?

I prepared a patch for further reference:

=46rom 268dcdafa34a690e2f99c0784ca33a6d2352ecf5 Mon Sep 17 00:00:00 200=
1
=46rom: Hanjun Guo <hanjun.guo@linaro.org>
Date: Sat, 21 Mar 2015 14:43:54 +0800
Subject: [PATCH] XEN / ACPI: Make XEN ACPI depend on X86

When ACPI is enabled on ARM64, XEN ACPI will also compiled
into the kernel, but XEN ACPI is x86 dependent, so introduce
CONFIG_XEN_ACPI to make it depend on x86 before XEN ACPI is
functional on ARM64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/xen/Kconfig  | 4 ++++
 drivers/xen/Makefile | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index b812462..a31cd29 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -253,4 +253,8 @@ config XEN_EFI
     def_bool y
     depends on X86_64 && EFI
=20
+config XEN_ACPI
+    def_bool y
+    depends on X86 && ACPI
+
 endmenu
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 2ccd359..f4622ab 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -13,7 +13,7 @@ CFLAGS_efi.o                +=3D -fshort-wchar
=20
 dom0-$(CONFIG_PCI) +=3D pci.o
 dom0-$(CONFIG_USB_SUPPORT) +=3D dbgp.o
-dom0-$(CONFIG_ACPI) +=3D acpi.o $(xen-pad-y)
+dom0-$(CONFIG_XEN_ACPI) +=3D acpi.o $(xen-pad-y)
 xen-pad-$(CONFIG_X86) +=3D xen-acpi-pad.o
 dom0-$(CONFIG_X86) +=3D pcpu.o
 obj-$(CONFIG_XEN_DOM0)            +=3D $(dom0-y)
--=20
1.7.12.4
