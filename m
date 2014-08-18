From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v2 00/18] Introduce ACPI for ARM64 based on
 ACPI 5.1
Date: Mon, 18 Aug 2014 19:11:49 +0100
Message-ID: <20140818181149.GG2094@xora-yoga-deb.xora.org.uk>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <CAJRNFK+UfJhGR65tOecy=X+YdHQHiNPZ4p_p8LUxhRL3GW5gFw@mail.gmail.com>
 <53E050B2.2080609@linaro.org>
 <CAJRNFKJtbfYEkYWcyXPOfRU9D4MVhabn5X1ZumZMSQFQ=S=j5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:40572 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaHRSLw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Aug 2014 14:11:52 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so5301591wgh.8
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2014 11:11:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJRNFKJtbfYEkYWcyXPOfRU9D4MVhabn5X1ZumZMSQFQ=S=j5g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Spyridakis <a.spyridakis@virtualopensystems.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Mon, Aug 18, 2014 at 07:08:59PM +0200, Alexander Spyridakis wrote:
> > Yes, I think so. If you meet any problem , please let us know, and we will
> > update the wiki.
> >
> >>
> >> Should I assume that UEFI is mandatory (alternative being the aarch64
> >> bootwrapper), as described in Documentation/arm64/arm-acpi.txt?
> >
> > Yes, UEFI is mandatory if you want to use ACPI.
> 
> Hello Hanjun,
> 
> What tables do you use for the foundation model (or AEMv8)?
> 
> The ones found in this repository:
> git://git.linaro.org/leg/acpi/acpi-asl.git are ACPIv5.0, and when the
> kernel gets pointed to them acpi is disabled because it expects an
> FADT v5.1 or later. Of course building these tables with latest ACPICA
> also fails.
> 
I updated that repository to ACPI 5.1 approximately 4 hours ago.

If you re-fetch you should see 5.1 tables for foundation model.

Graeme

