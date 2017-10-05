From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / LPIT: Add Low Power Idle Table (LPIT) support
Date: Thu, 5 Oct 2017 02:10:06 +0200
Message-ID: <CAJZ5v0j21EMMEQ=BRxzjEeRGaifYSGaxFVzg3TWN63d0EDtJ-g@mail.gmail.com>
References: <1507160613-56852-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36859 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdJEAKI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Oct 2017 20:10:08 -0400
In-Reply-To: <1507160613-56852-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Oct 5, 2017 at 1:43 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Added functionality to read LPIT table, which provides:
>
> - Sysfs interface to read residency counters via
> /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
>
> Here the count "low_power_idle_cpu_residency_us" shows the time spent
> by CPU package in low power state. This is read via MSR interface, which
> points to MSR for PKG C10.
>
> Here the count "low_power_idle_system_residency_us" show the count the
> system was in low power state. This is read via MMIO interface. This
> is mapped to SLP_S0 residency on modern Intel systems. This residency
> is achieved only when CPU is in PKG C10 and all functional blocks are
> in low power state.
>
> It is possible that none of the above counters present or anyone of the
> counter present or all counters present.
>
> For example: On my Kabylake system both of the above counters present.
> After suspend to idle these counts updated and prints:
> 6916179
> 6998564
>
> This counter can be read by tools like turbostat to display. Or it can
> be used to debug, if modern systems are reaching desired low power state.
>
> - Provides an interface to read residency counter memory address
> This address can be used to get the base address of PMC memory mapped IO.
> This is utilized by intel_pmc_core driver to print more debug information=
.
>
> Link: http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Po=
wer_S0_Idle.pdf
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/acpi/lpit.txt |  26 ++++++++
>  drivers/acpi/Kconfig        |   5 ++
>  drivers/acpi/Makefile       |   1 +
>  drivers/acpi/acpi_lpit.c    | 157 ++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/acpi/scan.c         |   3 +
>  include/acpi/acpi_lpit.h    |  34 ++++++++++
>  6 files changed, 226 insertions(+)
>  create mode 100644 Documentation/acpi/lpit.txt
>  create mode 100644 drivers/acpi/acpi_lpit.c
>  create mode 100644 include/acpi/acpi_lpit.h
>
> diff --git a/Documentation/acpi/lpit.txt b/Documentation/acpi/lpit.txt
> new file mode 100644
> index 0000000..6be68c0
> --- /dev/null
> +++ b/Documentation/acpi/lpit.txt
> @@ -0,0 +1,26 @@
> +To enumerate platform Low Power Idle states, Intel platforms are using
> +=E2=80=9CLow Power Idle Table=E2=80=9D (LPIT). More details about this t=
able can be
> +downloaded from:
> +http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S=
0_Idle.pdf
> +
> +Residencies for each low power state can be read via FFH
> +(Function fixed hardware) or a memory mapped interface.
> +
> +On platforms supporting S0ix sleep states, there can be two types of
> +residencies:
> +- CPU PKG C10 (Read via FFH interface)
> +- Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface=
)
> +
> +The following attributes are added dynamically to the cpuidle
> +sysfs attribute group:
> +       /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> +       /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_u=
s
> +
> +The "low_power_idle_cpu_residency_us" attribute shows time spent
> +by the CPU package in PKG C10
> +
> +The "low_power_idle_system_residency_us" attribute shows SLP_S0
> +residency, or system time spent with the SLP_S0# signal asserted.
> +This is the lowest possible system power state, achieved only when CPU i=
s in
> +PKG C10 and all functional blocks in PCH are in a low power state.
> +
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1ce52f8..4bfef0f 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -80,6 +80,11 @@ endif
>  config ACPI_SPCR_TABLE
>         bool
>
> +config ACPI_LPIT
> +       bool
> +       depends on X86_64
> +       default y
> +
>  config ACPI_SLEEP
>         bool
>         depends on SUSPEND || HIBERNATION
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 90265ab..6a19bd7 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -56,6 +56,7 @@ acpi-$(CONFIG_DEBUG_FS)               +=3D debugfs.o
>  acpi-$(CONFIG_ACPI_NUMA)       +=3D numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) +=3D cm_sbs.o
>  acpi-y                         +=3D acpi_lpat.o
> +acpi-$(CONFIG_ACPI_LPIT)       +=3D acpi_lpit.o
>  acpi-$(CONFIG_ACPI_GENERIC_GSI) +=3D irq.o
>  acpi-$(CONFIG_ACPI_WATCHDOG)   +=3D acpi_watchdog.o
>
> diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> new file mode 100644
> index 0000000..38d760d
> --- /dev/null
> +++ b/drivers/acpi/acpi_lpit.c
> @@ -0,0 +1,157 @@
> +
> +/*
> + * acpi_lpit.c - LPIT table processing functions
> + *
> + * Copyright (C) 2017 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/acpi.h>
> +#include <asm/msr.h>
> +#include <asm/tsc.h>
> +
> +struct lpit_residency_info {
> +       struct acpi_generic_address gaddr;
> +       u64 frequency;
> +       void __iomem *iomem_addr;
> +};
> +
> +/* Storage for an memory mapped and FFH based entries */
> +static struct lpit_residency_info residency_info_mem;
> +static struct lpit_residency_info residency_info_ffh;
> +
> +static int lpit_read_residency_counter_us(u64 *counter, bool io_mem)
> +{
> +       int err;
> +
> +       if (io_mem) {
> +               u32 count;
> +
> +               count =3D readl(residency_info_mem.iomem_addr);
> +               *counter =3D div64_u64(count * 1000000ULL, residency_info=
_mem.frequency);
> +               return 0;
> +       }
> +
> +       err =3D rdmsrl_safe(residency_info_ffh.gaddr.address, counter);
> +       if (!err) {
> +               u64 mask =3D GENMASK_ULL(residency_info_ffh.gaddr.bit_off=
set +
> +                                      residency_info_ffh.gaddr. bit_widt=
h - 1,
> +                                      residency_info_ffh.gaddr.bit_offse=
t);
> +
> +               *counter &=3D mask;
> +               *counter >>=3D residency_info_ffh.gaddr.bit_offset;
> +               *counter =3D div64_u64(*counter * 1000000ULL, residency_i=
nfo_ffh.frequency);
> +               return 0;
> +       }
> +
> +       return -ENODATA;
> +}
> +
> +static ssize_t low_power_idle_system_residency_us_show(struct device *de=
v,
> +                                                      struct device_attr=
ibute *attr,
> +                                                      char *buf)
> +{
> +       u64 counter;
> +       int ret;
> +
> +       ret =3D lpit_read_residency_counter_us(&counter, true);
> +       if (ret)
> +               return ret;
> +
> +       return sprintf(buf, "%llu\n", counter);
> +}
> +static DEVICE_ATTR_RO(low_power_idle_system_residency_us);
> +
> +static ssize_t low_power_idle_cpu_residency_us_show(struct device *dev,
> +                                                   struct device_attribu=
te *attr,
> +                                                   char *buf)
> +{
> +       u64 counter;
> +       int ret;
> +
> +       ret =3D lpit_read_residency_counter_us(&counter, false);
> +       if (ret)
> +               return ret;
> +
> +       return sprintf(buf, "%llu\n", counter);
> +}
> +static DEVICE_ATTR_RO(low_power_idle_cpu_residency_us);
> +
> +int lpit_read_residency_count_address(u64 *address)
> +{
> +       if (!residency_info_mem.gaddr.address)
> +               return -EINVAL;
> +
> +       *address =3D residency_info_mem.gaddr.address;
> +
> +       return 0;
> +}

