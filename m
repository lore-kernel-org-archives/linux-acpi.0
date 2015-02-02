From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v8 20/21] Documentation: ACPI for ARM64
Date: Mon, 02 Feb 2015 13:01:16 -0600
Message-ID: <54CFC97C.3080402@codeaurora.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-21-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:36942 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607AbbBBTBV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Feb 2015 14:01:21 -0500
In-Reply-To: <1422881149-8177-21-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>

On 02/02/2015 06:45 AM, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> Add documentation for the guidelines of how to use ACPI
> on ARM64.

This patch has a slight corruption to it:

In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=n
                                   ^
git-am chokes on this:

	fatal: cannot convert from n to UTF-8

Replacing the 'n' with '"us-ascii"' fixes it.

Patch #21 has the same problem, although it also has a trailing 
whitespace problem.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
