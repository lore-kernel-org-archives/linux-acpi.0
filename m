Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820547;
	b=1ON5AoaavyaGfwDR8spe76qMg7GQHGFEKIdpamPFpNuYol98sVamLPt1cAYh82ONlLbL
	 X8dc5LdpxoeBnIrzs/WljKnk+JxmZ5IriwaWwcL3p3TxYRkr3Sw+074hofwBZYd5vf0Cz
	 RZ4GjM7xu5S31njGIgBzShDE3vKwwh7BNswf0h7OB0Alsr4kS0BaAWZimg/T5qxXv6Bl2
	 FBwjZekN8/EeQ0LrEbH6MHTh9RfIR/Wk++ehtgdeGBPHJu6zmlWob3LR96IKujngs5Qpw
	 ZHF2cNQ242x785YSiNIjzH2NrxzWIeJKPy3umSZn5zTtnu9GIny+VmwLLA+dTbzcU7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820547;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NAVxLkX0a4bcfcFu61ZbxpmUsM8xwJUDmfjt4hb3NOg=;
	b=L1OBmeQQpD+gHM4mVYfKewqQS37t0m3XYAMEoscVivHuF/rVbC6rdgAOoVjFwIxgDiFH
	 /IASCg3kqtuFVF/co6wUfKtvBjIOo9X18QrlcXBUjROARYYvi7b/RECdUg0ODV7cqrptr
	 AN/ZysivxqNUvK8dCo76+bmEAy/1V1ELdiF4fKuTv8VmuZD2XBNrnBlqHIEA/GBXgT7s5
	 PUxn3+fn1bGBYw42CfiWOL+eh2Mkj4YqeauIH6oPPLJypLeieO5cLGbLSU+C1alwD6kbu
	 n13HvtwKt/SxOmd1HRdUm96OzMhWCbJvnaz5Etq7Rq7kRLy4CpP1hUYrAiAhetq6F3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJiu9wFw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8B606B38D
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJiu9wFw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AF21F00A15
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 19:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820545;
	bh=NAVxLkX0a4bcfcFu61ZbxpmUsM8xwJUDmfjt4hb3NOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dJiu9wFwHFqFy+VrcxAIDOcppy/ms4oszeBIbS2w3ARDb7FKT88vZf687qS61jvW1
	 BirjTGYhMqCTNqxZ1AzXYMfKSPYCK92z7hqo2JDaftN+flR/+sNotW959s+I6vNjpK
	 D37uxQLv7i0ve1Q5WNtWP7Vq5C8hXrEi9ySEACfeSZb7fzmpatEBt9ahiTIeorI/m7
	 XXSsb/kQOzBuCrYbLeO1qj54OXKaXjroyqag0ip77rXQ9yaCNZ4gQI7FSr1DR3xG25
	 7M3oVGJGzoipKEUEbwAiDh6xKzXVPlnDzRxOdPvvD4oyrV7u8Ntcz10BYTXey26h/X
	 6X3WWSkmNnIHw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so1035277e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 11:29:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxcMehXJvfZHylhLBw9c2uXJDX9JdN3bT7E9ZxESZMsnnlW1gEzGvI/vjWxTKVEOh/xPi3GaIoh1iLD@vger.kernel.org
X-Gm-Message-State: APuU4Z8uI6wZNGKHVXZiJAMmhkZxNgaGdc/6dRGpeBd9rLlruh26x9Pu
	RER3OyWVhjVuirAHy2WW3nLsRmA4D5WEETxPkRGgMsd9wycwkqJxKpjd8ZVFAj815HLmbnav3Dm
	zgPV1psgiqBEUpW6uTHMeDRc5Ff2SYhM=
X-Received: by 2002:a05:6512:124a:b0:5bf:d60c:9f98 with SMTP id
 2adb3069b0e04-5bfd9583912mr6468724e87.59.1793820544193; Wed, 04 Nov 2026
 11:29:04 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029034507.2721580-1-sashal@kernel.org> <20261029034507.2721580-2-sashal@kernel.org>
In-Reply-To: <20261029034507.2721580-2-sashal@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 20:28:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hGA=sF2duyU3ijoc4Tx7KCjuJuaOz8Bhrx-qSSm85AEQ@mail.gmail.com>
X-Gm-Features: AclHuK9iYrb5IlkXSdvE-hDJTa3sByHcfkzVSmMUA4_p8089h-1HcV4DodjfzXk
Message-ID: <CAJZ5v0hGA=sF2duyU3ijoc4Tx7KCjuJuaOz8Bhrx-qSSm85AEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: scan: Print the offline failure message in acpi_bus_offline()
To: Sasha Levin <sashal@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com, 
	syzbot+a265816368571f78ab88@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 4:45=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> When a physical node of an ACPI device being hot-removed cannot be
> offlined, acpi_bus_offline() passes the physical device back to
> acpi_scan_try_to_offline() through ret_p and the latter prints
> "Offline failed." for it after the namespace walk.  By then
> physical_node_lock is not held anymore, so the device may have been
> unbound from its ACPI companion and freed in the meantime.
>
> Print the message in acpi_bus_offline() when device_offline() fails in
> the second pass, while physical_node_lock keeps the device bound to its
> ACPI companion and so the reference taken by acpi_bind_one() is still
> held.  acpi_scan_try_to_offline() only needs to know that something
> could not be offlined, so pass the ACPI device back through ret_p
> instead, like in the "Offline disabled." case.
>
> Fixes: 303bfdb1a14d ("ACPI / scan: Add second pass of companion offlining=
 to hot-remove code")
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/acpi/scan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0b17a7e519569..07d32f118631e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -165,8 +165,9 @@ static acpi_status acpi_bus_offline(acpi_handle handl=
e, u32 lvl, void *data,
>                 if (ret >=3D 0) {
>                         pn->put_online =3D !ret;
>                 } else {
> -                       *ret_p =3D pn->dev;
> +                       *ret_p =3D &device->dev;
>                         if (second_pass) {
> +                               dev_warn(pn->dev, "Offline failed.\n");
>                                 status =3D AE_ERROR;
>                                 break;
>                         }
> @@ -235,7 +236,6 @@ static int acpi_scan_try_to_offline(struct acpi_devic=
e *device)
>                                          (void **)&errdev);
>
>                 if (errdev) {
> -                       dev_warn(errdev, "Offline failed.\n");
>                         acpi_bus_online(handle, 0, NULL, NULL);
>                         acpi_walk_namespace(ACPI_TYPE_ANY, handle,
>                                             ACPI_UINT32_MAX, acpi_bus_onl=
ine,
> --

Applied along with the [2/2] as 7.4-rc material, thanks!
