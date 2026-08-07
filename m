Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E5340280
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111970; cv=none; b=m7pBwlseGqs2sq5mSOvCk6aJv6+9r8of1Nclo6TtpPlWW9DuL5s9xdJR4Qo3gqVlFy7HehuzxyFSxV8Yq5FlIuAZj/ou6lUQUuqlmiogEJBcpF8/z4b1TN7TiiPuGyVCv9TpvsuB6UtGCN930LU7VmBSrGufDCxWd9P9gbIOC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111970; c=relaxed/simple;
	bh=OIaD/Mi7SOlolhAA46mA4zpn6Wu8tMT9nZKkH0mlhb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFtKWl7fn5iwq4zqy81s2btex3QSA2c2ZOCjg6ntX9xqx2CHikX3m3yJCcpCTzYPHKv7zr3PQZ0ShuK8Y6PSXLC8rOWYdkNWBHzwh+5uuSAD0d51tC5Bpfqgx+G6JHxbyG3tXRZ8VWY+yES+tDmQhqeyO+EnK7PCR+iYaZSmVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfOQyojD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfOQyojD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB31F00A3D
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786111965;
	bh=pXvVKfNQMMuwXjlce+18+h5QJMFg5pG10/CntClGMBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lfOQyojDqvBooE7ANP7Gp9HdFipEf0i8/icrrEkdKpGNlbRa9dFJCYHnjCQ037BKo
	 UiwW7YAhmLzUKN8w2BhOOIoEURzJ6QQLdIzpBUGIGMtyuHmlRpOI+k97OdJ1QOrILL
	 KXYJWUo52r+W5RrBIHpK9XKcF/ACMX1MAZOcWl/GX8V/U6iSI1kfYEu8YjYHk9fBFt
	 NWtEiTqhE0QRxiQcJUtkr0KDFDpLcUaG46S5dp5rq97KSFzUSRAMBnWzklV5y7G2rU
	 GH5IWNKpCZJk2+rlReJmiEHCG8H/ux8EKrGMNCtKh3O5v9I3nUmvw7u3yZONe/pzsp
	 DjBYg4Qt+lArg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so3198586e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 07:12:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RofsycnSw4cdandYOxMBxnnhjeOCUV5Dq4eF2jn0mUV4wmGSOyNUfha9pvncnZDwxyFLVGDvSvzv3hv@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQEouctBUhfU0F3MBJvNEi0idR6vIHV/ktpwMNQjS3G0szqed
	9ANpth7TCUzE03SVL34JzdYgDKrDV2ggwcxQL+nak6c5Zal1rgZVObUZLkYPmcYHPTVHvvwsvLO
	cSe0P3D5Vn3UK5RsCq11ZAkHPIN5//Dk=
X-Received: by 2002:a05:6512:304a:b0:5b2:a6eb:ff2f with SMTP id
 2adb3069b0e04-5b30b786252mr83259e87.43.1786111964210; Fri, 07 Aug 2026
 07:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806122732.533-1-baorliu@amd.com>
In-Reply-To: <20260806122732.533-1-baorliu@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 16:12:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gY8TZUDfAvj7WPfVJNyY0PXOEVO1SOSUpuZXV87mpoJA@mail.gmail.com>
X-Gm-Features: AUfX_mzySQLWrRT5rPulQjaWJpOnss-Yt6t9hXP39p6nQVi_sW6Gk8FRSJO6tpU
Message-ID: <CAJZ5v0gY8TZUDfAvj7WPfVJNyY0PXOEVO1SOSUpuZXV87mpoJA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Report wakeup key only for power button wakeups
To: Baorui Liu <baorliu@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 2:28=E2=80=AFPM Baorui Liu <baorliu@amd.com> wrote:
>
> Commit 16f70feaabe9 ("ACPI: button: trigger wakeup key events")
> makes the ACPI power button driver report KEY_WAKEUP from its resume
> callback. However, that callback is run whenever the ACPI button device
> is resumed, regardless of the actual system wakeup source.
>
> As a result, userspace may receive a KEY_WAKEUP event after resumes
> caused by unrelated wakeup sources.

So why is this a problem in practice?

> Avoid reporting the input event from acpi_button_resume(). Instead,
> report it only when the ACPI fixed power button status indicates that
> the power button was the wakeup source.

But power buttons need not be fixed event devices and there are also
sleep buttons that can generate KEY_WAKEUP, and what about lids?

