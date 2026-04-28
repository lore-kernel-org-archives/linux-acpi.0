Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045762D5C68
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367974; cv=none; b=Eoe5Ai9EWCT8YUQR1FOn+C+aisk50l0o8pcRKBKRV/3BMU/dX9FPnInMZJQyscOFCePyPp4BCMnJaiLgSKKfVfqg/tu+1ys5PSKItBZHk/Lu4ctqFxOIWLuwxoFXrOjNk3Qaokf4GI0taiDt5UzoQMj5/Z3071ga9wPnIcSzL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367974; c=relaxed/simple;
	bh=ZMSJhyCOtIvkpDAY1UyV0WQQ/akVYaE/bewN9HqkYjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW8U2L9HbZhpgfw0ucerW3tyNjz30E1eCf1cRDZVaccXU9rho3fmD+yKTahcdBx57p5eLRNghcKo+Ro4qyMFuecXP814z9vSz/nVf0b/rctSGFg+8L48eiaf4DVylU7VZ25garoN2rKXw62dXbv/UKWv0+I1XocDBt1GlHU1ngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA4n621B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA4n621B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D4C4AF09
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777367973;
	bh=ZMSJhyCOtIvkpDAY1UyV0WQQ/akVYaE/bewN9HqkYjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XA4n621B4oxs87UXHlV5GM7gBt/2vn5/LdyCWHwfVBQZEGshe8CNZXj318dxb4fCB
	 0xOi9b6b7XQdIQA/4XxbV7XNhFOvqmxglUSjQLsvERJWt1KIGGD9O7sJduiXdQyMND
	 893pVGekl2a2PDWCxWqlQkUmJw1G06qw8Iu2fOmDZ6xwSpKE7Moc4n7691x3LTYgVG
	 R3ddxwnIEIoPpvoyAQTqnxS/cvuW/+plVKWZTrX57sW4HBLb8ZtfpNZcDa8qDQyDff
	 ZVbEOIJiHOrnBDwUM2AnxDV4EW2sE2Xs8GIDZzWL209dypeNWazYlIu+HzTmRcJpml
	 GskwFfsGb6d+g==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e7d983f50so123949651fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 02:19:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8tU8f3ji36l+cw9xZLMCU7ugpoPqlrFJISkLiSAaA9hoxlWZQjBBvsT61OqCkT0c4n4yjAC70Voq2k@vger.kernel.org
X-Gm-Message-State: AOJu0YyXuqzoukhKXEMDoXr/SaqhMvdNzQFvofC0Pt1OvZ7DjeuGX5w6
	wn2tOF8xcMDeuUOz1yJj3OAY76JCB2u5A8Ri/nqO9kqx8gE+u0frFhS8N0jkRTegXYiz9j/XN0B
	FAfWHZ2xvRhFs6quzulpNlQSQdZvBsgy+e+vYp/2kTg==
X-Received: by 2002:a05:651c:513:b0:38e:58c7:cd0 with SMTP id
 38308e7fff4ca-39240ccfba3mr7100321fa.10.1777367972313; Tue, 28 Apr 2026
 02:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-baytrail-real-swnode-v3-0-0003e4c1708c@oss.qualcomm.com>
 <20260427-baytrail-real-swnode-v3-2-0003e4c1708c@oss.qualcomm.com> <f100e787-f45a-4d72-9664-a75b1181763e@kernel.org>
In-Reply-To: <f100e787-f45a-4d72-9664-a75b1181763e@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 28 Apr 2026 11:19:20 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfVMLz3jZvxdgaD8ZUdcX6pgYO=WGCfH-dDmpU_WsfDLA@mail.gmail.com>
X-Gm-Features: AVHnY4L6HCdejwKae1mL2EFJhpoS5hPoP_ZtDkqrEE7U7UUevyusXQnkvGNf5lM
Message-ID: <CAMRc=MfVMLz3jZvxdgaD8ZUdcX6pgYO=WGCfH-dDmpU_WsfDLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] platform/x86: x86-android-tablets: enable fwnode
 matching of GPIO chips
To: Hans de Goede <hansg@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 11:16=E2=80=AFAM Hans de Goede <hansg@kernel.org> w=
rote:
>
> Hi Bartosz,
>
> On 27-Apr-26 14:19, Bartosz Golaszewski wrote:
> > In order to allow GPIOLIB to match cherryview and baytrail GPIO
> > controllers by their firmware nodes instead of their names, we need to
> > attach the - currently "dangling" - existing software nodes to their
> > target devices dynamically.
> >
> > We deal with devices described in ACPI so set up a bus notifier waiting
> > for the ADD events. We know the name of the device we're waiting for so
> > match against it and - on match - assign the appropriate software node
> > as the secondary firmware node of the underlying ACPI node. In case the
> > event was emitted earlier than this driver's probe: also make sure the
> > device was not added before.
> >
> > Scheduling fine-grained devres actions allows for proper teardown and
> > unsetting of the secondary firmware nodes.
>
> Thank you for your work on this.
>
> The x86-android-tablets.ko kernel module uses platform_create_bundle()
> so its probe() cannot return -EPROBE_DEFER. IOW it expects all the GPIO
> pins which it needs to already be there when it loads (which so far in
> practice holds, since these x86 GPIO controllers are always builtin
> for various reasons).
>
> This means that there is no need all the notifier stuff. Only adding
> an acpi_bus_find_device_by_name() helper as suggested by Rafael and
> then finding the GPIO controllers and attaching the swnodes is
> necessary.
>
> And if the acpi_bus_find_device_by_name() fails it is ok to fail
> the probe() just like it currently fails when gpiod_get() returns
> -EPROBE_DEFER (or fails for other reasons).
>
> This should nicely simplify this patch.
>

Thanks Hans, I was not aware of this. Given that this is the only
driver needing this quirk, it will indeed make things much simpler.
I'll have a v4 by the end of this week.

Bart
