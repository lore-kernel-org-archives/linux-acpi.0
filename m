From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 00/13] ACPICA: 20160422 Release
Date: Fri, 06 May 2016 01:49:02 +0200
Message-ID: <2434982.zKfILYtmTK@vostro.rjw.lan>
References: <cover.1462331120.git.lv.zheng@intel.com> <cover.1462418912.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43686 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754614AbcEEXpt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2016 19:45:49 -0400
In-Reply-To: <cover.1462418912.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, May 05, 2016 12:57:47 PM Lv Zheng wrote:
> The 20160422 ACPICA kernel-resident subsystem updates are linuxized based
> on the linux-pm/linux-next branch.
> 
> NOTE:
> 1. Indentation improvement
> The [PATCH 01] is a result of an ACPICA release process fix. It requires
> much of human intervention, and many linuxized patches in the developers'
> local working repositories that are not upstreamed to the ACPICA will be
> burnt by this commit, and may take weeks or months for the developers to
> recover. So hope we can do it correctly and rapidly.
> 
> 2. AcessSize/BitOffset support
> ACPICA implements ACPI hardware register accesses using ACPI 1.0 style,
> which contains only BLK/LEN fields. ACPI 2.0 starts to use Generic Address
> Structure to define hardware registers, the ACPI 1.0 fields can be
> translated into Address/BitWidth fields and ACPI 2.0 defines new
> AccessSize/BitOffset fields as an extension. While the ACPICA code of the
> GAS support is still Address/BitWidth aware only. This becomes one of the
> significant ACPI 2.0 gaps in ACPICA.
> But as we have already switched the address favor to 64-bit (aka., favor
> GAS descriptors) and there is almost no regression report, enabling
> AccessSize/BitOffset awareness seems to be just a theoretical issue because
> there is no existing users requiring this, and enabling it might just be an
> ecosystem enabling work for the future users.
> So the most important thing of this improvement is to ensure regression
> safer by keeping old behavior working. [PATCH 08] is thus generated for
> this purpose. After ensuring this, we need this improvement to appear in
> the upstream to have more users to test it so that we can learn unknown
> cases from the feedback.
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
> 1. i386 + default + ACPI_DEBUGGER=y
> 2. x86_64 + default + ACPI_DEBUGGER=y
> Where:
> 1. i386: machine named as "Dell Inspiron Mini 1010"
> 2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
> 3. default: kernel configuration with following items enabled:
>    All hardware drivers related to the machines of i386/x86_64
>    All "drivers/acpi" configurations
>    All "drivers/platform" drivers
>    All other drivers that link the APIs provided by ACPICA subsystem
> 
> The divergences checking result:
> Before applying (20160318 Release):
>   494 lines
> After applying (20160422 Release):
>   485 lines
> The reduction is caused by recently merged module level improvement.
> 
> Bob Moore (7):
>   ACPICA: Refactor evaluate_object to reduce nesting
>   ACPICA: ACPI 6.1: Support for new PCCT subtable
>   ACPICA: ACPI 6.0: Update _BIX support for new package element
>   ACPICA: ACPI 6.0, tools/iasl: Add support for new resource
>     descriptors
>   ACPICA: Renamed some #defined flag constants for clarity
>   ACPICA: Move all ASCII utilities to a common file
>   ACPICA: Update version to 20160422
> 
> Lv Zheng (6):
>   ACPICA: Divergence: remove unwanted spaces for typedef
>   ACPICA: Utilities: Add ACPI_IS_ALIGNED() macro
>   ACPICA: Hardware: Add optimized access bit width support
>   ACPICA: Executer: Introduce a set of macros to handle bit width mask
>     generation
>   ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support in
>     acpi_hw_read()
>   ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support for
>     acpi_hw_write()

All [1-13/13] applied, thanks!

