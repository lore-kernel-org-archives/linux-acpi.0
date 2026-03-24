Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D338A2A4
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374526; cv=none; b=tkkryW4rHvGXJPAZvM5XZ6GW004xoEMpomD9zUPQheiv4tc9gmx1c78ZxSxxBWU3fN7WSm2f2vyBa22zgeCJu5j6fzeBWG9GFDRjLPIJ2ChPq5jmatMpfbQ9C1JIixvlBSWhCzeNDsUul1euxT9NQIMwmkTQBQrejjo7jntuj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374526; c=relaxed/simple;
	bh=G6WtppSinKwaKrXS4u1QoHvjZXzRhGZRLr+//RSkKyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOQEPECHRFxyrmcxRElE9PvvKw0RujZU4Arm/WYrEX04fWa38lj9fTABq5WbbCASB9mhW5xrH5XwH8y+rthsAyGyx3RqOmfs1GUHdpNnGvWPq08gfN/4WGOH9q7T6GSOTjEGEGUWzbxrOia7BcZx/O9lhP51a/zkgaW2L7W9bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7E6wzH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7E6wzH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08155C2BC87
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374526;
	bh=G6WtppSinKwaKrXS4u1QoHvjZXzRhGZRLr+//RSkKyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y7E6wzH5AlTezEHW22/RrB8Tk4KLPsDarKSXYKo4XMHsAYaPpPrTXl6uczO8OCuGC
	 kvBCv2yNZ0kQpohxahH3hoGSA8DiKiBKn6cs/l0+SnQrmXXYn1Vfht4nyd+z5hq+2N
	 9PUUON0VnvCoyp6EPdr/AtFCWiyOGpFwyn78T8EUbasVAhs6YX/iLw+IL8BIbTYDsq
	 SenYwtaf22GqvHvpkl/uaDRfLrzgjk8QmDQHEED19AokcXB5E96bH51LZruhSFRh2Q
	 L5fDXa8k+rZuekZqp53641y9mmCImXGpbQm2OvAqgW9FmR4wCcdXAD6iJc1LnPOmv0
	 4icuB5iZYWW9A==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ede943bf0so2077507fac.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 10:48:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw0TGsk3DtKh110X68euZcrP+dMnvk6BdOpqjTHZvFOzBkHpOtZ
	RU/FE4O7jppff7bLwxV7td4ZCW4lKXBkCq9P/hleHGyIC9bg6CnA3OC2l0S3+TeiUUmvmUzWx8W
	yXOWFZf9BZBPzMmWQFTye6v9D7sNw/II=
X-Received: by 2002:a05:6870:b00f:b0:417:3421:13ff with SMTP id
 586e51a60fabf-41ca722a383mr316014fac.29.1774374525066; Tue, 24 Mar 2026
 10:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324165458.1337233-2-bestswngs@gmail.com>
In-Reply-To: <20260324165458.1337233-2-bestswngs@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 18:48:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gPAotTij1Qv0LZH5fQX7Fi_SxA3qZxX75W8vx4Vd=pLA@mail.gmail.com>
X-Gm-Features: AQROBzCIs9VJWf1HMHAIJRiJEgJC8bMoXo_HsP8MI_Om-nM-aKpmVl0LzJNzrt0
Message-ID: <CAJZ5v0gPAotTij1Qv0LZH5fQX7Fi_SxA3qZxX75W8vx4Vd=pLA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-acpi@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 5:55=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> When ec_install_handlers() returns -EPROBE_DEFER on reduced-hardware
> platforms, it has already started the EC and installed the address
> space handler with the struct acpi_ec pointer as handler context.
> However, acpi_ec_setup() propagates the error without any cleanup.
> The caller acpi_ec_add() then frees the struct acpi_ec for non-boot
> instances, leaving a dangling handler context in ACPICA.
>
> Any subsequent AML evaluation that accesses an EC OpRegion field
> dispatches into acpi_ec_space_handler() with the freed pointer,
> causing a use-after-free:
>
>  BUG: KASAN: slab-use-after-free in mutex_lock (kernel/locking/mutex.c:28=
9)
>  Write of size 8 at addr ffff88800721de38 by task init/1
>  Call Trace:
>   <TASK>
>   mutex_lock (kernel/locking/mutex.c:289)
>   acpi_ec_space_handler (drivers/acpi/ec.c:1362)
>   acpi_ev_address_space_dispatch (drivers/acpi/acpica/evregion.c:293)
>   acpi_ex_access_region (drivers/acpi/acpica/exfldio.c:246)
>   acpi_ex_field_datum_io (drivers/acpi/acpica/exfldio.c:509)
>   acpi_ex_extract_from_field (drivers/acpi/acpica/exfldio.c:700)
>   acpi_ex_read_data_from_field (drivers/acpi/acpica/exfield.c:327)
>   acpi_ex_resolve_node_to_value (drivers/acpi/acpica/exresolv.c:392)
>   </TASK>
>
>  Allocated by task 1:
>   acpi_ec_alloc (drivers/acpi/ec.c:1424)
>   acpi_ec_add (drivers/acpi/ec.c:1692)
>
>  Freed by task 1:
>   kfree (mm/slub.c:6876)
>   acpi_ec_add (drivers/acpi/ec.c:1751)
>
> The bug triggers on reduced-hardware EC platforms (ec->gpe < 0)
> when the GPIO IRQ provider defers probing. Once the stale handler
> exists, any unprivileged sysfs read that causes AML to touch an
> EC OpRegion (battery, thermal, backlight) exercises the dangling
> pointer.
>
> Fix this by calling ec_remove_handlers() in the error path of
> acpi_ec_setup() before clearing first_ec. ec_remove_handlers()
> checks each EC_FLAGS_* bit before acting, so it is safe to call
> regardless of how far ec_install_handlers() progressed:
>
>   -ENODEV  (handler not installed): only calls acpi_ec_stop()
>   -EPROBE_DEFER (handler installed): removes handler, stops EC
>
> Fixes: 03e9a0e05739 ("ACPI: EC: Consolidate event handler installation co=
de")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/acpi/ec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 59b3d50ff01e..c981a53434ed 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1655,6 +1655,8 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct=
 acpi_device *device, bool ca
>
>         ret =3D ec_install_handlers(ec, device, call_reg);
>         if (ret) {
> +               ec_remove_handlers(ec);
> +
>                 if (ec =3D=3D first_ec)
>                         first_ec =3D NULL;
>
> --

Applied as 7.0-rc material, thanks!
