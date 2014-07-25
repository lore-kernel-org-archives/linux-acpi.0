From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 09/19] ARM64 / ACPI: Move the initialization of
 cpu_logical_map(0) before acpi_boot_init()
Date: Fri, 25 Jul 2014 13:18:39 +0100
Message-ID: <20140725121839.GC19632@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-10-git-send-email-hanjun.guo@linaro.org>
 <20140724152103.GB26190@leverpostej>
 <53D233CC.1070006@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39484 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751287AbaGYMSy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jul 2014 08:18:54 -0400
Content-Disposition: inline
In-Reply-To: <53D233CC.1070006@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-ker>

On Fri, Jul 25, 2014 at 11:39:08AM +0100, Hanjun Guo wrote:
> On 2014-7-24 23:21, Mark Rutland wrote:
> > On Thu, Jul 24, 2014 at 02:00:15PM +0100, Hanjun Guo wrote:
> >> Move the initialization of cpu_logical_map(0) before acpi_boot_init()
> >> to remove the duplicated initialization of cpu_logical_map(0).
> > 
> > It always make sense to initialise CPU0's logical map entry from the
> > hardware values, so you could do this earlier in the series, before you
> > introduce any ACPI code. Then you don't have the churn in acpi.c
> 
> ok, I will prepare a separate patch to do this before ACPI code, does it
> make sense to you?

Yes. Just put that at the start of the series.

Thanks,
Mark.