I don't see users of this.  Are there any?

> +
> +static void lpit_update_residency(struct lpit_residency_info *info,
> +                                struct acpi_lpit_native *lpit_native)
> +{
> +       info->frequency =3D lpit_native->counter_frequency ?
> +                               lpit_native->counter_frequency : tsc_khz =
* 1000;
> +       if (!info->frequency)
> +               info->frequency =3D 1;
> +
> +       info->gaddr =3D lpit_native->residency_counter;
> +       if (info->gaddr.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +               info->iomem_addr =3D ioremap_nocache(info->gaddr.address,
> +                                                  info->gaddr.bit_width =
/ 8);
> +               if (!info->iomem_addr)
> +                       return;
> +
> +               /* Silently fail, if cpuidle attribute group is not prese=
nt */
> +               sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
> +                                       &dev_attr_low_power_idle_system_r=
esidency_us.attr,
> +                                       "cpuidle");
> +       } else if (info->gaddr.space_id =3D=3D ACPI_ADR_SPACE_FIXED_HARDW=
ARE) {
> +               /* Silently fail, if cpuidle attribute group is not prese=
nt */
> +               sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
> +                                       &dev_attr_low_power_idle_cpu_resi=
dency_us.attr,
> +                                       "cpuidle");
> +       }
> +}
> +
> +static void lpit_process(u64 begin, u64 end)
> +{
> +       while (begin + sizeof(struct acpi_lpit_native) < end) {
> +               struct acpi_lpit_native *lpit_native =3D (struct acpi_lpi=
t_native *)begin;
> +
> +               if (!lpit_native->header.type && !lpit_native->header.fla=
gs) {
> +                       if (lpit_native->residency_counter.space_id =3D=
=3D ACPI_ADR_SPACE_SYSTEM_MEMORY &&
> +                           !residency_info_mem.gaddr.address) {
> +                               lpit_update_residency(&residency_info_mem=
, lpit_native);
> +                       } else if (lpit_native->residency_counter.space_i=
d =3D=3D ACPI_ADR_SPACE_FIXED_HARDWARE &&
> +                                  !residency_info_ffh.gaddr.address) {
> +                               lpit_update_residency(&residency_info_ffh=
, lpit_native);
> +                       }
> +               }
> +               begin +=3D lpit_native->header.length;
> +       }
> +}
> +
> +void acpi_init_lpit(void)
> +{
> +       acpi_status status;
> +       u64 lpit_begin;
> +       struct acpi_table_lpit *lpit;
> +
> +       status =3D acpi_get_table(ACPI_SIG_LPIT, 0, (struct acpi_table_he=
ader **)&lpit);
> +
> +       if (ACPI_FAILURE(status))
> +               return;
> +
> +       lpit_begin =3D (u64)lpit + sizeof(*lpit);
> +       lpit_process(lpit_begin, lpit_begin + lpit->header.length);
> +}
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 602f8ff..3f05d43 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -15,6 +15,8 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_data/x86/apple.h>
>
> +#include <acpi/acpi_lpit.h>
> +
>  #include <asm/pgtable.h>
>
>  #include "internal.h"
> @@ -2122,6 +2124,7 @@ int __init acpi_scan_init(void)
>         acpi_int340x_thermal_init();
>         acpi_amba_init();
>         acpi_watchdog_init();
> +       acpi_init_lpit();
>
>         acpi_scan_add_handler(&generic_device_handler);
>
> diff --git a/include/acpi/acpi_lpit.h b/include/acpi/acpi_lpit.h
> new file mode 100644
> index 0000000..5d5285a
> --- /dev/null
> +++ b/include/acpi/acpi_lpit.h
> @@ -0,0 +1,34 @@
> +/*
> + * acpi_lpit.h - LPIT table processing functions interface
> + *
> + * Copyright (C) 2017 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef ACPI_LPIT_H
> +#define ACPI_LPIT_H
> +
> +#ifdef CONFIG_ACPI_LPIT
> +
> +void acpi_init_lpit(void);
> +int lpit_read_residency_count_address(u64 *address);
> +
> +#else
> +
> +static inline void acpi_init_lpit(void) { }
> +
> +static inline int lpit_read_residency_count_address(u64 *address)
> +{
> +       return -EINVAL;
> +}
> +
> +#endif
> +#endif

The above can go into internal.h or sleep.h in drivers/acpi/ IMO.
There's not need to export it.

Thanks,
Rafael
