Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102002;
	b=kLQz749U+Il/wbqihhCTqf8X4CjjKxP1CKn7kYowfnJQT1GawU/oeC3XIVnjPJPsrgSn
	 DbxhoGCGJITDzZ4kJcHBVmIyzW3GSSTiPFUDciqEsL9zjH9qkHzrRqUsgDitDsJR5Sglb
	 czhFrzsSRArSL6UZxSQW2TqEomId9yDyd1Z6uC3qwv3HuNiA851K9mV7nrcHOV1zhStME
	 8rutz/KVPjFSW5XWHM/9BTh45226L5NUf06T7YZ05+LEZjnuc+qioSt6FixMvA4W7mpLC
	 HlbNV8EuLoAjGbZ4FQSEnS9h1HD+ZI+ze49TJzicDVciXtxkRJwgkOF4YdXGgMM9Ftg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102002;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eW571iO5qUDWhqnb/V2rwsfuoMvwgati36UAaHCNbvk=;
	b=DFCH+d1ANLrZXjrSQuLjHTHfAaFzm8SDcUo7ArCxOQJL56mrLSWKIqlF/j0FLWxqNW02
	 EUFQxRSeXpbA5gcKErztsCdhjkRSUtVuLCW0iJFsvY098pvBHJf4BNaORL88CuMnDz/2s
	 M1QBpBImKytFlfGUG3rJ/57TDwZFrnNWzwZQvsjKn5ifAKwPumVo71QYFWYAmm5FkCp8N
	 NDy9DyKz2cCyGo8lKrg6r35zBtzUiHwNlH80tmX/rVqq/ir/Vw9NtUjBL4AXG3bKSr8KT
	 oS1fW1F2uZVOm9RuHFSiNLJUC4PKjicEzid11oC6z2DG7Wt+EhU4WVdoA+etUhVB6hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofM0RcTa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25633606A31B
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofM0RcTa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7ECD1F031E8
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793102001;
	bh=eW571iO5qUDWhqnb/V2rwsfuoMvwgati36UAaHCNbvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ofM0RcTa0CwBxEvlJOqowo/YO17DqYJ6necpPeND9VQ/86GbNxcpw1bdV1UY3kVqk
	 3bm6WhatvEfxQ2CF040xXt5MmkN8x/mNKjkglvn2VvWugS62o8f2Ks0miZTyk7Povl
	 o18DoyHmI5YPa808QCyTV3IGOvwCYplAiM1jPoEjb/gsPkxG/kpBsdr3lAitC/v79A
	 0CbrDv4pBbI/sPhtOcCLgknsXaDI7Xcrl42QtR9fYk4Fz2Vcxo94X/5Mh7XkO8Qreb
	 xU+Rnr9qCttHe5wqCJkOdJB4iPfaVw5onwlbHmft9bqN3Anf3sN0awKg0sC2TM3mI7
	 HCfdX/68S4Mew==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso725634e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 04:53:21 -0700 (PDT)
X-Gm-Message-State: AFq9FYJAuOU26C5k1tryeguCHmGYDrh9+z95qM+npjwFkdi4UnCmYVQ7
	gYNLAq9V1+7kydXf8v1oWBGXZBDzrO0b71MV4A9RIhFqY1G18fuCy5pzpgjKla2SPqBOazhUDiG
	CDAR8kFcjp9HSgiVIwEIDpEa/eAKPl5E=
X-Received: by 2002:a05:6512:318d:b0:5bf:c79d:68f with SMTP id
 2adb3069b0e04-5bfc79d06f3mr475833e87.2.1793102000095; Tue, 27 Oct 2026
 04:53:20 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 27 Oct 2026 12:53:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g0B7HC5SV_VpBNnS0UffJn8w9_gsXpATkYhHFOBkAasg@mail.gmail.com>
