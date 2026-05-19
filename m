Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DDD405C5F
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200999; cv=none; b=ff8DTRS0ErhZYsPmZokrgx0W7vq4HkSczhUm0aXcCI1AoPUNbkfdY/Ln+iFihwMAGahwvQBn8jLqcqhQxpVH8TwzrRLpqoYQpwQmE9gVliPXlHdKeY97lr47VyniERWxIB3UOe1Ud2B5L5Fb1ddB4jepT0EDH2klNPsHxLlOWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200999; c=relaxed/simple;
	bh=aWkLOZuvmk6r4Lo3NfCvt5TcEBBPjJyW911t4jmHR60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSbkBZ61E+IvB0do1XrY6Ow5D01D4z9Kq3oHaquibavz1KkFvvQaMH4r666FU3EwZy2l6bS0XcOox+oq52MWk3Ld9sdqT6Y0Mnast6ULI3V56Un/B/3/7Djd9TzHElE3htXELmo7JuqjITpDxNIDgIMpS/PqcH0/iVaSXbtbueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lojPPS3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lojPPS3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36AAC2BCB8
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200998;
	bh=aWkLOZuvmk6r4Lo3NfCvt5TcEBBPjJyW911t4jmHR60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lojPPS3gLkdJNjoKaDA4B5NeBo72fz6EaM5kfcaLN46n66SVWZ/94RFrSk/7fyUxi
	 kEzapsFWH1blY1Bpm3q9ZaoeRiPZEIPebU/xFjDxkOMOBjPEJmSmHRAZFRp8WsRnT4
	 RMpZdyMWKSC5uUOCm7zzE5CBVurx0Y9EXoeo/9oxsVThXLNrfOchBbf9+xWnQg+ClT
	 aZZkAbveuLIe3tcFTqNdfZYjaY/HJ7bHR045wvJc/qN6U9xN6DK28Wadr7F1rV40Rj
	 feCXOdgtbY8IKgjIC76QIyIqw0ZioJV90O3whys7eUzXhhl/4UM59i2YAdF0J880P/
	 p5fzonNeXMagw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8738c178dso3440915e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 07:29:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8BHVMWQ9gf+cWxfHvTa1Ig0GhxaoQQh0tLgGlMmMeSzKOj7v5BLyWdfiRtstlU40fs3oDJvmkMS6CA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NNdJ3owvtWJz5qOdLGP2Zkm2unQQ1DIoRS0e7ac3CzaCXiRP
	AzZOH4unT/aRdxZ4tCLkLpeC/4yIbhPXTlOnxjFpLz3/YragZUJ5Ny5GZVyrp5XR71KjsL3MrNX
	1tB1ZEmV6Dw51CoDYeY0veI5X/Vl6gBE=
X-Received: by 2002:a05:6512:39c6:b0:5a8:881c:9cec with SMTP id
 2adb3069b0e04-5aa0e619193mr5461017e87.1.1779200997187; Tue, 19 May 2026
 07:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6007701.DvuYhMxLoT@rafael.j.wysocki> <CAJZ5v0iZV9dEY=wEiwmruY7o9kiuMyWr_bG3HbWuBDxxypAzWg@mail.gmail.com>
 <e364e3c0-1ca0-67f9-40fa-eaaaa913559f@linux.intel.com>
In-Reply-To: <e364e3c0-1ca0-67f9-40fa-eaaaa913559f@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 May 2026 16:29:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLwfE6cFF6gS+Q7aUjRt8+rTJFMvvB=TXkHj1rWA1XiQ@mail.gmail.com>
X-Gm-Features: AVHnY4LO-iogoq_D35cM_u5MzQR2X5rDBsoJaDzQ3iUIZSP5g0YIA-mqIpWGTRs
Message-ID: <CAJZ5v0iLwfE6cFF6gS+Q7aUjRt8+rTJFMvvB=TXkHj1rWA1XiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] platform/x86: Check ACPI_COMPANION() or
 ACPI_HANDLE() against NULL
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	Andrea Ho <Andrea.Ho@advantech.com.tw>, Eric Piel <eric.piel@tremplin-utc.net>, 
	Alex Hung <alexhung@gmail.com>, Shravan Sudhakar <s.shravan@intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:26=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 19 May 2026, Rafael J. Wysocki wrote:
>
> > Hi Ilpo,
> >
> > On Tue, May 12, 2026 at 5:17=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > Hi All,
> > >
> > > This series replaces
> > >
> > > https://lore.kernel.org/linux-acpi/4731840.LvFx2qVVIh@rafael.j.wysock=
i/
> > >
> > > and as a whole it makes exactly the same code changes.
> > >
> > > Every platform driver can be forced to match a device that doesn't ma=
tch
> > > its list of device IDs because of device_match_driver_override(), so
> > > platform drivers that rely on the existence of a device's ACPI compan=
ion
> > > object need to verify its presence.
> > >
> > > Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> > > against NULL to 5 platform/x86 drivers where they are missing.
> > >
> > > Thanks!
> >
> > I've noticed that you've picked up all of my patches except for this se=
ries.
> >
> > Has it been deferred on purpose or has it fallen through cracks?
>
> Somebody is a bit impatient... ;-) Nothing has fallen through the
> cracks, I just cannot apply patches infinitely fast because I also do
> take time to review them while applying... :-)

Oh, sorry, I should have waited a bit longer, but it is similar to one
of the other series, so I wasn't quite sure what happened.

> ~/linux/platform-fixes$ b4 ty -l 2>&1 | grep -B1 'Rafael'
>   3: [PATCH v2 0/5] platform/x86: Check ACPI_COMPANION() or ACPI_HANDLE()=
 against NULL
>        From: Rafael J. Wysocki <rafael@kernel.org>
> --
>   4: [PATCH v1] platform/surface: surfacepro3_button: Check ACPI_COMPANIO=
N()
>        From: Rafael J. Wysocki <rafael@kernel.org>
>
> --
