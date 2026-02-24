Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AE396D03
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935464; cv=none; b=lHR3DuAWPNpD6U9YhlWmc3snJincUR2Uq9NszaaUiFyorGrPzr/7b2w7OiuRgkCun35ntarZijgIlLrR5oSqYUFia/LelD7CpX5WlZT6p45a0K/JpXPWpZODUlQlURfbI8sqSKtzm2FjY2yR+UKcUWNVPj+6VOBC46Yjbnr/mCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935464; c=relaxed/simple;
	bh=LXAbzxo+O8HcnXz/n/MRwtj0chUGnuOiHznWbLW+sRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m91MqZMonB3TCQoIIZfujl2NetztwGTiflKco9kXkE0qteJX3IinbjrDsobDalpmieJhm7MXXANbhSJowBtcuUMmY0K4KMBT2MihVptxMqusOnin8ncrYqiLGLP9zt9KDZLxV9vyHTyeGg2/AruMq37HAmuCJ7ECaTWT+ItQG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYNxMplQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYNxMplQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA0DC2BC86
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771935464;
	bh=LXAbzxo+O8HcnXz/n/MRwtj0chUGnuOiHznWbLW+sRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fYNxMplQTMGokYR+YiDFNEQz8epZ2G2llYSsiqtMzJzAav8EHG+LJGh26PieXVW8M
	 1/Mqwy8JSo9Hwk88ixnoSnZffKvMqqNPhoNmuarbjQ3O5OlTY43pwkbnOSiES5QUtn
	 Dw4sHRf9hyhSqMI0ELWb33NkqblzRlx1DQln4zX4/6h0EfxTdAT9Ovse64qjdqdxWI
	 xV9uOBe+vG9/0fgsbh5x4obBz2k5WEgX/pgSi5Omge4DTcusyae6WqJ0of78srT3LT
	 X/+BPPrK9rS6wSodGKr0B5wl/jvot1R22hNLzE3IXLQmJg2/coc1IPI4BTALX6llTt
	 3M+Ze52nASFnA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-674181e5bb9so1037114eaf.3
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 04:17:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWI6TEC7WlqiATaXJTU9iP73lPDxZbE4Qpw+M5IlUxvcJi0e7aasdzI2A603kv+/2GjBVHRsbOTl4Dg@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHDtiskzQAfyyOlwImswPmt7GIUBFzsLMsrvceTb9F6fr46QH
	ck2hvpGfGpNZN8IFk+bJopBMTIFtrI6NF1xMGdoP/s1eN1SugQqs9320rokgxqhqB8pd41wwI8r
	4WZqCMKtzfrf/6Vsl3GCLQqy0VUZqIGc=
X-Received: by 2002:a4a:e911:0:b0:679:a4fe:f025 with SMTP id
 006d021491bc7-679c44f4d0emr6808274eaf.59.1771935463291; Tue, 24 Feb 2026
 04:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223220102.2158611-1-bart.vanassche@linux.dev> <20260223220102.2158611-29-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-29-bart.vanassche@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Feb 2026 13:17:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0goP11BWS4jKWuB1F2teaHdMnovG2MJ=B6aL+vwXqKWSQ@mail.gmail.com>
X-Gm-Features: AaiRm52QfhGiDPAdUawZvtFvHbk8IjTWiSmuQOaTV00Gj_l0F4FI1xa-Uc_MAEE
Message-ID: <CAJZ5v0goP11BWS4jKWuB1F2teaHdMnovG2MJ=B6aL+vwXqKWSQ@mail.gmail.com>
Subject: Re: [PATCH 28/62] PNP: isapnp: Check the isapnp_cfg_begin() return value
To: Bart Van Assche <bart.vanassche@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, 
	Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>, Jaroslav Kysela <perex@perex.cz>, 
	Adam Belay <ambx1@neo.rr.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 11:03=E2=80=AFPM Bart Van Assche
<bart.vanassche@linux.dev> wrote:
>
> From: Bart Van Assche <bvanassche@acm.org>
>
> Instead of ignoring isapnp_cfg_begin() failures, propagate the value
> returned by this function in case of a failure. This patch prepares
> for enabling thread-safety analysis since isapnp_cfg_begin() only locks
> a particular mutex if it returns zero.
>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Adam Belay <ambx1@neo.rr.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Fixes: f72e5c5c861c ("[PATCH] PnP Rewrite V0.9 - 2.5.43")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pnp/isapnp/core.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index 219f96f2aaaf..3591a2791c1a 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -853,7 +853,9 @@ static int isapnp_get_resources(struct pnp_dev *dev)
>
>         pnp_dbg(&dev->dev, "get resources\n");
>         pnp_init_resources(dev);
> -       isapnp_cfg_begin(dev->card->number, dev->number);
> +       ret =3D isapnp_cfg_begin(dev->card->number, dev->number);
> +       if (ret)
> +               return ret;
>         dev->active =3D isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
>         if (!dev->active)
>                 goto __end;
> @@ -887,10 +889,12 @@ static int isapnp_get_resources(struct pnp_dev *dev=
)
>  static int isapnp_set_resources(struct pnp_dev *dev)
>  {
>         struct resource *res;
> -       int tmp;
> +       int tmp, ret;
>
>         pnp_dbg(&dev->dev, "set resources\n");
> -       isapnp_cfg_begin(dev->card->number, dev->number);
> +       ret =3D isapnp_cfg_begin(dev->card->number, dev->number);
> +       if (ret)
> +               return ret;
>         dev->active =3D 1;
>         for (tmp =3D 0; tmp < ISAPNP_MAX_PORT; tmp++) {
>                 res =3D pnp_get_resource(dev, IORESOURCE_IO, tmp);
> @@ -936,9 +940,13 @@ static int isapnp_set_resources(struct pnp_dev *dev)
>
>  static int isapnp_disable_resources(struct pnp_dev *dev)
>  {
> +       int ret;
> +
>         if (!dev->active)
>                 return -EINVAL;
> -       isapnp_cfg_begin(dev->card->number, dev->number);
> +       ret =3D isapnp_cfg_begin(dev->card->number, dev->number);
> +       if (ret)
> +               return ret;
>         isapnp_deactivate(dev->number);
>         dev->active =3D 0;
>         isapnp_cfg_end();