X-Gm-Features: AclHuK-sPybzziVNvnjpKHMy_0ZM8EP9Kiy6CfDmwTeb6pCFjhVTy3qaKz6xdf8
Message-ID: <CAJZ5v0g0B7HC5SV_VpBNnS0UffJn8w9_gsXpATkYhHFOBkAasg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: TAD: introduce acpi_has_rtc()
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-acpi@vger.kernel.org, linux-rtc@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 4:21=E2=80=AFPM Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> The same RTC may also be accessible by other means, like the EFI
> GetTime() and SetTime() runtime services used by rtc-efi, which are best
> avoided if there is a native ACPI interface to the RTC.
>
> To allow other RTC drivers to stand down in that case, add an exported
> helper, acpi_has_rtc(), that returns true if there is a TAD the driver
> will register an RTC class device for.
>
> The helper looks for a platform device matching the driver's ID table
> whose _GCP indicates real time support, like acpi_tad_probe() checks,
> instead of checking whether the driver has bound to such a device, so
> that callers need not depend on the order in which drivers are probed.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v1: https://lore.kernel.org/r/20261022211304.2285792-1-hamzamahfooz@linux=
.microsoft.com/
> v2:
> - Rename acpi_tad_rtc_available() to acpi_has_rtc(), move it to within
>   acpi-tad (which allows us to simplify it quite a bit) and declare it
>   in linux/acpi.h. (Ard)
> - Add acpi_disabled check. (Ard)
> ---
>  drivers/acpi/acpi_tad.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h    |  6 ++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 45459a4ca..eea4d2123 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -899,6 +899,44 @@ static const struct acpi_device_id acpi_tad_ids[] =
=3D {
>         {}
>  };
>
> +static int acpi_tad_rtc_match(struct device *dev, const void *data)
> +{
> +       unsigned long long caps;
> +       acpi_status status;
> +
> +       if (!acpi_match_device(acpi_tad_ids, dev))
> +               return 0;
> +
> +       status =3D acpi_evaluate_integer(ACPI_HANDLE(dev), "_GCP", NULL, =
&caps);
> +
> +       return ACPI_SUCCESS(status) && (caps & ACPI_TAD_RT);
> +}
> +
> +/**
> + * acpi_has_rtc - Check if the RTC should be driven via the ACPI TAD
> + *
> + * Check if there is a TAD implementing the real time methods that this =
driver
> + * will register an RTC class device for.
> + *
> + * Return: %true if the RTC should be driven via the ACPI TAD, %false ot=
herwise.
> + */
> +bool acpi_has_rtc(void)
> +{
> +       struct device *dev;
> +
> +       if (acpi_disabled || !IS_ENABLED(CONFIG_RTC_CLASS))
> +               return false;

You may as well put these new functions under the existing
CONFIG_RTC_CLASS #ifdef so they don't get compiled unnecessarily, and
add an empty stub for acpi_has_rtc() in the !CONFIG_RTC_CLASS case.

The IS_ENABLED(CONFIG_RTC_CLASS) check above will not be necessary any
more then.

Apart from the above, the patch looks fine to me.

> +
> +       dev =3D bus_find_device(&platform_bus_type, NULL, NULL,
> +                             acpi_tad_rtc_match);
> +       if (!dev)
> +               return false;
> +
> +       put_device(dev);
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(acpi_has_rtc);
> +
>  static struct platform_driver acpi_tad_driver =3D {
>         .driver =3D {
>                 .name =3D "acpi-tad",
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ddacac812..71524a821 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1553,6 +1553,12 @@ extern bool acpi_has_watchdog(void);
>  static inline bool acpi_has_watchdog(void) { return false; }
>  #endif
>
> +#if IS_REACHABLE(CONFIG_ACPI_TAD)
> +bool acpi_has_rtc(void);
> +#else
> +static inline bool acpi_has_rtc(void) { return false; }
> +#endif
> +
>  #ifdef CONFIG_ACPI_SPCR_TABLE
>  extern bool qdf2400_e44_present;
>  int acpi_parse_spcr(bool enable_earlycon, bool enable_console);
> --
> 2.56.0
>
