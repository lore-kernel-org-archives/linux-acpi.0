From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to enforce this ACPI mode
Date: Wed, 8 Jan 2014 13:46:25 +0100
Message-ID: <201401081346.25767.arnd@arndb.de>
References: <1389142011-27356-1-git-send-email-al.stone@linaro.org> <1389142011-27356-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57871 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252AbaAHMqg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jan 2014 07:46:36 -0500
In-Reply-To: <1389142011-27356-2-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: al.stone@linaro.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On Wednesday 08 January 2014, al.stone@linaro.org wrote:
> Even though support for X86 in hardware reduced mode is possible, it
> is NOT enabled.  Extensive effort has gone into the Linux kernel so that
> there is a single kernel image than can run on all x86 hardware; the kernel
> changes run-time behavior to adapt to the hardware being used.  This is not
> currently possible with the existing ACPICA infrastructure but only presents
> a problem on achitectures supporting both hardware-reduced and legacy modes
> of ACPI -- i.e., on x86 only.

Not sure about the logic here: While it's certainly possible to build a kernel
that runs on all x86 machines, it's also possible to build one that only
runs on some of them when some basic options are turned off. I don't see
any difference between that and what we have on ARM64 or the multiplatform
subset of ARM32.

I don't think you need any strict architecture dependency here. If you want
to make it harder for users to accidentally turn it on, I'd suggest using

config ACPI_REDUCED_HARDWARE_ONLY
       bool "Hardware-reduced ACPI support only"
       depends on !X86 || EXPERT

	Arnd
