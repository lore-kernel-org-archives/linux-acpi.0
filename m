From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/10] ACPICA: 20140926 Release
Date: Tue, 21 Oct 2014 15:29:56 +0200
Message-ID: <1798245.6E7rCk8WjK@vostro.rjw.lan>
References: <cover.1412907188.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59097 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932503AbaJUNJb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2014 09:09:31 -0400
In-Reply-To: <cover.1412907188.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Friday, October 10, 2014 10:39:17 AM Lv Zheng wrote:
> The 20140926 ACPICA kernel-resident subsystem updates are linuxized based
> on the pm/linux-next branch to form this patchset.
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
>    All drivers/acpi configurations
>    All platform drivers
> 
> The divergences checking result:
> Before applying (20140828 Release):
>   848 lines (962 lines)
> After applying (20140926 Release):
>   852 lines
> PS:
> 1. The indication of 710 lines in the last release cover has wrongly
>    included unmerged divergence reductions, it should be 848 lines.
> 2. The indication of 852 lines shows an increment of divergence by applying
>    this release, this is actually because there is a new API
>    acpi_enable_all_wakeup_gpes() introduced in the recent linux-pm branch
>    that hasn't been back ported to the ACPICA upstream yet. If this is
>    included for re-counting 20140828 release, the 848 lines should be 962
>    lines. So this release has reduced 110 lines of divergence.
> 
> Bob Moore (4):
>   ACPICA: Add string for _DDN method name.
>   ACPICA: iASL/Disassembler: Add support for hardware summary mapfiles.
>   ACPICA: acpiexec: Do not put STDIN into raw mode unless it is a
>     terminal.
>   ACPICA: Update version to 20140926.
> 
> Lv Zheng (6):
>   ACPICA: acpidump: Add ACPI 1.0 RSDP support.
>   ACPICA: Events: Reduce indent divergences of events files.
>   ACPICA: Events: Reduce source code difference in
>     acpi_install_gpe_handler().
>   ACPICA: Events: Update GPE handler removal, match behavior of handler
>     install.
>   ACPICA: Events: Reduce source code difference for the
>     ACPI_EVENT_FLAG_HANDLE support.
>   ACPICA: Events: Reduce source code difference for the
>     ACPI_EVENT_FLAG_HANDLE renaming.
> 
>  drivers/acpi/acpica/achware.h                      |    2 +-
>  drivers/acpi/acpica/aclocal.h                      |    4 +-
>  drivers/acpi/acpica/actables.h                     |    2 +
>  drivers/acpi/acpica/amlresrc.h                     |   34 +++++++++++++++++
>  drivers/acpi/acpica/evgpe.c                        |   23 +++++------
>  drivers/acpi/acpica/evgpeinit.c                    |    1 +
>  drivers/acpi/acpica/evxface.c                      |   27 ++++++++-----
>  drivers/acpi/acpica/evxfevnt.c                     |   40 +++++++++++++-------
>  drivers/acpi/acpica/evxfgpe.c                      |   12 ++----
>  drivers/acpi/acpica/hwgpe.c                        |    9 ++++-
>  drivers/acpi/acpica/tbxfroot.c                     |   33 +++++++++++++++-
>  drivers/acpi/scan.c                                |    2 +-
>  drivers/acpi/sysfs.c                               |    4 +-
>  include/acpi/acnames.h                             |    1 +
>  include/acpi/acpixf.h                              |    2 +-
>  include/acpi/actypes.h                             |    4 +-
>  .../acpi/os_specific/service_layers/osunixxf.c     |    8 ++++
>  tools/power/acpi/tools/acpidump/apdump.c           |    2 +-
>  18 files changed, 156 insertions(+), 54 deletions(-)

Whole series applied, thanks Lv!

