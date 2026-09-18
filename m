Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8239CCF4
	for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742282; cv=none; b=Xdtas5jSI/LZOjxvfPOhrH0eq9Ga0tVwTaxj8xJCsNVSJMYoVkd8s6o2qNhoZwrgNgfqlLSWtd3nPzJpa8suABvr31lmn3UdiMJ7C3HcLX+eHNmL/VdNgcJbXjYV4cYK3Q9w30X+BngKfRCV8HKLluapACvJ+/ciGwOVz8j8B2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742282; c=relaxed/simple;
	bh=4ZilZJNHHY87uCtwLNAsqLEpobd2WFMMgoU4Rj3aqPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVu+zD0YPDC9LVhQ0vVDkaNP1T/GS0Qk4H/Du2lm0zN9GVq6Ol9ZZABcMlsJ5jugMVeWqjWDUXiPz1EW76yvHB8fK74RKxNT5dR/ClTd8iNClweEj6vn4ar7siaFUriY2/IBwmH3rBk6QNZ5iOvEJaDoqh0ACokKD7UeUzC74go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2dv6BPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2dv6BPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708341F0089A
	for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2026 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742280;
	bh=KBw1bExSXtsJEi/GDDkJ47SHkVdg0QHT3EHGaCOfe8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m2dv6BPyx3Zy0FMn6TPuVg7/QX11VEhW37M9oxxdKp0jNtCn17z/OrIpFaV/c10vJ
	 Wb8255I3NUyDZSP0NtNYbHkOgKimMPPu9LGMjgs1XaFefwD5l11n58XV94KQoFi0FY
	 OdoEUzjtdG3sOL5VhWAjcV7u6opNo3CXZh5pWdJLny8dJ2wqQgBEjxt6d8tdncdY0X
	 r2yUAJOFHG7mpFrxJcr9xDqYaz/OteVE3u9Ybb1TIZOdtVDokQ6svAY8y4tG5byVI0
	 mH/b1Tlk+H/xlq0fv9GEPDU/QL7VR9podspu67YlGNX46TjUsu6ZzgK+uMw0+iwh49
	 JQ0nzmAcAd+0Q==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d4688decso8098681fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2026 07:38:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwYk9ckCB4p5goE3WjQ2npyET4QGr4lTEQqNRGZd78YU420FGrn9n/ZLU5pPMNhpQndICBC2Al+RdO/@vger.kernel.org
X-Gm-Message-State: AFuF++kHiu/ws0Ztxwh22kHGBnRCj3kEQsNBVnRgh4JKbjk+8EKvnLHh
	8e95f+8Oni6P5CxIN57G7YgJTqNnNxdIsa56kvXMSdxoesaETtXcxYjRTKAZMfq/EE/izSAEG3o
	G6XJPpi2uHfnsRZJ1IidNtT6kiM7ttVE=
X-Received: by 2002:a2e:be1b:0:b0:39a:da70:2c77 with SMTP id
 38308e7fff4ca-3a5fbf05d53mr6133881fa.3.1789742278585; Fri, 18 Sep 2026
 07:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819085528.575-2-baorliu@amd.com> <20260917143116.445-1-baorliu@amd.com>
In-Reply-To: <20260917143116.445-1-baorliu@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 18 Sep 2026 16:36:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jb7QNF32To0AoOBxXHObUAS7QCrFAGObFJU1=VtOqm+w@mail.gmail.com>
X-Gm-Features: AcwNN1V21dznaWjpABNHjALTzsqliOCTgu4KiEbEf1Vn8RT6Yw4NYIp6-UdFsSY
Message-ID: <CAJZ5v0jb7QNF32To0AoOBxXHObUAS7QCrFAGObFJU1=VtOqm+w@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: button: Report wakeup key only for power button wakeups
To: "Baorui.Liu" <baorliu@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 4:31=E2=80=AFPM Baorui.Liu <baorliu@amd.com> wrote:
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

Please see

https://sashiko.dev/#/patchset/20260917143116.445-1-baorliu%40amd.com

and tell me what you think.

Thanks!

> ---
>  drivers/acpi/button.c | 13 ++++++++++++-
>  drivers/acpi/sleep.c  | 41 -----------------------------------------
>  2 files changed, 12 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cdbb1023a8ee..7a708fe351fb 100644
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
> @@ -476,6 +477,9 @@ static void acpi_button_notify(acpi_handle handle, u3=
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
> @@ -498,6 +502,11 @@ static void acpi_button_notify_run(void *data)
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
> @@ -508,6 +517,7 @@ static int acpi_button_suspend(struct device *dev)
>         struct acpi_button *button =3D dev_get_drvdata(dev);
>
>         button->suspended =3D true;
> +       button->wakeup_pending =3D false;
>         return 0;
>  }
>
> @@ -523,12 +533,13 @@ static int acpi_button_resume(struct device *dev)
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
> index 132a9df98471..7296e4bb0e4d 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -104,8 +104,6 @@ u32 acpi_target_system_state(void)
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
> @@ -484,7 +482,6 @@ static int acpi_pm_prepare(void)
>   */
>  static void acpi_pm_finish(void)
>  {
> -       struct acpi_device *pwr_btn_adev;
>         u32 acpi_state =3D acpi_target_sleep_state;
>
>         acpi_ec_unblock_transactions();
> @@ -503,23 +500,6 @@ static void acpi_pm_finish(void)
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
> -               acpi_dev_put(pwr_btn_adev);
> -       }
>  }
>
>  /**
> @@ -626,27 +606,6 @@ static int acpi_suspend_enter(suspend_state_t pm_sta=
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
> --
> 2.34.1
>
