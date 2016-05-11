From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
Date: Wed, 11 May 2016 02:07:38 +0200
Message-ID: <3620725.8soc3SaFWB@vostro.rjw.lan>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com> <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65015 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752303AbcEKAES (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 May 2016 20:04:18 -0400
In-Reply-To: <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mark Rutland <mark.rutland@arm.com>

On Tuesday, April 19, 2016 01:30:12 PM Sudeep Holla wrote:
> This patch adds appropriate callbacks to support ACPI Low Power Idle
> (LPI) on ARM64.
> 
> It also selects ARCH_SUPPORTS_ACPI_PROCESSOR_LPI if ACPI is enabled
> on ARM64.

Can you remind me why we need the ARCH_SUPPORTS_ACPI_PROCESSOR_LPI thing in
addition to the previously defined ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE?

I thought supporting LPI would not require an arch Kconfig option.

Thanks,
Rafael

