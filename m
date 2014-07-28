From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Mon, 28 Jul 2014 12:46:17 +0200
Message-ID: <5959830.lpqeqL7HbK@wuerfel>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org> <5014834.k6eecMddPC@wuerfel> <53D616AD.2090501@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60668 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaG1KrE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jul 2014 06:47:04 -0400
In-Reply-To: <53D616AD.2090501@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vge>

On Monday 28 July 2014 10:23:57 Graeme Gregory wrote:
> The PL011 UART is the use-case I keep hitting, that IP block has a 
> variable input clock on pretty much everything I have seen in the wild. 

Ok, I see. What does ACPI-5.1 say about pl011?

Interestingly, the subset of pl011 that is specified by SBSA does not
contain the IBRD/FBRD registers, effectively making it a fixed-rated
UART (I guess that would be a ART, without the U then), and you
consequently don't even need to know the clock rate.

However, my guess is that most hardware in the real world contains
an actual pl011 and it does make a lot of sense to allow setting
the baud rate on it, which then requires knowing the input clock.

If there is any hardware that implements just the SBSA-mandated subset
rather than the full pl011, we should probably implement both
in the kernel: a dumb driver that can only send and receive, and the
more complex one that can set the bit rates and flow-control but that
requires a standardized ACPI table with the input clock rate.

Whether the two would belong into one file or two separate driver
modules is something I can't tell, it would be up to the serial
maintainers to decide.

> I really hope that this use does not spread beyond a few essential 
> devices like the UART. IMO all real hardware should be the other side of 
> a PCIe bridge.

I would definitely agree with that.

	Arnd
