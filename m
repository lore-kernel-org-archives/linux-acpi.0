From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH v2 08/18] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
Date: Tue, 19 Aug 2014 12:25:26 -0700
Message-ID: <1408476326.22761.134.camel@smoke>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
		 <1407166105-17675-9-git-send-email-hanjun.guo@linaro.org>
	 <1408388212.22761.100.camel@smoke> <53F33EDC.3090203@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41796 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbaHSTZi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Aug 2014 15:25:38 -0400
In-Reply-To: <53F33EDC.3090203@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead>

Hi Hanjun,

On Tue, 2014-08-19 at 20:11 +0800, Hanjun Guo wrote:
> On 2014-8-19 2:56, Geoff Levand wrote:

> > 	message = acpi_disabled ? dn->full_name : "";
> > 
> > 	...
> > 	
> > 	pr_warn("CPU %d: %s unsupported enable-method property: %s\n",
> > 				cpu, message, enable_method)
> 
> In ACPI, there is no enable-method property, it is a term from, so I think the
> message printed can be separated.

I think it better to have a single message that can cover all
than to have separate messages.  Wouldn't the enable method be
"acpi-parking" or "acpi-psci"?  Then something like this would
work:

	pr_warn("CPU %d: %s Unsupported enable method: %s\n", cpu, message, enable_method);

-Geoff


