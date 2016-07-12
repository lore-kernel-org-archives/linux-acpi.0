From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 3/7] arm64: cpuidle: drop __init section marker to
 arm_cpuidle_init
Date: Tue, 12 Jul 2016 16:23:19 +0100
Message-ID: <20160712152319.GG22183@e104818-lin.cambridge.arm.com>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
 <1467997678-7107-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60111 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933252AbcGLPXY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jul 2016 11:23:24 -0400
Content-Disposition: inline
In-Reply-To: <1467997678-7107-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, ALKML <linux-arm-kernel@lists.infradead.org>, Sunil <sunil.vl@hpe.com>

On Fri, Jul 08, 2016 at 06:07:54PM +0100, Sudeep Holla wrote:
> Commit ea389daa7fd9 ("arm64: cpuidle: add __init section marker to
> arm_cpuidle_init") added the __init annotation to arm_cpuidle_init
> as it was not needed after booting which was correct at that time.
> 
> However with the introduction of ACPI LPI support, this will be used
> from cpuhotplug path in ACPI processor driver.
> 
> This patch drops the __init annotation from arm_cpuidle_init to avoid
> the following warning:
> 
> WARNING: vmlinux.o(.text+0x113c8): Section mismatch in reference from the
> 	function acpi_processor_ffh_lpi_probe() to the function
> 	.init.text:arm_cpuidle_init()
> The function acpi_processor_ffh_lpi_probe() references
> the function __init arm_cpuidle_init().
> This is often because acpi_processor_ffh_lpi_probe lacks a __init
> annotation or the annotation of arm_cpuidle_init is wrong.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
