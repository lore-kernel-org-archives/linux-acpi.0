Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB09431A39
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108859; cv=none; b=fI+DAINlDVDTNqfo6liJYUKlzzQGE04bYysWKoeJI8IHloFUfAt527u8a1AjQjXoIUMSAQl9VIECN9VF7+XtWE1F9GlqT99b3bcVKxLxv69ckalVZOY6X9x4kqdJFy+Njy2vs9XbGltbRk11kqcC5e+BnPmffuPZ5tHXqrYQ5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108859; c=relaxed/simple;
	bh=4isHO14CgbVSody6z39XpnyOmhSZrX6o3nwUveDwXls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9/sEnjwfA6Waw7k+UUPEMWShHfgREkB5AIOHTlb83buh7Y8AHFRb05OTh5eiD0pRE5EpLylMkK2O1T7mmLk7im4tpkDPv5RhIrG2NgFbFbwjVjIVY9YYWe6rFat2JFYBJAeLjYNjOHfKt6j/o4IBBNHx6iSaxerliEIr3qnc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKoV3yrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKoV3yrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C131F00A3A
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786108857;
	bh=YS6ppee6LjQvpZEJwS/FN5SZYS0sOXzr31c5/h+kh/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gKoV3yrNKFzu7buI4nhEEnzLYnVie6shBq0v+nuaOK0Aiwjik+xLj4LnWKu4l86od
	 FljL+0Kamwiny4AXneZeWp0UlABkHf/AZEjYXiZb7rcZtFKHXtrObTzWGeD2ZM0ftP
	 7E6jcKLY3vucLQKHdNmBmVl2WxjjZyFpxhNK5D/4me+NQtfFKTsTZJKl7hXAYStA4D
	 IazK2xbVJsHIxpxRFhmPxXl4XRKMKZkX89VdK4wFhGKxX/zBTI8QZTHb3q3UsqNpZ+
	 O8oSDNmXDi98i2NxXvlWnt2SCHxNZKTDA4w2JM6lG7tXoua3M7egKH4hFJL9lfdO/U
	 UTmjsOHNzE3cQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so27538181fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 06:20:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr1VQxNynSCtzSaQhSY1aeWb3rDjzfCoxhN/AQaH/FvzZnYK/ntbrcNwNKuL1KGegYqM+p1IByEQqOH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yRZC7fEZ38b2J3iDEE3rCrOYeR/7Ks2F7LpiiW7evafKer8d
	YpunPV8cLcXGOiE0aS3zJzhdglncs/0fLVsDVnYIn171m+GlvErNotbnUudO4k1YeIKvmNr+eRu
	tjRblKpiq7MBQSKR1mh2KMz6U4hskCqg=
X-Received: by 2002:a2e:a54d:0:b0:39c:9285:84f6 with SMTP id
 38308e7fff4ca-39fbb0374f1mr27056571fa.11.1786108855474; Fri, 07 Aug 2026
 06:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708024902.70806-1-luoxueqin@kylinos.cn>
In-Reply-To: <20260708024902.70806-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 15:20:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ia9eb=5PpmP=7bZs+birJ+R=hDKvCMLgFx4cGY8po=zw@mail.gmail.com>
X-Gm-Features: AUfX_mywEHrqJq_lRvjcXlwhmrlku-u9WmVobo83VCLLtCi8yiu7y-Axiv6S7sc
Message-ID: <CAJZ5v0ia9eb=5PpmP=7bZs+birJ+R=hDKvCMLgFx4cGY8po=zw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: TAD: Use devm_pm_runtime_set_active_enabled()
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:49=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> wr=
ote:
>
> Replace pm_runtime_set_active() and pm_runtime_enable() with
> devm_pm_runtime_set_active_enabled(), which also handles runtime PM
> cleanup on driver remove.  Drop the redundant pm_runtime_disable() call
> from acpi_tad_remove() accordingly.

The runtime PM on driver removal is handled already AFAICS and the
code before the change is simpler than after it.

So why change it?

> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/acpi/acpi_tad.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index fc43df083738..51f8d1b9a8fb 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -809,7 +809,6 @@ static void acpi_tad_remove(void *data)
>         }
>
>         pm_runtime_suspend(dev);
> -       pm_runtime_disable(dev);
>  }
>
>  static int acpi_tad_probe(struct platform_device *pdev)
> @@ -866,8 +865,10 @@ static int acpi_tad_probe(struct platform_device *pd=
ev)
>          * The platform bus type probe callback tells the ACPI PM domain =
to
>          * power up the device, so set the runtime PM status of it to "ac=
tive".
>          */
> -       pm_runtime_set_active(dev);
> -       pm_runtime_enable(dev);
> +       ret =3D devm_pm_runtime_set_active_enabled(dev);
> +       if (ret)
> +               return ret;
> +
>         pm_runtime_suspend(dev);
>
>         /*
> --
> 2.43.0
>
