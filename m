Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182698;
	b=cp7ZVbu1tbNiV6NU68ycczFf3G3eRBqoIKccsG7hEFWiXdjAH0B5uBO6eiNSk3kk1fqZ
	 cRSgJi253GDq9gyQIqrRHjHvC5W6xqX4O4KwaEqaJVmkrDSEnZEtb8+HrpbvqEqJkGzE5
	 SpgvHyOxghwXq6T2Xs84SMrceCRp2B1DwHmrZfVaF/QDrUNJz7KH/f+pMLM5GUIUBmmwu
	 PLSbY6FMvUtYcQRW3YeKJDtDtgRAHBv4Ih05LsViPzetse9q9Fot7I0Q/au2rxJQZ8egJ
	 y32zoLPHWemdAFiKzdAeBJlgyot2cukxo2Cu9tMBzxikvFk4jRoRT5F1a5F02Dc6UTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182698;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=klNlDWbGGWZJyrp4XweM69MPghYodR7UqYEX7WrNp5Q=;
	b=LRP9jrdqXLEypd4N9a+3SDar+zXR7TYAMc57PGh2jruz5qWZunCQrSa64uJP0X3/tFu4
	 GUSEi995jaZ/hIu1ACimKDVbld2zwwfQmyxTUXu3RGw1I3Ygr+UU3p8z5546jf2MQEpn5
	 nSVjrsQ09GRjUtszzLEofQQJ6izJeU39/FxzR3GkYKZ4gg1ipS5IO8TGDb561Z/SOkz/+
	 6dGlw9t4+Pvgt4pYlVrJOUnA8gSstA3XqhKBvqC+B2tIsAP0ofRxUoqL9So6ygZP5hLXz
	 wGVXmtdbb/InrOA5i1v/bo6zCN49srD9BcfDO31zY1XxxNkDybbvDiuJ43LBvnSFk2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYSpOgva;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F539606A33D
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYSpOgva
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9237C1F000C6
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182697;
	bh=klNlDWbGGWZJyrp4XweM69MPghYodR7UqYEX7WrNp5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nYSpOgvaIuEb0MU8QzpvAmzwUXi5z2WzSSoDTNKbPpSMz54zaZf3EaDH8d/UOgn1a
	 2Oq17AFie6dqdSJpahifkaaw9uLFhPiFrXDEyLjIi4Up95Ir+dhIelWcqVO3rouY1e
	 pUecJs51aiZXup6JHBM1lolSzZuWnG7Yqknts+S4AvAwe/ZdfvF/q3j6I6PAfCk0DF
	 c474H69Smc2ceGCkJX/VMXtrY8OLGF9V0KKuyfsKG1J9yPreFcS9NI+IXMZ5lEH+/d
	 vxg26Ypek0o3FvgOIJ9OKOmPKEe8VsaFtlCaPZ8FXrWe1EaZyOuAHfuSV3G9P+MleF
	 xlPJTZhi0BNRw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so1150283e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 05:51:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHpWORJdqe1TH8tm4DguWs/7p8hNJFlW18OFA3hZAM9piLlpIPzb2tT834erxepxevwFrY6QdDYT/Oc@vger.kernel.org
X-Gm-Message-State: APuU4Z9MWYsdxUpN2h0CrL09AAZg31C2dRe++CbDRpkB4mFGrh5yLats
	sxZ2Vl9PbHqZATMWtQvkF90KBYexNuzazOM7NV/o3pZfhDiPFs6EAPNhUoomRLoRlmLu9dpoJZ/
	GC7UAnGu41Fs6KVl4uD41HxP3a7MZ1cw=
X-Received: by 2002:a05:6512:3e04:b0:5c1:5169:7d96 with SMTP id
 2adb3069b0e04-5c1bc7bcc2fmr1070965e87.18.1795182696081; Fri, 20 Nov 2026
 05:51:36 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116131720.75103-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20261116131720.75103-1-johannes.goede@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 14:51:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jNJ_8-Sw9jZx+-B6GA8oNLHNYT=MTfYysFRUXQ-cHLEQ@mail.gmail.com>
X-Gm-Features: Aa3M54ojVHKtPF1tVTeprGJORFQfGjGr6dSVpnkyvUpFVQ7wIWMspvfH0fKmjOQ
Message-ID: <CAJZ5v0jNJ_8-Sw9jZx+-B6GA8oNLHNYT=MTfYysFRUXQ-cHLEQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Skip acpi_scan_dep_init() for processor devices
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 2:17=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> acpi_bus_check_add() only calls acpi_scan_add_dep() for devices of
> the ACPI_TYPE_DEVICE type. So the dep list of processor devices will
> never contain any deps for that device, making the acpi_scan_dep_init()
> call a no-op.
>
> Make acpi_add_single_object() only call acpi_scan_dep_init() for devices
> with the ACPI_TYPE_DEVICE type matching acpi_bus_check_add().
>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
> Changes in v2:
> - Turn this into a oneline change instead of adding separate top-level
>   if statements for the device and processor cases.
> ---
>  drivers/acpi/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 96b8b0dfe339..28563becfadd 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1881,7 +1881,7 @@ static int acpi_add_single_object(struct acpi_devic=
e **child,
>          * this must be done before the get power-/wakeup_dev-flags calls=
.
>          */
>         if (type =3D=3D ACPI_BUS_TYPE_DEVICE || type =3D=3D ACPI_BUS_TYPE=
_PROCESSOR) {
> -               if (dep_init) {
> +               if (type =3D=3D ACPI_BUS_TYPE_DEVICE && dep_init) {
>                         mutex_lock(&acpi_dep_list_lock);
>                         /*
>                          * Hold the lock until the acpi_tie_acpi_dev() ca=
ll
> --

Applied as 7.5 material, thanks!
