Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC37448393
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772282; cv=none; b=Wwpa2H/36SS/SURgOAPWC8asty06d1jg0luusv8kYBlCHTLizgNfxTtX3ZuDCHFM9sIdWdEgkk1Lj0cROr4X7dy7NRttWahlZVlZWJrq2Pt69TgbYsFpWeEkmEebT3/hilXbBTwNk7OM8Eq4KXiFwdoglznKIsFwXzb++5fZGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772282; c=relaxed/simple;
	bh=l2AIl/kpAuNoaMk+ybN1XBL0IKKOwb469zrWMKRoeIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBKgnuvuAssFRK8cnbEIGG6HSwF1YClkeTfOwhGI0Zkal7r4XcL+EKCym+N7c4ut68auSUsoAVH2xjyW9r3yJJmAtGGAMFGiXmBT7cIxnNNgndlHF2JWLVSqmzz9wwxLyUsdk+5md+dP4+WQK9DgV5w1kLd/xZ/3HQY5GoZili8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo7lq8Ix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo7lq8Ix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD471F01558
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 09:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788772281;
	bh=wG0WmAyOO3ymA3aJN2xgzJ3JTR+4gP9o+6XF/2CnAYs=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=bo7lq8Ix8Z66hcKAUGdbeyUGFcrhRsuV6ZTzEFGyxkZJroeJ9FR06RB2HoZ7wID95
	 WVrXGiwWbk9nBxIYhFpryUWaF/dhz0V3Ccz9y5AmMboZtsrxdjcAXsyoJL2/lmwhtS
	 rIEgZIboWAvAhBbh8yg//Gf6wf1h/4pFUlVd7TvVumXHepxoh4doHgRtvPF3IezqIZ
	 vWZuG+Yjd6Rewv3d/E6jB/4KqKYlMlwty4Kuja8yUqQ3zMPG/yRY4EnpZhxwmmu0TB
	 QC4J78n7TZ58X5kR+XjPiOeP8uQqLdnwFdg15kUvE+0MSY86ZiSFcsT+I6CaYESzVB
	 tQzLJoZOUYB8w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c74c469e8so20834761fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2026 02:11:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzI1JNWkhrU5mbUTqY308StdIkioLpm/63DkUbu2uNkhAg8Uq7buEybaTPXZ0zLBfD5g2Ea6o3zKrlq@vger.kernel.org
X-Gm-Message-State: AFuF++mJTV6FWc50QM491LIX2SOHjIvqz2QrTkMP/nGEV8g2CUZou5kk
	2nWdIwhEiI8iCMwnwOsTNWO8LxTxd4cadZFBUw9gVmENfI5Ary35XaPqZ+I5xPJuF3u9AMraEIQ
	xLoKEpfGqGzp6zMa3JqQy/RkqQ7eSc6k=
X-Received: by 2002:a05:651c:43cc:20b0:3a3:7681:6d69 with SMTP id
 38308e7fff4ca-3a376817499mr13635561fa.18.1788772279038; Mon, 07 Sep 2026
 02:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904084158.1341550-1-wenst@chromium.org> <20260904084158.1341550-8-wenst@chromium.org>
 <2026090430-botanist-ungodly-0299@gregkh> <CAGb2v65MSxL+r+wqMjPKVSh9aS1gkn8og6oBinSXDdipnoOyCQ@mail.gmail.com>
 <2026090433-chair-tidings-5c99@gregkh> <apvQlBEgHOW9MCxN@ashevche-desk.local> <2026090516-nutshell-handiness-37f9@gregkh>
In-Reply-To: <2026090516-nutshell-handiness-37f9@gregkh>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 7 Sep 2026 17:11:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64QQ1OsQ0hEw+hrYuG2bEpBFf6AWNnbJB-O3qr3on_X5Q@mail.gmail.com>
X-Gm-Features: AcwNN1Wpt14dNKe4B6humzooduMblAi6GFxjh3D2jQuOPYxWMei9coTZFdaWUGw
Message-ID: <CAGb2v64QQ1OsQ0hEw+hrYuG2bEpBFf6AWNnbJB-O3qr3on_X5Q@mail.gmail.com>
Subject: Re: [PATCH v8 07/16] usb: core: Move struct usb_port and related APIs
 to port.h
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 7:32=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Sep 05, 2026 at 11:19:32AM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 04, 2026 at 07:52:37PM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Sep 05, 2026 at 01:24:20AM +0800, Chen-Yu Tsai wrote:
> > > > On Sat, Sep 5, 2026 at 12:47=E2=80=AFAM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Fri, Sep 04, 2026 at 04:41:46PM +0800, Chen-Yu Tsai wrote:
> > > > > > |struct usb_port| and its matching container_of() macro should =
live in
> > > > > > its own port.h, matching the split we have for .c files.
> > > > >
> > > > > Why?
> > > >
> > > > This was requested by Andy. And to me it sort of made sense.
> > > >
> > > > > > Move them as described. Also move usb_port_is_power_on(), since=
 in the
> > > > > > next change its |struct usb_hub *| parameter will be changed to
> > > > > > |struct usb_port *|, and becomes a non-static function that onl=
y
> > > > > > references |struct usb_port|.
> > > > >
> > > > > No, please don't do that unless you have a really good reason.
> > > >
> > > > Which part? Move the code?
> > >
> > > Please don't make a new .h file.
> > >
> > > Moving the function might make sense on its own if you need it in a
> > > different file later on, but do a move only, and then change things i=
f
> > > you really need to do that.
> >
> > Isn't this file to break possible circular dependencies?
>
> If so, that was not stated here at all...

No. The code movement was purely done out of request by Andy [1]:

    At a brief look this will be the only function that takes usb_port
    instead of usb_hub in the entire hub.h (I don't count container_of()
    as a function). With that being said I would rather see it to be moved
    to port.c altogether (yes, it's more invasive change, but looks more
    consistent).  I would even dare to move struct usb_port (and container_=
of()
    accompanied with that) and this function to port.h. This might require
    a separate patch, though.

Putting the function in either .c file works, as it is referenced in both
files. Possible circular dependencies was the result, not the cause, of
the code movement.

And the main changes to usb_port_is_power_on() are in the next patch.
This one just moves the code and drops the "external".

If the maintainers feel that the code movement or header addition is
undesired, I will drop the movement. Or we can discuss reorganizing the
code in a separate series.


ChenYu

[1] https://lore.kernel.org/all/ake09vk4fEv1D9QC@ashevche-desk.local/
