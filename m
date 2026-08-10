Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83093B9D99
	for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2026 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357442; cv=none; b=Ql/yFKDHnS1/XLjPzreQ9j/5lnKqPnuSraTKR5NlkqWxnRq3KQO6TJWIJNQTK6VmbBb4GlLfeGCCrFaplANFVUYb9MmAZCAJSWlrc34AAmvVjyEMIsj2jXCMgbAZeOzt0PPkxbNMQ/7E1xQs64sqXExYxLqigJvbxji+b7Rc+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357442; c=relaxed/simple;
	bh=KLnJ8DvfIeep2JUl/u8mJF8nLAMo1QOYETUnEUXuQrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emZGj8HKYCyE1pP57MiItY3bIYtwwCe5OVkCkYWjiHNp7D9BChcBf0/8ItmdgVNe/d+CsUhFyTFs13SfwIS2d6RxR/I4QjdT3MEjgmp+grtoCIL8FkBp3A/K3X8CucOzTNaYPBrWt96n3XmUCUVjeC/CO75/7GjZzCBj8VSLFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYb9T9fe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYb9T9fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A196D1F00A3A
	for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2026 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357440;
	bh=UqYRtOJ30YsbmbMJGcVzgTOYzcf6BHcb1Jx07K6P280=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jYb9T9feNZCxkIArIe4Q+zCHuF24ItREboLBOnJjgG8kBJ8ug02xIqzAUJ+ndxy1Y
	 5u+qSm5FboCa+PTdC1nl49G06w0ruu0x9e6b7GwaOnB+iSVJqb3bEApP42gG+ErkZr
	 8EOw1eZPsIO/4yecdlbiA5AtPUDGWVZ7bbjCxe7KSisyeTg+UMdP3nY9Xur99+VXhL
	 WTx6HHb5NXn5KIW4BJTqmr1c1uI+M+C7tborNacGED2TMZSJw/lDmu/fZ6Sjyt7lex
	 qmDBDJlcKt02Igpx4Z2vWImR5f6L0u9F4GuTDDg2suH1C8DfUgKZHJPCtJHEXJHR7R
	 lkI1F9XWP02xA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39faa67fab8so10562981fa.2
        for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2026 03:24:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq2vOMh6Apn0aCnzMdjWEoQ5TXtAbDb+PI/AXwothiq6v2p9tOuqTCz0xjmr8E0HpJISF5rrt2PlvbV@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEkfpHxwnDFWaPEMls1IC4rReldZXetwbuYu+qyv5v7XYKz7A
	AU73TIPvYJ54n93tySzfNHEWGRQj95cqy/VbbEsooe0vNFG/t54+CFQBjlJgfihynlCbAuqeFX+
	KLZn8iAPZ7T9WqWh303A5OKUaBrWWU/Y=
X-Received: by 2002:a2e:a54d:0:b0:39c:9285:84f6 with SMTP id
 38308e7fff4ca-39fbb0374f1mr47366101fa.11.1786357439001; Mon, 10 Aug 2026
 03:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810065535.3432984-1-luriwen@kylinos.cn>
In-Reply-To: <20260810065535.3432984-1-luriwen@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 10 Aug 2026 12:23:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpwjNk9pmKN41Dh6Q9GcRJo7xQ-JJTSEviqF_HiU=XrQ@mail.gmail.com>
X-Gm-Features: AUfX_mz7C8P3FSdJ-1faoFRIkXiRDJd8vlnxxAzfAIZvumZp5i3bmoWdlfK-rB8
Message-ID: <CAJZ5v0jpwjNk9pmKN41Dh6Q9GcRJo7xQ-JJTSEviqF_HiU=XrQ@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: PM: Introduce CONFIG_ACPI_S2IDLE for
 platform-independent S2Idle support
