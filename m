From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/20] ACPICA: 20150818 Release
Date: Wed, 26 Aug 2015 01:49:31 +0200
Message-ID: <5059463.QBoEmM0tRe@vostro.rjw.lan>
References: <cover.1440402549.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63425 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932739AbbHYXV6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Aug 2015 19:21:58 -0400
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, August 25, 2015 10:28:18 AM Lv Zheng wrote:
> The 20150818 ACPICA kernel-resident subsystem updates are linuxized based
> on the linux-pm/linux-next branch.
> 
> The patchset has passed the following build/boot tests.
> Build tests are performed as follows:
> 1. i386 + default + COFNIG_ACPI=y
> 2. i386 + allyes + CONFIG_ACPI=y
> 3. i386 + default + COFNIG_ACPI=n
> 4. i386 + allyes + CONFIG_ACPI=n
> 5. x86_64 + default + COFNIG_ACPI=y
> 6. x86_64 + allyes + CONFIG_ACPI=y
> 7. x86_64 + default + COFNIG_ACPI=n
> 8. x86_64 + allyes + CONFIG_ACPI=n
> Boot tests are performed as follows:
> 1. i386 + default + COFNIG_ACPI=y
> 2. x86_64 + default + COFNIG_ACPI=y
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
> Before applying (20150717 Release):
>   518 lines
> After applying (20150818 Release):
>   517 lines
> 
> Bob Moore (14):
>   ACPICA: Correctly cleanup after a ACPI table load failure.
>   ACPICA: Disassembler: Remove duplicate code in _PLD processing.
>   ACPICA: Update parameter validation for data_table_region and
>     load_table.
>   ACPICA: Disassembler: Update for new listing mode.
>   ACPICA: Update info messages during ACPICA init.
>   ACPICA: Headers: Fix some comments, no functional change.
>   ACPICA: acpinames: Add new options and wildcard support.
>   ACPICA: acpiexec/acpinames: Support very large number of ACPI tables.
>   ACPICA: Table handling: Cleanup and update debug output for tools.
>   ACPICA: Add additional debug info/statements.
>   ACPICA: Debugger: Add option to display namespace summary/counts.
>   ACPICA: Make the max-number-of-loops runtime configurable.
>   ACPICA: Header support to improve compatibility with MSVC.
>   ACPICA: Update version to 20150818.
> 
> Lv Zheng (6):
>   ACPICA: Tables: Fix global table list issues by removing fixed table
>     indexes.
>   ACPICA: Tables: Cleanup to reduce FACS globals.
>   ACPICA: Debugger: Split debugger initialization/termination APIs.
>   ACPICA: Disassembler: Cleanup acpi_gbl_db_opt_disasm.
>   ACPICA: Disassembler: Cleanup acpi_gbl_db_opt_verbose acpiexec usage.
>   ACPICA: Debugger: Cleanup debugging outputs to dump name path without
>     trailing underscores.

Series queued up for 4.3, thanks!

Rafael

