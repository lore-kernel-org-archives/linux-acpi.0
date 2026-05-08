Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818393B52E1
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241938; cv=none; b=lxsm7cE34WBf5xpyChWCoOg/sRigpvSNOuVyCLYS3dsxQ1LngERafEq0QVxluaX06y/Za8sXZLmeaDMF/NzAy6dA7SIhEoG3KkphOHvpd3zYMxSHowSS+/37hBGurmfxTl2O9nA7+coCEoyHnZE7SbLZaWBclHs/2tlzcPDBZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241938; c=relaxed/simple;
	bh=+xa2Izm3ndqPvIm11GqvZEPFCn0mgjZpMDDxo1ksPX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhgnwqXarTSPiQfUI08Fq4BwjIMY7IgMy6oTKV+6VH7+xepMdVN2THCm0iBz4NlcVMGqAZR9mj01zx5wilxqeS8z8ok99oX6iKYGXCxX2rK4grQS2UANixCFVGNBUeEipO0Km/wofR0jb1miHydo3dODuBivRDOVx0c1y7gD0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2nqvWuZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2nqvWuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50128C2BCF4
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 12:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778241938;
	bh=+xa2Izm3ndqPvIm11GqvZEPFCn0mgjZpMDDxo1ksPX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J2nqvWuZQxdHcFivx7gVUYA6EV/zlfprLKlKMfq97E3WQI6OulOmjZPfOPqq7SWn2
	 moN1JEwvBNW7t0QxgCztkY0c2yQnY02xccD9zfsBa25MOfsr/Yc13cx4TOyJIaur/x
	 3eryZitZq1W1uTXMYQ4iQPxwIYpifFWDiYorHVBbo0nPebDLIDNdle+W8Qx342/A2l
	 cYLzj1B3XX76uVcWAwLS3meH92/5SVARxdJbPsPJ2+cqBGo0q6isg9OToXE7WBxVKI
	 mZMxQ7rpajIIuHeCpSFnpHnUb+/k2eN9LcoUo1L6gXVe22MI1GacV9oTmkkSkhJCAw
	 tr+gClqVsiJFw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a86bfa2a4eso2466327e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2026 05:05:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ZNxS9XPSPxTH5+CnG0+O/N7Cdskvvkx6664wlo3ghmZzbLxbIe6wXV6LGgEdeZmpIkcSBsY8ULVPU@vger.kernel.org
X-Gm-Message-State: AOJu0YzQahreD8moO5uqoCTySvmpEd5NaPniIuNv2AyA1I8LuSeMTq6O
	0gHnOLaunKASYKo+4KKVXWGvD1vQF04Osja1B5MxRW4ktETCYO8sp8wCfDPnTE/2yYvQVVD2Xma
	xTMYT/XYJis3gkP2zVLdZznKobseNnQI=
X-Received: by 2002:ac2:4e0e:0:b0:5a3:ccae:c650 with SMTP id
 2adb3069b0e04-5a887ce5215mr3806491e87.26.1778241936653; Fri, 08 May 2026
 05:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1956046.tdWV9SEqCh@rafael.j.wysocki>
In-Reply-To: <1956046.tdWV9SEqCh@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 14:05:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZPb6GRuM+VF6F_mSAOStL82kbtm-VKn046sRtbeLUaw@mail.gmail.com>
X-Gm-Features: AVHnY4LuxtDjtYGm-wfo6qJswHM9itJLlcsQiLfilv4j3h519Aw4KmO_NOMWfwA
Message-ID: <CAJZ5v0jZPb6GRuM+VF6F_mSAOStL82kbtm-VKn046sRtbeLUaw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] platform/x86: classmate-laptop: Bind to platform
 devices instead of ACPI ones
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 10:15=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi All,
>
> This series is part of a larger effort to switch over all drivers using
> the struct acpi_driver interface to the more common struct platform_drive=
r
> interface and eliminate the former.  The background is explained in
> Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
> the patch that introduced the above document:
>
> https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/
>
> The bottom line is that the kernel would be better off without struct
> acpi_driver and so it is better to get rid of it.
>
> This series carries out driver conversion of 5 subdrivers in the platform=
 x86
> classmate-laptop driver.
>
> The first 5 patches in the series are preliminary.
>
> Patch [01/10] updates remove callbacks of 2 subdrivers in classmate-lapto=
p
> to free memory allocated during initialization as appropriate.

After posting this series I realized that it would be more convenient
to switch the _add() callbacks allocating the memory over to
devm_kzalloc() because that would lead to fewer changes overall in
subsequent patches.

So there will be a v2, but I'll first post two more driver conversion serie=
s.

Thanks!
