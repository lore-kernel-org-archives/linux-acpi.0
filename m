Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332362;
	b=ZFVmY8KnLZ+HeZdxQl5p2EIDSySgiHxUpgt7uwwLd5vNo/y72wsUlipUYBTKXnnhFEGY
	 2iX7k9HhUU529BpM2H0D5MWs/OQxFM52y0TnsDn1XZQ6uPspClz/RQ8xo9+9d6cwxqWGy
	 Q7Vqu9TAGmtPAh2X8fmSXpqDl+k9e+w/Z6DFBQf6SJbzuTLb1VdDbY+IhiUWZasMml+6S
	 HXh3THEmRmmprBFuc/Y4HafQXyMEIwFevXQnxDmGoxHiGNNIckOM6PUESfhDGhudR5+My
	 xDLs9I4ijTE6MokvWkFsMMzIfJt2FGAAYFvFQyxsHPavseeTBN/wQAp05LKnpyBNLDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332362;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5vT4kOVkwspgVbTxuey70SAjA4cZQ7aS/tMGa/bX0lM=;
	b=pes3lTv55JoXa5lHXdkLCtrEOUcy8EeqgEDkIEe6o4haGsIJR7kJtr4zKAzUTl6BNxBm
	 4pkPkkeJvPJLfFSwLuwn2AnglWbBDGBhaoovn0HjtjuaPPhNeJdDh4TvzzLCw6F+tMDxk
	 Vo5JSxODPrlqQsa93iOUXts6ixTBR5dlud8+lVNYhIKrAxRUq8eyCV2RiSMsozM91YEvu
	 nTeJ06Q6V4u0SVoaTo+eNanEirJmfe8HRgIQij58y7WYArRK/x7ix9wCEhHZubNKAjRe0
	 HzIkPYq64KBmJCEb5r64k7h0raIjJy+pNocFfqSrROs9ipBB8qGS/Adm/PBJWTqzNsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mq/Zln3+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1B606A320
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mq/Zln3+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55C91F0089F
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332361;
	bh=5vT4kOVkwspgVbTxuey70SAjA4cZQ7aS/tMGa/bX0lM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mq/Zln3+Rpd0DBHOagWPTuXBEBodAVtcAavlO6+6cc1+i2u01lXuc7l2idmaC32Z3
	 Whk3RVaM/dXpMuWqh01E/GiP4M/Fi98mCwu0osE9YWJKzgZg0NrylYkWJpolw7mY5d
	 2KBKyypt8hydXLFdpM14tj5X1QSuud93z/OYo45v8E8uCiRjSOSMr/Wt3+l2cFVU4b
	 KYopzqwb0cl4mq30sdz8RLNFt9O2enA+9pNmee1SYJ6h/N7esC2c/90z9zmUsvq5PS
	 U4lpW+DkOigq9xoYYk4MhDcviU1njnpn2WW/eU8XQRJRUQa+eHGPMdlDELCy9xvbKk
	 XKOAgkIQJIQAw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3acef9307c7so18618411fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 09:39:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH6wiPDu8UE8jkbU6YLUab4hddAp7sq1PHzJKd67YNRRrcfNLlRFfU+j/1Gbsnott1JsJwTicxFHHYH@vger.kernel.org
X-Gm-Message-State: APuU4Z/dbv9FAnhdLEaIER9iGqzFWgA0JHIQTYetN45KFWmLA58FajV7
	qS3Z0/Sm2gLAEsjnitutricnexSqhBPHu7mF15/GkVrC5gI+ldlpy4DHAatJlaj+qE+ATGCM2ai
	R19Edt2JD3wHRjK2FudGvR3F9ig91grI=
X-Received: by 2002:a05:651c:31d9:b0:3ac:e231:bb21 with SMTP id
 38308e7fff4ca-3ae09610ba5mr8464091fa.6.1794332360247; Tue, 10 Nov 2026
 09:39:20 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103114140.75649-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261103114140.75649-1-k.chen@smail.nju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 18:39:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jFbGMUHJuantcTCi09=O3s4u3rDsXvTRdooHB0BTaPpg@mail.gmail.com>
X-Gm-Features: AclHuK_xUML9TSmfS1vig7OOfS5r2174nZw9AzhO9x79V2QDVM--UhXZ11qRnDk
Message-ID: <CAJZ5v0jFbGMUHJuantcTCi09=O3s4u3rDsXvTRdooHB0BTaPpg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: check the _CST register buffer length
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:41=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> acpi_processor_evaluate_cst() casts the first buffer of each _CST
> C-state package to struct acpi_power_register without checking
> buffer.length.  A short buffer makes the driver read past the ACPI
> allocation and use the resulting address and space_id, which can reach
> acpi_processor_ffh_cstate_probe() and rdmsr().  The _LPI path already
> performs this check.
>
> Skip C-states whose register buffer is smaller than
> struct acpi_power_register.
>
> The check has been missing since before the current git history; the
> initial git import is the earliest tree containing the code.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Changes starting to reject firmware-supplied data that have been
accepted all the time so far are generally risky, but this particular
one should not appear to be problematic AFAICS.

So (tentatively) applied as 7.5 material, thanks!

> ---
>  drivers/acpi/acpi_processor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 5fbab54171b7..d77c90a243cf 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -903,6 +903,12 @@ int acpi_processor_evaluate_cst(acpi_handle handle, =
u32 cpu,
>                         continue;
>                 }
>
> +               if (obj->buffer.length < sizeof(*reg)) {
> +                       acpi_handle_info(handle, "_CST C%d package elemen=
t[0] buffer too small, skip...\n",
> +                                        i);
> +                       continue;
> +               }
> +
>                 reg =3D (struct acpi_power_register *)obj->buffer.pointer=
;
>
>                 obj =3D &element->package.elements[1];
> --
> 2.34.1
>
