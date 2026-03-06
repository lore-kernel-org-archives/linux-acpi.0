Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571D37FF65
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772794231; cv=none; b=XvnuTK2yJX5bRhIDu6CBqzYfoG/a5ixinAcuovTz8eJryoNST1TW/UgwGfzo10gUPLax/RNRdxEVROmAs0D1UVqbq+AmPl7WtQN+yhI6I1sZQrjmQMEQT0pBkYY2wl79isj2cvlYc2LUfLR+72detQTyDnc2vPG3VHhhS0henWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772794231; c=relaxed/simple;
	bh=eqfwaX1uUOLxfVqp14A/eKO9yjUcQYR1yY7udHjnM58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fH2SWao+U5VqfRvNA0O2eyrOeQDr3+i4tbmeWh35wYJsNDyTkhKMAgOhZm6eI8YTlpF1nMy9gWlUOqzYaEeIHmr4hv0c++t/K1nXMCuegRASm6sD+uBrkVnNOkdc05LPRM5EctwVpU9g+ccZpxhx8leCzJ+CZx9oRHheL926+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL109GPK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL109GPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9B0C19422
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772794231;
	bh=eqfwaX1uUOLxfVqp14A/eKO9yjUcQYR1yY7udHjnM58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QL109GPKUjGOgdM9EMD+JVuR9qN96jmF4YoJadjN0rnVSXKL4rV4xBmJYIiY2QOCn
	 /WWprn6e6HIFl2nd5FiaMJGTfUH/HhsGQ6fn99CLSGonX1an+sgmAoV+KB9MMZDN0z
	 HWjggZI/nt0QnxIgH/XpHi+94gi5S60kI06oErqLgTujCH90zoafSWdKMz3eYqGASR
	 xGdKlxB206m12AsikPm/rbQas6eHK/frJ2Wwd5ywfPLaHbgf/+ezNXCF/ZZQWt7FQi
	 nuHcFV+65YquiSb6KPUDgWiQYllB9zuqdfr7pnKq9rZ6XMiaxq4SDRR1gjhqkcAZK0
	 1+puriBz1S57A==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4638fe85a7eso3662136b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 02:50:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAzlMl4uEyUCzAKohnBT6uNOHudt7pNoZbKG5mtIo+z7AEGLwxP1UG/C1mWPCF2nU2Id7ycz79qIYx@vger.kernel.org
X-Gm-Message-State: AOJu0YwM99HvxzUA11WHjAORg8ycJ9GdjdftgICQ7nRmkSHVGxjKQQDo
	0mmnIvfVDgdArlKyUmbn0Kz7goVL+IHLgOA/Q8Hyw/WT5aZZ0pKLAdPNFz6Tre5ne+1vePPer/E
	UI2Vgrc7pxTDngGyLgEDl1DBTxVU+6uA=
X-Received: by 2002:a05:6808:1a13:b0:462:d862:ae4b with SMTP id
 5614622812f47-466dcb0c5ddmr899575b6e.36.1772794230253; Fri, 06 Mar 2026
 02:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306025144.604062-1-superm1@kernel.org>
In-Reply-To: <20260306025144.604062-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 11:50:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
X-Gm-Features: AaiRm50g37fvKlybKCMspgESY95b-XaohiztvSV1PmJYGjAi1Y3nD7adhroYSLs
Message-ID: <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Don't allow MFD devices to probe
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	W_Armin@gmx.de, Pratap Nirujogi <pnirujog@amd.com>, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 3:51=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> After ACPI video was converted into a platform device in
> commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one"=
)
> other devices that are MFD children of LNXVIDEO are being probed.
> This isn't intended.
>
> During probe detect MFD cells and reject them.
>
> Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one"=
)
> Reported-by: Pratap Nirujogi <pnirujog@amd.com>
> Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c794c=
5952018@amd.com/

The link is broken, so I can't see what is really happening, but my
guess is that MFD devices are created under the video bus device and
they get the same device ID (confusingly enough).

> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/acpi/acpi_video.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 3fa28f1abca38..2cb526775ac47 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/mfd/core.h>
>  #include <linux/mutex.h>
>  #include <linux/input.h>
>  #include <linux/backlight.h>
> @@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform_dev=
ice *pdev)
>         int error;
>         acpi_status status;
>
> +       if (mfd_get_cell(pdev))
> +               return -ENODEV;

If the above is the case, I'd prefer this check

        if (!device->pnp.type.backlight)

which should also work, but is more general.

> +
>         status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE,
>                                 acpi_dev_parent(device)->handle, 1,
>                                 acpi_video_bus_match, NULL,
> --
