From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/16] ACPICA 20170629 Release
Date: Sat, 22 Jul 2017 00:02:12 +0200
Message-ID: <2899664.mSJ6QsBJhb@aspire.rjw.lan>
References: <cover.1499671181.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52212 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753111AbdGUWKG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 18:10:06 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Monday, July 10, 2017 03:22:39 PM Lv Zheng wrote:
> The 20170629 ACPICA kernel-resident subsystem updates are linuxized based
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
> Before applying (20170531 Release):
>   369 lines
> After applying (20170629 Release):
>   390 lines (increased due to export of acpi_tb_xxx functions)
> 
> Alex James (1):
>   ACPICA: iASL: Ensure that the target node is valid in
>     acpi_ex_create_alias
> 
> Bob Moore (2):
>   ACPICA: Small indentation changes, no functional change
>   ACPICA: Update version to 20170629
> 
> Erik Schmauss (3):
>   ACPICA: Tools: Deallocate memory allocated by
>     ac_get_all_tables_from_file via ac_delete_table_list
>   ACPICA: iASL compiler: allow compilation of externals with paths that
>     refer to existing names
>   ACPICA: Disassembler: skip parsing of incorrect external declarations
> 
> Ganapatrao Kulkarni (1):
>   ACPICA: iasl: Update to IORT SMMUv3 disassembling
> 
> Kees Cook (1):
>   Back port of "ACPICA: Use designated initializers"
> 
> Lv Zheng (7):
>   ACPICA: linuxize: cleanup typedef definitions
>   ACPICA: Tables: Add sanity check in acpi_put_table()
>   ACPICA: Tables: Cleanup table handler invokers
>   ACPICA: Tables: Do not validate signature for dynamic table load
>   ACPICA: Tables: Change table duplication check to be related to
>     acpi_gbl_verify_table_checksum
>   ACPICA: Tables: Combine checksum/duplication verification together
>   ACPICA: Tables: Add deferred table verification support
> 
> Robin Murphy (1):
>   ACPICA: IORT: Update SMMU models for revision C
> 
>  drivers/acpi/acpica/acapps.h    |   2 +
>  drivers/acpi/acpica/aclocal.h   |   5 +-
>  drivers/acpi/acpica/acobject.h  |  12 ++-
>  drivers/acpi/acpica/actables.h  |   5 +-
>  drivers/acpi/acpica/excreate.c  |   5 +
>  drivers/acpi/acpica/hwxfsleep.c |   9 +-
>  drivers/acpi/acpica/nsaccess.c  |   6 ++
>  drivers/acpi/acpica/psobject.c  |  26 +++++
>  drivers/acpi/acpica/tbdata.c    | 230 +++++++++++++++++++++++++++++++++++-----
>  drivers/acpi/acpica/tbinstal.c  | 161 ++++------------------------
>  drivers/acpi/acpica/tbxface.c   |  39 ++++++-
>  drivers/acpi/acpica/tbxfload.c  |   2 +-
>  drivers/acpi/bus.c              |   3 -
>  drivers/acpi/tables.c           |   4 +-
>  include/acpi/acpixf.h           |  15 +--
>  include/acpi/actbl.h            |   1 +
>  include/acpi/actbl2.h           |  16 ++-
>  include/acpi/platform/acenv.h   |   9 +-
>  include/acpi/platform/aclinux.h |   3 +
>  19 files changed, 356 insertions(+), 197 deletions(-)

Whole series applied.

Thanks,
Rafael

