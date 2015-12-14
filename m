From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable() support
Date: Mon, 14 Dec 2015 15:28:19 -0800
Message-ID: <CALCETrXeoGZhrNr9OmqFB+i7-tbM+d3sO8uCNnMx40JfDsjoEw@mail.gmail.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1449108825.git.lv.zheng@intel.com>
 <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34106 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbbLNX2k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2015 18:28:40 -0500
Received: by obciw8 with SMTP id iw8so144770762obc.1
        for <linux-acpi@vger.kernel.org>; Mon, 14 Dec 2015 15:28:39 -0800 (PST)
In-Reply-To: <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>

On Wed, Dec 2, 2015 at 6:43 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> From: Chen Yu <yu.c.chen@intel.com>
>
> This patch implements acpi_os_readable(). The function is used by ACPICA
> AML debugger to validate user specified pointers for dumping the memory as
> ACPICA descriptor objects.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  arch/x86/Kconfig                  |    1 +
>  arch/x86/include/asm/acenv.h      |    1 +
>  arch/x86/kernel/acpi/boot.c       |   44 +++++++++++++++++++++++++++++++++++++
>  drivers/acpi/Kconfig              |    3 +++
>  drivers/acpi/osl.c                |   12 ++++++++++
>  include/acpi/platform/aclinux.h   |    1 -
>  include/acpi/platform/aclinuxex.h |    5 -----
>  7 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index db3622f..6593b6a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -19,6 +19,7 @@ config X86
>         def_bool y
>         select ACPI_LEGACY_TABLES_LOOKUP        if ACPI
>         select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> +       select ACPI_MEMORY_ACCESS_CHECK_SUPPORT if ACPI
>         select ANON_INODES
>         select ARCH_CLOCKSOURCE_DATA
>         select ARCH_DISCARD_MEMBLOCK
> diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
> index 1b010a8..a2a2849 100644
> --- a/arch/x86/include/asm/acenv.h
> +++ b/arch/x86/include/asm/acenv.h
> @@ -20,6 +20,7 @@
>
>  int __acpi_acquire_global_lock(unsigned int *lock);
>  int __acpi_release_global_lock(unsigned int *lock);
> +bool __acpi_memory_readable(void *pointer, size_t length);
>
>  #define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq) \
>         ((Acq) = __acpi_acquire_global_lock(&facs->global_lock))
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index e759076..4a5e22e 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1699,6 +1699,50 @@ int __acpi_release_global_lock(unsigned int *lock)
>         return old & 0x1;
>  }
>
> +bool __acpi_memory_readable(void *pointer, size_t length)
> +{
> +       unsigned long obj_start, obj_end;
> +       unsigned long start_pfn, end_pfn;

What does "readable" mean in this context?

--Andy
