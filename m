Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFB37F00E
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632813; cv=none; b=c1wsSuyvLPEsxeq8+mYqFlpjnpRlxFWMIRQ5o6pox95fSJmpo/8KMpe3PwwTFILoFRBN2xuITYlzHEy6zUXL332u2LIVkzpV0WxREaSYEq12TMuncksVYtpMh9+55irspCaYPsleGqSzZ9IRydMovuxPETYgGaLcYMsnDBvZUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632813; c=relaxed/simple;
	bh=vQQRzvuKVOEeuzDANaerK8guZGkuHGOWY6CJg112n1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzMdNiGDW2hTz4tnEtU7s0ekXxKdTq5RNXyL+W5MYdlhkeCKaLVemoYCkCMVoQ058uIecNzrLc56+H9ird927MRtZMvbjULQ6M2PGYgeSVpZN9ZAQwfhNyT6qokMiunycLy4hMebMqvrqqCSpa99W62CyrqAEAgiEHUEcnY+wH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM6Ej9dt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM6Ej9dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEB2C2BCB2
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 07:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775632813;
	bh=vQQRzvuKVOEeuzDANaerK8guZGkuHGOWY6CJg112n1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uM6Ej9dtmzhotdKYzxKOpoBRUkXmBU48KmjrOJ1act5HrGtAbA2jN9N6PlARQDxww
	 7tUsZzxcp6sqCHPSF8ShB0cRvWM9rjNOJ/tGcE9WbcO6Mm46gitC4wiCQRDoPnk2nM
	 4K588/DnqvW4QGjASP9i2udyf8rmlc0mVG1Bw3aE3JP037p5hPuwTbLriIysdhdCw5
	 vjLBj4weABkjh5kKePHW7zR7OoYvPgFfikd2yb5glpvAU8a3axfjnCvkR7U1n2OgRx
	 dOdKAnbmcoDkgfkAWc9JSaN4+jwPfiiCWNL99QF1xmARyPJHz7LuJ0wCOkPaTwCN44
	 zhbljzj0Qnl4A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so7526604e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 08 Apr 2026 00:20:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBa17a+PYQycCdsimorT80sG2SRSiTzDklCAADEKwh5YFM9OblpkTq9rvyXfShC54//YgUZ6WTkuee@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBI47TgKkyEvhCQT675LsSJ5tsFJOfXPGbz606MyH9Z08E3Ao
	A5zdzZYBLH0wNkhrXI4hGGWBxE7as4aeGfPDSykdByuEn/eEUqV0uWH3cM9LjRwCzxkXkk0Rb1m
	A5ryGpWvRKGKCDcj7EPaY/UCpj3dRa/S/NuAd66tn3g==
X-Received: by 2002:a05:6512:224f:b0:5a3:cd17:8d71 with SMTP id
 2adb3069b0e04-5a3cd178dd9mr7417144e87.21.1775632811510; Wed, 08 Apr 2026
 00:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-swnode-unreg-retcode-v4-0-1b2f0725eb9c@oss.qualcomm.com> <20260407-swnode-unreg-retcode-v4-1-1b2f0725eb9c@oss.qualcomm.com>
In-Reply-To: <20260407-swnode-unreg-retcode-v4-1-1b2f0725eb9c@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 8 Apr 2026 09:19:59 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdWSigDmTGSCe-ggAC+rKcCLimKgKU_kAGh5N66jyXGtg@mail.gmail.com>
X-Gm-Features: AQROBzBCj7JqwaHPPnoLthJA6owUVGcRqQISKVXzppqDGxU8U2cLLlP3S_fk-F0
Message-ID: <CAMRc=MdWSigDmTGSCe-ggAC+rKcCLimKgKU_kAGh5N66jyXGtg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] software node: return -ENOTCONN when referenced
 swnode is not registered yet
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 3:28=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> It's possible that at the time of resolving a reference to a remote
> software node, the node we know exists is not yet registered as a full
> firmware node. We currently return -ENOENT in this case but the same
> error code is also returned in some other cases, like the reference
> property with given name not existing in the property list of the local
> software node.
>
> It makes sense to let users know that we're dealing with an unregistered
> software node so that they can defer probe - the situation is somewhat
> similar to there existing a firmware node to which no device is bound
> yet - which is valid grounds for probe deferral. To that end: use
> -ENOTCONN to indicate the software node is "not connected".
>
> Acked-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Hi Danilo!

With Andy's Ack, do you think you could still queue this for v7.1? I'd
then take the GPIO patch (2/2) independently and it would make further
work next cycle much easier.

Thanks,
Bartosz
