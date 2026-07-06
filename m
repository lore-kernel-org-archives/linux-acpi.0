Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72B2F5491
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361253; cv=none; b=k0hylOXnRyIAb136aWCW2Yv9CuGfAkdNcDppHOwtRL6TID8FDQtz0djn2GQs5SpuUQ2E3eB2cL9iCe5PwiMJKOm2qQOQJPZqVLoX6HD/L7+fxk9PSQtQtgKc29T4eQDlwSlNQO2Z7ln8wWppxyPNp3xBv40Wvm03KJSHfA0wFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361253; c=relaxed/simple;
	bh=lbd0uqPE4ls5JcVRvfqHG8TKV7gAumvPdOSvOTLVANY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDh1kSJx7uDVCg7hpTZGs0iHSP2mmNAtXeubk3BfwxVnmlk0q24Zmhmo/+f3/8XGXzy90dodMgPw9CuVHS/f0ztJt9xfXLLDGD3eO0OsNgFvTDtT4P72ymFVvrs8rsGSoy+YvCOfK2tP3RkjpyKaqAKAnQI5UovSppwz8UG20KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4IdPFT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4IdPFT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D2B1F00A3A
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361251;
	bh=yBORSGvkJXb3KkkeHkzVsJDwbnzvkYDaHnK5K79Z+0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W4IdPFT8WewEhL3CyP1Lmq+ORLtv+XHLZJX75dlGqIZ7hSfs/KB6YtHeY6rEBG8hN
	 p4Y4Eom5Uf7zSC8iQPbJKAQQp/G6qM7/FTsmo1Xa/ntBYw+htB3FdGpAy2hnEvWi4Q
	 e7hcBF1iOXiIsSID7Ha9WvUj/izaNNGlTDoXaSrsq19XCvKahHwBzSJ/JMLreVAhzQ
	 PHj31XfcELPBQG3Y8wjGjIKhIawS9GZIguLiCLXC1Zlk56Urj696jkTzae7Ppzextm
	 6M0gxhPmtSv7wCdIfQhFJyPXtT3TMuTXmrRSw35/lJOzCHREEQHoqcPCyRlps4BjaF
	 NwLKkWrskhk1A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aebc8cb5bcso2205879e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 11:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq4eNTLy8dNeLxtIyHPNCvOjcolYmqvVrb1CowtdFsojvcLTh5DLKsH0vn0Wx0C4u+ymNYuVi7LKeA4@vger.kernel.org
X-Gm-Message-State: AOJu0YwA5YRG8QYNbpO9QHfLhUY0n6ucK+DmCutoHnnMImNe8LZ+N5r/
	Ln9UlJNnqU8viXFsxkS31PrVXdO58iAa/rr3ODHk3CIUzAeWNOTuGE9Q5jsZvlXBEe5Cb6Cbcen
	A7H5jam/Dgtz0hAHVfP54sN0Czrzuyqc=
X-Received: by 2002:ac2:4895:0:b0:5ae:ba89:a90f with SMTP id
 2adb3069b0e04-5b007c426d6mr225859e87.51.1783361250100; Mon, 06 Jul 2026
 11:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703033603.114931-1-dbgh9129@gmail.com>
In-Reply-To: <20260703033603.114931-1-dbgh9129@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 20:07:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFLJE95AGjafbjF90wMSO2h-DOEV2xzwMrkw_vtpi+Eg@mail.gmail.com>
X-Gm-Features: AVVi8CccSSGVozyhOYF3GH7iytDp3TTJ7LNHy5Q0XeM2EAyXhR9MMTEJl0GG3zw
Message-ID: <CAJZ5v0jFLJE95AGjafbjF90wMSO2h-DOEV2xzwMrkw_vtpi+Eg@mail.gmail.com>
Subject: Re: [PATCH v1] PNP: Fix card device cleanup on registration failure
To: Yuho Choi <dbgh9129@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 5:36=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wrote=
:
>
> pnp_add_card() ignores __pnp_add_device() failures. If device_register()
> fails there, the device is removed from the global and protocol lists, bu=
t
> remains on the card list and its device reference is not dropped.
>
> Remove the failed device from the card list and call put_device() before
> continuing with the remaining card devices.
>
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/pnp/card.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
> index 87f5af454751..df5e3d3cbf6c 100644
> --- a/drivers/pnp/card.c
> +++ b/drivers/pnp/card.c
> @@ -254,9 +254,16 @@ int pnp_add_card(struct pnp_card *card)
>         /* we wait until now to add devices in order to ensure the driver=
s
>          * will be able to use all of the related devices on the card
>          * without waiting an unreasonable length of time */
> -       list_for_each(pos, &card->devices) {
> +       list_for_each_safe(pos, temp, &card->devices) {
>                 struct pnp_dev *dev =3D card_to_pnp_dev(pos);
> -               __pnp_add_device(dev);
> +               error =3D __pnp_add_device(dev);
> +               if (error) {
> +                       mutex_lock(&pnp_lock);
> +                       list_del(&dev->card_list);
> +                       dev->card =3D NULL;
> +                       mutex_unlock(&pnp_lock);
> +                       put_device(&dev->dev);
> +               }
>         }
>
>         /* match with card drivers */
> --

Applied as 7.3 material, thanks!
