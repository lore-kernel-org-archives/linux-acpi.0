From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/15] ACPICA: Update ACPICA files to reduce source code differences between Linux and ACPICA.
Date: Thu, 31 Oct 2013 14:54:34 +0100
Message-ID: <1616365.YVuAuunBk7@vostro.rjw.lan>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64436 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753679Ab3JaNmY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Oct 2013 09:42:24 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Thursday, October 31, 2013 09:29:23 AM Lv Zheng wrote:
> This series is based on ACPICA 20130927 release.
> 
> This series is to reduce the source code differences between Linux and
> ACPICA so that the release process can be easier with less human
> intervention and the known bugs can also be prevented.
> 
> This series includes only Linux part patches.
> Please also find another companion ACPICA patchset for references.
> 
> The source code differences between Linux and ACPICA can be summarized as
> follows:
> 1. 1516 Lines (53.2 Kbytes) before applying the patch set;
> 2. 1001 Lines (35.3 Kbytes) after applying the patch set.
> 
> The rest of the divergences are now accountable:
> 1.  (Internal) ACPI_FUTURE_USAGE
> 2.  (Internal) Linux compiler.h related
> 3.  (Internal) Bug report message
> 4.  AcpiSrc bug
> 5.  Some events related divergences
> 6.  FADT 64bit/32bit favor
> 7.  Boolean -> bool conversion
> 8.  GPE masking mechanism
> 9.  D3_cold implicity
> 10. XSDT - introduced by table override and sgi-hotplug
> 11. Xen sleep register hook
> 12. Slow hardware support
> Where:
> Internal: divergences are committed and would not be fixed.
> 
> A QA process is executed to compare resulting binary files. Those patches
> which were not expected to change any text section indeed, changed no text.
> Sometimes line numbers changed due to line deletions and insertions, but
> that is expected.
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
> Please review.
> 
> Lv Zheng (15):
>   ACPICA: Update default space handlers.
>   ACPICA: Update ANOBJ_IS_EXTERNAL flag.
>   ACPICA: Update namespace dump code.
>   ACPICA: Update RSDP table definitions.
>   ACPICA: Update DMAR table definitions.
>   ACPICA: Add new statistics interface.
>   ACPICA: Fix wrong object length returned by
>     acpi_ut_get_simple_object_size().
>   ACPICA: Fix an ACPI_ALLOCATE_ZEROED() reversal.
>   ACPICA: Cleanup useless memset invocations.
>   ACPICA: Remove dead AOPOBJ_INVALID check.
>   ACPICA: Fix cached object deletion code.
>   ACPICA: Update compilation environment settings.
>   ACPICA: Update acpidump related header file changes.
>   ACPICA: Cleanup asmlinkage for ACPICA APIs.
>   ACPICA: Add __init for ACPICA initializers/finalizers.

Queued up for 3.13 (with some changelog/subject modifications), thanks Lv!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
