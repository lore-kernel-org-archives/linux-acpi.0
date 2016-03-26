From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7] acpi: Issue _OSC call for native thermal interrupt handling
Date: Sat, 26 Mar 2016 01:56:07 +0100
Message-ID: <CAJZ5v0hP7F_6Wdd0dS7DRWysQApRUrgo5-XvhWiHHo0VYQwKOQ@mail.gmail.com>
References: <1458792459-538-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32904 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbcCZA4K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2016 20:56:10 -0400
In-Reply-To: <1458792459-538-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, "open list:EDAC-CORE" <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Mar 24, 2016 at 5:07 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> There are several reports of freeze on enabling HWP (Hardware PStates)
> feature on Skylake based systems by Intel P states driver. The root
> cause is identified as the HWP interrupts causing BIOS code to freeze.
> HWP interrupts uses thermal LVT.
> Linux natively handles thermal interrupts, but in Skylake based systems
> SMM will take control of thermal interrupts. This is a problem for several
> reasons:
> - It is freezing in BIOS when tries to handle thermal interrupt, which
> will require BIOS upgrade
> - With SMM handling thermal we loose all the reporting features of
> Linux arch/x86/kernel/cpu/mcheck/therm_throt driver
> - Some thermal drivers like x86-package-temp driver depends on the thermal
> threshold interrupts
> - The HWP interrupts are useful for debugging and tuning performance
>
> So we need native handling of thermal interrupts. This requires some
> way to inform SMM that OS can handle thermal interrupts. This can be
> done by using _OSC/_PDC under processor scope very early in ACPI
> initialization flow.
> The bit 12 of _OSC/_PDC in processor scope defines whether OS supports
> handling of native interrupts for Collaborative Processor Performance
> Control (CPPC) notifications. Since HWP is a implementation of CPPC,
> setting this bit is equivalent to inform SMM that OS is capable of
> handling thermal interrupts.
> Refer to this document for details on _OSC/_PDC
> http://www.intel.com/content/www/us/en/standards/processor-vendor-
> specific-acpi-specification.html
>
> This change introduces a new function acpi_early_processor_set_osc(),
> which walks acpi name space and finds acpi processor object and
> set capability via _OSC method.
>
> Also this change writes HWP status bits to 0 to clear any HWP status
> bits in intel_thermal_interrupt().
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

I've queued it up, but I have modified the subject and the changelog
and renamed the new function.

Please have a look at
http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=42341f87ba1bee4c5be95038c24abb69cbcf361a
and let me know if it makes sense to you.

Thanks,
Rafael
