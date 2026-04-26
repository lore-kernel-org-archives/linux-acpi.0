Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589B146A66
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777212901; cv=none; b=j+fxF9Fn1uTxL3fCyHHpWggUea5fKF452N7n/IaZghspg+vYMS9A/fGIA3lnuJGXrBdBOFbgs1OGcW0HBIobusDcp0uorHgIWYGOXEhMCe94jrXGShl9DcbsG118lckHA+fWw0Sea/2pRR1L2++uo0h84j/V4yqvwj4YaBk1lIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777212901; c=relaxed/simple;
	bh=FUNWq72NPGGdz6EJb3uxa+Oi+retgXmbTsjPtrfFkcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuPBsNgAlfuAp/PQd6nUtcgcCQf25lTDz1Xpu9/zMznqro4d1bgsd41Ld05l0ifQ6BMuJPte5KmW0pNepuB7Co5jNLHcPeAynyKtTnJNCmad7o+z3iViO5VnK25/ywj2U8W52BmjsnfF6vkBUS0rTIUFFuowVhSVIi4U+7/b1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsEYHSu8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsEYHSu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A723AC2BCF5
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777212900;
	bh=FUNWq72NPGGdz6EJb3uxa+Oi+retgXmbTsjPtrfFkcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hsEYHSu85lecGigxt58jpJmevAe3rIyC+a3hR+VtB21njzrDdyn2QQJosCXvBda9t
	 e/lGCdDFn8K5GL2cxRl13hXuj765mNd7QA8+apL82nOjdCiH47tdjWg4Ns5zqt3U4b
	 fJGnnpSbpyYN8K/Fol/z4lVUALRGHIZe9MKpwXCDZnUCnT6bR4m722TD2esdaAHYpG
	 iYfX/HUGJTmcx/mXIhczLgwe5H+hSRMQwSHuPEU2RmPeraUMfyOg++ZcgA8UsuuKHM
	 j5vNdP4pMqdMWXo0+WPptRyL1rR8PTiWhQ7EIhbzUb/8o6X4403R/2JgovJmKndcgF
	 X2GzvFcuAyrCQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38dd575bca3so90884121fa.1
        for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 07:15:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+U97qlBa1YrXBhg64DyakbwWeFNqXF0JykKHFMprSP73R0XhAo5H1ahPaWy2YUtsnayPoXBONLft6j@vger.kernel.org
X-Gm-Message-State: AOJu0YxWqH3GxPzWGzCsPjPcdxUIGZXgQ5JouQ6QOBBZxhmEdjj4Mge/
	3ujXjzaRA6JV1xQRMmGQ4urcVaOhjA24+zPF0Yj91Syjd1hDCxkoGoHaj/tBiikjhZ4gCqsHovg
	I6NxsAqm1I9ZoSe1Rmdqvfb1R7sLT0sA=
X-Received: by 2002:a05:6512:15a8:b0:5a1:5994:2773 with SMTP id
 2adb3069b0e04-5a41729a1edmr10689256e87.14.1777212898821; Sun, 26 Apr 2026
 07:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425215734.14116-1-lkml@antheas.dev> <20260425215734.14116-2-lkml@antheas.dev>
In-Reply-To: <20260425215734.14116-2-lkml@antheas.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 26 Apr 2026 16:14:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ipM9khNZs3uNu5GuFO3nJZ=EOht7mLtLNNsW9s9jWCsg@mail.gmail.com>
X-Gm-Features: AVHnY4JWyGMd1NOgybJl2FDo75-8DqAC5Ej-Y-3SSPoX25XI_lL-W6Spt_Wccrc
Message-ID: <CAJZ5v0ipM9khNZs3uNu5GuFO3nJZ=EOht7mLtLNNsW9s9jWCsg@mail.gmail.com>
Subject: Re: [RFC v2 01/10] acpi/x86: s2idle: Rename LPS0 constants so they
 mirror their function
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com, 
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org, 
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org, 
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 11:57=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
>
> The LPS0 3/4 constants are part of a firmware notification called
> "Display on/off", in which the device enters a "Screen Off" state.
> The LPS0 7/8 constants are part of a firmware notification in which
> a Windows modern standby computer enters a "sleep" state where the
> CPU may still be active and maintain the radios.
>
> However, currently, the values are named as "Screen on/off" and "MS
> entry/exit", where Modern Standby is abbreviated as "MS". Therefore,
> perform a minor rename so that the values match their function. Then,
> fix the debug message to say that it executes notifications instead of
> entering states as it is otherwise confusing.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/acpi/x86/s2idle.c | 84 +++++++++++++++++++++------------------
>  1 file changed, 45 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index b6b1dd76a06b..61a044b59776 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -43,20 +43,20 @@ static const struct acpi_device_id lps0_device_ids[] =
=3D {
>  #define ACPI_LPS0_DSM_UUID     "c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
>
>  #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS       1
> -#define ACPI_LPS0_SCREEN_OFF   3
> -#define ACPI_LPS0_SCREEN_ON    4
> +#define ACPI_LPS0_DISPLAY_OFF  3
> +#define ACPI_LPS0_DISPLAY_ON   4

You've clearly ignored my feedback on this.

Thanks!