To: Riwen Lu <luriwen@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:55=E2=80=AFAM Riwen Lu <luriwen@kylinos.cn> wrote=
:
>
> The ACPI S2Idle (suspend-to-idle) code is currently located in sleep.c
> and guarded by CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT. This config is
> historically tied to x86/ia64 sleep states (S3/S4), which prevents
> ACPI-based platforms like ARM64 from using the OS-centric s2idle
> framework and its associated wakeup event handling (e.g., from ACPI
> buttons or the lid).
>
> Since S2Idle is a software-driven low-power state that does not rely on
> firmware sleep states (S3/S4), it should be available to all
> ACPI-enabled platforms.
>
> To achieve this, introduce a new, independent Kconfig option,
> CONFIG_ACPI_S2IDLE. It is selected by ACPI_SYSTEM_POWER_STATES_SUPPORT
> for backward compatibility, but can now also be enabled separately by
> other platforms.
>
> Move all s2idle-specific code into a dedicated file,
> drivers/acpi/s2idle.c. This creates a clear and independent ACPI s2idle
> framework, centered around a default acpi_s2idle_ops and a weakly
> defined acpi_s2idle_setup() hook.
>
> The change allows all ACPI platforms to use this common s2idle
> infrastructure. Platforms with unique requirements can override the
> defaults via the weak function, while others (like ARM64) can now simply
> enable the config to obtain functional s2idle support with standard ACPI
> wakeup handling.
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

OK, so I'm totally unconvinced about the approach here, while I agree
that it would be good to allow s2idle to also work on platforms using
HW-reduced ACPI.

I'll be mostly offline this week though, so let's get back to it later.

