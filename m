Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FD4DC52C
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200283; cv=none; b=mfSqvygw1542fsuzChSu+NHpQyqYrdf6Z/7UDfIDYxdWckxv+6ldC60bW/jD4DmwbYjl3RZW1xGMmiR11R/d6WkzSmHDo+9xZIcqBs9Ya3MDtRGiTx71aFkhXEKYRRtaa2DAAaMveFRvI2oY3U3wKnVjnKmeYiMyZ5hPYjB54Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200283; c=relaxed/simple;
	bh=JHOus79Wu+r+HDZ2hBP8tbG0eO1J8TwzQ6ZaLJiZLVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpoF07hEwi1dgNm3X5CIl6cKcfesp3CSFznn2acxtDn/byNvQEOXnCBmZO/7Dp4WtFLXCwbVpBQ7zSnwVxVpitTiReJ4LIVdc15TNCN2fzOrO6T6aA5+WcWRcpRGR1/oWvZbE1ILCrji96aCeR3uMw7fvV5y/luH5VOofmarIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3xVYe8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3xVYe8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CC3C2BCFB
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200283;
	bh=JHOus79Wu+r+HDZ2hBP8tbG0eO1J8TwzQ6ZaLJiZLVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O3xVYe8ZW8z7Ip6KF63EM9l02r4HeqBRfdswcbFsyn45hPbjtV5VG+sUOuLMZWSkH
	 XY0i0Ggum2flYm4as4b1SCkI+S6youNcZr3veM0Jag/WfvgrocgMZv8332T6dZonOC
	 yuQb3FcJxTOTSKSqOK48XlbZSMfb6geB4jJu+FUYXvs6TmjOSckfViW8fVesoiCGmj
	 kB48X/Wk0R570HvCUqTgueYOxHnoUo96j77khbdUlKM3h/7+GpsGiUzNPJd9b4utCF
	 7Hi4/2Q+ARPaskxNQNgvvfr6mGd8QLmAOYiD6u4gDk4eC8bR3vSNHtiYjKZFm8Sto6
	 uXpPgzDaKopSw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8738c178dso3425659e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 07:18:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ERIhsS9aQj+EjhRHauIvw6C/8l/5yVmuPj+/yaw5hUhY1d/k7fmOao8sBg10pTSE1LY0GnAeu/6Qk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8vMUNIts12NVIhGeW+obdOAu7BXZMF5grpHwc13weD6XDrEI
	apSIMTh8JB0pEEWtkaKxYTIFdR4xoeCK2EmMMN4nS1twUunlzDLbe+83yvJ6dOq8ZuSxB0Moi9l
	IHDKuk+301cMdUHXTtOTQcI5Oxv1CihE=
X-Received: by 2002:a05:6512:3092:b0:5a4:301:b92 with SMTP id
 2adb3069b0e04-5aa0e749e70mr6365569e87.33.1779200281822; Tue, 19 May 2026
 07:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6007701.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6007701.DvuYhMxLoT@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 May 2026 16:17:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZV9dEY=wEiwmruY7o9kiuMyWr_bG3HbWuBDxxypAzWg@mail.gmail.com>
X-Gm-Features: AVHnY4Jyoi0-mOyC7aOS9SMWvUMPDVuOqDIXc2U3npd8T1bnxUO5yv3NPiBtJZI
Message-ID: <CAJZ5v0iZV9dEY=wEiwmruY7o9kiuMyWr_bG3HbWuBDxxypAzWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] platform/x86: Check ACPI_COMPANION() or
 ACPI_HANDLE() against NULL
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	Andrea Ho <Andrea.Ho@advantech.com.tw>, Eric Piel <eric.piel@tremplin-utc.net>, 
	Alex Hung <alexhung@gmail.com>, Shravan Sudhakar <s.shravan@intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Tue, May 12, 2026 at 5:17=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi All,
>
> This series replaces
>
> https://lore.kernel.org/linux-acpi/4731840.LvFx2qVVIh@rafael.j.wysocki/
>
> and as a whole it makes exactly the same code changes.
>
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
>
> Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> against NULL to 5 platform/x86 drivers where they are missing.
>
> Thanks!

I've noticed that you've picked up all of my patches except for this series=
.

Has it been deferred on purpose or has it fallen through cracks?
