Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182999;
	b=WmImoRzfAiqxDXGLL5echFUoQdQVLnTV7CxrYaiT0gUMLCbOCaq17okTQ7CxfI4xPw/c
	 6I9vNTYBRXaddK3UxHUtInkiDWeV+HE/T5dC+Nhp67kPjp9bBdIJtQMJZZ7Dc9Elk1mLZ
	 oKFgpIBqO6baozSU4Jrg2CzlldZ1EAKUz2Qg0qdUSOkYYIQx00bvNyFHEO2DMyxdSi2iU
	 cvKvGtnEgrLvmb8WI++TL+Q/AseI38hXXKdw89lHdhYvX/oNLjxzNNWyQ0S/+VzSgtdgQ
	 BjjBMlCXJA5Yjp70uZI6vkGXXpeyVoi2GKOmZqQCXnP3ePeLShCgcZXerhsb2hawERg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182999;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1wiuOTBHUfvZeBmhO8viOZzk1cxLMeoaIYwnU/zl3gw=;
	b=0m4X6We7dg+Bwq44DxDlQJkomNyzGhmes4zajtkysL7jeI5jDbsLs1qGdXW3HSGVaHh7
	 Tl/ynruonEZ0iNtcAglyN67cPBpysmvyFewzTSKSkfsjfjT821uots68lk7WEJAR/bWcH
	 UH5TqY2ChTOlOhKddg34CvaRZSX9WhaTeTE8ZXtDRJ6gnkapvrqgdCNEZeLhf5gSpEx5h
	 to2arlVfG2fBt05NdZKdVPkYH/ODB00ofNJkrE1ybcCqNkyk+XaaedHaNH2ta5PkedwBK
	 L93GNDKvFHSfEGhbaCu+nzXjUQNJuudwE/qPYh/Cogm+HxagZ4ryHQXXR98HSULz4MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP30F5Ov;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA57606A333
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP30F5Ov
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC971F01564
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182998;
	bh=1wiuOTBHUfvZeBmhO8viOZzk1cxLMeoaIYwnU/zl3gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aP30F5Ovej1bfFb/CohrzuZh938PW2NRqoBY5u15ydmw7Lle0wF7k6RjgHH0Td7Uc
	 2mmflR29YXyAMy5lvTZ9Fv1ufM2PBbqLkiBkJKJqXitW1LsoLwEUIyZqVtwEQLeIZK
	 2pCUmjnDmPQw7KXmGqAGs/5yTkzfl5lqnTjnRP12LNOhpxGoBKtNhqHsRLKYIvXSMD
	 Dn0lfuOzlM4lrvGMlKVLoTzB7YPBIl/VqvINVRr+vUSutDyHcYWZL4WkwnDbjN+de1
	 J4uHhxutwyYvnBDAF2vETN/OFpkkw8EuItcTNMu+SSJt0KC4rUGxpMl1zpyzlNvXJ/
	 N+mo0UknhDn7w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ae417eb235so7489801fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 05:56:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHGEYIC1AUr7SwWRbr0TVOjwYTVcMyfI54RcMnuSxRd73TAU4t0+jaGiG569MlNz9j7gp02f0TAZP11@vger.kernel.org
X-Gm-Message-State: APuU4Z8p2Bg4k4O0Np/QSkh7t73Ynh38+CVpdpNyin3f5Ty8WM14Kjav
	UZe65xWm1s6NYCBEQX4AjSyPzHzy0ZpSNjqnLg2igTzi5pBTk8QZKb/SdmL4YxKy++EooRWDVIJ
	V1XbtkQg+KO6VUm4pvb8sK+AYQp1MRWk=
X-Received: by 2002:a05:651c:a1a3:b0:3ae:25c8:dc9a with SMTP id
 38308e7fff4ca-3ae7f9b2228mr11292111fa.5.1795182997003; Fri, 20 Nov 2026
 05:56:37 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109082832.496-1-baorliu@amd.com> <20261117071709.428-1-baorliu@amd.com>