>  drivers/acpi/Kconfig    |  14 ++++
>  drivers/acpi/Makefile   |   1 +
>  drivers/acpi/bus.c      |   3 +
>  drivers/acpi/internal.h |  10 ++-
>  drivers/acpi/s2idle.c   | 163 ++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/sleep.c    | 145 -----------------------------------
>  6 files changed, 189 insertions(+), 147 deletions(-)
>  create mode 100644 drivers/acpi/s2idle.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f165d14cf61a..8c0918747bbb 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -55,6 +55,7 @@ config ACPI_GENERIC_GSI
>
>  config ACPI_SYSTEM_POWER_STATES_SUPPORT
>         bool
> +       select ACPI_S2IDLE if SUSPEND
>
>  config ACPI_CCA_REQUIRED
>         bool
> @@ -113,6 +114,19 @@ config ACPI_SLEEP
>         depends on ACPI_SYSTEM_POWER_STATES_SUPPORT
>         default y
>
> +config ACPI_S2IDLE
> +       bool "ACPI suspend-to-idle support"
> +       depends on SUSPEND
> +       help
> +         This option enables the core ACPI framework for the suspend-to-=
idle
> +         (S2Idle) power state. This state is software-driven and does no=
t
> +         require platform firmware sleep states (S3/S4).
> +
> +         It is automatically selected by platforms with
> +         CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT (like x86), but can als=
o
> +         be enabled independently by other ACPI platforms (e.g., ARM64) =
to
> +         gain support for low-power idle and ACPI wakeup events.
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
> index a30a904f6535..eedcd940859c 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1534,6 +1534,9 @@ static int __init acpi_bus_init(void)
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
> +       return 0;
> +}
> +
> +bool acpi_s2idle_wake(void)
> +{
> +       if (!acpi_sci_irq_valid())
> +               return pm_wakeup_pending();
> +
> +       while (pm_wakeup_pending()) {
> +               /*
> +                * If IRQD_WAKEUP_ARMED is set for the SCI at this point,=
 the
> +                * SCI has not triggered while suspended, so bail out (th=
e
> +                * wakeup is pending anyway and the SCI is not the source=
 of
> +                * it).
> +                */
> +               if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))=
 {
> +                       pm_pr_dbg("Wakeup unrelated to ACPI SCI\n");
> +                       return true;
> +               }
> +
> +               /*
> +                * If the status bit of any enabled fixed event is set, t=
he
> +                * wakeup is regarded as valid.
> +                */
> +               if (acpi_any_fixed_event_status_set()) {
> +                       pm_pr_dbg("ACPI fixed event wakeup\n");
> +                       return true;
> +               }
> +
> +               /* Check wakeups from drivers sharing the SCI. */
> +               if (acpi_check_wakeup_handlers()) {
> +                       pm_pr_dbg("ACPI custom handler wakeup\n");
> +                       return true;
> +               }
> +
> +               /*
> +                * Check non-EC GPE wakeups and if there are none, cancel=
 the
> +                * SCI-related wakeup and dispatch the EC GPE.
> +                */
> +               if (acpi_ec_dispatch_gpe()) {
> +                       pm_pr_dbg("ACPI non-EC GPE wakeup\n");
> +                       return true;
> +               }
> +
> +               acpi_os_wait_events_complete();
> +
> +               /*
> +                * The SCI is in the "suspended" state now and it cannot =
produce
> +                * new wakeup events till the rearming below, so if any o=
f them
> +                * are pending here, they must be resulting from the proc=
essing
> +                * of EC events above or coming from somewhere else.
> +                */
> +               if (pm_wakeup_pending()) {
> +                       pm_pr_dbg("Wakeup after ACPI Notify sync\n");
> +                       return true;
> +               }
> +
> +               pm_pr_dbg("Rearming ACPI SCI for wakeup\n");
> +
> +               pm_wakeup_clear(acpi_sci_irq);
> +               rearm_wake_irq(acpi_sci_irq);
> +       }
> +
> +       return false;
> +}
> +
> +void acpi_s2idle_restore(void)
> +{
> +       /*
> +        * Drain pending events before restoring the working-state config=
uration
> +        * of GPEs.
> +        */
> +       acpi_os_wait_events_complete(); /* synchronize GPE processing */
> +       acpi_ec_flush_work(); /* flush the EC driver's workqueues */
> +       acpi_os_wait_events_complete(); /* synchronize Notify handling */
> +
> +       s2idle_wakeup =3D false;
> +
> +       acpi_enable_all_runtime_gpes();
> +
> +       acpi_disable_wakeup_devices(ACPI_STATE_S0);
> +
> +       if (acpi_sci_irq_valid()) {
> +               acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
> +               disable_irq_wake(acpi_sci_irq);
> +       }
> +}
> +
> +void acpi_s2idle_end(void)
> +{
> +       acpi_scan_lock_release();
> +}
> +
> +static const struct platform_s2idle_ops acpi_s2idle_ops =3D {
> +       .begin =3D acpi_s2idle_begin,
> +       .prepare =3D acpi_s2idle_prepare,
> +       .wake =3D acpi_s2idle_wake,
> +       .restore =3D acpi_s2idle_restore,
> +       .end =3D acpi_s2idle_end,
> +};
> +
> +void __init __weak acpi_s2idle_setup(void)
> +{
> +       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> +               pr_info("Efficient low-power S0 idle declared\n");
> +
> +       s2idle_set_ops(&acpi_s2idle_ops);
> +}
> +
> +bool acpi_s2idle_wakeup(void)
> +{
> +       return s2idle_wakeup;
> +}
> +
> +void __init acpi_s2idle_init(void)
> +{
> +       acpi_s2idle_setup();
> +}
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 132a9df98471..eeaacc354c48 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -724,143 +724,6 @@ static const struct platform_suspend_ops acpi_suspe=
nd_ops_old =3D {
>         .recover =3D acpi_pm_finish,
>  };
>
> -static bool s2idle_wakeup;
> -
> -int acpi_s2idle_begin(void)
> -{
> -       acpi_scan_lock_acquire();
> -       return 0;
> -}
> -
> -int acpi_s2idle_prepare(void)
> -{
> -       if (acpi_sci_irq_valid()) {
> -               int error;
> -
> -               error =3D enable_irq_wake(acpi_sci_irq);
> -               if (error)
> -                       pr_warn("Warning: Failed to enable wakeup from IR=
Q %d: %d\n",
> -                               acpi_sci_irq, error);
> -
> -               acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
> -       }
> -
> -       acpi_enable_wakeup_devices(ACPI_STATE_S0);
> -
> -       /* Change the configuration of GPEs to avoid spurious wakeup. */
> -       acpi_enable_all_wakeup_gpes();
> -       acpi_os_wait_events_complete();
> -
> -       s2idle_wakeup =3D true;
> -       return 0;
> -}
> -
> -bool acpi_s2idle_wake(void)
> -{
> -       if (!acpi_sci_irq_valid())
> -               return pm_wakeup_pending();
> -
> -       while (pm_wakeup_pending()) {
> -               /*
> -                * If IRQD_WAKEUP_ARMED is set for the SCI at this point,=
 the
> -                * SCI has not triggered while suspended, so bail out (th=
e
> -                * wakeup is pending anyway and the SCI is not the source=
 of
> -                * it).
> -                */
> -               if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))=
 {
> -                       pm_pr_dbg("Wakeup unrelated to ACPI SCI\n");
> -                       return true;
> -               }
> -
> -               /*
> -                * If the status bit of any enabled fixed event is set, t=
he
> -                * wakeup is regarded as valid.
> -                */
> -               if (acpi_any_fixed_event_status_set()) {
> -                       pm_pr_dbg("ACPI fixed event wakeup\n");
> -                       return true;
> -               }
> -
> -               /* Check wakeups from drivers sharing the SCI. */
> -               if (acpi_check_wakeup_handlers()) {
> -                       pm_pr_dbg("ACPI custom handler wakeup\n");
> -                       return true;
> -               }
> -
> -               /*
> -                * Check non-EC GPE wakeups and if there are none, cancel=
 the
> -                * SCI-related wakeup and dispatch the EC GPE.
> -                */
> -               if (acpi_ec_dispatch_gpe()) {
> -                       pm_pr_dbg("ACPI non-EC GPE wakeup\n");
> -                       return true;
> -               }
> -
> -               acpi_os_wait_events_complete();
> -
> -               /*
> -                * The SCI is in the "suspended" state now and it cannot =
produce
> -                * new wakeup events till the rearming below, so if any o=
f them
> -                * are pending here, they must be resulting from the proc=
essing
> -                * of EC events above or coming from somewhere else.
> -                */
> -               if (pm_wakeup_pending()) {
> -                       pm_pr_dbg("Wakeup after ACPI Notify sync\n");
> -                       return true;
> -               }
> -
> -               pm_pr_dbg("Rearming ACPI SCI for wakeup\n");
> -
> -               pm_wakeup_clear(acpi_sci_irq);
> -               rearm_wake_irq(acpi_sci_irq);
> -       }
> -
> -       return false;
> -}
> -
> -void acpi_s2idle_restore(void)
> -{
> -       /*
> -        * Drain pending events before restoring the working-state config=
uration
> -        * of GPEs.
> -        */
> -       acpi_os_wait_events_complete(); /* synchronize GPE processing */
> -       acpi_ec_flush_work(); /* flush the EC driver's workqueues */
> -       acpi_os_wait_events_complete(); /* synchronize Notify handling */
> -
> -       s2idle_wakeup =3D false;
> -
> -       acpi_enable_all_runtime_gpes();
> -
> -       acpi_disable_wakeup_devices(ACPI_STATE_S0);
> -
> -       if (acpi_sci_irq_valid()) {
> -               acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
> -               disable_irq_wake(acpi_sci_irq);
> -       }
> -}
> -
> -void acpi_s2idle_end(void)
> -{
> -       acpi_scan_lock_release();
> -}
> -
> -static const struct platform_s2idle_ops acpi_s2idle_ops =3D {
> -       .begin =3D acpi_s2idle_begin,
> -       .prepare =3D acpi_s2idle_prepare,
> -       .wake =3D acpi_s2idle_wake,
> -       .restore =3D acpi_s2idle_restore,
> -       .end =3D acpi_s2idle_end,
> -};
> -
> -void __weak acpi_s2idle_setup(void)
> -{
> -       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> -               pr_info("Efficient low-power S0 idle declared\n");
> -
> -       s2idle_set_ops(&acpi_s2idle_ops);
> -}
> -
>  static void __init acpi_sleep_suspend_setup(void)
>  {
>         bool suspend_ops_needed =3D false;
> @@ -875,20 +738,12 @@ static void __init acpi_sleep_suspend_setup(void)
>         if (suspend_ops_needed)
>                 suspend_set_ops(old_suspend_ordering ?
>                                 &acpi_suspend_ops_old : &acpi_suspend_ops=
);
> -
> -       acpi_s2idle_setup();
>  }
>
>  #else /* !CONFIG_SUSPEND */
> -#define s2idle_wakeup          (false)
>  static inline void acpi_sleep_suspend_setup(void) {}
>  #endif /* !CONFIG_SUSPEND */
>
> -bool acpi_s2idle_wakeup(void)
> -{
> -       return s2idle_wakeup;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static u32 saved_bm_rld;
>
> --
> 2.25.1
>
