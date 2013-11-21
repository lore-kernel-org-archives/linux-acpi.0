From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/6] ACPICA: 20131115 Release
Date: Thu, 21 Nov 2013 14:30:34 +0100
Message-ID: <2072117.i6uSfJDjnh@vostro.rjw.lan>
References: <cover.1384747396.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58035 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751225Ab3KUNRy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 08:17:54 -0500
In-Reply-To: <cover.1384747396.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Thursday, November 21, 2013 12:17:03 PM Lv Zheng wrote:
> The 20131115 ACPICA kernel resident system updates is linuxized based on
> the pm/linux-next branch.
> 
> The patch set has passed a build/boot test on the following machines:
> Dell Inspiron Mini 1010 (i386)
> HP Compaq 8200 Elite SFF PC (x86-64)
> With the following kernel configuration items enabled:
>   CONFIG_ACPI
>   CONFIG_SFI
>   CONFIG_ACPI_AC
>   CONFIG_ACPI_BATTERY
>   CONFIG_ACPI_BUTTON
>   CONFIG_ACPI_VIDEO
>   CONFIG_ACPI_FAN
>   CONFIG_ACPI_DOCK
>   CONFIG_ACPI_PROCESSOR
>   CONFIG_ACPI_PROCESSOR_AGGREGATOR
>   CONFIG_ACPI_IPMI
>   CONFIG_ACPI_THERMAL
>   CONFIG_ACPI_CONTAINER
>   CONFIG_ACPI_SBS
>   CONFIG_ACPI_NUMA
>   CONFIG_ACPI_HED
>   CONFIG_ACPI_APEI
>   CONFIG_ACPI_APEI_GHES
>   CONFIG_ACPI_APEI_EINJ
>   CONFIG_ACPI_APEI_ERST_DEBUG
>   CONFIG_X86_PM_TIMER
>   CONFIG_CPU_FREQ
>   CONFIG_I2C_SCMI
>   CONFIG_DMAR_TABLE
>   CONFIG_INTEL_IOMMU
>   CONFIG_IRQ_REMAP
>   CONFIG_BLK_DEV_IDEACPI
>   CONFIG_DRM_I915
>   CONFIG_DRM_RADEON
>   CONFIG_DRM_NOUVEAU
>   CONFIG_SENSORS_ACPI_POWER
>   CONFIG_SENSORS_ATK0110
>   CONFIG_INPUT_ATLAS_BTNS
>   CONFIG_TCG_TPM
>   All devices under CONFIG_X86_PLATFORM_DEVICES
> 
> Please review.
> 
> Bob Moore (3):
>   ACPICA: Debug output: Do not emit function nesting level for kernel
>     build.
>   ACPICA: Add support to delete all objects attached to the root
>     namespace node.
>   ACPICA: Update version to 20131115.
> 
> Lv Zheng (2):
>   ACPICA: Tests: Add CHECKSUM_ABORT protection for test utilities.
>   ACPICA: Resources: Fix loop termination for the get AML length
>     function.
> 
> Tomasz Nowicki (1):
>   ACPICA: Delete all attached data objects during namespace node
>     deletion.
> 
>  drivers/acpi/acpica/acresrc.h  |    6 +++---
>  drivers/acpi/acpica/nsalloc.c  |   18 ++++++++++++++----
>  drivers/acpi/acpica/nsutils.c  |   18 ++++++++++--------
>  drivers/acpi/acpica/rscalc.c   |    9 +++++++--
>  drivers/acpi/acpica/rscreate.c |   36 +++++++++++++++++-------------------
>  drivers/acpi/acpica/rsutils.c  |    2 +-
>  drivers/acpi/acpica/utdebug.c  |   31 ++++++++++++++++++++++++-------
>  include/acpi/acconfig.h        |    2 ++
>  include/acpi/acpixf.h          |    2 +-
>  9 files changed, 79 insertions(+), 45 deletions(-)

Since these are mostly fixes, I've queued up this series for the next ACPI pull
request for 3.13 (next week most likely).

I've fixed up the two changelogs that used unconverted function names.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