> Fixes: 16f70feaabe9 ("ACPI: button: trigger wakeup key events")
> Signed-off-by: Baorui Liu <baorliu@amd.com>
> ---
>  drivers/acpi/button.c     | 23 +++++++++++++++--------
>  drivers/acpi/sleep.c      | 21 +++++++++++++++++++++
>  drivers/acpi/sleep.h      |  1 +
>  drivers/acpi/x86/s2idle.c |  4 +++-
>  include/acpi/button.h     |  5 +++++
>  5 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 3836ee75dd66..700510f6e5d0 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -480,6 +480,21 @@ static void acpi_button_notify(acpi_handle handle, u=
32 event, void *data)
>                                         event, ++button->pushed);
>  }
>
> +void acpi_power_button_wakeup(struct acpi_device *device)
> +{
> +       struct acpi_button *button =3D acpi_driver_data(device);
> +       struct input_dev *input;
> +
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER) {
> +               input =3D button->input;
> +               input_report_key(input, KEY_WAKEUP, 1);
> +               input_sync(input);
> +               input_report_key(input, KEY_WAKEUP, 0);
> +               input_sync(input);
> +       }
> +}
> +EXPORT_SYMBOL(acpi_power_button_wakeup);
> +
>  static void acpi_button_notify_run(void *data)
>  {
>         acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
> @@ -503,7 +518,6 @@ static int acpi_button_suspend(struct device *dev)
>  static int acpi_button_resume(struct device *dev)
>  {
>         struct acpi_button *button =3D dev_get_drvdata(dev);
> -       struct input_dev *input;
>
>         button->suspended =3D false;
>         if (button->type =3D=3D ACPI_BUTTON_TYPE_LID) {
> @@ -512,13 +526,6 @@ static int acpi_button_resume(struct device *dev)
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
> index 132a9df98471..26bbecd0c166 100644
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
> @@ -518,6 +519,7 @@ static void acpi_pm_finish(void)
>                                                     NULL, -1);
>         if (pwr_btn_adev) {
>                 pm_wakeup_event(&pwr_btn_adev->dev, 0);
> +               acpi_power_button_wakeup(pwr_btn_adev);
>                 acpi_dev_put(pwr_btn_adev);
>         }
>  }
> @@ -818,6 +820,24 @@ bool acpi_s2idle_wake(void)
>         return false;
>  }
>
> +void acpi_s2idle_restore_check_powerkey(void)
> +{
> +       struct acpi_device *pwr_btn_adev;
> +       acpi_event_status pwr_btn_status =3D ACPI_EVENT_FLAG_DISABLED;
> +
> +       acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
> +
> +       if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
> +               pwr_btn_adev =3D acpi_dev_get_first_match_dev(ACPI_BUTTON=
_HID_POWERF,
> +                                                           NULL, -1);
> +               if (pwr_btn_adev) {
> +                       pm_wakeup_event(&pwr_btn_adev->dev, 0);
> +                       acpi_power_button_wakeup(pwr_btn_adev);
> +                       acpi_dev_put(pwr_btn_adev);
> +               }
> +       }
> +}
> +
>  void acpi_s2idle_restore(void)
>  {
>         /*
> @@ -849,6 +869,7 @@ static const struct platform_s2idle_ops acpi_s2idle_o=
ps =3D {
>         .begin =3D acpi_s2idle_begin,
>         .prepare =3D acpi_s2idle_prepare,
>         .wake =3D acpi_s2idle_wake,
> +       .restore_early =3D acpi_s2idle_restore_check_powerkey,
>         .restore =3D acpi_s2idle_restore,
>         .end =3D acpi_s2idle_end,
>  };
> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
> index 9c3cb109c5d2..50382c90446c 100644
> --- a/drivers/acpi/sleep.h
> +++ b/drivers/acpi/sleep.h
> @@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wa=
keup_address)
>  extern int acpi_s2idle_begin(void);
>  extern int acpi_s2idle_prepare(void);
>  extern bool acpi_s2idle_wake(void);
> +extern void acpi_s2idle_restore_check_powerkey(void);
>  extern void acpi_s2idle_restore(void);
>  extern void acpi_s2idle_end(void);
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index b6b1dd76a06b..ce6663c1ef70 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -598,8 +598,10 @@ static void acpi_s2idle_restore_early_lps0(void)
>  {
>         struct acpi_s2idle_dev_ops *handler;
>
> -       if (!lps0_device_handle || sleep_no_lps0)
> +       if (!lps0_device_handle || sleep_no_lps0) {
> +               acpi_s2idle_restore_check_powerkey();
>                 return;
> +       }
>
>         list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node)
>                 if (handler->restore)
> diff --git a/include/acpi/button.h b/include/acpi/button.h
> index af2fce5d2ee3..3cbf3272371e 100644
> --- a/include/acpi/button.h
> +++ b/include/acpi/button.h
> @@ -8,11 +8,16 @@
>
>  #if IS_ENABLED(CONFIG_ACPI_BUTTON)
>  extern int acpi_lid_open(void);
> +extern void acpi_power_button_wakeup(struct acpi_device *device);
>  #else
>  static inline int acpi_lid_open(void)
>  {
>         return 1;
>  }
> +
> +static inline void acpi_power_button_wakeup(struct acpi_device *device)
> +{
> +}
>  #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
>
>  #endif /* ACPI_BUTTON_H */
>
> base-commit: 4d823c9d06aaa91476b58e56e4d44c4112da2811
> --
> 2.34.1
>
