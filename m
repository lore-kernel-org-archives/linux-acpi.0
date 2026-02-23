Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90729309EFA
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862434; cv=none; b=KsEd2YUTmiZ76cUvo9GSHgqSHxIRIXUgV9bCo7cLZxpoXM+IhdLg96xeaqm65GvqA1reLJ5EUP9/9x0XiAzPiOgb/2YHMCaBlPZgb/TqLqh+igvqiEX6BqiyLAlw25XrvzyUF8sk+NVJdQMqkWtqOMixdHMrcnlqEmYC3DmaNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862434; c=relaxed/simple;
	bh=EstmXOsompBSlyg7uWOQ8eWvFFkyH0qpqEJz+d2SKUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cm2ujT6udzAsU9sZSPaP8mwy8GSjDopibARwqpv3zUqCcvUA2Ud4p491fJmwY4fKvqRd4hg0QWEonS5iqeoVZyp+nzV82gLPMaS033NlEM9UHq0goIyMWEO4x5LStiis1g6WQNDUGfaSeEmDGEDolB0fQaOCl6ER6/qk9N09uM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGe54xrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGe54xrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667C1C4AF09
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862434;
	bh=EstmXOsompBSlyg7uWOQ8eWvFFkyH0qpqEJz+d2SKUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nGe54xrw35oEsbsLputQfSHXX7wKHjNsbJAOL6IzBD4mF066MA6zEOV8kyjcVrijA
	 ma0jETT4xEKUaMvqBC0A1fG1USw0MT5Id9oaJi9kTuJoeFycqxEfqvPXUhmGVUF8Mx
	 UkB+hONE8Jf6ljY2SX5nZQpARy+ve55xJZ9bLS2Kx5mCDWSzhmilfg6X5gkKdAByeW
	 xLNYaEwFRbqNnioypbvVhEJHJzzXWYorAg6sAxLiMa42Msx0SpTWGUA7ado/FnyVhn
	 EM48QAdfEG/LUg7eREwPK9v5Si+4WpDIbKwCcCL7uRaIx8QSBu3atDiAFRRlYQZkJx
	 HRoC633IgcxwQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40974bf7781so3790900fac.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 08:00:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIN7OiHkSa0zGam+jiL1F1xIgdC+ji9I/Mg6ROwhZN6YfLQLSix+7IkaWrlqQn/aMwNhgpMiE0+Ddj@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBEaNEkaaxQc/088X6qkFFpTiuZo918TGfFw/ovWmteWBsU4j
	pINjHhS0PiaPtAqsQtPrEkRypMuKRWr/F1hpOi3GAWf3ZNBpa7CJjRTvGTRHBRNTOjplRR4SOuL
	F7HeZU7w1G5ZU5MxyHR+dTLYSGRF2A5o=
X-Received: by 2002:a05:6870:824c:b0:40e:f203:eb4d with SMTP id
 586e51a60fabf-4154539eb81mr7760671fac.2.1771862433404; Mon, 23 Feb 2026
 08:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <CAMRc=MeD6rMQ2dU2mjS36=i3eXSs2HVG+qgAL3rsuvpQL0nCsQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeD6rMQ2dU2mjS36=i3eXSs2HVG+qgAL3rsuvpQL0nCsQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 17:00:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+DuaDcZ7N2gh1mbrYvgNSBDtmhmSEsw8Y=yFvW16iow@mail.gmail.com>
X-Gm-Features: AaiRm51Sk5zSDw10OTJvpIzbnWzryvjP6Hmt7k5VN_hzFAPM7iZFp8x-QaBqi10
Message-ID: <CAJZ5v0j+DuaDcZ7N2gh1mbrYvgNSBDtmhmSEsw8Y=yFvW16iow@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] driver core: provide and use device_match_fwnode_ext()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:46=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Mon, Feb 23, 2026 at 4:41=E2=80=AFPM Bartosz Golaszewski
> <bartosz.golaszewski@oss.qualcomm.com> wrote:
> >
> > In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> > reference to a specific fwnode, we only match it against the primary
> > node of the controllers. Let's extend that to also the secondary node b=
y
> > exposing fwnode_is_primary() to drivers and reworking
> > gpio_chip_match_by_fwnode().
> >
> > Link: https://lore.kernel.org/all/aZUIFiOYt6GOlDQx@google.com/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > ---
>
> Forgot to pick up Linus' R-b:
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Rafael: is it fine if I take it through the GPIO tree?

Sure, no problem.
