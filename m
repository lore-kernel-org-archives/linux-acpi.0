From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Tue, 27 Jan 2015 11:46:53 -0600
Message-ID: <54C7CF0D.4050607@codeaurora.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:44920 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbA0Rq6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jan 2015 12:46:58 -0500
In-Reply-To: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, suravee.suthikulpanit@amd.com, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, ashwin.chaugule@linaro.org, msalter@redhat.com

On 01/14/2015 09:04 AM, Hanjun Guo wrote:
> This is the v7 of ACPI core patches for ARM64 based on ACPI 5.1
>

Tested-by: Timur Tabi <timur@codeaurora.org>

However, these 17 patches are insufficient to make ACPI work completely 
on ARM64.  I need to add two patches:

acpi: add arm to the platforms that use ioremap
http://lists.linaro.org/pipermail/linaro-acpi/2014-November/002943.html

acpi: fix acpi_os_ioremap for arm64
http://lists.linaro.org/pipermail/linaro-acpi/2014-November/002859.html

Without these two patches, my ACPI-based device drivers don't probe. 
Can we add them to this 17-patch patchset?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
