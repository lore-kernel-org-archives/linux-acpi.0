Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311927;
	b=wZKu2Gngz+GxyY4E9eoroZEUHDEdEk3mFomiVs+6zU43ARcfr8DlHhZ2BzGKQvozotIc
	 w8kslwCqvY6Lxewst7jNh/MB3Q0M1EA4VW2PqeKBTbu+2F0elPNjmADYQQWk/ATCYWmOi
	 TKxehpoIQeQDmfY7Z287UaBkjxsP7iMx5ggSr3r9J0bZMNmXVrZYM3KUl41z4N6lMDCr/
	 pybWKAEEbXqEpSF+R8wlgBqmsf5FNnuIEGrj+gUlte/X/yZHhD/h2N30lQmu+weytPgfG
	 +txQIKEiUHGgW/Gzcp/jXIbHboqchM4nFzFcGheXHsNAOpeMEBvc0zNsMfuNslYGQbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311927;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8xrzXhTL0WVs+COqTlijJQelSK0Qwyr/ovJyC3RLEII=;
	b=b2avKo/mO0jciTydKRJxgvSIlRXvVHqDPJWNsNTlgKkhvaFZo/TFbRqMRawrIHe4Kp5v
	 CtRrqdWUvSESWzH7DtnxCL/ewvCL4AwH6AeoBvsolXsy7OzSuzM9/hzR5NtVL25qWA6ZH
	 0/X1TFULlb4tI4Qj2qEqDCfp52nrcmEmaEZZVf9JPYCP60WU9QA8TM2OdZAezV5mlBsxs
	 arDvDhrFpYyVGMkadRQAKpC+kybKhgf65HR51lfMaPj51EYM0nSqQKdUIzpdI4G2PiG7N
	 LBVhut5J24XzhyvQTLcEVoNSXuNg2Hq9ZncSKWljfWvaXvw+Hf+iW+MvDZc/Tp/EnBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emMxNhtQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A34606A330
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emMxNhtQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9069B1F008AB
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311926;
	bh=8xrzXhTL0WVs+COqTlijJQelSK0Qwyr/ovJyC3RLEII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=emMxNhtQXT6GeTvh+kRkYwEWLH00HiNJERy3KvUu1oP+Jo823ihfoYWMD4dWQ8b3E
	 D0PKYmvBaybuB0d57/MYtPdxyy4SiFEw5FXFGmhFYvVkK2RJtp3I1S9+mBSR/k3Dv3
	 f01ILM37j7MCQsznWJh+JlhOj+ohzsv472o4Gfozjnx2hkqfju4OIeFeP395+l3Qld
	 8p9rfS/OiakXatmNF4PYWIUBV24HVxbyvA5uW6jLZ1Z/FJv3ssc5ctzqjC9UByWLPY
	 21FQLvDjtxcBFETPHRDCV5rEnM/2XbOHpdgeqRG/ARr54N7RGDN8AILQE1zJbuSwWB
	 3Odo42VY0GyqQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso290653666b.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 03:58:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErECPzsKZrBLtuHyo6xvWlFg+aa5PRLwE3Fhm4+5/Tgnyzzh6/UlpprGu5cFw3wbvHzrqZPdEDKX0+IH@vger.kernel.org
X-Gm-Message-State: APuU4Z9/dsRNSvaCNCsGdPwsWXOpZEC9XFNme0Mh976Z43HOQrgXl8vI
	ZbO6CfaBK+EHR+Aiqz7GpClhx1ZetYkTofjcZjK2Hp57f+YB+si0KlzTGs74WOp6aUvqERKIFzO
	G/ez1MfMIR4q79Z3VMCc+rbOwVSiCq24=
X-Received: by 2002:a17:906:3f97:b0:c46:8909:963b with SMTP id
 a640c23a62f3a-c5049548348mr132813666b.9.1794311925102; Tue, 10 Nov 2026
 03:58:45 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110084613.2746641-1-maobibo@loongson.cn>
In-Reply-To: <20261110084613.2746641-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 10 Nov 2026 19:58:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6DetSReoZviN_JuJzuzs9ZvUxXg9UXqKg-nfCu-+eRWQ@mail.gmail.com>
X-Gm-Features: AclHuK84cDWlYHFN5XyFvyk3vWEarUjoMDQprQZIFAhcunkS7NK99kky2uOcYIo
Message-ID: <CAAhV-H6DetSReoZviN_JuJzuzs9ZvUxXg9UXqKg-nfCu-+eRWQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: LoongArch: Fix IOVT table parsing and add
 checksum validation
To: Bibo Mao <maobibo@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Nov 10, 2026 at 4:46=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> In acpi_iovt_init(), hdr is already a pointer, so passing &hdr is
> incorrect. Pass hdr directly instead.
>
> Also add checksum calculation/validation for the IOVT table.
>
> Bibo Mao (2):
>   ACPI: LoongArch: Fix incorrect pointer argument in acpi_iovt_init()
>   ACPI: LoongArch: Add checksum support with IOVT table
>
>  drivers/acpi/loongarch/iovt.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
>
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> --
> 2.39.3
>
>
