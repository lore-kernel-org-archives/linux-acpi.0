Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD74D17B0
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829283; cv=none; b=LeceJiIAxYz+4cfPKmwQpXRZpfwTPYKWbFIfiXGQoSedZ/Y9Cac6WG99vKyfKGMovIeig3SWFr0RoAXcBL3xEQ+2PK8+a3gYXajB7K42L0lhuS2CjLNHQfVK3loXPLKjOzYimISs7LEVMUydbW6o/PFd++E94fvdKdw40qIwdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829283; c=relaxed/simple;
	bh=RnY8lPHIFP3jmQr3m+6xqpYC8Mv4DIN5BZGA5Z0IwSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUmE7yQjOHbNS7CjAU15tes1td5niiRIBRcC5z5J6qQ/AQWaeo94SL+ivKBYgjJMO0MbIl5dkOgDPP69yqAWXqlEYanaChDun1eBf12/8AgxKic47g/7I2To5FVBQQj03+YwD8vrhlMle7JXYS6XQ5Yo7iSbZeQJz3g4uFoo+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nytZ1PIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nytZ1PIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1D71F008A2
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791829281;
	bh=GCKWXxEM7wbFA/APNv4BotWXro/we/hiP8BlFU4oiJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nytZ1PIKnwCbPznACBxrltd7zXVnlXHe7vXlu4KnDV6S4JEkc++0mecKRXOgWTKAA
	 BmYLzxnqv/rRXhkR4HLdhBWE/JEl0NpxOJF5n95GLHBXY2UANSSZWvEGPxolIxWX47
	 ibW3X9hontKkdy+xyhO24vF/agUqArY/XeLlzYmxJ+iFfwCyeaNuFTvRf8Y36sX8sz
	 tvV02kCdP3y305fAN2kHYF+abE2OQY6fN43pGf3HhoqXmp0THtt8+yA9H48kAU7QZC
	 DEuzu83sPzYYTenAad1Dydub/KMExPXUsF2V4o885i0Lydm3l+PEx2VtuPq+/xlRQj
	 IuQdtxEh+Immg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso4960192e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 11:21:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwJB8X2V6cl6W6Rl8nbpVCdMWSYl+xTjDbR5AR+aYKJXC7xKruzjLOk2kZDfaWEq3sfSm0/0y9lS7SS@vger.kernel.org
X-Gm-Message-State: AFq9FYIssDWiS4trBjFTSqhT6bNibtgMisKqBD3JghGQf40xGx7uh3gm
	vb00sbQmTJ6MhgSnSBkJT0kGXepr5xNXMNdqyY4ucXZgP0K7mt6Ok99qEvt9RgPVTiDiRSbC6Ap
	3X+kvXfAdiLuXFLa0TNOMHC1oYWHXqDE=
X-Received: by 2002:a05:6512:158b:b0:5bc:db4b:930e with SMTP id
 2adb3069b0e04-5bcdd5317a8mr3088103e87.28.1791829279852; Mon, 12 Oct 2026
 11:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922024232.816-1-baorliu@amd.com> <20261012060847.486-1-baorliu@amd.com>
In-Reply-To: <20261012060847.486-1-baorliu@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:19:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_136ACZzxQ=MdvRx_7iYRu3L3z1tY01ONfkSz5JEXzw@mail.gmail.com>
X-Gm-Features: AclHuK_tHMLoic4JTE_J6o2cp2lr4wxlud2cMNMVANjSB0lQNuZd5IoVuv9XxXI
Message-ID: <CAJZ5v0h_136ACZzxQ=MdvRx_7iYRu3L3z1tY01ONfkSz5JEXzw@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: button: Report wakeup key only for power button wakeups
To: "Baorui.Liu" <baorliu@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:09=E2=80=AFAM Baorui.Liu <baorliu@amd.com> wrote:
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
> clear it to avoid a deferred KEY_POWER delivery to userspace, and mark
> wakeup_pending so button resume can still report KEY_WAKEUP. Also clear
> wakeup_pending before setting suspended to avoid a race with a power
> button SCI during suspend entry.
>
> Declare acpi_button_power_wakeup_pending() with IS_REACHABLE so that
> CONFIG_ACPI_BUTTON=3Dm does not leave an unresolved reference in built-in
> sleep.c.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202609290454.LJrhMCb3-lkp@intel.com/
> Signed-off-by: Baorui.Liu <baorliu@amd.com>
> ---
> Changes since v4:
> - Fix LKP build ERROR when CONFIG_ACPI_BUTTON=3Dm by declaring
>   acpi_button_power_wakeup_pending() with IS_REACHABLE().

Please see the Sashiko feedback on this patch:

https://sashiko.dev/#/patchset/20261012060847.486-1-baorliu%40amd.com

and let me know what you think about it.

Thanks!

