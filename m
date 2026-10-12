Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEB4BEE24
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826931; cv=none; b=egaB9AzC376zUk2EiD6s/ntfQnmt7S/26xME0wLCEG7V7tHLHvzJHx0uGVHADtdFvVEi8a64pAPO5c9LHrXq6IZ+ULD+nGhSAWMcJx111AswA+M2R3RYGuNTLZhEYMa7JI9EtcpDG64z13wILIG7AYAKexYXo1te8lA7DU27Fmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826931; c=relaxed/simple;
	bh=kDfoMWmAYHZy2nSafS6SQrl9vzfIoQ8TNQJ3qLvqrLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q98KoNE/sKnh2I+usHC9McLMneXn7VgMudzoI0zj60lCutHsP8VBPA/VLTSLvaBBWrFK50addXc5MrF7/SuV1oVbjiJNnHK9NgbCUxbPtA+m3Wrf/7PPXPHpHaunF/wT9PyFfc7dFaOaJ3ejWLYXCBDRu5tZHzoM1JKimrBPQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6hv0RjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6hv0RjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE99F1F008A2
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826929;
	bh=1W+0UCXLuughcp6e8ltm0COK4feqcaALMQ+e08Exoh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G6hv0RjOnlllaDTR7PVKH4uK2OqND+01PupYnue9erwhxlvENu1TxAsvzDEgpaAcl
	 FJ3nv4Op2vYXRheDJyhyUgHn0DjTYJW+jnVUGQyVkLMZA85UkRe4Q8kA83iO2EEQQQ
	 XPB154WJRbyo6GIWjgR5JnojBfhtsvbu3iQqHOIsFHl3GdKQWfNCzMkCPl1FgbHsUe
	 I40wpId/dPWAOfGlQaqbR3PEQ2XAmw5J0irzOZLURr2xT2JGyN4pJ50rc4kHYveoeU
	 Mzoi6KJpZcxW/g41JyLoRP9Yo0goT3anKZLazB/6/Cj+idCZT8waklOkZcJFHjquQY
	 LCioaQSXF597w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso1651265e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 10:42:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzTFQfkJXU4nKbSZuB8v2a8yG3gY1ghRsqX853GRnfCqWqiAWjbHdVLhdZQdGmxptVOwhioLfAFFXjA@vger.kernel.org
X-Gm-Message-State: AFq9FYKhva4fImGRJhvM96s5so1PHa28iBcX9o1DSSwo2AF0cAqcYk10
	m7Re2vgUlNkF3nU5dCyIVBAKhkxFvjEEUjImmz/WBFVo7ylOFDUsWuhMkjOgnXXuFax6IfN1Lrb
	Tye64JX9f3IFkbAMDHIv+RdHgZstoN0U=
X-Received: by 2002:a05:6512:3053:b0:5bc:d9d6:6aa8 with SMTP id
 2adb3069b0e04-5bcde6bd2d9mr3548313e87.23.1791826928190; Mon, 12 Oct 2026
 10:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002080703.77402-1-luriwen@kylinos.cn>
In-Reply-To: <20261002080703.77402-1-luriwen@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 19:40:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwMvhT+O5ynqrV_X+FVLAa2fQw61zoM0t=aKMmtcPCFQ@mail.gmail.com>
X-Gm-Features: AclHuK-K4CqwtVQ7g1Lp4Kukd8lnoHpe1WAuzaA1j06xjbQ4nK2RGuKK-l7OXwU
Message-ID: <CAJZ5v0iwMvhT+O5ynqrV_X+FVLAa2fQw61zoM0t=aKMmtcPCFQ@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: PM: Make s2idle available on all ACPI platforms
 with suspend support
