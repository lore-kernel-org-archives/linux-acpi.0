From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Sun, 22 Mar 2015 22:49:30 +0100
Message-ID: <2189259.UNlTC1BNmt@vostro.rjw.lan>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org> <CAFoFrHatzS3MwGVeOPPjY1R1sfBRYnJjgbQjvfzi6xS+XYD14g@mail.gmail.com> <550F2E91.7010109@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65172 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751832AbbCVVZa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2015 17:25:30 -0400
In-Reply-To: <550F2E91.7010109@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julien Grall <julien.grall@linaro.org>
Cc: Naresh Bhat <naresh.bhat@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Hanjun Guo <hanjun.guo@linaro.org>, Jon Fraser <jfraser@broadcom.com>, Parth Dixit <parth.dixit@linaro.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, linux-acpi@vger.ke

On Sunday, March 22, 2015 09:05:21 PM Julien Grall wrote:
> Hello,
> 
> On 21/03/2015 12:09, Naresh Bhat wrote:
> >      From 268dcdafa34a690e2f99c0784ca33a6d2352ecf5 Mon Sep 17 00:00:00 2001
> >     From: Hanjun Guo <hanjun.guo@linaro.org <mailto:hanjun.guo@linaro.org>>
> >     Date: Sat, 21 Mar 2015 14:43:54 +0800
> >     Subject: [PATCH] XEN / ACPI: Make XEN ACPI depend on X86
> >
> >     When ACPI is enabled on ARM64, XEN ACPI will also compiled
> >     into the kernel, but XEN ACPI is x86 dependent, so introduce
> >     CONFIG_XEN_ACPI to make it depend on x86 before XEN ACPI is
> >     functional on ARM64.
> >
> >     Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org
> >     <mailto:hanjun.guo@linaro.org>>
> >     ---
> >       drivers/xen/Kconfig  | 4 ++++
> >       drivers/xen/Makefile | 2 +-
> >       2 files changed, 5 insertions(+), 1 deletion(-)
> >
> >     diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> >     index b812462..a31cd29 100644
> >     --- a/drivers/xen/Kconfig
> >     +++ b/drivers/xen/Kconfig
> >     @@ -253,4 +253,8 @@ config XEN_EFI
> >           def_bool y
> >           depends on X86_64 && EFI
> >
> >     +config XEN_ACPI
> >     +    def_bool y
> >     +    depends on X86 && ACPI
> >     +
> >       endmenu
> >     diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> >     index 2ccd359..f4622ab 100644
> >     --- a/drivers/xen/Makefile
> >     +++ b/drivers/xen/Makefile
> >     @@ -13,7 +13,7 @@ CFLAGS_efi.o                += -fshort-wchar
> >
> >       dom0-$(CONFIG_PCI) += pci.o
> >       dom0-$(CONFIG_USB_SUPPORT) += dbgp.o
> >     -dom0-$(CONFIG_ACPI) += acpi.o $(xen-pad-y)
> >     +dom0-$(CONFIG_XEN_ACPI) += acpi.o $(xen-pad-y)
> >       xen-pad-$(CONFIG_X86) += xen-acpi-pad.o
> >       dom0-$(CONFIG_X86) += pcpu.o
> >       obj-$(CONFIG_XEN_DOM0)            += $(dom0-y)
> 
> [..]
> 
> >
> > AFAIK,  There is already a kernel patch exists to fix this issue.  I
> > think  Julien or Parth is a right person to ask.  Hence I am CCed Julien
> > Grall too.
> 
> The ACPI support for Xen is not ready. So I think avoiding to compile 
> drivers/xen/acpi.c on ARM64/ARM seems the better solution for now.
> 
> Although, rather than introducing a new CONFIG option, I would use the 
> same trick we use within the Makefile to avoid hotplug.c on ARM/ARM64.
> 
> ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)), )
> dom0-$(CONFIG_ACPI) += acpi.o $(xen-pad-y)
> endif

Well, is avoiding an extra CONFIG_ option worth the ugliness of this?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
