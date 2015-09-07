From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/5] acpi: Add basic device probing infrastructure
Date: Mon, 07 Sep 2015 23:29:36 +0200
Message-ID: <2194763.hsLfaM94lK@vostro.rjw.lan>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com> <1441386412-8139-2-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45796 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751255AbbIGVBr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2015 17:01:47 -0400
In-Reply-To: <1441386412-8139-2-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday, September 04, 2015 06:06:48 PM Marc Zyngier wrote:
> IRQ controllers and timers are the two types of device the kernel
> requires before being able to use the device driver model.
> 
> ACPI so far lacks a proper probing infrastructure similar to the one
> we have with DT, where we're able to declare IRQ chips and
> clocksources inside the driver code, and let the core code pick it up
> and call us back on a match. This leads to all kind of really ugly
> hacks all over the arm64 code and even in the ACPI layer.
> 
> In order to allow some basic probing based on the ACPI tables,
> introduce "struct acpi_probe_entry" which contains just enough
> data and callbacks to match a table, an optional subtable, and
> call a probe function. A driver can, at build time, register itself
> and expect being called if the right entry exists in the ACPI
> table.
> 
> A acpi_probe_device_init() is provided, taking an ACPI table
> identifier, and iterating over the registered entries.

What about things that are provided by the ACPI namespace (eg. via _MAT) rather
than in static tables?

Thanks,
Rafael

