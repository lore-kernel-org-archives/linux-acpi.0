Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1127816C
	for <linux-acpi@vger.kernel.org>; Sat, 11 Apr 2026 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907204; cv=none; b=n9hRjeUeEmNPLhNUAL5GgV85FFA0R6otxBfKBge476aSNdMBmsnwzKUMvLYSmCvPapEJ/p37x4rHShRqgcYg474r7Omwm1OKClP9BCscnxGnjLvrQpx2mrwZ4rx6k+cOUqzUmTeeyhZTb6FslWea5XzrK/fPF52joNVsbigfdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907204; c=relaxed/simple;
	bh=yCwfZVKRGy2sHdV6NywY4rfux68HZ7RD7Myz9Y2oT9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVz3YzQeVnwYtT+vzmme2ngxDB16Y7v+zOaTphLzQGDJ2fRj6Ux2T+RRxfSD5IlRJceosXDrUYO5kGZDUNg6mXlCs6+cObU3MusNti8MLo5vpDKhJ4ku6RM7rRJGIkwSAltHMNzP2T5HZ5WiWIDsCKbCZac/fbCZA9pXSWTDBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VabrCVK8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VabrCVK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AB0C2BCB0
	for <linux-acpi@vger.kernel.org>; Sat, 11 Apr 2026 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775907204;
	bh=yCwfZVKRGy2sHdV6NywY4rfux68HZ7RD7Myz9Y2oT9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VabrCVK8tz5wBVZC810196634nz76SAF/45GK1Aw0Uu6hCz8eS619DbBz+XmxtFtY
	 VjMlHS+OxjC5iUA31/NfDB/TAgrPj7TipXcag38TppwrFZhEEfy/lpbzqoJxmhpNDc
	 bMOwL6b/JTC2vFr2EwValOEMiqxsYYeMrNzo+87ddeGSTgsE5jZmwUjn/bjuOK43uz
	 ndruIIqbOs+etoYHpHxJc59RIfUvpIqXMScb4P+B4PdobrDZQucZx4JZKRG9d1PUIq
	 0jtHkd/vlyeEgS8xvIfMqQfQMNisGN+atqIiaprMEl5O8Ds5bGEuhtZXwHTdsqesb4
	 BInykFIM+Rehg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-415e568a7ecso1028151fac.0
        for <linux-acpi@vger.kernel.org>; Sat, 11 Apr 2026 04:33:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQG4zM8E5QxS4nycN0Hco7+6O+fmCWTEphFb3SuPhY/8CQ+EhsrSqt4km7kOjqoZONFHcZ8RUhlOIe@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgzxwtPDsDfiB9kj0Cnlt5by1xwvZkGciaHNwmzF0tspnBsI3
	tZMUdhNF/cnUvY2tgmdS6dl8944PVfjHUk+ehH8xkuIVV0qQlczY/NK8/gOQbYAfHMmuNpTZL05
	4tASioiWjgWZkBP6YHUqGrgsg5KXmhHM=
X-Received: by 2002:a05:6820:841a:b0:67c:27a7:8c4d with SMTP id
 006d021491bc7-68be86e7a4bmr2185898eaf.48.1775907203103; Sat, 11 Apr 2026
 04:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410103451.2014607-1-lgs201920130244@gmail.com>
In-Reply-To: <20260410103451.2014607-1-lgs201920130244@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 11 Apr 2026 13:33:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iADp9n2y0VYRYVd7dbCmrs8DePUiHt8NfdWpei88CVsA@mail.gmail.com>
X-Gm-Features: AQROBzA1eomXPQ2GoLn5YRzGqNl9QPHF9M4-G07uNibocYRp9f3nIytu6184pUg
Message-ID: <CAJZ5v0iADp9n2y0VYRYVd7dbCmrs8DePUiHt8NfdWpei88CVsA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: power: Use put_device() in power resource add error path
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 12:35=E2=80=AFPM Guangshuo Li <lgs201920130244@gmai=
l.com> wrote:
>
> After device_initialize(), the lifetime of struct device is managed by
> the driver core through reference counting.
>
> acpi_add_power_resource() initializes device->dev via
> acpi_init_device_object(), which installs acpi_release_power_resource()
> as the release callback. If acpi_device_add() fails, however, the error
> path calls acpi_release_power_resource() directly instead of dropping
> the device reference with put_device().
>
> This bypasses the normal device lifetime rules and frees the object
> without releasing the reference acquired by device_initialize(), which
> may lead to a refcount leak and potentially a use-after-free. Fix it by
> calling put_device(&device->dev) and let the release callback handle
> the final cleanup.
>
> Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/acpi/power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 361a7721a6a8..f96f954876a7 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -991,7 +991,7 @@ struct acpi_device *acpi_add_power_resource(acpi_hand=
le handle)
>         return device;
>
>   err:
> -       acpi_release_power_resource(&device->dev);
> +       put_device(&device->dev);

Please use acpi_dev_put() here.

Also, acpi_add_single_object() has the exact same problem, so it would
be good to fix them both together in one patch.

>         return NULL;
>  }
>
> --

Thanks!