To: Riwen Lu <luriwen@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 10:07=E2=80=AFAM Riwen Lu <luriwen@kylinos.cn> wrote=
:
>
> The ACPI s2idle code lives in sleep.c and is guarded by
> ACPI_SYSTEM_POWER_STATES_SUPPORT, which is only selected by x86 and
> loongarch.  Consequently, ACPI platforms using HW-reduced ACPI (like
> arm64) have no ACPI s2idle support at all and cannot handle ACPI
> wakeup events (power button, lid, GPEs) during suspend-to-idle.
>
> s2idle is a pure software suspend state that does not depend on
> firmware S-states, so move it out of sleep.c into a new s2idle.c and
> tie it to a separate hidden symbol, ACPI_S2IDLE, that is enabled by
> default whenever suspend support is there (following the ACPI_LPIT
> pattern).  No user-visible option is introduced, no platform needs to
> select anything, and x86/loongarch builds are unaffected.
>
> The s2idle code is initialized from acpi_bus_init() via
> acpi_s2idle_init() which replaces the acpi_s2idle_setup() call from
> acpi_sleep_suspend_setup().  The weak acpi_s2idle_setup() is kept
> unchanged for the existing x86 override.
>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
> v1 -> v2:
>  - Fix acpi_s2idle_setup() declaration error when SUSPEND is disabled in
>    x86 builds.
>
> v2 -> v3:
>  - Select ACPI_S2IDLE if SUSPEND is enabled for
>    ACPI_SYSTEM_POWER_STATES_SUPPORT, so the select no longer violates the
>    ACPI_S2IDLE dependency on SUSPEND.
>
> v3 -> v4:
>  - Add pr_fmt() in s2idle.c so log messages keep the "ACPI: PM: " prefix
>    that sleep.c used; without it the moved pr_info/pr_warn would lose the
>    subsystem prefix.
>  - Drop the redundant #ifdef CONFIG_SUSPEND / #else wrapper in s2idle.c.
>    The !SUSPEND branch was dead code, because CONFIG_ACPI_S2IDLE itself
>    depends on SUSPEND, so s2idle.c is only compiled when SUSPEND is set.
>  - Make acpi_s2idle_init() return void.  The int return value was always =
0
>    in the real implementation and -ENXIO in the stub, and the only caller
>    (acpi_bus_init()) ignores it; a void interface is honest and the stub
>    becomes a clean no-op.
>  - Mark the weak acpi_s2idle_setup() default __init, matching the x86
>    override (which is already __init) and allowing the code to be discard=
ed
>    after init.
>  - Use SPDX-License-Identifier: GPL-2.0-only in s2idle.c for consistency
>    with sleep.c (the file the code was split out from).
>  - Trivial cleanups: remove a double blank line in the Makefile and drop
>    the redundant "Warning: " prefix from a pr_warn() message.
>
> v4 -> v5:
>  - Add #include <linux/interrupt.h> to s2idle.c.  enable_irq_wake(),
>    disable_irq_wake() and rearm_wake_irq() are declared there.
>
> v5 -> v6:
>  - Turn ACPI_S2IDLE into a hidden bool with default y, following the
>    ACPI_LPIT pattern, instead of a user-visible option selected by
>    ACPI_SYSTEM_POWER_STATES_SUPPORT.  No prompt, no conditional select
>    and no arch-specific changes: x86 and loongarch builds stay as they
>    are and arm64 gets s2idle automatically.
>
>
>  drivers/acpi/Kconfig    |   5 ++
>  drivers/acpi/Makefile   |   1 +
>  drivers/acpi/bus.c      |   3 +
>  drivers/acpi/internal.h |  10 ++-
>  drivers/acpi/s2idle.c   | 163 ++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/sleep.c    | 145 -----------------------------------
>  6 files changed, 180 insertions(+), 147 deletions(-)
>  create mode 100644 drivers/acpi/s2idle.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f165d14cf61a..11b574b394a4 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -113,6 +113,11 @@ config ACPI_SLEEP
>         depends on ACPI_SYSTEM_POWER_STATES_SUPPORT
>         default y
>
> +config ACPI_S2IDLE
> +       bool
> +       depends on SUSPEND
> +       default y
> +
>  config ACPI_REV_OVERRIDE_POSSIBLE
>         bool "Allow supported ACPI revision to be overridden"
>         depends on X86
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d1b0affb844f..f1e89e45e876 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -35,6 +35,7 @@ acpi-$(CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT) +=3D sl=
eep.o
>  acpi-y                         +=3D device_sysfs.o device_pm.o
>  acpi-$(CONFIG_ACPI_SLEEP)      +=3D proc.o
>
> +acpi-$(CONFIG_ACPI_S2IDLE)     +=3D s2idle.o
>
>  #
>  # ACPI Bus and Device Drivers
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 808c6746be14..afde30bb17aa 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1428,6 +1428,9 @@ static int __init acpi_bus_init(void)
>         /* Initialize sleep structures */
>         acpi_sleep_init();
>
> +       /* Initialize default acpi s2idle ops */
> +       acpi_s2idle_init();
> +
>         /*
>          * Get the system interrupt model and evaluate \_PIC.
>          */
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 40f875b265a9..5a08315d308a 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -267,13 +267,19 @@ static inline bool acpi_ec_dispatch_gpe(void)
>                                    Suspend/Resume
>    ----------------------------------------------------------------------=
---- */
>  #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
> -extern bool acpi_s2idle_wakeup(void);
>  extern int acpi_sleep_init(void);
>  #else
> -static inline bool acpi_s2idle_wakeup(void) { return false; }
>  static inline int acpi_sleep_init(void) { return -ENXIO; }
>  #endif
>
> +#ifdef CONFIG_ACPI_S2IDLE
> +extern bool acpi_s2idle_wakeup(void);
> +extern void acpi_s2idle_init(void);
> +#else
> +static inline bool acpi_s2idle_wakeup(void) { return false; }
> +static inline void acpi_s2idle_init(void) {}
> +#endif
> +
>  #ifdef CONFIG_ACPI_SLEEP
>  void acpi_sleep_proc_init(void);
>  int suspend_nvs_alloc(void);
> diff --git a/drivers/acpi/s2idle.c b/drivers/acpi/s2idle.c
> new file mode 100644
> index 000000000000..b5cd9649acda
> --- /dev/null
> +++ b/drivers/acpi/s2idle.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * s2idle.c - ACPI suspend-to-idle support.
> + *
> + */
> +
> +#define pr_fmt(fmt) "ACPI: PM: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/suspend.h>
> +#include <linux/irq.h>
> +
> +#include "internal.h"
> +#include "sleep.h"
> +
> +static bool s2idle_wakeup;
> +
> +int acpi_s2idle_begin(void)
> +{
> +       acpi_scan_lock_acquire();
> +       return 0;
> +}
> +
> +int acpi_s2idle_prepare(void)
> +{
> +       if (acpi_sci_irq_valid()) {
> +               int error;
> +
> +               error =3D enable_irq_wake(acpi_sci_irq);
> +               if (error)
> +                       pr_warn("Failed to enable wakeup from IRQ %d: %d\=
n",
> +                               acpi_sci_irq, error);
> +
> +               acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
> +       }
> +
> +       acpi_enable_wakeup_devices(ACPI_STATE_S0);
> +
> +       /* Change the configuration of GPEs to avoid spurious wakeup. */
> +       acpi_enable_all_wakeup_gpes();
> +       acpi_os_wait_events_complete();
> +
> +       s2idle_wakeup =3D true;

So the problem with the current approach is that the code above is not
useful on arm64 (and any systems without full ACPI HW support for that
matter).

This observation applies to the majority of the ACPI s2idle callbacks.

While I kind of agree with moving that code to a separate file, I
don't think it is useful to compile all of that code unconditionally
if CONFIG_ACPI is set.

> +       return 0;
> +}
> +

[cut]
