From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/20] ACPICA: 20130927 Release
Date: Thu, 31 Oct 2013 14:53:25 +0100
Message-ID: <5928487.YJ48OytAyJ@vostro.rjw.lan>
References: <cover.1383009405.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64999 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753419Ab3JaNlP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Oct 2013 09:41:15 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tuesday, October 29, 2013 09:28:41 AM Lv Zheng wrote:
> The 20130927 ACPICA kernel resident system updates is linuxized based on
> the pm/linux-next branch.
> 
> The patch set has passed a build/boot test on the following machines:
> Dell Inspiron Mini 1010 (i386)
> HP Compaq 8200 Elite SFF PC (x86-64)
> With the following kernel configuration items enabled:
>   CONFIG_ACPI_AC
>   CONFIG_ACPI_BATTERY
>   CONFIG_ACPI_NUMA
>   CONFIG_ACPI_PROCESSOR
>   CONFIG_ACPI_THERMAL
>   CONFIG_ACPI_VIDEO
>   CONFIG_CPU_FREQ
>   CONFIG_I2C_SCMI
>   CONFIG_SENSORS_ACPI_POWER
>   CONFIG_PANASONIC_LAPTOP
>   CONFIG_XO15_EBOOK
>   CONFIG_DMAR_TABLE
>   CONFIG_INTEL_IOMMU
>   CONFIG_IRQ_REMAP
> 
> Some divergences are reduced by the new software mechanisms introduced in
> this release cycle.  The divergences result is as follows:
>   Before applying: 68.8 Kbytes, 1984 Lines
>   After applying: 54.1 Kbytes, 1558 Lines
> 
> Please review.
> 
> Bob Moore (10):
>   ACPICA: Table print header function: Increase default width for table
>     length.
>   ACPICA: Add a check for a null node during namespace walk.
>   ACPICA: Add history/line-editing for Unix/Linux systems.
>   ACPICA: Fix a macro for the hardware-reduced case
>   ACPICA: Add safe versions of common string functions.
>   ACPICA: Predefine name macros: Sort list.
>   ACPICA: Hardcode access width for the reset register.
>   ACPICA: Update comment: no functional change.
>   ACPICA: Simplify configuration of global ACPI_REDUCED_HARDWARE macro.
>   ACPICA: Update version to 20130927.
> 
> Lv Zheng (9):
>   ACPICA: Cleanup memory allocation macros and configurability.
>   ACPICA: Fix possible memory leaks in the GPE handling.
>   ACPICA: Add EXPORT_ACPI_INTERFACES macro to external interface
>     modules.
>   ACPICA: Linuxize: Change indentation of C labels.
>   ACPICA: Deploy ACPI_EXPORT_SYMBOL_INIT for main ACPICA initialization
>     interfaces.
>   ACPICA: Prevent possible build issues for use of ACPI_PRINTF_LIKE
>     macro
>   ACPICA: AcpiSrc: Fix indentation issues for macro invocations.
>   ACPICA: Add support to allow host to redefine individual OSL
>     prototypes.
>   ACPICA: Update aclinux.h for new OSL override mechanism.
> 
> Tomasz Nowicki (1):
>   ACPICA: Ensure that debug output is immediately disabled on
>     termination.

I've queued up the series for 3.13, thanks Lv!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
