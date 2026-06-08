Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4468134D3B9
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922189; cv=none; b=C2UYWOuGlmapK2813DEdoHrXSFVQiNfr1+QD1qKYU+AdXjdWGsh6abm6J5193i5Wya4H4jECqRKXVCN1YDUFz0Fj0wHFrbIkjE/4ZB6ApvXVZAAcbWS02u/H067TDWcff8bKI0vw3omx/4sltLZpcorCJHzzhJ/dyPRuYQJjIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922189; c=relaxed/simple;
	bh=eZ55qpaboQW4WiNjRuICiXpsY9DIr5r/k2MSDBEMUSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUHjKUib/WlsecEzVJ1qNGACQVfdYIHTub6YaTonSNRUGB5gex8LVZVSJo76dkx72v2Ha2PLP8wp6+g3Hf9FkB5laxtim6dtBd2BeEqgR7MR4/h1uzgEZgRrHD0wxiEmFS2CdTB3O3at0dpsHl2iVLTm81M9Ei+KxqiRhRs2Sps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDjJNhzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDjJNhzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99B71F00899
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780922187;
	bh=uuwsAFBtkAgHh5HFsocGkIr00//2kER23ReKpX5/rP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dDjJNhzQhZzRQPnEtjLLnkHbjJv0aZhthY7RuQcCNrTT/9rZBMysPtBsWJma+Q1e2
	 ZwtKLcwgoYgXQ/tuRd+3lCintDLxuKtmZYGObCdZbDB0GUQfanfifNa2zXS70lhVLu
	 ylINb9YjSTtynEFWtC9yv9TynwZMtotPe3hVq8PW5ToNn8zSHB8TsWIImSAsNdSHsW
	 mpDj2xuMaMhzVll6P64rXOcS0jZ6Oik3Ok3aiekqDLgJ3Yyuq1CIMJZDBl7ig73ALL
	 ShHMbWw5H+demh3YIGdfgGplWIZ1dHjPfeooWeQkgRTT2EoCztdAqExkeuet1E+lIJ
	 2ekoTMtmySc3Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa6cdebc33so3857627e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 05:36:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/NZA4dSb0s2VCBCyubfXy1z8xApm6rM/WX146TGIyImeFR07uIepD1nrOsh3Jm649NgK/OLOXxpwFh@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAxLrdco4SnBvHEPgdybNR/XFMta3B8Kn9hGFd25KtgMWfSvD
	+sYtmwdIggSmX8uWn2cjX64O2JnXkzZ5JtYrzw0VB2iYMOcHs0dsJ6dpPGo9kmEKR1fk+idZFji
	Y6AfaMoHlOYCTn3LIDnR9Fo9Rw4Byslo=
X-Received: by 2002:a05:6512:3981:b0:5aa:6c98:a09a with SMTP id
 2adb3069b0e04-5aa87b8bce0mr4936984e87.3.1780922186354; Mon, 08 Jun 2026
 05:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603163108.2149359-1-dbgh9129@gmail.com>
In-Reply-To: <20260603163108.2149359-1-dbgh9129@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 14:36:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gDNdWoqLaq6G4ujgpvPCowG8uqZoGX+UTak8WOZYmHvg@mail.gmail.com>
X-Gm-Features: AVVi8CeuBP8kufDHBCLuw0v0PAvbfN4SJ9guSE1pRkf4_5NtqKh5Oi-qBYLDyes
Message-ID: <CAJZ5v0gDNdWoqLaq6G4ujgpvPCowG8uqZoGX+UTak8WOZYmHvg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: IPMI: Fix message kref handling on dead device
To: Yuho Choi <dbgh9129@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 6:31=E2=80=AFPM Yuho Choi <dbgh9129@gmail.com> wrote=
:
>
> acpi_ipmi_space_handler() takes an extra reference on tx_msg before
> checking whether the selected IPMI device is dead. The reference
> belongs to the tx_msg_list entry and is normally dropped by
> ipmi_cancel_tx_msg() or ipmi_flush_tx_msg() after the message is removed
> from the list.
>
> On the dead-device path, the message has not been queued yet, but the
> error path still calls ipmi_msg_release() directly. That bypasses
> kref_put() and frees tx_msg while the queued-message reference is still
> recorded in the kref count.
>
> Take the queued-message reference only after the dead-device check
> succeeds, immediately before adding tx_msg to the list.
>
> Fixes: 7b9844772237 ("ACPI / IPMI: Add reference counting for ACPI IPMI t=
ransfers")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/acpi/acpi_ipmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 8f1aeae8b72e..79ce6e72bf29 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -550,7 +550,6 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_a=
ddress address,
>                 return AE_TYPE;
>         }
>
> -       acpi_ipmi_msg_get(tx_msg);
>         mutex_lock(&driver_data.ipmi_lock);
>         /* Do not add a tx_msg that can not be flushed. */
>         if (ipmi_device->dead) {
> @@ -558,6 +557,7 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_a=
ddress address,
>                 ipmi_msg_release(tx_msg);
>                 return AE_NOT_EXIST;
>         }
> +       acpi_ipmi_msg_get(tx_msg);
>         spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
>         list_add_tail(&tx_msg->head, &ipmi_device->tx_msg_list);
>         spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
> --

Applied as 7.2 material, thanks!
