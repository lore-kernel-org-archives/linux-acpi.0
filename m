From: Alexander Spyridakis <a.spyridakis@virtualopensystems.com>
Subject: Re: [Linaro-acpi] [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific
 ACPI boot support
Date: Tue, 2 Sep 2014 10:28:00 +0200
Message-ID: <CAJRNFKKziDydj_HFPam6e+FSZr6D3XPUQ+-iuH0a1Bbh3+Kz3A@mail.gmail.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
	<1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
	<5404AE56.80801@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:34352 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbaIBI2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 04:28:04 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so6004553qaj.35
        for <linux-acpi@vger.kernel.org>; Tue, 02 Sep 2014 01:28:02 -0700 (PDT)
In-Reply-To: <5404AE56.80801@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>

On 1 September 2014 19:35, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 01/09/14 15:57, Hanjun Guo wrote:
> > From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >
> > ACPI kernel uses MADT table for proper GIC initialization. It needs to
> > parse GIC related subtables, collect CPU interface and distributor
> > addresses and call driver initialization function (which is hardware
> > abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> >
> > NOTE: This commit allow to initialize GICv1/2 only.
>
> I cannot help but notice that there is no support for KVM here. It'd be
> good to add a note to that effect, so that people do not expect
> virtualization support to be working when booting with ACPI.

Just a heads up for this, I run up to this problem too while testing
and by forcing some values for vgic and arch_timers I could boot a
QEMU guest without problems.

I'll try and see if it will be easy to handle this more properly
instead of hardcoded values.

Regards.
