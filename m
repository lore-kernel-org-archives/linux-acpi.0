Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4073488D8D
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912832; cv=none; b=ouXZaUEeoR5krEKbf2b5XVHgGuWon9hI4vux+93ZtD4pi77J34PTKXQNeeiXK96EqoWGRc66/jxCYpeudErC1HV5+8+Q/7p+p+LkDiuW5FhJkTOP5dghJrhJbvsVZ7aEwf2Vn/aPzWvottrbcZ5JgJFzGbHph8sMKeE6XwuQodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912832; c=relaxed/simple;
	bh=8PdWjod07bHKZwUVHLIgVKm3jr0Xu6hUYREqyJ3XlFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayQWu9IGP9FUnQ6YLG5uirGp9wm+qbWUWU7hO3eQngBR52PiRpmfm1IqAxs/weA/q9h5fXGgVGIC79BqWH6xvpOcXElYXJOjmDjkLs8iLcmW1yYvq+ieHs0kLL4vW9q+avXZ9uuxEyHFrbK7wHSdzYwfJtjGcnTe2cLRX990ha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTFWJnbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTFWJnbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6079A1F0089B
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912830;
	bh=6awH/vbnBHcu26jrXfWlQmHVLGeEP4ZBKf9jZGLzBIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PTFWJnbMA4+bEKWldAUflmX5j2RwFNi4/UnAoyDNoVDOazqTbIjD9MMwXSvnCHZGa
	 fkdJl6q9IZDWa1qvbnTIbzE0Kg2e5UPwhYghe7JYWhIL2eM4ogYFeuBsQTleby6Im4
	 I+qezXDcll/ewbmkcqF//u2UvWfmMzy+piv+qIOfkp+di6+MV/81BI3R07IJynfbGd
	 hKM1n5va081aKAE0nH+pjCJfZm6AkRUhHXU0puPIBaaWYcDmPUxvLnu3s/9no6dIsm
	 t6I/5W2/L9oQXw7QiXn0XCTQVE4esF0LBlmIDxjuuyTxIHlQiVDatV1+Vhe8RW7hRC
	 q39m1tuWN6mCg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcdab9a82bso3646067e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 10:33:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz4CzIyhoyfM7axjQnUoISEwdcxcl8Yf/nIvz64nnXK7XUMrqjD0RlWrqkPOrPNmlzz15J9dXbEzRc8@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0DbnUMcs57dwoBAXcj5ngxWR+sEX1Qb3b9nmd5loBtANKtuMm
	+aruZf0UmIuRyx+PddGEFs9n0GvzfdlqYbkpe88uvZI0SDbYD/gTnZgmMb7h+GNihxY32EpKqex
	MFYd89iEC4WAq6wYAUb/IMqLa6CJvdGY=
X-Received: by 2002:a05:6512:3a95:b0:5b2:1de0:5ea2 with SMTP id
 2adb3069b0e04-5bcde6bdf43mr4782005e87.16.1791912828699; Tue, 13 Oct 2026
 10:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013063856.1755787-1-liujinlong176@163.com>
In-Reply-To: <20261013063856.1755787-1-liujinlong176@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 19:31:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4tFgMMw_y4+ZnM+z9kocnnFPR6zpOk3Q42TQvi+EMLw@mail.gmail.com>
X-Gm-Features: AclHuK-7KDiwa_4uvqa0A04Agt1etoSv_btEyf-H2k55xkIwAscnz-TuH39ci5s
Message-ID: <CAJZ5v0j4tFgMMw_y4+ZnM+z9kocnnFPR6zpOk3Q42TQvi+EMLw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Support separate press and release events
To: liujinlong176@163.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liujinlong <liujinlong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:39=E2=80=AFAM <liujinlong176@163.com> wrote:
>
> From: liujinlong <liujinlong@kylinos.cn>
>
> The ACPI button driver only recognizes notify value 0x80 and
> always synthesizes a press followed by an immediate release.
> This makes it impossible for userspace to determine the actual
> duration of a power button press.
>
> Add two new notify values, 0x81 and 0x82, that firmware can use
> to report the press and the release separately.  The 0x80 path
> is unchanged for compatibility with existing firmware.

You'd need to update the ACPI specification first as that's where the
notification values are defined.

> Move the notify value definitions to include/acpi/button.h so
> they can be shared between the driver and other users.
>
> Signed-off-by: liujinlong <liujinlong@kylinos.cn>
> ---
>  drivers/acpi/button.c | 24 ++++++++++++++++++------
>  include/acpi/button.h |  4 ++++
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cdbb1023a8ee..b72ed9fc429d 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -26,7 +26,6 @@
>  #define ACPI_BUTTON_FILE_STATE         "state"
>  #define ACPI_BUTTON_TYPE_UNKNOWN       0x00
>  #define ACPI_BUTTON_NOTIFY_WAKE                0x02
> -#define ACPI_BUTTON_NOTIFY_STATUS      0x80
>
>  #define ACPI_BUTTON_CLASS_POWER                "button/power"
>  #define ACPI_BUTTON_DEVICE_NAME_POWER  "Power Button"
> @@ -465,7 +464,8 @@ static void acpi_button_notify(acpi_handle handle, u3=
2 event, void *data)
>
>         switch (event) {
>         case ACPI_BUTTON_NOTIFY_STATUS:
> -               break;
> +       case ACPI_BUTTON_NOTIFY_PRESS:
> +       case ACPI_BUTTON_NOTIFY_RELEASE:
>         case ACPI_BUTTON_NOTIFY_WAKE:
>                 break;
>         default:
> @@ -482,10 +482,22 @@ static void acpi_button_notify(acpi_handle handle, =
u32 event, void *data)
>         input =3D button->input;
>         keycode =3D test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_=
POWER;
>
> -       input_report_key(input, keycode, 1);
> -       input_sync(input);
> -       input_report_key(input, keycode, 0);
> -       input_sync(input);
> +       switch (event) {
> +       case ACPI_BUTTON_NOTIFY_STATUS:
> +               input_report_key(input, keycode, 1);
> +               input_sync(input);
> +               input_report_key(input, keycode, 0);
> +               input_sync(input);
> +               break;
> +       case ACPI_BUTTON_NOTIFY_PRESS:
> +               input_report_key(input, keycode, 1);
> +               input_sync(input);
> +               break;
> +       case ACPI_BUTTON_NOTIFY_RELEASE:
> +               input_report_key(input, keycode, 0);
> +               input_sync(input);
> +               break;
> +       }
>
>         acpi_bus_generate_netlink_event(button->class, dev_name(&device->=
dev),
>                                         event, ++button->pushed);
> diff --git a/include/acpi/button.h b/include/acpi/button.h
> index af2fce5d2ee3..832f1a308828 100644
> --- a/include/acpi/button.h
> +++ b/include/acpi/button.h
> @@ -6,6 +6,10 @@
>  #define ACPI_BUTTON_HID_LID    "PNP0C0D"
>  #define ACPI_BUTTON_HID_SLEEP  "PNP0C0E"
>
> +#define ACPI_BUTTON_NOTIFY_STATUS      0x80
> +#define ACPI_BUTTON_NOTIFY_PRESS       0x81
> +#define ACPI_BUTTON_NOTIFY_RELEASE     0x82
> +
>  #if IS_ENABLED(CONFIG_ACPI_BUTTON)
>  extern int acpi_lid_open(void);
>  #else
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
