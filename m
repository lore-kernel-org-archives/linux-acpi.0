Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD13E3D90
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250692; cv=pass; b=c3I4yZwPCxW1UYpyLNx2VVaSbSFy6Ml7WUcN0O8c3UK87lC80bRRL34PxDzD7NIQQHTVpJUM2XY6PGVtZP7xvYGaj58e9JpAclsbKbpDs0fkN7WqB2Zj3iFzYyOXfV4hUcHbh5+f3VE+HBjYc+U7gv2BSFRuyo7xSTCvg+WWBiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250692; c=relaxed/simple;
	bh=AAW7Bc+70pQhpUTfJT214lM/e5AbzwxyHZSFmCFPS7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M56IpLpEL3hUjVYCVPOP8QDUkBqxmv7r01C0BrkOTUdMPRjow2ZPbwP3Tk/BKf8vzOQmvHY1if7KY+kq1G4BxlUGeXn0s9yCIPAgpoHJatoYT2+QUS+VS26EQxJsT5ooMsGRYdI467kp6cTiCnIx5QAruTSpsHvQ+TKxJi5xrwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FOExL29O; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOExL29O"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dc2b658544so4600897b3.2
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 00:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781250684; cv=none;
        d=google.com; s=arc-20240605;
        b=kCTMzrLSLixfZtbHOf9bcmy5Tw8avX4vTHGnTijraX8LA0eOIKwxEjQQoLndMJpE9U
         NkQbQTjVlyZ0rBGRTjypkoXeX1SFV+CAubbVykmnUG+Uv+a8Q2BfqU9XGE5Oj96oOM77
         wKfE6K2Af2uRO5FQWrLFcgJiXbm5PQdON2Oc25QPEdPB9HHWwQc0A4P4gW+D3KAHkDss
         uU5YzVHqgGFUCCvxuzZc6kbltn7NjCkVHw9H1wy1MVZSqC0KDRc6eorOL0rkZra9CqYv
         KnahOUeSlIlsYLIidmcEDmlYym1KZCzCSTgmYONeCcV+b8k+PWxYi4rcHWXxn2/XBa5j
         Jgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SR0MIdclzqLJ5NMQX/zWd9Yh3H6pzRPWDeVIlwB7J0g=;
        fh=3zfNSe6K5PgzOOn7tzuhBy0qTNs9ioTuXkEXdTuJU78=;
        b=SYhlVBZVOM30qVLmKhNJZglAjr6c0lzDZAitVnC7z4dXO2ykrwhU/8jeIJ+AODO/tT
         SzFsZmsa3lruvqGD6wXFSsA7WMONvz+vUjeB4uTiwprDQ6xG3gCo8yNtSzIj5EZhmqho
         m5AKKT+CrIRdTAbTmoKonw9kzJ30ZtISZfdDun8TwE0WtEUZ/SufX/cLcQGVFiTUlbOS
         z0kXyQBammC+IQhiehNxMInpFlxZjTCBR1/fANWp332KMJzd8IkTvpiUjEaQgRlxPxcj
         pU9uk9SI8L8dTNQAoZRnDBDnMd2/p6RuG1XYq1kFDTqvU+J1070CIzihMF+LaHh6qTmI
         uSnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781250684; x=1781855484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR0MIdclzqLJ5NMQX/zWd9Yh3H6pzRPWDeVIlwB7J0g=;
        b=FOExL29OPYXtRjr1jFVeFa7zcPsHHFHr6diu6VMqNotYkNZv7Wjo3syPc4R8ExctZp
         dRfHQrQ1QbppC5ogpXbF12ugxXsiKvzABW9lOoaQg9awzs4dNN/NYp20PF5wDlT8hpjJ
         1S1xuuiqMchZQ6nCjXW2tI+NMR/LrTS+SDRC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250684; x=1781855484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SR0MIdclzqLJ5NMQX/zWd9Yh3H6pzRPWDeVIlwB7J0g=;
        b=FMfgbhOwt4AWR6/a26/dQmX/nlHhDdn7rodu2oBV1sGolNHcSTp84nzrHidZQjHrJh
         X6m5HmGtA66TrIQE7PFf5dQq4FFpYoMgcg74BeXTaX+r2Q5KWrKXrbDnBHQ+aZSLe0cd
         7xYqt4gJf54LYGsAt/GFQdfxgMoe8eeCXQMC4ArcWGhaqHWJRvU7b+8stnbgE1X/ExUa
         idz5BGo8eKwu+lSj0vmn7R6tSsevtHw68Eaa7eSUrTVhtNwT47Vc0/3zWZHpANb5oTsJ
         sPUsTr5pohh7UdaQj8RyJ7ssb5LYUSxeRvtup1zd+GgG66IN39BtSvf6srkr5Hg+Zngl
         e/EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nS9U0tu2VOdhUdpSK0pMHXQbsuvTmZhlug0MTrZuVH4iiJ5RErGYfIv/hjt+SBIS520guPWZN+dAS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9a7XujW1uY6MG81JfcVIY+JGMbboqNBwcLvgl6i2zjUYD2FC
	C16vjbg4yFxakS1IjdBtoZc9JuUSTExxcAeLIpLuZ0G0IGgHf2AqZzSXo/VaboiBp8U2D3DCtCh
	GM0HuweUU8PtIz8ADNfDxPuClde5HUSysXv/1oxnM
