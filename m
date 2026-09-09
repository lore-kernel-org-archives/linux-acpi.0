Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1029550DB2
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964949; cv=none; b=OOuoEYO5Dg30FalCAZ4KQErioYCIkrlRwTi8VRz/qcqkyHdIXuRZZCmU77gxNkNWks4Vi/O+lr36Ksh5AAkJqdlUXwlGC/UMzXwVv4NR+fxECfCrR1q4sLuhrolk1Yggnx6p0VOmtbLADkZgJtcHs2vKr1dgixwEkrNJ7Vhb5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964949; c=relaxed/simple;
	bh=dvPDYFwQ8RintGRd0HTntD2Yww6HkOurQpSlnULPxDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMwWYQaAcpqaCLODpeontrIwuckvUsbTHYDWUMs09MJDoeuY9iD7bHri34BAgCzvKWnYvqQKoMXVzFnJGBgCRzz7PtbPkWjPRD5mbrTkYwmBr4C7IqzsXY7FWNN8nnt3mtW5fiu8HMhoV11BE9vVuSHHQCpdvRHkc5+RiA1mlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPpCHEix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPpCHEix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501A51F00A3F
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964947;
	bh=fh3WnRyJQ9LMq3PODuE5LGdezgqZCEn8MJmFbIl2+yY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fPpCHEixX1RLo4IpLv84CazUr3DnrpNH2H1LdBBG52BoUV+iKk8xv13XuMBT+F7Nu
	 6RBLn+SymQ1f3HFgT/9Zxf9i+hI35Ax9OWtDk1BXYP+vFxHe1zG7c8TLkejgtrscQW
	 2gNurilH6a0omvPOeY/I9qJa1bgeagipZ3X9f66IIuk3Iy74FkusqqxpLreLR4+Cel
	 ltJycXdM618YbEnduCwf9mFHTqDyIcnTtR8fxOOidJ8VoY2zCDXl8qYXyF/BdpTB7U
	 62HGDFRrWvzw5stZ4dIqjVLIEPITuP/EO2jDSFQJ7HpJrsOeprztgVwvxhJT0Q/pia
	 hPjG5HtEVLiPQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b4afc8465eso8200881e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 07:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxiKbGZx7oXkybpYtxfaLsWVTaE2BBd8XUMxiPPrTvt4eYoKrjwe9vHJeZgzkelVABPRE6UGv0y6aIp@vger.kernel.org
X-Gm-Message-State: AFuF++mJ4pVHtnn92UXXXHlQAGjGiX3VCTb+879TiQHglRB43weQxBfR
	asJ+GM1Z2cAtIl3kXcciB+/w9tDtZMZ4h5M2fR/D7m4EvbiCzgaIacyz2YsnqeDY77tdSHdjroe
	1evd9DoLDQzUdxI8vOHWpzwsh6cMBoG8=
X-Received: by 2002:a05:6512:23a5:b0:5b6:6b8:1fc5 with SMTP id
 2adb3069b0e04-5b616f5a434mr6190885e87.17.1788964945569; Wed, 09 Sep 2026
 07:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806122732.533-1-baorliu@amd.com> <20260819085528.575-1-baorliu@amd.com>
 <20260819085528.575-2-baorliu@amd.com>
In-Reply-To: <20260819085528.575-2-baorliu@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 16:41:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCS9r4eN4XoEsuJKPED=xdQXOvV72OOkrCZpLqui6oSw@mail.gmail.com>
X-Gm-Features: AcwNN1UN-21r50zcJGP317drOXU6Y5TqW0M5AQBFuMKIX8k1zzAv6DTnJSyJteI
Message-ID: <CAJZ5v0hCS9r4eN4XoEsuJKPED=xdQXOvV72OOkrCZpLqui6oSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: button: Report wakeup key only for power
 button wakeups
To: "Baorui.Liu" <baorliu@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 10:56=E2=80=AFAM Baorui.Liu <baorliu@amd.com> wrote=
:
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
> case. Do not synthesize a Power Button input event from generic ACPI
> sleep resume code.
>
> Signed-off-by: Baorui.Liu <baorliu@amd.com>

