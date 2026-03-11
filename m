Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C23DDDAA
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228754; cv=none; b=rXu89c8GXGHlwG3VVxTGIeNszM5Yt0avAWUZFeAbPVLKwKNRn0nWGaRJ1CIfjHDk/HZHxkV3LthpZGt/5SSyU9ojFKnnxZJ7hbub5b2UHaS4g8B9B7uMhDpQfez+9TZ198DvQIKyNI2FwistLREKqT2r1B4GyNJJs040NtN8zK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228754; c=relaxed/simple;
	bh=fQkIU4jHyY63YLrpHjCxOzMLppmUih5G1hp4RFWNSxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npmEdh030ah5BdlvL7/V8j/CGckRY1tKQYUdEOHIvEgOHpr/MxWA6RxnnEM/TJchEYQmsf2yx/TEopLF2Vcc0kIykQJB1Y6/QudaSqYrQnDUysmxPNXRb+O6TPtmj7pFr0gD/HnV+Vcqh5edmMT3vmuofMkXACg3awqolNCimN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdPFlBg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdPFlBg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984CBC4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773228753;
	bh=fQkIU4jHyY63YLrpHjCxOzMLppmUih5G1hp4RFWNSxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jdPFlBg3vR2b4TIGnbBboKIWbmsyz2xBxibhjaSYBBGmrer+6gSX7+zfmuQMDgZbU
	 lnZV18YUfRtkil7PCjSy4J6T+ifzf0VvfHJjlQmNGRZjnMsnD48lJSSmKDYWXt40BJ
	 cBHVmfYFUJinRgRuxvvQkv0xgsTTKssibdtPelmGEk8XAlaYtf8DL9hXxyDLxakWEc
	 SMgP0TM2mqW3wwQvx83Uww2ADEzHIWm2shX5UeJI3W0RLjqlun0ui21TUXXiI2JdWR
	 dHK40zRjIF9R7hS8nFnMdvw0mLYY+pChRB8Y1h/pRDjg05JV+2ntGiueZH+ld84bWk
	 gHKQeCmbqFgIQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-467161c4b89so1639333b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 04:32:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwDviFwAi1xH6R3X+a2+oFx9ordNcLHJqKz9JW1lt8vjbHsWsOW
	wkGfW4GGdMiA8lmmDZO7VnYOQ3rCL5ZKmkaN3KyNcyw2/3F7VIa9mtmrgvS5VXic1HZ9VYXEDgP
	QUfhXBI/2bc6UCa1mpM/iCULm2YrNlg0=
X-Received: by 2002:a05:6808:1447:b0:45c:95ab:bce3 with SMTP id
 5614622812f47-467335938aamr1249161b6e.46.1773228752805; Wed, 11 Mar 2026
 04:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311105835.463030-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260311105835.463030-1-ben.dooks@codethink.co.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 12:32:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0js_-QdXR1hxc70MehHebnJu+VAqEHBrfcqE436tyYp_w@mail.gmail.com>
X-Gm-Features: AaiRm53aNxlkfYrk6UkhgRay70aX-HXDLLoNL2sGTzcI9-XvKPERIhEL0sTxSC8
Message-ID: <CAJZ5v0js_-QdXR1hxc70MehHebnJu+VAqEHBrfcqE436tyYp_w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: OSL: fix __iomem type on return acpi_os_map_generic_address()
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:58=E2=80=AFAM Ben Dooks <ben.dooks@codethink.co.=
uk> wrote:
>
> The pointer returned from acpi_os_map_generic_address() is
> tagged with __iomem, so make the rv it is returned to also
> of void __iomem * type.
>
> Fixes the following sparse warning:
>
> drivers/acpi/osl.c:1686:20: warning: incorrect type in assignment (differ=
ent address spaces)
> drivers/acpi/osl.c:1686:20:    expected void *rv
> drivers/acpi/osl.c:1686:20:    got void [noderef] __iomem *
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/acpi/osl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 5b777316b9ac..62b9c83d4f20 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1681,7 +1681,7 @@ acpi_status __init acpi_os_initialize(void)
>                  * Use acpi_os_map_generic_address to pre-map the reset
>                  * register if it's in system memory.
>                  */
> -               void *rv;
> +               void __iomem *rv;
>
>                 rv =3D acpi_os_map_generic_address(&acpi_gbl_FADT.reset_r=
egister);
>                 pr_debug("%s: Reset register mapping %s\n", __func__,
> --

Applied as 7.0-rc material, thanks!
