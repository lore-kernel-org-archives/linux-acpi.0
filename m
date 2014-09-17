From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
Date: Wed, 17 Sep 2014 02:31:14 +0100
Message-ID: <20140917013114.GB31214@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
 <20140912145102.GB5532@arm.com>
 <20140912151850.GB9234@xora-haswell.xora.org.uk>
 <20140912154903.GE5532@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43607 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbaIQBbi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2014 21:31:38 -0400
Content-Disposition: inline
In-Reply-To: <20140912154903.GE5532@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.

On Fri, Sep 12, 2014 at 04:49:03PM +0100, Catalin Marinas wrote:

> Now, for x86, do we need acpi_sleep_init() when CONFIG_ACPI_SLEEP is
> off? If not, we could simply add a dummy acpi_sleep_init() function when
> !ACPI_SLEEP and don't enable the config option for arm64.

The !ACPI_SLEEP case still uses the ACPI code for powering the system 
down. I'd recommend adding a new CONFIG_ACPI_POWER_OFF option, wrapping 
the remaining code in sleep.c and disabling that on ARM.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
