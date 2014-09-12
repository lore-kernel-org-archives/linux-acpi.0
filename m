From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v4 14/18] ARM64 / ACPI: Add GICv2 specific ACPI boot support
Date: Fri, 12 Sep 2014 15:48:23 -0400
Message-ID: <54134E07.6010508@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org> <1410530416-30200-15-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13499 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbaILTth (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Sep 2014 15:49:37 -0400
In-Reply-To: <1410530416-30200-15-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On 09/12/2014 10:00 AM, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> ACPI kernel uses MADT table for proper GIC initialization. It needs to
> parse GIC related subtables, collect CPU interface and distributor
> addresses and call driver initialization function (which is hardware
> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> 
> NOTE: This commit allow to initialize GICv1/2 basic functionality.
> GICv2 vitalization extension, GICv3/4 and ITS are considered as next
> steps.

Aside: A request to specifically update the flags in ACPI to indicate
GICv3/v4 systems has been filed for a future spec revision.

Jon.


