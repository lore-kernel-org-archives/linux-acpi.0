Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B7466B15
	for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054281; cv=none; b=iCDqroJNIABqH13YREwNcfSjGA1jem59ElTKETAbHm/wLLSYP3jNVSvzwO485N4X142Qp+HUQv1FgzzJYG+zgUReqPlWGFeKQAP93cZORmbKZcdfb6xVWQ1fNlcCYqvr0Ai4SFhe1i0dCS8sjVdCvgBduX4bi5nLgI89gWxNYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054281; c=relaxed/simple;
	bh=XKvpuhGOPbv8JCt779JZ4GIg/qJ5Sfy6ojxNg7/AzzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLtt2LsIzjitHKuXOMdcfT1h3kWPsenj51OwlRzmFpS3OgdZIKSiZCf6mYokhjHQWq3jbo/lSuGYU6Rb6/q2FH2HKTtMf9dPS20FKtLll2EDpfA/CpPpJZwOBtp/rnoOY5WTEFxyduQHIrM9UFou9P0Mb3OnmLErisxSiKUN9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2itKOHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2itKOHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4711F00A3D
	for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787054280;
	bh=XKvpuhGOPbv8JCt779JZ4GIg/qJ5Sfy6ojxNg7/AzzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y2itKOHZ1Mnet1zHwg5XtX1JhFrFSmUObrDdtPi12AxNF5VMjvFPNo8kqGlpnpeAn
	 NTS3pnbO1qM+nhrpTCFn5AlETHOXPAHh+NN2dKDSuKxb4E4Hq8keA3rtE1Gobr9gxs
	 c1bizEj38yKoa9EoXQhLMLFN33faqhMKNdFrJGPfnjI2QIMUCYT+Iwx3H+A57nVTSd
	 CclTRaaJR+ow2lz9L/Nc2RpLmriXlQD/iOqJagXKzYuhIDVQ/y5ZHBDj2mw3Y/F233
	 BLQfO1LmolBF6fzxuUNujNphjxReJkk6ijWzuSewWCnAs8CEbGDyM/6wQS/ErtNCqS
	 ENidzBiQt6Szw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a151eda82dso20828671fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 04:58:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrx7N2aZlGUSc/R0SP63T6VA77JWDb6JbAKUxoWjCl7sd6fMY5+Y2Mpi8xoXBa2YXmb/i2K3nzO1clN@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRGeFb4BLrq+2tQLuz9dxqxeoML6tvZsl3n4Mtk6sGyaVdxQI
	gOqRyCOQ/yTxx1864uIY/IuxQoeQOEXk3qTzbfP99/SDB1u+XPWWcLuvDZ4WQynAR0QqFQRas0k
	/0DJWM0FqiHgbO2ZwNme1SvDltruO+10=
X-Received: by 2002:a05:651c:30ca:b0:3a1:1d3b:67f1 with SMTP id
 38308e7fff4ca-3a1751ed6f9mr11681411fa.7.1787054278515; Tue, 18 Aug 2026
 04:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0g3pVxLgXBAHho5B+kfAiQQkQHGoO-1uBxp0OyXiGGcRQ@mail.gmail.com>
 <20260818034110.1067658-1-peixin.xie@linux.spacemit.com>
In-Reply-To: <20260818034110.1067658-1-peixin.xie@linux.spacemit.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 18 Aug 2026 13:57:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jwAvynHo+ctq_CJJCKPDFct7DBj8SbDhKvWp7KZM0wwQ@mail.gmail.com>
X-Gm-Features: AcwNN1VT3s4C1GHK_DVVrKqoeuQkWt6_4B_3wLCbIvEsEaFXd2oU1DdrdTKsH9I
Message-ID: <CAJZ5v0jwAvynHo+ctq_CJJCKPDFct7DBj8SbDhKvWp7KZM0wwQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Drop power resource references for deferred devices
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: rafael@kernel.org, dlan@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:41=E2=80=AFAM Peixin Xie
<peixin.xie@linux.spacemit.com> wrote:
>
> On Wed, Aug 12, 2026 at 03:15:27PM +0200, Rafael J. Wysocki wrote:
> > Have you considered dropping the acpi_bus_init_power() call from
> > acpi_bus_get_power_flags() and doing it only once when the device gets
> > ready for enumeration?
>
> Thank you for the suggestion. I tested this approach on the SpacemiT K3
> platform and it works as expected.
>
> In addition to removing the acpi_bus_init_power() call, I set
> device->flags.initialized to false at the end of acpi_bus_get_power_flags=
()
> to mark the device power state as not yet initialized.

Instead of doing this, IMV it would be better to remove the setting of
device->flags.initialized to 1 in acpi_init_device_object() and set it
to 1 in acpi_add_power_resource().

> This causes the existing path in acpi_bus_attach() to call acpi_bus_init_=
power() once the
> device is ready for enumeration.
>
> The power resource references are now balanced and runtime suspend and
> resume continue to work correctly. I will send a v2 in next couple days.

Please do, but please take the comment above into consideration.

Thanks!
