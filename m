From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Wed, 04 Feb 2015 10:16:34 -0600
Message-ID: <54D245E2.2030003@codeaurora.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>	 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>	 <2422968.Es7R0p3loO@vostro.rjw.lan>	 <1422984576.18187.82.camel@deneb.redhat.com>	 <20150204112508.GB26006@e104818-lin.cambridge.arm.com> <1423066107.18187.99.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:37538 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbbBDQQj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 11:16:39 -0500
In-Reply-To: <1423066107.18187.99.camel@deneb.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Ashwin Chaugule <ashwinc@>

On 02/04/2015 10:08 AM, Mark Salter wrote:
> acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> which are already included in the kernel's linear RAM mapping. So we
> need ioremap_cache to avoid two mappings to the same physical page
> having different caching attributes.

Would it be possible to modify ioremap() so that it can tell whether the 
memory is already mapped in some way, and then use a compatible remapping?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
