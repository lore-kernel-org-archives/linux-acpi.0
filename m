Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90038445AFB
	for <linux-acpi@vger.kernel.org>; Sat,  5 Sep 2026 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604644; cv=none; b=tnWS7oBxam5goB8VNQoOLz46yP16mV23HAXGbiaR7aHQ+3lR+dftG48RTc+TXD7MnNNXWY5gom8xt8dciQ9QHoYXlsUlMaHZj2K5DM2cAULIffp5RG444IHTOAwLlq/Mjv/KJ1lZsSk4+ktPFn7spAmBDbWC4itKnP1mg3HRSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604644; c=relaxed/simple;
	bh=V1gx4U5fkFEV4lHy+AglIGTQIAiXexQmalrE/icVYKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbFEwvNRmdEy2QTSsPtHuSND9mozW5Iut3JxtGmR1m7j6cEdOvESiUdJJ6pqWwF/sPtW9HHGpfTWL8C+gjFTX/Iqpl0zU3+IYcWVgJsTiPNzXF/k1u9zuHz4tw9iyWofny7cOk8hogsSkyLOWYBhM8En/T+jyBoT2EPC3FtXLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiWW2ZxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiWW2ZxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C6B1F00A3F
	for <linux-acpi@vger.kernel.org>; Sat,  5 Sep 2026 10:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788604641;
	bh=TqC57J+7NKmrnBjgypTbvCny67wCZQ5LpUFSbev2QcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eiWW2ZxQmlR8Jn+9H8qTzymZEAgD7nqjJhsRskoaOjIes3y0OX1+Qb+alqnaQ9hh2
	 rb9vD/TWhwrJut5Yc2RJVzN09+kPoeW3lnxktGyZBsGAzQ9RqrKMFvUtSBjrLJ8SiQ
	 27h2YcL9zUVOxzudX74jF88aGP4DPlvztxGlWlk/0gBywb/GE8X94WDSIUrJijUw8s
	 +GypmRd3U/rI68KkJ17gGNfnQ6dJZ9Dp/NmRms5SER0mpeZMwgqAVxESuCemI558tc
	 1TtZkcRJGbetrQLuzaRW73UfyzY8x0zlKeOLG4WE0jQKKBbgQCaxXLYndv56si+kSM
	 uHQTsSdYo4eqA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b523efb0bfso687148e87.3
        for <linux-acpi@vger.kernel.org>; Sat, 05 Sep 2026 03:37:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBztNguNub9gWqRgs9xzC+FQBUPgjNr2BSHVYO3JEDPFfdxve5yDqGFo4AT6nspozK+Up5GwcneJE94l@vger.kernel.org
X-Gm-Message-State: AFuF++mWjbCk1PAgYsUnnLM73sgH7AZ8yczBZ19y7o0Wta1Mtlr4Evbe
	MBAZMMJjQt/K3ItoGeeBo2Hl8/ulEua3Ra+LjSikaU9ju489+kL8s/LfqDAAbDWY2TSutUYlRBO
	BxqeuiptZnzsKM0p5r70zjFYYSegHlsg=
X-Received: by 2002:ac2:4f03:0:b0:5b1:5ab5:ea09 with SMTP id
 2adb3069b0e04-5b616e739e2mr3368733e87.0.1788604639868; Sat, 05 Sep 2026
 03:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2869083.mvXUDI8C0e@rafael.j.wysocki> <apu-JPPA7wVn-BH-@ashevche-desk.local>
In-Reply-To: <apu-JPPA7wVn-BH-@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sat, 5 Sep 2026 12:36:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irXxwPOOVdNHpPEb7etatE8sCaXz8NbN_UOiR4tO_L+A@mail.gmail.com>
X-Gm-Features: AcwNN1XvRHB7yCVNh84NLXZWN5QHOTFIEsR3s8lIEbUY7I2YxEF-hToOaNm3uuI
Message-ID: <CAJZ5v0irXxwPOOVdNHpPEb7etatE8sCaXz8NbN_UOiR4tO_L+A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: glue: Reduce debug noise from acpi_device_notify()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 9:00=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2026 at 05:44:55PM +0200, Rafael J. Wysocki wrote:
>
> > When debug is enabled in the ACPI glue code that handles binding
> > devices to ACPI companions, acpi_device_notify() produces a lot of
> > message noise related to devices that have no ACPI companions.
> >
> > Reduce that noise by checking the most obvious case, ACPI device
> > objects, directly and returning from acpi_device_notify() in that
> > case without printing any debug messages.  Also avoid printing a
> > debug message when there is no matching ACPI bus type definition for
> > the given device, which is the case for the vast majority of devices.
> >
> > Additionally, make the debug messages that get printed more informative
> > and change the format prefix to "ACPI/glue", so it is easier to filter
> > these messages.
>
> You are quick :-) But the comment I gave against v1 still stays here.
> (TL;DR: I expect to see "ACPI: glue: " in pr_fmt().)

Well, there's a v3 already in which I don't change pr_fmt() any more:

https://lore.kernel.org/linux-acpi/6048536.DvuYhMxLoT@rafael.j.wysocki/

because acpi_handle_debug() uses it like dev_fmt() (and only if
dynamic debug is compiled in) and it looks odd when printed after the
device name (or ACPI object path).

I have a patch to clean up the acpi_handle_*() mess which will be posted la=
ter.
