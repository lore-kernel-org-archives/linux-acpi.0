Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FEC3B635B
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262399; cv=none; b=WnOO4A8dVnAFxDIRInqfq3ixbRI0Mw9W6eagbMvS8LLaVfQygK7lcgkoyQ0BNjZRK8XGWtJPQ1K/mKUb9z6FjVrMyofPRze/jDI2eWPvpULYr/R+7KqHBLgzvcnfpDtDr7DuKgEzk2aY3TjTRKP5eHbHAfurQXyRG85iiW2Zs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262399; c=relaxed/simple;
	bh=t/wF/kG/4FiENpBsKWaQXoozCWIBvFXTFk0Nss72t7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaOYC1WG4PiQhNzxkyb+F+c2rFOvZeMF52H4MD81Mt7/8iv8WHzq/KDJu+3IRxzOmn5GhxmiD0PAV8Wn2ayJum0HEpplyd9E5ryQ0vpaPF2C7UEUsb+Ho35stmzKIB5rfVJ62T6DmodHcpxIm+vEypjo/Xz4IZnLd6k4MDTpIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+rGx8yL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+rGx8yL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BA8C19424
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776262399;
	bh=t/wF/kG/4FiENpBsKWaQXoozCWIBvFXTFk0Nss72t7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c+rGx8yLHLpPpzgiFDX0Bzck6qG3nukjTCbZHLQunz/oY/QZ9yHqe5DO/YWi6zXBe
	 8CrCJHpntJIDStOZ2cVQ71vYC4nv89YlDaQq1HFCbARos20WUUoic+08cAHgxn2iZI
	 /y4Tj7OTGXcydOVLvH4zTFR/yeQl6E0N7nVOjGFAUui5a9BjbTF5NxLgVkxm5tYX2V
	 BnbjohqSiXJd28fG/OMsRdezE9aXV2WffIEu+U9wKJpKf0q3u35iOIlDwv+KiLmTap
	 uCfasZXa5Y0VbFQMpttdXAQP1pl/BYyHkGJCq3mF/vVrTYXI0TWIcio3VhTSROPUk4
	 fc6yhne06rSjg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-46808125c65so2404280b6e.2
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 07:13:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8HpekQPKp9eXTmN2ITlQUf9a9mKuaruvVoP+uUe99e7RZbMXKqQRv55MS1TzDR+CbTpLxjiVB4geKD@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXTmZLXsqOTgtrwlGWV4QPOgQemSmPOQbWN0SXkA8HXHiZUqi
	830lHm+6JYPEXpDvpLgWJTepX6PBiJaMP/qTnzF4xBChj7bYZLOnneN0Ktgl8ZpEV8/Sx0L19OM
	DipIFHKLSbDEMsDjo/VHByaKmsy6Qf4Y=
X-Received: by 2002:a05:6808:4f09:b0:464:82b8:efff with SMTP id
 5614622812f47-478a03fd5a6mr11155025b6e.29.1776262398419; Wed, 15 Apr 2026
 07:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad624e0d-cfd7-4521-ae33-c5c3287b4204@linux.ibm.com>
 <CAJZ5v0g4R+X+JXf1JB=3b_gqAdbyOv0drF242MCKkuNx1n4oow@mail.gmail.com> <755caa0d-c574-4c58-a274-ce8f6f04aa9c@linux.ibm.com>
In-Reply-To: <755caa0d-c574-4c58-a274-ce8f6f04aa9c@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Apr 2026 16:13:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8957hN2CzEahNC=rdPsOZK=mCs07-Uhym-8QngMz2nQ@mail.gmail.com>
X-Gm-Features: AQROBzBDmVlSGSQMX9UusDG7MrOzf0q_HGt5kHVoUfcWttzu8S9F5GvNpV37Cu8
Message-ID: <CAJZ5v0j8957hN2CzEahNC=rdPsOZK=mCs07-Uhym-8QngMz2nQ@mail.gmail.com>
Subject: Re: Build failure in linux-next: implicit declaration of acpi_has_method
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, lenb@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, luiz.dentz@gmail.com, 
	Ritesh Harjani <riteshh@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 10:35=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
>
> On 15/04/26 12:50 pm, Rafael J. Wysocki wrote:
> > On Wed, Apr 15, 2026 at 9:16=E2=80=AFAM Venkat Rao Bagalkote
> > <venkat88@linux.ibm.com> wrote:
> >> Greetings!!!
> >>
> >> IBM CI has reported a build failure on linux-next repo.
> >>
> >> Failures:
> >>
> >> drivers/bluetooth/btintel_pcie.c: In function
> >> =E2=80=98btintel_pcie_acpi_reset_method=E2=80=99:

What kernel is this?

I cannot find the function above in the mainline.

> >> drivers/bluetooth/btintel_pcie.c:2309:14: error: implicit declaration =
of
> >> function =E2=80=98acpi_has_method=E2=80=99; did you mean =E2=80=98acpi=
_has_watchdog=E2=80=99?
> >> [-Werror=3Dimplicit-function-declaration]
> >>    2309 |         if (!acpi_has_method(handle, "_PRR")) {
> >>         |              ^~~~~~~~~~~~~~~
> >>         |              acpi_has_watchdog
> >>
> >>
> >> The function acpi_has_method() lacks a stub definition in
> >> include/linux/acpi.h
> >> for the !CONFIG_ACPI case, unlike other ACPI utility functions.
> > Code that calls acpi_has_method() clearly depends on ACPI though, so
> > building it in the !CONFIG_ACPI case is questionable.
>
>
> Thank you so much for the review and explanation!!
>
> Adding the stub, would just hide the real issue. I guess, proper fix is
> to add the ACPI dependency in Kconfig.
>
>
>
> # git diff
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index c5d45cf91f88..fc1b37044a9b 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -502,7 +502,7 @@ config BT_NXPUART
>
>   config BT_INTEL_PCIE
>          tristate "Intel HCI PCIe driver"
> -       depends on PCI
> +       depends on PCI && ACPI
>          select BT_INTEL
>          select FW_LOADER
>          help
>
>
> Can you please confirm, if this the right approach before I submit a
> formal patch.

I'm not sure about that.  You need to talk to the driver maintainer.

> Thank you again for your patience and guidance.

You're welcome.
