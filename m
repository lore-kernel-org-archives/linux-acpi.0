From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/20] clocksource / acpi: Add macro CLOCKSOURCE_ACPI_DECLARE
Date: Wed, 22 Jan 2014 16:47:28 +0100
Message-ID: <4603592.X6dscGmyfO@wuerfel>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <3140612.0s75qS6VKb@wuerfel> <20140122151749.GA1519@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50036 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030AbaAVPrx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jan 2014 10:47:53 -0500
In-Reply-To: <20140122151749.GA1519@e106331-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rob Herring <robh@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Hanjun Guo <hanjun.guo@linaro.org>, "patches@linaro.org" <patches@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On Wednesday 22 January 2014 15:17:49 Mark Rutland wrote:
> Except for the fact that some timers / clocksources that we already have
> in 32-bit land will likely be reused in 64-bit SoC designs. People will
> want to use the same driver for both 32-bit and 64-bit kernels, and thus
> we need CLOCKSOURCE_OF_DECLARE in 64-bit kernels.
> 
> Those platforms which will have ACPI will likely reuse existing timer IP
> blocks, and will want to make minimal changes to the driver, which will
> likely be using CLOCKSOURCE_OF_DECLARE. We can't change these to
> platform drivers or we can break existing systems because the timers
> will be registered too late.
> 
> I don't see how we can share drivers between 32-bit and 64-bit kernels
> without sharing a common driver model, and I think it makes sense to
> have some uniformity across drivers (i.e. always use
> CLOCKSOURCE_*_DECLARE rather than sometimes using platform drivers).

This still sounds like speculation. I would defer this change until
we actually have a platform that needs it.

The platforms that would reuse a lot of IP blocks are most likely
embedded systems and /not/ server hardware following some strict
specification, so they wouldn't use ACPI.

	Arnd
