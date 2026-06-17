Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC603B1B3
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721077; cv=none; b=h+snYITdLfLqcLWBmvoCL7+kYBAfFRLZgm6Xu6K6H+hrtaxK8U8CJ83sKeW5e8TlRu6qnAYcDXHEy+77c2bjHhnGTmfqO8u9muy/KrtG1necJA6UcuWgn+UCoGIxBw5JqZXPiTlqfLADeNyWa5E6MKOW6QKQh44EQho7c3041x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721077; c=relaxed/simple;
	bh=+rIJjRhimxdHwQcJdlXLtKKzUjrPBLDTqjWuBVxBysg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY/NPU9j6cRitorhP0t9312EoVKm/623hXkWwqZxZoi8ALzDQdxBAfotNyxysRNc5tn0WqN7ROqu3qlWmVidyHp40IaAcSl5dwByPKTmw7ksqlbYUDf4sJz1/fPe9IfMz4YXnB+I1jMWnObuyvcf9mWn0QqJl0iBZAW6y/2NNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Bw2iXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Bw2iXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FDE1F00A3F
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781721076;
	bh=mJGoVxUE8DzCW85pwKZ2iXF+Km2oJiQidAen57cABQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R7Bw2iXZv/krDPykWM/QOVLvHhuSX+P8VRMfVKP+SexXSHN8krs938vx2iaj+xnh2
	 cTLhvFXBRSd7OD7yYR6K0KZB5i6MTO2IKMhMS18LchljPRo+Z2ztYtkPHQ3kEUSxPv
	 hTI09HR8MyGlfqVvssRfS1d49SScvkOHsBc1MB6hr27a4VGKfo9Y34BlHY6OW8U816
	 YMLJA+nkpDbcicE9bVIvEArvrjvwXM6GTtTxJ7/1cEzIIENJCEuG5giW3zsK3KJavL
	 Yb1agskZRz0y+rXRcelSiq+Ov6e/3E3gm6PHANG+DveCxm/7AfhYa+HOMRAbE7mc9H
	 K49FR3ILFCs/Q==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ad4b60f6d5so93652e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 11:31:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9gyy3H4YAnML3C0uNA96BKVv1K/pBIfagAk1371xrpi1J1nYFzwkEt82b38o1QQPntEZot4+22W8NW@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcrkbTGnOQlfcDYXZGoxvhWkll5R4ZeiWzb7rj7oywsC94zuJ
	XPIW0tvegas3J3wjNk0sYNdxdaqdaBlglkSMSTBHnOQtXan9fQ+UtBHOKS9TeVgnm5rmlLCt9kQ
	2GIdj7DfUxAwHXDkSIBQ5QQhN4NlXTkM=
X-Received: by 2002:a05:6512:12c8:b0:5aa:8562:2a7c with SMTP id
 2adb3069b0e04-5ad46ff6163mr1678961e87.31.1781721074501; Wed, 17 Jun 2026
 11:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617075633.534689-1-trenn@suse.de> <20260617092448.538721-1-trenn@suse.de>
In-Reply-To: <20260617092448.538721-1-trenn@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Jun 2026 20:31:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hOZs3TMgdCc+cfK_TVbmDj6z=PTYcDmdqtrZWhHOHG+w@mail.gmail.com>
X-Gm-Features: AVVi8CeyzrtDEvan0YOCem7k_z4rlg9z_MR3fu_Fz1QnY-ZKSQEJEf2UUbn7zlU
Message-ID: <CAJZ5v0hOZs3TMgdCc+cfK_TVbmDj6z=PTYcDmdqtrZWhHOHG+w@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()"
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thomas Renninger <trenn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 11:25=E2=80=AFAM Thomas Renninger <trenn@suse.de> w=
rote:
>
> This reverts commit 97f7d3f9c9acb70d4eef7bcdef3218823d142733.
>
> acpica has it's own safe strncpy function: acpi_ut_safe_strncpy
> and must not use kernel's strscpy_pad.
>
> Closes: https://lore.kernel.org/all/79e9e913-0fb1-4110-804b-c3b5d0edafe4@=
kernel.org
> Reported-and-tested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Thomas Renninger <trenn@suse.com>

Applied as 7.2-rc material, but I wrote a new changelog for it.

Thanks!

> ---
>  drivers/acpi/acpica/utnonansi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnona=
nsi.c
> index 3a7952be6545..ff0802ace19b 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -168,7 +168,8 @@ void acpi_ut_safe_strncpy(char *dest, char *source, a=
cpi_size dest_size)
>  {
>         /* Always terminate destination string */
>
> -       strscpy_pad(dest, source, dest_size);
> +       strncpy(dest, source, dest_size);
> +       dest[dest_size - 1] =3D 0;
>  }
>
>  #endif
> --
