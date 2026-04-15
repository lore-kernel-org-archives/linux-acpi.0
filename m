Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EB2848A7
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273077; cv=none; b=sbtX0ll3vH7+o2hRHFw7lNLRjbJgNrPlZCmeXcA7X6j30McnwEtfByvsRAKHkpWiP8hE04dbehGcvHUA7LAztSaxxqlReFvFicghqEU+EqAgS6DLISZGYC4SWAT6Q30FpCLz0PvaWEMC33DDjZ07lXHNgXEUQTQQWz2jZMH3jPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273077; c=relaxed/simple;
	bh=RbYKVXex9oaQ86R9gVx0D5AHNtQ6HIyiOkjBKaEEM3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avnTQIw/R8y4G/8dGclpWoWS0izAlCQoAhU36SSaQk9nbxOBYTKMqlaCHPKU5wAE5yHjXG9fT8g5/fFJhXkVcywmMNS2EO5GCqHtzx+m8UxpPH9Iimhm5AXIYVqX/seYJrOX4SCe0LNE1q9av8sDeapqEi4eDl7LMdNnaxdtNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS1pzTTm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS1pzTTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5146C19424
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776273076;
	bh=RbYKVXex9oaQ86R9gVx0D5AHNtQ6HIyiOkjBKaEEM3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SS1pzTTm9tqJsJdiUcHR0OAnlaSZNDnZyUjswYaN3+30eqVjvifxfYEHfDF3v8KSC
	 Ft1OMPz7cUFpQv+RNdbeFa5wvE5jAslOP1QJELbzRKV6lRYBik+BLXrUGcwqGlazyP
	 0m8VEYDj4CAIzfOy/5tx2HWTy3BvBwQXcACLqL0OubDIgIFjnGyCDjMzC/vtqKgT+C
	 R387j3ynlBOK8qh+5ktiE5mTPPIL9W7m5CVUfEw8IPWqe07ucpempx5QEH9HpDVPbx
	 YQyYAdW054L/BYjj1yMa+GBvMO95ZTfrk8yDAX2z4bJvdNO/8p6nKipFjxl3WOOTQE
	 08sV0tOkdTi9g==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4779b2497b4so3757872b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 10:11:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ZlJEa3SvN8amGLvJOe6bGhbrDsZM3gIwWucEKt7C/D3enfkeHaLazeE12uvqb08D5U4Sdzt8ihSgg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/nWiIUYXwh6NgW7r7jQoiOhE1xbeTNC4cPAQX8XvYN4oiNoo
	GRo79RSKr/RDZqjsRS7/Kqb5SErcYtLQOVueh1U9zA2ZKwCmPX8X+AL8OM+bI+GLUT0Ib8LtGsa
	+sI8HXR59be6co5B1OStM6ZLerix7hMo=
X-Received: by 2002:a05:6808:660b:b0:467:58e:5d6e with SMTP id
 5614622812f47-4789f60519cmr11070598b6e.30.1776273075831; Wed, 15 Apr 2026
 10:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413093100.24993-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260413093100.24993-1-johannes.goede@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Apr 2026 19:11:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVW7Uj5nriF4YSvoyqufpje8cdmkYLob8WOb4LGguq+g@mail.gmail.com>
X-Gm-Features: AQROBzCunXbqEqRG3n7n5UzXbKq5McPrYtp8MSRMfX7zEqvzxtMDzw_MXpImcLA
Message-ID: <CAJZ5v0hVW7Uj5nriF4YSvoyqufpje8cdmkYLob8WOb4LGguq+g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Move Lenovo Legion S7 15ACH6 quirk to the
 right section
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 11:31=E2=80=AFAM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> The video_detect_dmi_table[] quirk table has different sections for
> different types of problems.
>
> The Lenovo Legion S7 15ACH6 quirk deals with a non working nvidia_wmi_ec
> backlight, move it to the section with the other models with this problem=
.
>
> While at it also add a comment with the laptop model name to the quirk.
>
> Fixes: f144bc21befd ("ACPI: video: force native for Lenovo 82K8")
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/acpi/video_detect.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 4cf74f173c78..f9519187f99c 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -899,6 +899,15 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
>                 },
>         },
> +       {
> +        /* https://gitlab.freedesktop.org/drm/amd/-/issues/4512 */
> +        .callback =3D video_detect_force_native,
> +        /* Lenovo Legion S7 15ACH6 */
> +        .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
> +               },
> +       },
>
>         /*
>          * x86 android tablets which directly control the backlight throu=
gh
> @@ -948,14 +957,6 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>                 },
>         },
> -       /* https://gitlab.freedesktop.org/drm/amd/-/issues/4512 */
> -       {
> -        .callback =3D video_detect_force_native,
> -        .matches =3D {
> -               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -               DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
> -               },
> -       },
>         { },
>  };
>
> --

Applied as 7.1-rc material, thanks!
