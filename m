From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
Date: Wed, 11 May 2016 16:06:29 +0100
Message-ID: <57334A75.10207@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
 <3620725.8soc3SaFWB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53241 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbcEKPGi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 May 2016 11:06:38 -0400
In-Reply-To: <3620725.8soc3SaFWB@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mark Rutland <mark.rutland@arm.com>



On 11/05/16 01:07, Rafael J. Wysocki wrote:
> On Tuesday, April 19, 2016 01:30:12 PM Sudeep Holla wrote:
>> This patch adds appropriate callbacks to support ACPI Low Power Idle
>> (LPI) on ARM64.
>>
>> It also selects ARCH_SUPPORTS_ACPI_PROCESSOR_LPI if ACPI is enabled
>> on ARM64.
>
> Can you remind me why we need the ARCH_SUPPORTS_ACPI_PROCESSOR_LPI thing in
> addition to the previously defined ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE?
>

That's stupid of me, I removed it from the driver in v4 but the few
remnants of it stayed by mistake(mainly in this patch alone)

> I thought supporting LPI would not require an arch Kconfig option.
>

That's correct.

-- 
Regards,
Sudeep
