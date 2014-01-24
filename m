From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/20] ARM64 / ACPI: Implement core functions for parsing MADT table
Date: Fri, 24 Jan 2014 21:57:15 +0100
Message-ID: <201401242157.15495.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <52E15756.4060705@arm.com> <52E287EE.70407@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62496 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbaAXU5a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jan 2014 15:57:30 -0500
In-Reply-To: <52E287EE.70407@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <Mark.Rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin

On Friday 24 January 2014, Hanjun Guo wrote:
> >> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> >> index e108d9c..c335c6d 100644
> >> --- a/arch/arm64/include/asm/acpi.h
> >> +++ b/arch/arm64/include/asm/acpi.h
> >> @@ -83,6 +83,9 @@ void arch_fix_phys_package_id(int num, u32 slot);
> >>   extern int (*acpi_suspend_lowlevel)(void);
> >>   #define acpi_wakeup_address (0)
> >>   
> >> +#define MAX_GIC_CPU_INTERFACE 256
> > I'll bite. Where on Earth is this value coming from?
> 
> I just thought 256 is big enough for now :(
> Yes, should be a larger number for GICv3.

Could this just be set to NR_CPUS? That way it will be large enough for
any system you can actually run on.

	Arnd
