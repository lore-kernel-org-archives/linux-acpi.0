Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E0372EE0
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715650; cv=none; b=hSeD+YQSENOvXM1WyfYZXmSkXM70qMxF3E0rTgUnQYdJ0pa/2grSzGGHBm3/oOcHAtOX4XRtigacupnaNogRKTBtA8UbHraPbE1xCDRSQrAyvW1buoJ/3xQGwZlUEko/akbf1zbYQIkKrdSv7s2ejichQDvRjVhy/e9I9lCZ7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715650; c=relaxed/simple;
	bh=2fLPVF8V+Qo14CJ4xDQwdqLS8Injz5P+WDXvbO/X/0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI3vkxKVl6rZwfo4yiCv3tJTF1pY/ZEDvTfJQHvybmIX1hksoR2pMMGW9Mclrdbz+qk+R4K/k2jKnyM/qtxCP3z7Ep/NUgPnYI/5YgoBFkmpbeozdioJMFZgwVqdUw0ftxV/QW/MDOBMH9w4BWDVIfIP15zId8Bu/zWDsa9hevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twUdTs6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twUdTs6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D891C2BCAF
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715650;
	bh=2fLPVF8V+Qo14CJ4xDQwdqLS8Injz5P+WDXvbO/X/0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=twUdTs6XpsaHTqb7/+sj6nUAKJHd7mJ015J4UZirKJlRB4Mn9xHgbdf1BJbu5xM4c
	 QeSuYlsHXhCNopfoOno24MTfQaNqdGHiL41ffTSK55F7zs3oO06VT+POBJN6ZiCG+i
	 8AJ35Juqjo/ffp+aKwq8LWxpgDpvsFTCT5T8/L92KIr90JOqn5Ce2QPIhcUAudQvsW
	 ionlFFANhsQdtpQVuXoOgIWd8wsCBDNJFnLu1U4foxnA+4tBizXxJRXdidX5GM3fFO
	 rM0yV/EevQjWQmwLcME0JdH6slrFh79w+HpApj0JTbpTLOmHtJ6H+AWGa1xadyNSHD
	 X9cHt2rkn9ocg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79863ab8478so78253387b3.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 05:00:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfUl/7tzcx+gMW0TCzBBtDWEX+yZqh2dN8wphtaf9wuX23aiv5DNOLKDBnG75psBl6AQSrCnS9E/+L@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79W32AGuTyITv/0E75jEREZ4JNN16Sc++uOn3H7hvNeN/8IYb
	nS2r5yNrd+NSA0hIwTCc/FCnibCunwuUPsP6VhyU3YYVbzojaF/cfUWUiyzklBdqF3k46XSG8Ok
	C9Z9ULgajqBh+aSn5Cdd0mek9EweH+KA=
X-Received: by 2002:a05:690c:385:b0:796:3c39:eb96 with SMTP id
 00721157ae682-798c6bd8c88mr47025427b3.13.1772715649725; Thu, 05 Mar 2026
 05:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-5-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-5-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 14:00:37 +0100
X-Gmail-Original-Message-ID: <CAD++jLnuKkWh9HRBHOVtYnDuPgAU=bjm=gUZtEHEcyp-e0y3Ng@mail.gmail.com>
X-Gm-Features: AaiRm51We3q6CMYsTkjp3rhKYGVHxX_F9UZaiYdDL8ZCrn8J3C4v9v7PwSz-XUA
Message-ID: <CAD++jLnuKkWh9HRBHOVtYnDuPgAU=bjm=gUZtEHEcyp-e0y3Ng@mail.gmail.com>
Subject: Re: [PATCH 5/6] gpio: remove machine hogs
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 10:52=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> With no more users, remove legacy machine hog API from the kernel.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sweet, less and clearer abstractions using strings instead, I like it.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