In-Reply-To: <20261117071709.428-1-baorliu@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 14:56:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gxGtEENP9kBmwFvcrSxPMyguYsYoYKpa6oa7hhvAvN=A@mail.gmail.com>
X-Gm-Features: Aa3M54qMGTerQhE_Nm0y29KaS6q9nXPh-orCIudbnnqELVntdJmHR5gWcAI8JeY
Message-ID: <CAJZ5v0gxGtEENP9kBmwFvcrSxPMyguYsYoYKpa6oa7hhvAvN=A@mail.gmail.com>
Subject: Re: [PATCH v8] ACPI: button: Report wakeup key only for power button wakeups
To: "Baorui.Liu" <baorliu@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 8:17=E2=80=AFAM Baorui.Liu <baorliu@amd.com> wrote:
>
> The ACPI button driver reports KEY_WAKEUP from the Power Button input
> device to let userspace know that the system was resumed by a power
> button wakeup.
>
> However, reporting KEY_WAKEUP from generic system resume paths can make
> userspace observe a Power Button wakeup even when the system was resumed
> by a different wake source.
>
> This is reproducible on an AMD Android 15 Xen guest. With a kernel
> without this fix, a non-power-button S3 resume:
>
>   echo mem > /sys/power/state
>   xl trigger android s3resume
>
> makes the Power Button input device report KEY_WAKEUP. The same test on
> a kernel with this fix no longer reports KEY_WAKEUP from the Power Button
> input device.
>
> Track whether a power button event/notify is observed while the ACPI
> button device is suspended, and report KEY_WAKEUP on resume only in that
> case.
>
> When the fixed power-button status bit is set during early S3 resume,
> clear it to avoid a deferred KEY_POWER delivery to userspace, and set a
> sleep.c-owned flag so button resume can still report KEY_WAKEUP. Do not
> call into the button driver from that IRQ-disabled path. Also clear
> wakeup_pending before setting suspended, with a compiler barrier, and
> drain ACPI notify work before clearing suspended on resume. Report
> KEY_WAKEUP before clearing suspended so a late notify cannot drop both
> KEY_WAKEUP and KEY_POWER.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202609290454.LJrhMCb3-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202611030112.cVsBZFFE-lkp@i=
ntel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202611030545.3st9p1ha-lkp@i=
ntel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202611100542.1xljQv20-lkp@i=
ntel.com/
> Signed-off-by: Baorui.Liu <baorliu@amd.com>
>
> Changes since v7:
> - Guard acpi_sleep_pwr_btn_wakeup_pending() with CONFIG_ACPI_SLEEP,
>   matching its definition in sleep.c, so button resume does not link
>   against a missing symbol when CONFIG_PM_SLEEP=3Dy and CONFIG_ACPI_SLEEP
>   is unset (0day/LKP ERROR on x86_64 randconfig).
>
> Changes since v6:
> - Include <linux/types.h> in include/acpi/button.h so the bool
>   declaration/stub of acpi_sleep_pwr_btn_wakeup_pending() builds when
>   the header is included without prior bool typedefs (0day/LKP ERROR
>   via nouveau_connector.c on parisc64-defconfig and arm64-randconfig).

Sashiko has feedback on this:

https://sashiko.dev/#/patchset/20261117071709.428-1-baorliu%40amd.com

Please let me know what you think about it.

Also, if you decide to send a new version, please do so in a new thread.

Thanks!