>  drivers/acpi/button.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
>  drivers/acpi/sleep.c  | 27 +++++++++++--------------
>  include/acpi/button.h | 13 ++++++++++++
>  3 files changed, 70 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cdbb1023a8ee..c07de417df5d 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -191,6 +191,7 @@ struct acpi_button {
>         bool last_state;
>         ktime_t last_time;
>         bool suspended;
> +       bool wakeup_pending;
>         bool lid_state_initialized;
>         bool gpe_enabled;
>  };
> @@ -397,6 +398,34 @@ static void acpi_lid_forget(struct acpi_device *adev=
)
>  }
>
>  /* Driver Interface */
> +/**
> + * acpi_button_power_wakeup_pending - Mark fixed power button wakeup pen=
ding.
> + *
> + * Used when the fixed power-button status bit is observed and cleared d=
uring
> + * early S3 resume, so KEY_WAKEUP can still be reported from button resu=
me
> + * without delivering a deferred KEY_POWER to userspace.
> + */
> +void acpi_button_power_wakeup_pending(void)
> +{
> +       struct acpi_device *adev;
> +       struct device *phys_dev;
> +       struct acpi_button *button;
> +
> +       adev =3D acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF, NUL=
L, -1);
> +       if (!adev)
> +               return;
> +
> +       phys_dev =3D acpi_get_first_physical_node(adev);
> +       if (phys_dev) {
> +               button =3D dev_get_drvdata(phys_dev);
> +               if (button && button->type =3D=3D ACPI_BUTTON_TYPE_POWER)
> +                       button->wakeup_pending =3D true;
> +       }
> +
> +       acpi_dev_put(adev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_button_power_wakeup_pending);
> +
>  int acpi_lid_open(void)
>  {
>         guard(mutex)(&acpi_lid_lock);
> @@ -476,6 +505,9 @@ static void acpi_button_notify(acpi_handle handle, u3=
2 event, void *data)
>
>         acpi_pm_wakeup_event(button->dev);
>
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->suspend=
ed)
> +               button->wakeup_pending =3D true;
> +
>         if (button->suspended || event =3D=3D ACPI_BUTTON_NOTIFY_WAKE)
>                 return;
>
> @@ -498,6 +530,11 @@ static void acpi_button_notify_run(void *data)
>
>  static u32 acpi_button_event(void *data)
>  {
> +       struct acpi_button *button =3D data;
> +
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->suspend=
ed)
> +               button->wakeup_pending =3D true;
> +
>         acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data)=
;
>         return ACPI_INTERRUPT_HANDLED;
>  }
> @@ -507,6 +544,12 @@ static int acpi_button_suspend(struct device *dev)
>  {
>         struct acpi_button *button =3D dev_get_drvdata(dev);
>
> +       /*
> +        * Clear wakeup_pending before marking suspended. Otherwise a pow=
er
> +        * button SCI between the two stores could set wakeup_pending and=
 then
> +        * be overwritten here, losing a real wakeup.
> +        */
> +       button->wakeup_pending =3D false;
>         button->suspended =3D true;
>         return 0;
>  }
> @@ -523,12 +566,13 @@ static int acpi_button_resume(struct device *dev)
>                 acpi_lid_initialize_state(button);
>         }
>
> -       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER) {
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->wakeup_=
pending) {
>                 input =3D button->input;
>                 input_report_key(input, KEY_WAKEUP, 1);
>                 input_sync(input);
>                 input_report_key(input, KEY_WAKEUP, 0);
>                 input_sync(input);
> +               button->wakeup_pending =3D false;
>         }
>         return 0;
>  }
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 132a9df98471..30e268987e37 100644
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
> @@ -504,12 +505,11 @@ static void acpi_pm_finish(void)
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
> +        * via wakeup_pending; do not synthesize KEY_POWER here.
> +        */
>         if (!pwr_btn_event_pending)
>                 return;
>
> @@ -626,14 +626,11 @@ static int acpi_suspend_enter(suspend_state_t pm_st=
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
> +        * so the event does not reach userspace as KEY_POWER. Remember t=
hat a
> +        * power-button wake occurred so button resume can report KEY_WAK=
EUP
> +        * and acpi_pm_finish() can emit a PM wakeup event.
>          */
>         if (ACPI_SUCCESS(status) && (acpi_state =3D=3D ACPI_STATE_S3)) {
>                 acpi_event_status pwr_btn_status =3D ACPI_EVENT_FLAG_DISA=
BLED;
> @@ -642,8 +639,8 @@ static int acpi_suspend_enter(suspend_state_t pm_stat=
e)
>
>                 if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
>                         acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> -                       /* Flag for later */
>                         pwr_btn_event_pending =3D true;
> +                       acpi_button_power_wakeup_pending();
>                 }
>         }
>
> diff --git a/include/acpi/button.h b/include/acpi/button.h
> index af2fce5d2ee3..c909c00664c7 100644
> --- a/include/acpi/button.h
> +++ b/include/acpi/button.h
> @@ -15,4 +15,17 @@ static inline int acpi_lid_open(void)
>  }
>  #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
>
> +/*
> + * sleep.c is built-in and calls this helper. Use IS_REACHABLE so that w=
hen
> + * CONFIG_ACPI_BUTTON=3Dm the call site gets an inline stub instead of a=
n
> + * unresolved vmlinux link reference (0day/LKP ERROR).
> + */
> +#if IS_REACHABLE(CONFIG_ACPI_BUTTON)
> +extern void acpi_button_power_wakeup_pending(void);
> +#else
> +static inline void acpi_button_power_wakeup_pending(void)
> +{
> +}
> +#endif /* IS_REACHABLE(CONFIG_ACPI_BUTTON) */
> +
>  #endif /* ACPI_BUTTON_H */
>
> base-commit: 4a819ee5f2834330656d6ac168c4c8cf27fdeec2
> --
> 2.34.1
>
