Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B425581EC
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060981; cv=none; b=G/aUM8/lH2BwXk0uxHqI1UbP970jd5pdM/tKpyz4Knsebr6yU++Yi3u4PvVO8Q2JGnxMXE7dB4CN5K88/obpByHXF89WxoNVv+al7zYO4lO5uHHp31Z+Su9KCDoWjhXlLNWvL+snOQsK+3YArlW7nOrpFz9Jo6sQHjzoLlgNUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060981; c=relaxed/simple;
	bh=hqETN4V4lES92DA1ym1pqiDWGID/DKHOdXafLh2gBqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLEMcEhuxUqg+C24Sbb12zic57uCbmzHv23fYPmLofTp9HltpCXivC0QE0S9Imf1aST91DEG6O017Xwenyvx/LPDpkrRXJcmV0nbDdROYeHUssYZyA81rtKlvPzkGOaa+et57S89rCxNJ+FgywJWkZ4uiAftbVe1K/DjzfjMR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJSpNk4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJSpNk4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14751F00899
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060967;
	bh=X0ILc7wnInlLytqmZSrBjOKShbJpcBGc1iP8l6Nsg0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oJSpNk4Q+uYZZb1MQHCXw0zJNny2rFrsDVh7PqVqu4VceX+zRYW8Oc/CttA8K1bRo
	 iTJXYjBp+A5fj1/JG57f1FrDoojw8/ugE0cck4vINXb2pY+Pyb5TojJS+RA5BF5R5t
	 XaprpfV0+CKp800zs05VFQUuEH7KD56fxV+DSU+oNs36LfgJYsMfxYElwI+7KfipcU
	 0xkMaedY+lO8Nyx/ZSLLwHTTh/rRo1ZlfXN+mWnuR3haSXTC09960BpZQcV5liAR88
	 7DZIRnF5yAwaTxoGmVtRJbNw+rQ2OP8Xah9Z/2+CuiOHKeb6pqpgk6phIW/5lpmUTK
	 gIuE7i6DxYHCQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so78980741fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:22:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxu76JIxEVlqSpunMRW9qf/zlJREp+RCI/fnoHespWDAJ4tp5JPwtmzTyboEcg3rO3ebPRVikx5+NEb@vger.kernel.org
X-Gm-Message-State: AFuF++l28fNG6SZKgY3G1Y/c7mfv7RyqtqMVhyoVmxkmIKd7xi7gcrfE
	MQlrZnrq3mcJc4VJxf8muSODEFAEFNTjPtkxYwYek9j8a3LDzJgDwZJhfPjQRFjvAxGAfo5w13e
	3SnSGzXMrP0bQznaKyNk4O76pj3pDcB0=
X-Received: by 2002:a2e:bc82:0:b0:3a3:7681:6d60 with SMTP id
 38308e7fff4ca-3a376817530mr49434941fa.24.1789060966180; Thu, 10 Sep 2026
 10:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821131530.3375820-1-ekffu200098@gmail.com>
In-Reply-To: <20260821131530.3375820-1-ekffu200098@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 19:21:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jgc_Cb8Cgop=Zr+cu7ZgEvtFj=V=szT_0sfquNch3XHQ@mail.gmail.com>
X-Gm-Features: AcwNN1XSTG3u4FewQ3cvvW-eEXM30vofm64UweitGiVDuj8gixypoJot8Yuqclg
Message-ID: <CAJZ5v0jgc_Cb8Cgop=Zr+cu7ZgEvtFj=V=szT_0sfquNch3XHQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: MRRM: Use for_each_populated_zone() in get_node_num()
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 3:15=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> get_node_num() iterates over the populated zones of every online node
> with a nested loop. for_each_populated_zone() iterates over the same
> zones in the same order.
>
> So use for_each_populated_zone() instead and remove the unused
> variable.
>
> No functional change.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/acpi/acpi_mrrm.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> index e99cbda83452..83934e2aa0d4 100644
> --- a/drivers/acpi/acpi_mrrm.c
> +++ b/drivers/acpi/acpi_mrrm.c
> @@ -36,17 +36,11 @@ static u32 mrrm_mem_entry_num;
>
>  static int get_node_num(struct mrrm_mem_range_entry *e)
>  {
> -       unsigned int nid;
> +       struct zone *zone;
>
> -       for_each_online_node(nid) {
> -               for (int z =3D 0; z < MAX_NR_ZONES; z++) {
> -                       struct zone *zone =3D NODE_DATA(nid)->node_zones =
+ z;
> -
> -                       if (!populated_zone(zone))
> -                               continue;
> -                       if (zone_intersects(zone, PHYS_PFN(e->base), PHYS=
_PFN(e->length)))
> -                               return zone_to_nid(zone);
> -               }
> +       for_each_populated_zone(zone) {
> +               if (zone_intersects(zone, PHYS_PFN(e->base), PHYS_PFN(e->=
length)))
> +                       return zone_to_nid(zone);
>         }
>
>         return -ENOENT;
> --

Applied as 7.4 material, thanks!