> ---
>  drivers/acpi/button.c | 63 ++++++++++++++++++++++++++++++++++++-------
>  drivers/acpi/sleep.c  | 47 +++++++++++++++++++++-----------
>  include/acpi/button.h | 19 +++++++++++++
>  3 files changed, 104 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index c41fba556030..9a80a27e4297 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -203,6 +203,7 @@ struct acpi_button {
>         bool last_state;
>         ktime_t last_time;
>         bool suspended;
> +       bool wakeup_pending;
>         bool lid_state_initialized;
>         bool gpe_enabled;
>  };
> @@ -488,7 +489,11 @@ static void acpi_button_notify(acpi_handle handle, u=
32 event, void *data)
>
>         acpi_pm_wakeup_event(button->dev);
>
> -       if (button->suspended || event =3D=3D ACPI_BUTTON_NOTIFY_WAKE)
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER &&
> +           READ_ONCE(button->suspended))
> +               WRITE_ONCE(button->wakeup_pending, true);
> +
> +       if (READ_ONCE(button->suspended) || event =3D=3D ACPI_BUTTON_NOTI=
FY_WAKE)
>                 return;
>
>         input =3D button->input;
> @@ -510,6 +515,12 @@ static void acpi_button_notify_run(void *data)
>
>  static u32 acpi_button_event(void *data)
>  {
> +       struct acpi_button *button =3D data;
> +
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER &&
> +           READ_ONCE(button->suspended))
> +               WRITE_ONCE(button->wakeup_pending, true);
> +
>         acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data)=
;
>         return ACPI_INTERRUPT_HANDLED;
>  }
> @@ -519,7 +530,15 @@ static int acpi_button_suspend(struct device *dev)
>  {
>         struct acpi_button *button =3D dev_get_drvdata(dev);
>
> -       button->suspended =3D true;
> +       /*
> +        * Clear wakeup_pending before marking suspended. Otherwise a pow=
er
> +        * button SCI between the two stores could set wakeup_pending and=
 then
> +        * be overwritten here, losing a real wakeup. barrier() prevents =
the
> +        * compiler from reordering the stores relative to that IRQ handl=
er.
> +        */
> +       WRITE_ONCE(button->wakeup_pending, false);
> +       barrier();
> +       WRITE_ONCE(button->suspended, true);
>         return 0;
>  }
>
> @@ -527,21 +546,45 @@ static int acpi_button_resume(struct device *dev)
>  {
>         struct acpi_button *button =3D dev_get_drvdata(dev);
>         struct input_dev *input;
> +       bool report_wakeup =3D false;
> +
> +       /*
> +        * Drain notify work queued while suspended so a late power-butto=
n
> +        * notify still observes suspended =3D=3D true, sets wakeup_pendi=
ng, and
> +        * does not synthesize KEY_POWER for userspace.
> +        */
> +       acpi_os_wait_events_complete();
> +
> +       /*
> +        * Sample and report KEY_WAKEUP before clearing suspended. Otherw=
ise a
> +        * notify that arrives after sampling but before suspended is cle=
ared
> +        * can set wakeup_pending and then be dropped without KEY_WAKEUP =
or
> +        * KEY_POWER. Clear suspended before wakeup_pending so a new SCI =
sees
> +        * suspended =3D=3D false and takes the normal KEY_POWER path; ba=
rrier()
> +        * keeps that store order.
> +        */
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER) {
> +               report_wakeup =3D READ_ONCE(button->wakeup_pending) ||
> +                               acpi_sleep_pwr_btn_wakeup_pending();
> +               if (report_wakeup) {
> +                       input =3D button->input;
> +                       input_report_key(input, KEY_WAKEUP, 1);
> +                       input_sync(input);
> +                       input_report_key(input, KEY_WAKEUP, 0);
> +                       input_sync(input);
> +               }
> +       }
> +
> +       WRITE_ONCE(button->suspended, false);
> +       barrier();
> +       WRITE_ONCE(button->wakeup_pending, false);
>
> -       button->suspended =3D false;
>         if (button->type =3D=3D ACPI_BUTTON_TYPE_LID) {
>                 button->last_state =3D !!acpi_lid_evaluate_state(ACPI_HAN=
DLE(dev));
>                 button->last_time =3D ktime_get();
>                 acpi_lid_initialize_state(button);
>         }
>
> -       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER) {
> -               input =3D button->input;
> -               input_report_key(input, KEY_WAKEUP, 1);
> -               input_sync(input);
> -               input_report_key(input, KEY_WAKEUP, 0);
> -               input_sync(input);
> -       }
>         return 0;
>  }
>  #endif
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 7c1fb5b844be..a17318a7a3d6 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -22,6 +22,7 @@
>  #include <linux/syscore_ops.h>
>  #include <asm/io.h>
>  #include <trace/events/power.h>
> +#include <acpi/button.h>
>
>  #include "internal.h"
>  #include "sleep.h"
> @@ -105,6 +106,23 @@ u32 acpi_target_system_state(void)
>  EXPORT_SYMBOL_GPL(acpi_target_system_state);
>
>  static bool pwr_btn_event_pending;
> +static bool pwr_btn_wakeup_pending;
> +
> +/**
> + * acpi_sleep_pwr_btn_wakeup_pending - Consume fixed power-button wake h=
int.
> + *
> + * Returns true once if acpi_suspend_enter() observed and cleared the fi=
xed
> + * power-button status bit during early S3 resume. Used by the button dr=
iver
> + * to report KEY_WAKEUP without sleeping in that IRQ-disabled path.
> + */
> +bool acpi_sleep_pwr_btn_wakeup_pending(void)
> +{
> +       bool pending =3D READ_ONCE(pwr_btn_wakeup_pending);
> +
> +       WRITE_ONCE(pwr_btn_wakeup_pending, false);
> +       return pending;
> +}
> +EXPORT_SYMBOL_GPL(acpi_sleep_pwr_btn_wakeup_pending);
>
>  /*
>   * The ACPI specification wants us to save NVS memory regions during hib=
ernation
> @@ -504,12 +522,12 @@ static void acpi_pm_finish(void)
>
>         acpi_resume_power_resources();
>
> -       /* If we were woken with the fixed power button, provide a small
> -        * hint to userspace in the form of a wakeup event on the fixed p=
ower
> -        * button device (if it can be found).
> -        *
> -        * We delay the event generation til now, as the PM layer require=
s
> -        * timekeeping to be running before we generate events. */
> +       /*
> +        * If woken by the fixed power button, provide a wakeup event on =
that
> +        * device. KEY_WAKEUP input reporting is handled by the button dr=
iver
> +        * via acpi_sleep_pwr_btn_wakeup_pending() / wakeup_pending; do n=
ot
> +        * synthesize KEY_POWER here.
> +        */
>         if (!pwr_btn_event_pending)
>                 return;
>
> @@ -625,14 +643,13 @@ static int acpi_suspend_enter(suspend_state_t pm_st=
ate)
>         /* Reprogram control registers */
>         acpi_leave_sleep_state_prep(acpi_state);
>
> -       /* ACPI 3.0 specs (P62) says that it's the responsibility
> -        * of the OSPM to clear the status bit [ implying that the
> -        * POWER_BUTTON event should not reach userspace ]
> -        *
> -        * However, we do generate a small hint for userspace in the form=
 of
> -        * a wakeup event. We flag this condition for now and generate th=
e
> -        * event later, as we're currently too early in resume to be able=
 to
> -        * generate wakeup events.
> +       /*
> +        * ACPI 3.0 (P62): OSPM should clear the fixed power-button statu=
s bit
> +        * so the event does not reach userspace as KEY_POWER. Only set p=
lain
> +        * flags here: this path runs with IRQs disabled, so do not call =
into
> +        * the button driver (it may take sleeping locks). Button resume =
later
> +        * consumes pwr_btn_wakeup_pending for KEY_WAKEUP; acpi_pm_finish=
()
> +        * uses pwr_btn_event_pending for the PM wakeup event.
>          */
>         if (ACPI_SUCCESS(status) && (acpi_state =3D=3D ACPI_STATE_S3)) {
>                 acpi_event_status pwr_btn_status =3D ACPI_EVENT_FLAG_DISA=
BLED;
> @@ -641,8 +658,8 @@ static int acpi_suspend_enter(suspend_state_t pm_stat=
e)
>
>                 if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
>                         acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> -                       /* Flag for later */
>                         pwr_btn_event_pending =3D true;
> +                       WRITE_ONCE(pwr_btn_wakeup_pending, true);
>                 }
>         }
>
> diff --git a/include/acpi/button.h b/include/acpi/button.h
> index af2fce5d2ee3..83f5dd373f39 100644
> --- a/include/acpi/button.h
> +++ b/include/acpi/button.h
> @@ -2,6 +2,8 @@
>  #ifndef ACPI_BUTTON_H
>  #define ACPI_BUTTON_H
>
> +#include <linux/types.h> /* for bool */
> +
>  #define ACPI_BUTTON_HID_POWER  "PNP0C0C"
>  #define ACPI_BUTTON_HID_LID    "PNP0C0D"
>  #define ACPI_BUTTON_HID_SLEEP  "PNP0C0E"
> @@ -15,4 +17,21 @@ static inline int acpi_lid_open(void)
>  }
>  #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
>
> +/*
> + * Set in acpi_suspend_enter() when the fixed power-button status bit is
> + * observed (IRQ-disabled context). Consumed by the button driver on res=
ume
> + * so KEY_WAKEUP can be reported without calling into the button driver =
from
> + * that early path. Defined in sleep.c under CONFIG_ACPI_SLEEP. CONFIG_P=
M_SLEEP
> + * can be enabled without CONFIG_ACPI_SLEEP, so the stub keeps button.o
> + * linkable in that case. Safe when CONFIG_ACPI_BUTTON=3Dm.
> + */
> +#if IS_ENABLED(CONFIG_ACPI_SLEEP)
> +bool acpi_sleep_pwr_btn_wakeup_pending(void);
> +#else
> +static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
> +{
> +       return false;
> +}
> +#endif
> +
>  #endif /* ACPI_BUTTON_H */
>
> base-commit: 0069320cef67ba6ca745a05868c40e4c46b61284
> --
> 2.34.1
>
