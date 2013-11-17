From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/12] Hardware Reduced Mode cleanup for ACPI
Date: Sun, 17 Nov 2013 22:47:24 +0100
Message-ID: <8247743.aZJaemC719@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54443 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751300Ab3KQVet (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 16:34:49 -0500
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Saturday, November 09, 2013 06:36:10 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>
> 
> This series of patches starts with Hanjun's patch to create a kernel
> config item for CONFIG_ACPI_REDUCED_HARDWARE [0].  Building on that, I
> then reviewed all of the code that touched any of several fields in the
> FADT that the OSPM is supposed to ignore when ACPI is in Hardware Reduced
> mode [1].  Any time there was a use of one of the fields to be ignored,
> I evaluated whether or not the code was implementing Hardware Reduced
> mode correctly.  Similarly, for each the flags in the FADT flags field
> that are to be ignored in Hardware Reduced mode, the kernel code was again
> scanned for proper usage.  The remainder of the patches are to fix all of
> the situations I could find where the kernel would not behave correctly
> in this ACPI mode.
> 
> These seem to work just fine on the RTSM model for ARMv7, both with and
> without ACPI enabled, and with and without ACPI_REDUCED_HARDWARE enabled;
> similarly for the FVP model for ARMv8.  The patches for ACPI on ARM
> hardware will be coming later but they presume that reduced HW mode is
> functioning correctly.  In the meantime, there's no way I can think of
> to test all possible scenarios so feedback would be greatly appreciated.
> 
> 
> [0] List at https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/AcpiReducedHw#Section_5:_ACPI_Software_Programming_Model
> [1] Please see the ACPI Specification v5.0 for details on Hardware Reduced
>     mode.
> 
> 
> Al Stone (12):
>   ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
>   ACPI: bus master reload not supported in reduced HW mode
>   ACPI: clean up compiler warning about uninitialized field
>   ACPI: HW reduced mode does not allow use of the FADT sci_interrupt
>     field
>   ACPI: ARM: exclude calls on ARM platforms, not include them on x86
>   ACPI: ensure several FADT fields are only used in HW reduced mode
>   ACPI: do not reserve memory regions for some FADT entries in HW
>     reduced mode
>   ACPI: in HW reduced mode, getting power latencies from FADT is not
>     allowed
>   ACPI: add clarifying comment about processor throttling in HW reduced
>     mode
>   ACPI: ACPI_FADT_C2_MP_SUPPORTED must be ignored in HW reduced mode
>   ACPI: use of ACPI_FADT_32BIT_TIMER is not allowed in HW reduced mode
>   ACPI: correct #ifdef so compilation without ACPI_REDUCED_HARDWARE
>     works

I have some comments that will be sent in replies to the individual patches.

In addition to that my personal experience with the HW reduced mode is
somewhat limited, so to speak, so I'll need to ask people with more experience
in that field for opinions.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