X-Gm-Gg: Acq92OEPp2oRkU4RpNzd5zBarDScOtbpC9baoFNiZvt9EfTZIufWnZNIRHWX7eWxsyV
	HNnDcR1d9YK0wqrUzn0pLRtlBIVIxeAAQl+9AQfEaNTz207rooMCBEmJgqkDQxYkZESJznqjeMt
	JroP1W4DpSx/qjZMxAM4Iv0yQW/u71o9PG0SIHrAAVo1ag1J2uATd0/RhR7FyECa1XgqYDv8d+4
	f9X4esCAXW1dHwbggPfXlfZz33kxD5lVm6FcV4XoYz2S7J4jraM0P7wAJL+aYK3aV7kQCnlQN0d
	L0o5LR0M
X-Received: by 2002:a05:690c:ec7:b0:7bd:73f3:7a70 with SMTP id
 00721157ae682-7f7b8523999mr14898787b3.32.1781250684397; Fri, 12 Jun 2026
 00:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-5-wenst@chromium.org>
 <ailytpKQcvYTUH7j@ashevche-desk.local>
In-Reply-To: <ailytpKQcvYTUH7j@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 16:51:13 +0900
X-Gm-Features: AVVi8CeA8ndBvqsmj_bBdEg4mr2h2E0R3_zPJJzKBFEx0mTdugBDzHIodwmMGm4
Message-ID: <CAGXv+5FrD7abUvw5JgZECcGBvtOOpezDtmUrCRmVAbDx0ApxhA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] usb: hub: Return actual error from
 hub_configure() in hub_probe()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:38PM +0800, Chen-Yu Tsai wrote:
> > The addition of power sequencing descriptor handling in the USB hub cod=
e
> > requires dealing with deferred probing from pwrseq_get(). The power
> > sequencing provider may not yet be available when the USB hub probes.
> >
> > Return the actual error code from hub_configure() when it fails, so tha=
t
> > the driver core can notice the deferred probe request.
>
> Makes sense to me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> One nit-pick, though.
>
> ...
>
> > -     if (hub_configure(hub, &desc->endpoint[0].desc) >=3D 0) {
> > +     ret =3D hub_configure(hub, &desc->endpoint[0].desc);
> > +     if (ret >=3D 0) {
> >               onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
> >
> >               return 0;
> >       }
> >
> >       hub_disconnect(intf);
> > -     return -ENODEV;
> > +     return ret;
>
> Can we convert to regular pattern, id est checking for errors first?

Sure. Will do it together in the next version.


ChenYu

>         ret =3D hub_configure(hub, &desc->endpoint[0].desc);
>         if (ret < 0) {
>                 hub_disconnect(intf);
>                 return ret;
>         }
>
>         onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
>
>         return 0;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
