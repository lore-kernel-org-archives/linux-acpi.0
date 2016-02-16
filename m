From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/5] ACPI / processor_idle : introduce ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
Date: Tue, 16 Feb 2016 21:18:36 +0100
Message-ID: <12469811.iv3SctjXxl@vostro.rjw.lan>
References: <1449065446-26115-1-git-send-email-sudeep.holla@arm.com> <1449065446-26115-5-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53107 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751927AbcBPURP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 15:17:15 -0500
In-Reply-To: <1449065446-26115-5-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, x86@kernel.org, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mahesh Sivasubramanian <msivasub@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Prashanth Prakash <pprakash@codeaurora.org>

On Wednesday, December 02, 2015 02:10:45 PM Sudeep Holla wrote:
> ACPI 6.0 adds a new method to specify the CPU idle states(C-states)
> called Low Power Idle(LPI) states. Since new architectures like ARM64
> use only LPIs, introduce ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE to
> encapsulate all the code supporting the old style C-states(_CST)

No.

The way it really should work is to check if the firmware supports LPI
(and what kind of it) and try to use _CST if LPI is not supported.

If LPI is supported by the firmware, use it if the LPI objects are
present as expected or fall back to using _CST otherwise.

This way it all should work without any new Kconfig options.

Thanks,
Rafael

