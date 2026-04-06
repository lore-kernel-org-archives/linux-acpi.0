Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A6386424
	for <linux-acpi@vger.kernel.org>; Mon,  6 Apr 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486682; cv=none; b=BwJ3cLJfd10FBHtJUXmI8uBK965HVz9dYWMW/wQUlifR9qlgWUD4Khyu9qNVdQJM18GJxpYVk3ySrs1s32r7CAVzWiQVy3omMXgMPI6NSRsay0LaDW0lBPH4H7zrE7B6OmVLk9rzBPszbdyitMxMd96yxeBXwP7rRV57fj2nMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486682; c=relaxed/simple;
	bh=v3Irs1NIPTFYJcSHAF9iC7cgfpGgGTjEhxGID1fhyuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUYjczYAj2gEXnDGs+QxWWYR9gRivvQ+nbeki8Yncj4EnCkTAOxLZDoTwKYlfZBqU0MhfBoUqk00mWcVgRJ1GR+oToCk3VaaBELZiyCx601ypbZ6Jt3IlWJT3TMk9CAgV/reDPiOla9JM/5AoesuSP9dZR5WPqdbWvEFeiX6ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODpe9CmW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODpe9CmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA00C2BCAF
	for <linux-acpi@vger.kernel.org>; Mon,  6 Apr 2026 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775486681;
	bh=v3Irs1NIPTFYJcSHAF9iC7cgfpGgGTjEhxGID1fhyuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ODpe9CmWtsC7BymXhJfknAaNyASd5DVsMNvOR4od4EJuN7EzvDeR17BXxDJX/4CeN
	 6wlvlid+XQE95Zqu1eQjKuZyAabXsRe6R4JJqyzMtU2HUSUuSjEzPbwDEhtyLOozhn
	 M6xTgNn4cpZ+0Amujwtep75qn+r/Mhs9eA9TGtM/4rADyPhM2l/8ZLpE9fUXJ+8s7s
	 zCvjHiZRBYKtstHKcTVnvciqp97p9ffF6G6CAazlNc/5OoELdHC8YdFkkEEmpHA2H3
	 83DE/nylfJUHt315OQnJen/tRxjETLKD9FfTMkvvL3/WUs4KaJrsDBalBVYRkViUWs
	 i5wfaG6J4aHFg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-684571567a8so500191eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Apr 2026 07:44:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPFUHDNBbnC1+quzFAJhldVnshVjT+0494vxpIUDlkYccH76SRsrD/BIVRxMg64S8TkjdK2UJ/1btv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LdbLZ+SzKA8VFJXeK+C3QXnm7rh149DrJTVu4hgTN7+Ehjda
	zxzS78oTUjZHLwzWVeiL8UBbJ42m/uwDS7iTVSLk7KYXAK0Ei2GIUnBC5RghtjTCgWNr+F4cgCD
	RLSIlp3TlbTOyAWC4jZbrvazBXN0Eaa0=
X-Received: by 2002:a05:6820:174e:b0:67e:cc7:ccf5 with SMTP id
 006d021491bc7-6821e869e70mr6882008eaf.9.1775486681131; Mon, 06 Apr 2026
 07:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401135311.1737958-2-xry111@xry111.site>
In-Reply-To: <20260401135311.1737958-2-xry111@xry111.site>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 16:44:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iL-XZaUwgan-j6ctG=r461BTyGc6cTBAK=Mr0v12WwgA@mail.gmail.com>
X-Gm-Features: AQROBzDsZRUsUtASikqhmQYyvIbvNieZ4PnJ2nc1p7aEvrgNQ_ZD3EbS3dZpXdc
Message-ID: <CAJZ5v0iL-XZaUwgan-j6ctG=r461BTyGc6cTBAK=Mr0v12WwgA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Enable FPDT on LoongArch
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Zixing Liu <liushuyu@aosc.io>, Mingcong Bai <jeffbai@aosc.io>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 3:55=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> FPDT provides system- and application-readable performance statistics,
> useful for profiling and analyzing boot-time performance. FPDT table
> support is now available as a pending patch at the EDK II upstream [1]
> and has been tested on real hardware such as Loongson XA61200_V1.1 and
> XB612B0_V1.2 with patched firmware.
>
> We have also cross checked systemd-analyze(1) against a stop watch and
> the `dp' command in EFI Shell to see that the timing information are
> correct.
>
> Now that the functionality of FPDT is verified on LoongArch hardware,
> list LOONGARCH as a possible dependency, allowing it to be enabled.
>
> Link: https://github.com/tianocore/edk2/pull/12378 [1]
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 6f4b545f7377..f165d14cf61a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -96,7 +96,7 @@ config ACPI_SPCR_TABLE
>
>  config ACPI_FPDT
>         bool "ACPI Firmware Performance Data Table (FPDT) support"
> -       depends on X86_64 || ARM64
> +       depends on X86_64 || ARM64 || LOONGARCH
>         help
>           Enable support for the Firmware Performance Data Table (FPDT).
>           This table provides information on the timing of the system
> --

Applied as 7.1 material, thanks!
