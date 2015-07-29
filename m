From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/22] ACPICA: 20150717 Release
Date: Wed, 29 Jul 2015 02:58:24 +0200
Message-ID: <6694402.X3yTrJO9Rd@vostro.rjw.lan>
References: <cover.1437627016.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56702 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751155AbbG2Ab3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2015 20:31:29 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, July 23, 2015 12:51:58 PM Lv Zheng wrote:
> The 20150717 ACPICA kernel-resident subsystem updates are linuxized based
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
> Before applying (20150619 Release):
>   539 lines
> After applying (20150717 Release):
>   518 lines
> Note that the reduction is due to:
> 1. The FACS related divergences are not counted;
> 2. Some debugger related divergences are merged in this release as the
>    configurability of the debugger code has improved.
> 
> Bob Moore (6):
>   ACPICA: iASL: Add new warnings for method local_x and arg_x
>     variables.
>   ACPICA: Cleanup use of all non-ANSI local C library functions.
>   ACPICA: Cleanup use of NEGATIVE and POSITIVE defines.
>   ACPICA: iASL: Add support for TCPA Server Table.
>   ACPICA: iASL/Disassembler: Add prototype verbose mode.
>   ACPICA: Update version to 20150717.
> 
> Lv Zheng (15):
>   ACPICA: Parser: Reduce parser/namespace divergences for tracer
>     support.
>   ACPICA: Parser: Cleanup aml_offset in struct acpi_walk_state.
>   ACPICA: Parser: Cleanup aml_offset in union acpi_operand_object.
>   ACPICA: Dispatcher: Cleanup union acpi_operand_object's AML address
>     assignments.
>   ACPICA: Executer: Add back pointing reference of method operand.
>   ACPICA: Namespace: Add function to directly return normalized full
>     path.
>   ACPICA: Dispatcher: Move stack traversal code to dispatcher.
>   ACPICA: Dispatcher: Add trace support for interpreter.
>   ACPICA: Executer: Add interpreter tracing mode for method tracing
>     facility.
>   ACPICA: Executer: Add OSL trace hook support.
>   ACPICA: Executer: Add option to bypass opcode tracing.
>   ACPICA: Parser: Remove redundant opcode execution debugging output.
>   ACPICA: MSVC: Fix inclusion order issue of <crtdbg.h>.
>   ACPICA: Debugger: Reduce structure size for debugger.
>   ACPICA: Debugger: Move debugger specific APIs to debugger component.
> 
> Markus Elfring (1):
>   ACPICA: Remove extraneous check for null walk_state.

Series queued up for 4.3, thanks!

Rafael

