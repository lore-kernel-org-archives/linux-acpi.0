From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/14] ACPICA: 20160831 Release
Date: Mon, 12 Sep 2016 23:54:58 +0200
Message-ID: <7319979.1aYLGgGL7v@vostro.rjw.lan>
References: <cover.1473226203.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57708 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1750998AbcILVsy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 17:48:54 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Wednesday, September 07, 2016 02:05:34 PM Lv Zheng wrote:
> The 20160831 ACPICA kernel-resident subsystem updates are linuxized based
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
> Before applying (20160629 Release):
>   508 lines
> After applying (20160831 Release):
>   508 lines
> 
> Bob Moore (5):
>   ACPICA: Debugger: Add subcommand for predefined name execution
>   ACPICA: Cleanup for all string-to-integer conversions
>   ACPICA: Add a couple of casts to uthex.c
>   ACPICA: Update return value for intenal _OSI method
>   ACPICA: Update version to 20160831
> 
> Lv Zheng (9):
>   ACPICA: Tables: Remove acpi_tb_install_fixed_table()
>   ACPICA: Tables: Remove wrong table event macros
>   ACPICA: Tables: Add new table events indicating table
>     installation/uninstallation
>   ACPICA: Tables: Override all 64-bit GAS fields when
>     acpi_gbl_use32_bit_fadt_addresses is TRUE
>   ACPICA: Interpreter: Fix MLC issues by switching to new term_list
>     grammar for table loading
>   ACPICA: Namespace: Add acpi_ns_get_node_unlocked()
>   ACPICA: Namespace: Fix dynamic table loading issues by tuning
>     namespace/interpreter locks
>   ACPICA: Dispatcher: Fix a mutex issue for method auto serialization
>   ACPICA: Tables: Tune table mutex to be a leaf lock

All applied.

Thanks,
Rafael

