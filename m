Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C03FA5E9
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911045; cv=none; b=IC5tA5TdQJVPdHqlkh8NKWolmAQrZhtXvTVflKSlm8Xk7wVbCpcU59z2Q0B0vZelmQVESzWbzfzRbFTsZUeLn40f8EZtIq30sQSdBH9SVMaRS1YOuyyBtoK45PFonAetHKdA+K3++nFlLhgCi7/veTsj7tO20YZIpjn/+FdC2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911045; c=relaxed/simple;
	bh=mJtcqmUq0cBx1wjzyx0LLtiPVC9wWOuFJyVu3NzVUgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY0wXNnygQag32rU4O8hiVGYoIi4vMmbWsZa2qI8gn3B05RNP/bPFmHv0QGXga/qWqCa1G6Tb7YCiSsB7ZXC3a2tWD2+7tGzG8bHDztzDWduH+OOk5QKzHBJ0K+fijiclIOmiBNHbawStg9i8nMD7vY7QRVBULCIFM+hzckbwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXMuGzHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXMuGzHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27601F00A3A
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911042;
	bh=ltNstaK6dajoA5IMGhcGva79gi6KK7SFdrzAoeCHRYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IXMuGzHb5KmINokB6zpA6V54B8wFuKBxhogER/1zZOimgnhe9nfFVPTIbJgRudzFP
	 NuiE/908R3mqq2YUcTrqAsc6YeY1GB2mm6BQD2cvLclTgVrva6rDci3/Tvryw9hVG/
	 hDxuohwT5242M7YU+n7QPI5aMwiD7GahsXaga0FjFwdCnt8VAJITG7IiYtVBa8r9IX
	 pFwjA27zWRwiyDQo1cyGDDlnV0t9qHrgX1yXaATvD+g6G2k6nrldx8jPuxZK6S4B2s
	 IGHAXO9KS+9PhMjBJvuAUnYlABATZtQWF0JX5tGl/o8rZvOjHVd3viTyhua6Mi+sxr
	 BMwa9iUFnBJEg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a1981228f8so4922931fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 02:57:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoPqrUxUJVzv8KSLIYKyFo9ChuMaMgaWOYj6f/qnX2OOd56r7wjxBu/YTY7pL8AwJ9d7TG/dqhjNxGD@vger.kernel.org
X-Gm-Message-State: AFuF++lzM9tW9LXoy152DNVlPVrK4EmSFKro2pt0dMK8jdeU4zuQr3Bj
	eaCIsRVz6KxpJp1QDngCr7wbNDHRxnTTDChqHPkf31DQn1ZbowvuyQ/yJ6GNuAzjKbzK7hv1D94
	yr4FylzJslJ6B/F91BjzrwwHZa2vULyY=
X-Received: by 2002:a05:651c:a390:20b0:39b:7cd:e1ca with SMTP id
 38308e7fff4ca-3a301b1336amr7126071fa.9.1787911041178; Fri, 28 Aug 2026
 02:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com> <20260828084328.257703-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20260828084328.257703-3-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 28 Aug 2026 11:56:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jwmpqO+QhKjgc2ipU6GMFPt-+Uggi4U4oU2WH0_Yichg@mail.gmail.com>
X-Gm-Features: AcwNN1WLpIYQw8JrVFqbMLf4nNw8N3EOCsNzdUqzGB9OwLoGtv-S9Xl5EldHUTY
Message-ID: <CAJZ5v0jwmpqO+QhKjgc2ipU6GMFPt-+Uggi4U4oU2WH0_Yichg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: Use PTR_IF() for ACPI_PTR()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 10:43=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Make ACPI_PTR() use PTR_IF() so __maybe_unused can be dropped from what i=
s
> being referred to.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  include/linux/acpi.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 10d6c6c11bdf..347763282f36 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -755,7 +755,6 @@ int acpi_device_modalias(struct device *, char *, int=
);
>
>  struct platform_device *acpi_create_platform_device(struct acpi_device *=
,
>                                                     const struct property=
_entry *);
> -#define ACPI_PTR(_ptr) (_ptr)
>
>  static inline void acpi_device_set_enumerated(struct acpi_device *adev)
>  {
> @@ -1073,8 +1072,6 @@ static inline int acpi_dma_configure_id(struct devi=
ce *dev,
>         return 0;
>  }
>
> -#define ACPI_PTR(_ptr) (NULL)
> -
>  static inline void acpi_device_set_enumerated(struct acpi_device *adev)
>  {
>  }
> @@ -1152,6 +1149,8 @@ static inline int acpi_mrrm_max_mem_region(void)
>
>  #endif /* !CONFIG_ACPI */
>
> +#define ACPI_PTR(_ptr) PTR_IF(IS_BUILTIN(CONFIG_ACPI), _ptr)
> +
>  #ifdef CONFIG_ACPI_HMAT
>  int hmat_get_extended_linear_cache_size(struct resource *backing_res, in=
t nid,
>                                         resource_size_t *size);
> --
> 2.47.3
>
