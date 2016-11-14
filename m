From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH] ACPI: allow compilation with bare metal compilers
Date: Mon, 14 Nov 2016 16:10:23 -0700
Message-ID: <a1df6127-6911-ba82-194c-cb41e9395c4c@redhat.com>
References: <1479164926-1733-1-git-send-email-ahs3@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35109 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941174AbcKNXK2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2016 18:10:28 -0500
Received: by mail-qt0-f170.google.com with SMTP id c47so57665104qtc.2
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2016 15:10:27 -0800 (PST)
In-Reply-To: <1479164926-1733-1-git-send-email-ahs3@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Will Deacon <will.deacon@arm.com>

My bad.

Adding Will Deacon who originally reported the error.

On 11/14/2016 04:08 PM, Al Stone wrote:
> The ACPICA subsystem of the ACPI driver sets up a compilation environment
> for itself, adding in multiple typedefs unique to ACPICA that depend on
> where ACPICA will be used.
> 
> The vast majority of such environments (Linux, QNX, ...) have an environment
> defined by the acenv.h header file.  When using a Linaro compiler [1]
> specifically built to be used in an embedded environment with perhaps a
> kernel and an init process as the only things running, there is no
> environment defined for ACPICA so the typedefs it needs are not set up,
> causing compilation to fail badly unless ACPI is completely disabled.
> Since ACPI is enabled in the default config for the kernel, the compilation
> failure is fairly obvious.
> 
> This may not be the optimal solution, but add in to the ACPI header file
> include/acpi/platform/acenv.h a default so that if GCC is being used, and
> all else fails, assume that we are going to be in a Linux-like environment
> and re-use the environment definition for Linux.  This allows us to build
> a kernel using this compiler [1] with or without ACPI.
> 
> [1] https://releases.linaro.org/components/toolchain/binaries/latest/aarch64-elff/gcc-linaro-6.1.1-2016-08-x86_64_aarch64-elf.tar.xz
> 
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> ---
>  include/acpi/platform/acenv.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
> index 34cce72..cdd1cd6 100644
> --- a/include/acpi/platform/acenv.h
> +++ b/include/acpi/platform/acenv.h
> @@ -234,6 +234,21 @@
>  #elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
>  #include "acefi.h"
>  
> +/*
> + * Up to this point, we've been looking for specific environments.  In
> + * some cases, there is no environment, and we're just working on bare
> + * metal.  However, since we're compiling the Linux kernel, let's just
> + * pretend we're in a Linux environment.
> + */
> +#elif defined(__GNUC__) && !defined(__INTEL_COMPILER)
> +#if !defined(_LINUX)
> +#define _LINUX
> +#endif
> +#if !defined(__linux__)
> +#define __linux__
> +#endif
> +#include <acpi/platform/aclinux.h>
> +
>  #else
>  
>  /* Unknown environment */
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
