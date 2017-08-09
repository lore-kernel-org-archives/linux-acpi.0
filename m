From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/15] ACPICA 20170728 Release
Date: Thu, 10 Aug 2017 00:41:21 +0200
Message-ID: <5701807.lAdA1cBxkj@aspire.rjw.lan>
References: <cover.1501730699.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54775 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752149AbdHIWti (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2017 18:49:38 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, "David E . Box" <david.e.box@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Thursday, August 3, 2017 8:26:02 AM CEST Lv Zheng wrote:
> The 20170728 ACPICA kernel-resident subsystem updates are linuxized based
> on the linux-pm/linux-next branch.
> 
> The patchset has passed the following build/boot tests.
> Build tests are performed as follows:
> 1. i386 + allyes
> 2. i386 + allno
> 3. i386 + default + ACPI_DEBUGGER=y
> 4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> 5. i386 + default + ACPI_DEBUG=n + ACPI=y
> 6. i386 + default + ACPI=n
> 7. x86_64 + allyes
> 8. x86_64 + allno
> 9. x86_64 + default + ACPI_DEBUGGER=y
> 10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> 11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
> 12.x86_64 + default + ACPI=n
> Boot tests are performed as follows:
> 1. x86_64 + default + ACPI_DEBUGGER=y
> Where:
> 1. i386: machine named as "Dell Inspiron Mini 1010"
> 2. x86_64: machine named as "Microsoft Surface Pro 3"
> 3. default: kernel configuration with following items enabled:
>    All hardware drivers related to the machines of i386/x86_64
>    All "drivers/acpi" configurations
>    All "drivers/platform" drivers
>    All other drivers that link the APIs provided by ACPICA subsystem
> 
> The divergences checking result:
> Before applying (20170629 Release):
>   390 lines
> After applying (20170728 Release):
>   390 lines
> 
> Bob Moore (8):
>   ACPICA: Namespace: Update/fix an error message
>   ACPICA: Add a comment, no functional change
>   ACPICA: Interpreter: Update handling for Alias operator
>   ACPICA: Debugger: Improve support for Alias objects
>   ACPICA: Implement deferred resolution of reference package elements
>   ACPICA: Ensure all instances of AE_AML_INTERNAL have error messages
>   ACPICA: Resources: Allow _DMA method in walk resources
>   ACPICA: Update version to 20170728
> 
> Erik Schmauss (1):
>   ACPICA: Revert "Update resource descriptor handling"
> 
> James Morse (1):
>   ACPICA: iASL: Add support for the SDEI table
> 
> Lv Zheng (4):
>   ACPICA: Divergences: reduce access size definitions
>   ACPICA: CLib: Add short multiply/shift support
>   ACPICA: acpidump: Add DSDT/FACS instance support for Linux and EFI
>   ACPICA: EFI/EDK2: Cleanup to enable /WX for MSVC builds
> 
> Shao Ming (1):
>   ACPICA: EFI/EDK2: Sort acpi.h inclusion order

All applied, thanks!

