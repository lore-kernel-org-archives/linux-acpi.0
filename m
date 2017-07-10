From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/16] ACPICA 20170629 Release
Date: Mon, 10 Jul 2017 15:19:14 +0800
Message-ID: <cover.1499670225.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:26625 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdGJHTR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:19:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The 20170629 ACPICA kernel-resident subsystem updates are linuxized based
on the linux-pm/linux-next branch.

The patchset has passed the following build/boot tests.
Build tests are performed as follows:
1. i386 + allyes
2. i386 + allno
3. i386 + default + ACPI_DEBUGGER=y
4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
5. i386 + default + ACPI_DEBUG=n + ACPI=y
6. i386 + default + ACPI=n
7. x86_64 + allyes
8. x86_64 + allno
9. x86_64 + default + ACPI_DEBUGGER=y
10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
12.x86_64 + default + ACPI=n
Boot tests are performed as follows:
1. x86_64 + default + ACPI_DEBUGGER=y
Where:
1. i386: machine named as "Dell Inspiron Mini 1010"
2. x86_64: machine named as "Microsoft Surface Pro 3"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20170531 Release):
  369 lines
After applying (20170629 Release):
  390 lines (increased due to export of acpi_tb_xxx functions)

Alex James (1):
  ACPICA: iASL: Ensure that the target node is valid in
    acpi_ex_create_alias

Arvind Yadav (1):
  ACPI / DPTF: constify attribute_group structures

Bob Moore (1):
  ACPICA: Small indentation changes, no functional change

Erik Schmauss (3):
  ACPICA: Tools: Deallocate memory allocated by
    ac_get_all_tables_from_file via ac_delete_table_list
  ACPICA: iASL compiler: allow compilation of externals with paths that
    refer to existing names
  ACPICA: Disassembler: skip parsing of incorrect external declarations

Kees Cook (1):
  Back port of "ACPICA: Use designated initializers"

Lv Zheng (8):
  Revert "scripts/spelling.txt: add "an union" pattern and fix typo
    instances"
  ACPICA: linuxize: cleanup typedef definitions
  ACPICA: Tables: Add sanity check in acpi_put_table()
  ACPICA: Tables: Cleanup table handler invokers
  ACPICA: Tables: Do not validate signature for dynamic table load
  ACPICA: Tables: Change table duplication check to be related to
    acpi_gbl_verify_table_checksum
  ACPICA: Tables: Combine checksum/duplication verification together
  ACPICA: Tables: Add deferred table verification support

Robin Murphy (1):
  ACPICA: IORT: Update SMMU models for revision C

