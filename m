Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13553B5F3
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077351; cv=none; b=WMwgYL8fi2i8iKPtqsqHgTo+38UAZBiyZUrNhX594YSy4UXtUE+uZoX/eOC/p1/E9uekqVGjStNixfhdl97S002bYDCLQhZblitzROEmchI3zsefHLU2K1vkHj1dvEBbqkz9kl2wlLFgdyfewMN2KOONocMKkbvGAoACbDbi4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077351; c=relaxed/simple;
	bh=05SYmPVQWFoyTDgjeCZfpOazZFzG+IVtD8DiOeOsWiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9fM/KqickLOeLxYfi77OPPK/GgZe/zwiz1p400k7R4C/EoY94c87ogki/7BUQWJFq+4JkeS8gE4znkc6Ou4jjczayO2V0zPcdT/d/dN6SVizV7aNjq8jf7mdO7XH9AOTaOLhEZ0jxunZnWMuZCLPcXPnbplraV4XUYH8KPUqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMq5gsrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMq5gsrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1B21F000FF
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077349;
	bh=7QW81cvINme6M0bGvDRqQTvKenedhv17lPUFmpuoqXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DMq5gsrPP9omidtY7Ulu0yCBrNiYk1mxcqvGEOCqh85SZKeH+8moIh+neYAvHGwIb
	 4rj/rnZ4DGRM5xQWuml03oXwuBReH7ekavZNmQryjPR5Z2tl9rzNrFBDcmdyrdT7VE
	 x1qUDL4BvhW9IuCg0vi+xmxFgBPuy4tDQ4YqNmF5IAQkdlOvJY9pDpj9BgnWoJ9GC8
	 JanJnx3DCni39SmnMq0bf++kQMs/YE02JqvAIJaO40gPET8V53nBkcpBwMmmh0D/BL
	 /dQy3ST4mBQ+N2uvO5G5o0amAKCi6IedU5kulq7pk4XATFmzlMR20VJh6E9pTWoG05
	 0ql2rA6KwQsnQ==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5da7416f9so28907201fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 04:42:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwa1f97/FJjhftIsWGhUujoczNSKgBgrggHWJrS13k9fQWCcDmSJDWt+fPARQsi+5HBRjLe/eJzVp5B@vger.kernel.org
X-Gm-Message-State: AFuF++nAcHfqq3ns+dmlItUX+yjn+p5jtlr+qUUgkv2vuJzWRpse9MJG
	OB0aj+kGj9ianh6zj1LcA010sO3Tbibvita8SEhNcpYkT8ZYUjqoDSHV0fO94St6iJprXnyO0MV
	QQQEKKrSSN9HyLIWcbzrMlwYRblNo+Mo=
X-Received: by 2002:a2e:bc10:0:b0:3a1:980f:5907 with SMTP id
 38308e7fff4ca-3a627892485mr3982481fa.8.1790077348118; Tue, 22 Sep 2026
 04:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <513319f19ed6b0b6d4c76dc517074531966b98f5.1789745223.git.robin.murphy@arm.com>
In-Reply-To: <513319f19ed6b0b6d4c76dc517074531966b98f5.1789745223.git.robin.murphy@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 13:40:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j72dht4wiVcoFmk2Rt1pvPL7Yrr_29jihzfKAb3Pu24g@mail.gmail.com>
X-Gm-Features: AcwNN1XFdUIteGPaJpXW86qPJXvAnlLXBq3k7UIJUIoBIulEgnEmcSHCAYpWQEk
Message-ID: <CAJZ5v0j72dht4wiVcoFmk2Rt1pvPL7Yrr_29jihzfKAb3Pu24g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Provide !ACPI stub for acpi_device_uid()
To: Robin Murphy <robin.murphy@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 5:27=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> While the likes of acpi_dev_uid_to_integer() and acpi_dev_uid_match()
> already have stubs for !ACPI, the basic acpi_device_uid() getter does
> not. As with acpi_device_hid(), add one for the convenience of portable
> drivers who just want the string itself - in fact they are so much alike
> that we can simply alias the exact same stub definition.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  include/acpi/acpi_bus.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1a45e0d521d8..ed309ea4785d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -963,6 +963,7 @@ static inline const char *acpi_device_hid(struct acpi=
_device *device)
>  {
>         return "";
>  }
> +#define acpi_device_uid acpi_device_hid
>
>  static inline bool
>  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_in=
fo **pld)
> --

Sashiko has reservations that look valid:

https://sashiko.dev/#/patchset/513319f19ed6b0b6d4c76dc517074531966b98f5.178=
9745223.git.robin.murphy%40arm.com
