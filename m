From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 00/14] ACPICA 20130823 Release
Date: Wed, 25 Sep 2013 18:00:40 +0200
Message-ID: <2966084.pIPhPZgieX@vostro.rjw.lan>
References: <cover.1377844863.git.lv.zheng@intel.com> <cover.1379900697.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53675 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751301Ab3IYPtT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 11:49:19 -0400
In-Reply-To: <cover.1379900697.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Monday, September 23, 2013 09:50:40 AM Lv Zheng wrote:
> The 20130823 ACPICA kernel resident system updates is linuxized based on
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
> Bjorn Helgaas (1):
>   ACPICA: acpi_read: On error, do not modify the return value target
>     location.
> 
> Bob Moore (7):
>   ACPICA: Improve error message for "too many parent prefixes"
>     condition.
>   ACPICA: Debug output: small formatting update, no functional change.
>   ACPICA: Debugger: Prevent possible command line buffer overflow,
>     kernel behavior is not affected.
>   ACPICA: Validate start object for acpi_walk_namespace.
>   ACPICA: Debugger: Add new command to display full namespace
>     pathnames.
>   ACPICA: SCI Handlers: Update handler interface, eliminate unnecessary
>     argument.
>   ACPICA: Update version to 20130823.
> 
> David E. Box (1):
>   ACPICA: Operation region support: Never free the handler "context"
>     pointer.
> 
> Lv Zheng (4):
>   ACPICA: Add support for host-installed SCI handlers.
>   ACPICA: Tables: Cleanup table checksum verification code.
>   ACPICA: Tables: Cleanup RSDP signature codes.
>   ACPICA: Cleanup exception codes.
> 
> Naresh Bhat (1):
>   ACPICA: Linux-specific header: enable "aarch64" 64-bit build.

Queued up for 3.13, thanks Lv!