This doesn't apply on top of 7.3-rc2 for me, so please rebase and resend it=
.

When you resend it, don't add a cover letter (cover letters are only
needed for patch series, not for individual patches).  If there is
information in the cover letter that is not covered by the patch
changelog, it can be copied there.

Thanks!

> ---
>  drivers/acpi/button.c | 38 ++++++++++++++++-------------
>  drivers/acpi/sleep.c  | 56 +++----------------------------------------
>  include/acpi/button.h |  5 ----
>  3 files changed, 24 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 8d2843bece29..f9b6b7fff5bd 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -175,6 +175,7 @@ struct acpi_button {
>         int last_state;
>         ktime_t last_time;
>         bool suspended;
> +       bool wakeup_pending;
>         bool lid_state_initialized;
>  };
>
> @@ -452,6 +453,9 @@ static void acpi_button_notify(acpi_handle handle, u3=
2 event, void *data)
>         acpi_pm_wakeup_event(&device->dev);
>
>         button =3D acpi_driver_data(device);
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->suspend=
ed)
> +               button->wakeup_pending =3D true;
> +
>         if (button->suspended)
>                 return;
>
> @@ -468,23 +472,6 @@ static void acpi_button_notify(acpi_handle handle, u=
32 event, void *data)
>                                         event, ++button->pushed);
>  }
>
> -void acpi_power_button_wakeup(struct acpi_device *device)
> -{
> -       struct acpi_button *button =3D acpi_driver_data(device);
> -       struct input_dev *input;
> -
> -       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER) {
> -               input =3D button->input;
> -               input_report_key(input, KEY_WAKEUP, 1);
> -               input_sync(input);
> -               input_report_key(input, KEY_WAKEUP, 0);
> -               input_sync(input);
> -       }
> -
> -       return;
> -}
> -EXPORT_SYMBOL(acpi_power_button_wakeup);
> -
>  static void acpi_button_notify_run(void *data)
>  {
>         acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
> @@ -492,6 +479,12 @@ static void acpi_button_notify_run(void *data)
>
>  static u32 acpi_button_event(void *data)
>  {
> +       struct acpi_device *device =3D data;
> +       struct acpi_button *button =3D acpi_driver_data(device);
> +
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->suspend=
ed)
> +               button->wakeup_pending =3D true;
> +
>         acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data)=
;
>         return ACPI_INTERRUPT_HANDLED;
>  }
> @@ -503,11 +496,13 @@ static int acpi_button_suspend(struct device *dev)
>         struct acpi_button *button =3D acpi_driver_data(device);
>
>         button->suspended =3D true;
> +       button->wakeup_pending =3D false;
>         return 0;
>  }
>
>  static int acpi_button_resume(struct device *dev)
>  {
> +       struct input_dev *input;
>         struct acpi_device *device =3D to_acpi_device(dev);
>         struct acpi_button *button =3D acpi_driver_data(device);
>
> @@ -518,6 +513,15 @@ static int acpi_button_resume(struct device *dev)
>                 acpi_lid_initialize_state(device);
>         }
>
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->wakeup_=
pending) {
> +               input =3D button->input;
> +               input_report_key(input, KEY_WAKEUP, 1);
> +               input_sync(input);
> +               input_report_key(input, KEY_WAKEUP, 0);
> +               input_sync(input);
> +               button->wakeup_pending =3D false;
> +       }
> +
>         return 0;
>  }
>  #endif
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 0adfcd0fb55e..d655248c20d4 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -22,7 +22,6 @@
>  #include <linux/syscore_ops.h>
>  #include <asm/io.h>
>  #include <trace/events/power.h>
> -#include <acpi/button.h>
>
>  #include "internal.h"
>  #include "sleep.h"
> @@ -105,8 +104,6 @@ u32 acpi_target_system_state(void)
>  }
>  EXPORT_SYMBOL_GPL(acpi_target_system_state);
>
> -static bool pwr_btn_event_pending;
> -
>  /*
>   * The ACPI specification wants us to save NVS memory regions during hib=
ernation
>   * and to restore them during the subsequent resume.  Windows does that =
also for
> @@ -463,7 +460,6 @@ static int acpi_pm_prepare(void)
>   */
>  static void acpi_pm_finish(void)
>  {
> -       struct acpi_device *pwr_btn_adev;
>         u32 acpi_state =3D acpi_target_sleep_state;
>
>         acpi_ec_unblock_transactions();
> @@ -482,24 +478,6 @@ static void acpi_pm_finish(void)
>         acpi_target_sleep_state =3D ACPI_STATE_S0;
>
>         acpi_resume_power_resources();
> -
> -       /* If we were woken with the fixed power button, provide a small
> -        * hint to userspace in the form of a wakeup event on the fixed p=
ower
> -        * button device (if it can be found).
> -        *
> -        * We delay the event generation til now, as the PM layer require=
s
> -        * timekeeping to be running before we generate events. */
> -       if (!pwr_btn_event_pending)
> -               return;
> -
> -       pwr_btn_event_pending =3D false;
> -       pwr_btn_adev =3D acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POW=
ERF,
> -                                                   NULL, -1);
> -       if (pwr_btn_adev) {
> -               pm_wakeup_event(&pwr_btn_adev->dev, 0);
> -               acpi_power_button_wakeup(pwr_btn_adev);
> -               acpi_dev_put(pwr_btn_adev);
> -       }
>  }
>
>  /**
> @@ -604,27 +582,6 @@ static int acpi_suspend_enter(suspend_state_t pm_sta=
te)
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
> -        */
> -       if (ACPI_SUCCESS(status) && (acpi_state =3D=3D ACPI_STATE_S3)) {
> -               acpi_event_status pwr_btn_status =3D ACPI_EVENT_FLAG_DISA=
BLED;
> -
> -               acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_s=
tatus);
> -
> -               if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
> -                       acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> -                       /* Flag for later */
> -                       pwr_btn_event_pending =3D true;
> -               }
> -       }
> -
>         /*
>          * Disable all GPE and clear their status bits before interrupts =
are
>          * enabled. Some GPEs (like wakeup GPEs) have no handlers and thi=
s can
> @@ -797,19 +754,12 @@ bool acpi_s2idle_wake(void)
>
>  void acpi_s2idle_restore_check_powerkey(void)
>  {
> -       struct acpi_device *pwr_btn_adev;
>         acpi_event_status pwr_btn_status =3D ACPI_EVENT_FLAG_DISABLED;
> +
>         acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
>
> -       if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
> -               pwr_btn_adev =3D acpi_dev_get_first_match_dev(ACPI_BUTTON=
_HID_POWERF,
> -                       NULL, -1);
> -               if (pwr_btn_adev) {
> -                       pm_wakeup_event(&pwr_btn_adev->dev, 0);
> -                       acpi_power_button_wakeup(pwr_btn_adev);
> -                       acpi_dev_put(pwr_btn_adev);
> -               }
> -       }
> +       if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET)
> +               acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
>  }
>
>  void acpi_s2idle_restore(void)
> diff --git a/include/acpi/button.h b/include/acpi/button.h
> index be02d3ff2896..af2fce5d2ee3 100644
> --- a/include/acpi/button.h
> +++ b/include/acpi/button.h
> @@ -8,16 +8,11 @@
>
>  #if IS_ENABLED(CONFIG_ACPI_BUTTON)
>  extern int acpi_lid_open(void);
> -extern void acpi_power_button_wakeup(struct acpi_device *device);
>  #else
>  static inline int acpi_lid_open(void)
>  {
>         return 1;
>  }
> -static inline void acpi_power_button_wakeup(struct acpi_device *device)
> -{
> -       return;
> -}
>  #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
>
>  #endif /* ACPI_BUTTON_H */
> --
> 2.34.1
>
