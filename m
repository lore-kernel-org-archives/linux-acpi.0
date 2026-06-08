Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E38379993
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921581; cv=none; b=J+boVod7ewK65H1AbCbYDmwSfv4O25dus/3epefE5bMRUqLTTLYQzp/liP9MNIlNOtKbQjbsMNMl85s5ClNYDuNQspdeK52W6JG9lGUuyEX54ZTxGaK+IO92cyjMdukYpgSNq2zQlbj8tNuPM+urjeaDD0sfnMKyVB47dP7XGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921581; c=relaxed/simple;
	bh=7DhxZ7yfH4+vfLKOCbiA9cF2BdUf669xcy735WasgC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoVKtFV2I85W35V5RJPSabMWeutObY9P91QIlLIZD0QPNAjU98UjZyc5cgK05f5tPql9uOxsfrbBI4TsbGy00JJCj2EiUsK0rAjxtIctt4Y1tMKLd2DaZYhqO08X1BlTPavNddRCDbfXrXmpbD03SsulM+Er7R0/Sss+ryiqOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3YHIbax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3YHIbax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744061F00899
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780921580;
	bh=XZuHMQwvSRfO+7cG8KDHzH3cLbEldsRvdsUgkplPbQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R3YHIbaxSCqvcWNGvysFj0boItKDZF3+XT9f9532m5miEzVLE6vHAEJgokod+QyzU
	 xe+JfWYmBwdV6YjwVtsp8IF9yFArNLBE2doNORpeO0Fur0Na+ijMEwrsyYVxSnyqOL
	 gAPFGkGRPATzbH26QOiwOI8XI8dpQx3+G0W91hYWdTjiOdkTl1YUdP2+VOhAgI+G84
	 khkWajfrygBXvoyxVOIkJuPld74ENlxhCgnCZZlJmgtxtT9WhyS8hWFCab9MTaj8Yr
	 sL4l1azJjsDwqkJ+Uv0rRCorq0h9EWFMEYR85OIpSAmG8Eykpup54REMD+KZJ5TSzy
	 /2RjU0JzBQi5w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so3576344e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 05:26:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YyKeuw8zR+eZhehBoJEVV7GCb3z5HUmke6elzngv4Aoz2UrS5R3
	ldWTGyxNndNIRGWB1FDPfiA9aPQwZujQ8RJYh3KjxHAW46/ouSPfC/xL/XW4Q7D0gKt/v/2+A94
	qIh1+vSdipqpOwJKbSC+g0O2lfwHq+I0=
X-Received: by 2002:a05:6512:33d0:b0:5aa:6ede:51 with SMTP id
 2adb3069b0e04-5aa87b86f71mr4543224e87.27.1780921578833; Mon, 08 Jun 2026
 05:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601235808.1113137-1-jeremy.linton@arm.com> <ff856534-28b0-4867-abc6-84698b8a5d81@linux.microsoft.com>
In-Reply-To: <ff856534-28b0-4867-abc6-84698b8a5d81@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 14:25:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jSA8N_UzYgrcqfNuXdsyYiowYyTqE=7dAzp8ifjuj7Lw@mail.gmail.com>
X-Gm-Features: AVVi8CdVe0nTEFQx5ZVYD8d8yEwvl2oRql6FNtKmsqA83we1qL4Z_pBdixgKr7Y
Message-ID: <CAJZ5v0jSA8N_UzYgrcqfNuXdsyYiowYyTqE=7dAzp8ifjuj7Lw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Suppress UBSAN warning caused by field misuse
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, jarredwhite@linux.microsoft.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 6:33=E2=80=AFPM Easwar Hariharan
<easwar.hariharan@linux.microsoft.com> wrote:
>
> On 6/1/2026 16:58, Jeremy Linton wrote:
> > The definition of reg->access_width changes depending on the
> > reg->space_id type.  Type ACPI_ADR_SPACE_PLATFORM_COMM uses
> > access_width to indicate the PCC region, which can result in a UBSAN
> > if the value is greater than 4.
> >
> > For example:
> >
> >  UBSAN: shift-out-of-bounds in drivers/acpi/cppc_acpi.c:1090:9
> >  shift exponent 32 is too large for 32-bit type 'int'
> >  CPU: 61 UID: 0 PID: 1220 Comm: (udev-worker) Not tainted 7.0.10-201.fc=
44.aarch64 #1 PREEMPT(lazy)
> >  Hardware name: To be filled by O.E.M.
> >  Call trace:
> >   ...(trimming)
> >   ubsan_epilogue+0x10/0x48
> >   __ubsan_handle_shift_out_of_bounds+0xdc/0x1e0
> >   cpc_write+0x4d0/0x670
> >   cppc_set_perf+0x18c/0x490
> >   cppc_cpufreq_cpu_init+0x1c8/0x380 [cppc_cpufreq]
> >   ... (trimming)
> >
> > Lets fix this by validating the region type, as well as whether
> > access_width has a value. Then since we are returning bit_width
> > directly for ACPI_ADR_SPACE_PLATFORM_COMM, drop the code correcting
> > the size.
> >
> > Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for s=
ystem memory accesses")
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

Applied as 7.2 material, thanks!
