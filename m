Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46C302742
	for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883664; cv=none; b=WCQialY40l1DGgZ2h6uDoieIw/j/363+Jbb0Ef26fxkadXfKDAb08rD31lT2hzHSw2rEfcis9a0CN2I/LpfNLnyuITOqn7XVZstDIvTIplRzRvtLnuC9PkGNtGzrFPs7HvBIUAPrHUBRs12pbrY5QDUSZ2QuQbWTmLgrhkovYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883664; c=relaxed/simple;
	bh=xHrHVh2gjtZAlMvc6B7qF9sFWvYbUvBLX/gsoRzMuy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEPssLkvkXpmRYOxdYiiBsMywe9TyHRkfeoQTTBVzYx93t63nmdoS26L9O8HLhJiZviQ3k35QgPmFU3W7EAiUri4MqiJDWJACh61n/7mfXD7wNe6MZjVY5QOa/P6bj5CpO1a1RAzSRvfFcbTGsvdRDVNgr3T6TCBplfhNpLYOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK3Ywlfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK3Ywlfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076761F00A3D
	for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883663;
	bh=BBRiqcsup+KORBlJFnYzM635PePacrdbfpZxDOoL7Vg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FK3YwlfyCMCgZU9yD/KirBWEoXk1CDd/copxSK3wf51rc4q2epGqErB5BBPiqTtnU
	 6sUnpJ8S6WsjFh2ZSMw4bfTHL/XA9h38+mTC/l+25vZQgUkg2SOJLNBGIACE0zB70L
	 2/V6JHvJElOaiqDj3eurYjCnr2f6OqWsh00pUGOCeQ5rFpmNkH/ddmlF48tJc4MyTU
	 2q86Mt0bYcI0uhGhc/DeV1MovKREEeoKiSDKyKCPnFyKhHZLushpVy7gOOt+/qYds2
	 q17rcGwm6hRRSzR8TfbiwQZQMRpax/aIWn8KxRHqZCLsLTpzviGDXuRT/ELqddYTao
	 tbL4Mx/LRvHpA==
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5751b7d147aso4242586e0c.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 05:07:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9mEBpBD26OhIiYg2561LBcuylzVvR3sXhXK2Vyn4qTMetGhclNGCMJoUbrgM9wMmXVMnrZdP+5ooTb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aFy5eo5bQMqKljIW5bCeOytmtmAG6jX5CjYzD306HcFSD8YX
	oHpAnkOAixtc0W3JLsymxYhimG/nvhpEpAiWKabrCHRwZvKbIfBVnje+0B4ZBifArdYFOUINkJ3
	MimhWCnbXTLvIHeFz+XldN0+DyuykV1w=
X-Received: by 2002:a05:6122:2206:b0:56a:fc35:9664 with SMTP id
 71dfb90a1353d-5865e4a8531mr10884255e0c.3.1779883662314; Wed, 27 May 2026
 05:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778378939.git.jeanralph.aviles@gmail.com> <39d1c5567a2c0c6454a0c10a32d2dd853349d303.1778378939.git.jeanralph.aviles@gmail.com>
In-Reply-To: <39d1c5567a2c0c6454a0c10a32d2dd853349d303.1778378939.git.jeanralph.aviles@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 May 2026 14:07:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7Fefk46xdEfG8dO+Bouj39MqN7ppz+7QarsFv=O+6pQ@mail.gmail.com>
X-Gm-Features: AVHnY4I2lK3ZNIN89vfFUQeNF0kbatb_Bxb0xMuE0-4hS-r_kE8WwH3AXp86p3Y
Message-ID: <CAJZ5v0h7Fefk46xdEfG8dO+Bouj39MqN7ppz+7QarsFv=O+6pQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI: video: Do not initialise device_id_scheme
To: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 4:48=E2=80=AFAM Jean-Ralph Aviles
<jeanralph.aviles@gmail.com> wrote:
>
> Reported by checkpatch:
>
> ERROR: do not initialise statics to false
> Signed-off-by: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
> ---
>  drivers/acpi/acpi_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 05793ddef787..e8880a2113cb 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -63,7 +63,7 @@ MODULE_PARM_DESC(hw_changes_brightness,
>   * Whether the struct acpi_video_device_attrib::device_id_scheme bit sho=
uld be
>   * assumed even if not actually set.
>   */
> -static bool device_id_scheme =3D false;
> +static bool device_id_scheme;
>  module_param(device_id_scheme, bool, 0444);
>
>  static int only_lcd;
> --

Applied as 7.2 material (with adjusted subject and changelog).

The rest of the series has not been applied because they are minor
cleanups that I would do differently.

Generally speaking, checkpatch is for new code.

Thanks!
