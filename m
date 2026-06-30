Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640CF3CC31F
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823042; cv=none; b=a55ooZPdayZHO8nvSvBticM0a8pNdnXoijYeA0PuI4i9KTfgyCu7yFRfhQnZNrSRJjx8OkKN1SJMg7Bv5EF5jQUi1k00iBb7fiBUj5eoU9vcrSeXi+ItBkGROZken1SwulS1rQOy+nEy9Xiwxl1YyPlbAr+CAVsMmErP8raxMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823042; c=relaxed/simple;
	bh=zSWpTmeu3hLOlTij9mdzv2Axpj+6Dc59p1ePFiJDuxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsNiZiI68kqwoGMefIkxHpiwd15eI9JP+yIWcV+rFsjgorAt4KfhpfW/AgoHv2qLGL91Ie8mh93WDcMOkyzVRaL6ML2E35jUTN0uQc+8dBGYtT+Hi007t1mCK0chpb6JD/BGueWQEoiEkh6J4gl+oGvFzVZhaUxzNnD2Uh5seqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtgno1Ag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtgno1Ag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9931F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823041;
	bh=RrXrY7uO6BkOtk7aaJeTfYLUFl9qw1za+dx9E2dQVFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Gtgno1AgEHdROvjvvWF/ktKB/k7MhihZq4QcYwKOdDOTCQxmvO0vYgXvH/TDtf+5J
	 RoySB9gwMiKOuwvj/rbpDVgzpMDo72Yje4Y9LVMmL0W0fhr1wQjq+5Zxemb37Tcf1w
	 zwqKEBx0eXABWGoaxgzgM9rZp9o8atob/hh5WfZi+UqjYq0Hlu9tAltkB2/eWSRdL4
	 Tc5KtLpJy6TVJCn4RqrG4/BJbzowDUQIg08JGUG8qIBxLtYcSWilWb+nYrYbapBVjP
	 3mwtUKAAu4R0jkJh7CYOlyFT1cCdGOydl9cucRK9+Z4RBZqLPAdhu9V7L5QYNe/LWl
	 5mIzgJuvb6jDA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39b237fb695so3961341fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 05:37:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RriwEL0/mcHHdnwGGGZRfXSRXCmY3L0ZQQM5gtnLUIoVBUZkwwLoZO0QL89Kug/4Dgpe4EJpLpPAkJN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JElNDRIzgm7v4XDhhITDXL11GURfVK134uyd78Wp6woV7+dM
	e9DGtkcESrqSgO1hI12lqsv182YUaNB0L7C78cH0QNdlCJ8EMxoaeAZMIo8rISQx0VuTNWpuCXQ
	kjiCeBiRwMSVKALUsi/LfjbsSREJvubw=
X-Received: by 2002:a05:6512:3f11:b0:5ae:b8c8:f2fa with SMTP id
 2adb3069b0e04-5aebdbdef7emr852372e87.50.1782823039507; Tue, 30 Jun 2026
 05:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0484b30b6935994f5a2d97c55a47a95e1557dd15.1781102535.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <0484b30b6935994f5a2d97c55a47a95e1557dd15.1781102535.git.u.kleine-koenig@baylibre.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 30 Jun 2026 14:37:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gse46Kq_MeBJ6b9Aqk75hgDR2GUOR19XgmTLmXRk1R4w@mail.gmail.com>
X-Gm-Features: AVVi8Cc3mNES6JMhmKiqYwqIn8iET1HGQLRNxXc3w-iTZmsWKfVTP_ZP72tL-8o
Message-ID: <CAJZ5v0gse46Kq_MeBJ6b9Aqk75hgDR2GUOR19XgmTLmXRk1R4w@mail.gmail.com>
Subject: Re: [PATCH v1] PNP: Drop unused assignment of pnp_device_id driver data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:43=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> The driver explicitly sets the .driver_data member of struct
> pnp_device_id to zero without relying on that value. Drop these unused
> assignments.
>
> While touching this array simplify the list terminator and align the the
> array's coding style to what is used most for these.
>
> This patch doesn't modify the compiled array, only its representation in
> source form benefits. The former was confirmed with builds on x86 and
> arm64.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
> Hello,
>
> I intend to change struct pnp_device_id and for that it's required that
> .driver_data is not assigned using a list initializer. Instead of
> converting it to a named initializer, drop the assignment as the value
> is unused. So this is both a cleanup and a preparation for a later patch
> series.
>
> See
> https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre=
.com/
> for a more verbose description on the mentioned change to struct
> pnp_device_id (though this is about platform_device_id, but the idea
> here is the same).
>
> Best regards
> Uwe
>
>  drivers/pnp/system.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
> index 835113b2cb04..bd939b564379 100644
> --- a/drivers/pnp/system.c
> +++ b/drivers/pnp/system.c
> @@ -17,10 +17,10 @@
>
>  static const struct pnp_device_id pnp_dev_table[] =3D {
>         /* General ID for reserving resources */
> -       {"PNP0c02", 0},
> +       { .id =3D "PNP0c02" },
>         /* memory controller */
> -       {"PNP0c01", 0},
> -       {"", 0}
> +       { .id =3D "PNP0c01" },
> +       { }
>  };
>
>  static void reserve_range(struct pnp_dev *dev, struct resource *r, int p=
ort)
>

Applied as 7.3 material, thanks!
