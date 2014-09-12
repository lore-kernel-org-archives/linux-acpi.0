From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
Date: Fri, 12 Sep 2014 15:43:36 -0400
Message-ID: <54134CE8.8070506@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org> <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10745 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbaILTo7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Sep 2014 15:44:59 -0400
In-Reply-To: <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On 09/12/2014 10:00 AM, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> ACPI 5.1 does not currently support S states for ARM64 hardware but
> ACPI code will call acpi_target_system_state() for device power
> managment, so introduce sleep-arm.c to allow other drivers to function
> until S states are defined.

Aside: ACPI5.1 does define the Platform Communication Channel and CPC
(Collaborative Processor Performance Control). Some details need to be
fleshed out there for practical 64-bit ARMv8 server systems, but the
underpinnings and mechanisms are in place in the 5.1 specification that
can be built upon over time to achieve practical S-State equivalence.

Jon.

