Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2D4F405C
	for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799761; cv=none; b=N0Rw+qjpz0YJUVGv21n8Zv91vKdt4vD2NvpfaMgKIUy6Qq0Y9xSUcpvMGEZLlLtqSTPMg54yU/UY9nubVUi9px7EPEMOJ3EikfuLQ0/0MXA+xHf2zG3TyTFWaJJ+OtkpwAKqbEHP19o+uTm7WuM8lrzbJlWlcQ5Et5O+zbr4soU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799761; c=relaxed/simple;
	bh=fo7ptHyG+tnhAXsNDsN1giB7oOY5HkLN0hn/ghVCrng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eyj6mFeZMmS8oz+AgEcu6ApH8ARbykiyv/jhSaGMJ8aTTghNo81p54JmdqXJvKTkIH5n4l7fIgWuKLigSUgmadbpodDHBDWXFsyga/0eh7+geH5y947hkt0kNzRUfprCE4WitQZFIrDb3oUgQS0wvbJoVhYHWPbq7o7iLdtDPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2//S1D4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2//S1D4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A161F00898
	for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 20:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799757;
	bh=fo7ptHyG+tnhAXsNDsN1giB7oOY5HkLN0hn/ghVCrng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D2//S1D4E4clN2WDOS7AQ/nU3fsyWubsuSQJiWA/aegLoRV/ra3M21K1jiBI/9eeP
	 ytyDGumt7SPzQg+f6QrJancpOEKj1YNGI16gatcJhrQYWxRuPs497WNS18bA7tra8T
	 VLNu+rplaB2whFlA7asglYsB8Dp06is/89i3QAuf0oquuC3Ev5odg8mWQy5+BJwD/q
	 49N5bu5tAdbVU2fgjTWogRWeuHrPN1NnbcamzBaHwCQAw2is3zvUuSoGSLoNd/+WdV
	 jb/LHQ/a3fxeauZSOwioSUN8wQsqsHq0/QRBLmh3TtFhd6pnHXhgNZ0Eo9IbQ4v4zs
	 3QWpEi4J+BDYw==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a772de44c5so11061661fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 13:22:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy8pOG7StK/r7/cvIAWyyZ4X/yYT96DbBnmhiBgMFiIo8x45QQ5VBSSlmvOXEEwFwWhU/p2bfPrScWn@vger.kernel.org
X-Gm-Message-State: AFq9FYJntZgYrNnh8fZndb6I+jCxrhbpdEixcWG4VVQRPeZjGkfEe+9i
	SbMSa7/Xog5xoDeJx3gmZ9BfDYLMFPr7Pgf36M8dYR6p2Cmp0Hqoay61lwzAc4C38rVUcK22M9E
	06tCCuy5I5GrSFe2Ac5/goILJg8tZfNI=
X-Received: by 2002:a05:651c:a387:10b0:3a6:4726:7c5d with SMTP id
 38308e7fff4ca-3a7791aec2amr5600681fa.14.1790799756662; Wed, 30 Sep 2026
 13:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930111505.1108-1-theflyingrahul@gmail.com>
In-Reply-To: <20260930111505.1108-1-theflyingrahul@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 22:22:22 +0200
X-Gmail-Original-Message-ID: <CAD++jL=45ZdTbHsLDTAmTt3f+=VBVK014TLJyd5Drdba3V=dSQ@mail.gmail.com>
X-Gm-Features: AclHuK-W8ctlswVDSA5k2LnKOTD2F2jW84eCsuIgLPSKz2kwZeTcb2gNv9ENqzk
Message-ID: <CAD++jL=45ZdTbHsLDTAmTt3f+=VBVK014TLJyd5Drdba3V=dSQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: GED: Support GpioInt event resources
To: Rahul Pon <theflyingrahul@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 1:16=E2=80=AFPM Rahul Pon <theflyingrahul@gmail.com=
> wrote:

> The Generic Event Device accepts only Interrupt and ExtendedInterrupt
> resources in _CRS. Some ACPI firmware signals GED events through GPIO
> controllers instead: the HP OmniBook 5 16-bf1xxx (Snapdragon X2) describe=
s
> its lid (LIGE) and embedded-controller event device (ECGE) as ACPI0013 wi=
th
> GpioInt resources, and both currently fail to probe with "unable to parse
> IRQ resource".
>
> Handle GpioInt resources: get the Linux IRQ with acpi_dev_gpio_irq_get(),
> which applies the trigger and polarity and returns -EPROBE_DEFER until th=
e
> GPIO controller is registered, and evaluate _EVT with the GPIO pin number=
,
> as done for GSIs above 255. GpioIo resources are skipped. On a failed wal=
k,
> free the events already requested and propagate the GPIO error (including
> -EPROBE_DEFER) instead of -EINVAL.
>
> Tested on the HP OmniBook 5 16-bf1xxx: lid close/open run _EVT and reach
> the ACPI button driver and logind.
>
> Assisted-by: LLM
> Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>

I don't understand the patch at all, but I understand that Andy or Mika mus=
t
review it otherwise it's not going anywhere, so looping them in.

Yours,
Linus Walleij
