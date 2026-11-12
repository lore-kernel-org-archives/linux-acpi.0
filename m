Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505364;
	b=QFIvWOuTRRPwQUoIvD5hkMWnsu21J62U9tWWZiRTC6SVSj1h8/CQPswqKMgMVv96cFHW
	 JVHrNkIQiovsbSRGwVZmTc9newybp93Ww12IrhY0CX4eszDHih/fO0IHKtWhE50E8PjWo
	 uDsAHmxAUlGyTgFJU44QQ0yqJBSGjgsGn2BxXgy7paoVyiLgoxpvKh6dyOpJ4zTM8HZHP
	 wFn+gKYFCOWftnOgmxqV1gF8SmBZZ3d4DH/vEDXGQ0UjOAWk+7JYLAWzWgjBWUD+9HG9l
	 tWMi+FbMjDP5KBtYFKyz6J4QMGiLAEmgBQFO+TZUASoMCma9cJ78sDYhyn0j0gr/uMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505364;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dzWJEFgvdT+vHRtnGux6cMYJH+knM9Gr6vtgOh5tUQs=;
	b=H9iEK117QmCnq4uhdicGWem/bBSzKI9K4BxS+L7w6hbRFrT1YLP5PkaRnjfj+OWbrj/G
	 /GFubnHXj3W81hotyKA3Z4wGA2NkeHJJCZHIxM8ZBpkZLhmd8QwicILt2umhmAORD2GDK
	 VADp17fOaC6qsT1FF3F39X3IKibw6W0cwL0wuhvlM1ObR+kVbHLt7O4Q5IQYr3iSSeB7B
	 j6eZWWZ7Ayl2WHL45oy4clAD7990n3fhHTfAbzbPU/Dy5EYL1azS0PuE3NckGhgplDFqe
	 t6ErZ2Z9qSqYf5qR2qfcgNn4X5Fifn4AyGwYpqzL5oiz7FcLngfHkccNyobdMX48Xcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfyjjQyu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631B606CFEE
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfyjjQyu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2161F000CA
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505363;
	bh=dzWJEFgvdT+vHRtnGux6cMYJH+knM9Gr6vtgOh5tUQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cfyjjQyuczet0nt0DwhDdEictwt3nSHiMm9lPgyLiD8nDh8/xcZcJISvkTYKYf1op
	 fhQOU+iVyRh9Hss86gMDjFaF8gBA/rLyws3WvKI4UMtegfrr5zCva7ZjqZt8CKaj5y
	 BO4AGVJ4IeF6F+3H/1dlRwUEM15osL0RPtZ8ZXP3cDlN05dZJX6xdqDKiqLr5RLwiT
	 ay8Hg7b+kq2UpdXtJV2pXxHhMShr/oO+PxC5mpnj+LY7IkRN8lInxaErdMAk7IU8kW
	 +8xJIVZu5WUBA1T9zfCxqFi0nUuJVRuz1lYW1MkF2rr3pImxqef66wLX5f/dflxggk
	 xqq8HO38q/ZyQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3acff56a300so40490461fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 09:42:43 -0800 (PST)
X-Gm-Message-State: APuU4Z+D6bE9nlBYWELEcOlMNcwH9iV1/uVQZoztuddHphxxF98Tpk9/
	1bvwIMuO5aQjIF3y+v86BGwUVwR44sNCplm5yQCPeZ86t2PKK+aM/ERqZLhW0+DJyI7DmU9KDLR
	omq0gXP+hf3ackP8J3PwC3dG6xHFwngQ=
X-Received: by 2002:a05:6512:308e:b0:5bf:d1e4:a034 with SMTP id
 2adb3069b0e04-5c170b1c321mr22971e87.21.1794505362241; Thu, 12 Nov 2026
 09:42:42 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <13049690.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <13049690.O9o76ZdvQC@rafael.j.wysocki>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 18:42:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gshFCfoscf=q6Hf+=VYP8bgwO1J15AdYAKcCFr8=TtsQ@mail.gmail.com>
X-Gm-Features: AclHuK9Bd2DHl5E847k92KIt96ido52lXPqqLSIJUvnnTI75NP7Kob5DIdXh8WY
Message-ID: <CAJZ5v0gshFCfoscf=q6Hf+=VYP8bgwO1J15AdYAKcCFr8=TtsQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: CPPC: Drop two compliance checks involving
 nominal performance
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:39=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> On a number of Intel platforms in the field, the nominal performance
> value in ACPI _CPC (which is an integer) is larger than the guaranteed

I said "larger", but should have said "less".  Sorry about this.

Will fix this when applying the patch unless there are other comments.

> performance value and it may even be larger than the highest performance
> value (that come from register reads).
>
> The new specification compliance checks involving those values added
> by commit 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control
> semantics") cause the CPPC library to refuse to work for some CPUs
> on the affected systems which in turn causes the intel_pstate driver
> to overestimate the maximum performance levels for those CPUs.  One
> of the affected systems is Dell Pro 5 14 P514260.
>
> In this particular case, the fact that the specification is not
> exactly followed has no implications and the checks enforcing
> compliance are not useful, so drop them from the CPPC library.
>
> If really necessary, they will need to be done elsewhere.
>
> Fixes: 32299b29a887 ("ACPI: CPPC: Validate _CPC entry and control semanti=
cs")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/cppc_acpi.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -2940,9 +2940,8 @@ int cppc_get_perf_caps(int cpunum, struc
>         if (!high || !low || !nom || !ref || !min_nonlinear ||
>             high > U32_MAX || low > U32_MAX || guaranteed > U32_MAX ||
>             nom > U32_MAX || ref > U32_MAX || min_nonlinear > U32_MAX ||
> -           high < nom || nom < min_nonlinear || min_nonlinear < low ||
> -           (CPC_SUPPORTED(guaranteed_reg) &&
> -            (guaranteed < low || guaranteed > nom))) {
> +           nom < min_nonlinear || min_nonlinear < low ||
> +           (CPC_SUPPORTED(guaranteed_reg) && guaranteed < low)) {
>                 ret =3D -EFAULT;
>                 goto out_err;
>         }
>
>
>
>
