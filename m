Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C413B19A3
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675243; cv=pass; b=PeT+2TVIoeQHON9xEM0tUCO5MolO92J9P9NVCleTV9gu3myYzYmTsnegMMCTaWQN1M2iEdbMYP1197AlNZ1Q7xTEGgPSBuhRm8kVkajIidrSDPgKTbWPIe+0cgnEgiXckCBNQqWGZhBwYhXW3CaxTPM5/i6rm0lNBPCq0qtOXGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675243; c=relaxed/simple;
	bh=B3GzhcznlTgp3S6SnojCWf3qgJxcSS+uWQsFtA09RSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z038LBF2icnTF6DW0cJ1khXPlTMAExXbYhSvCVxap9XorLgAc7hmhNTYH16EFF0HJZmYILBWDgbVRJN7RRwouN1orSNxmdEgX+cQTl/sRV/QfiFqoMjqnXADMhd8feUPsoow6Wu08b49Fwk7esa2ruc0YdTrQwTUpNZ9BuW04SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/M1AyMB; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/M1AyMB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9b1df1a6b3so5002466b.0
        for <linux-acpi@vger.kernel.org>; Wed, 08 Apr 2026 12:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775675240; cv=none;
        d=google.com; s=arc-20240605;
        b=jnyDLYotS4umWmyRKEZjPXqsbi+ujPdJ/GZlJtxFBZ0Ri1DsMNAZV9Q/bLfJuUeWjU
         TGlHM8Zg7is4moRfsOYPgm874iqjUYFOzI5iQZzdUHW48kIBrm8mvy+HwXECCrS7XGA8
         u6wplXIl+nuR7eb7PGKdRmHubAEqsNHZwncGmRLU//Pv0yyft5ylnQbVcZUjKyyhfF3P
         qn87emzMDEkgvghaLi3bTrN1092iJojHkd6D/8z3pCNk0umYW0NTtDQL5XPFUbIWwzrf
         +cnMbaWm60LKZsKpoXY85p5b0tO/0B1P5q/RXCBkkarFWEPg21PGZj4e+DO8StgucWmf
         BkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5MgGWh9XKK+ZjwM7NdPVqoY4t2PvZ9URXYNukPgpet0=;
        fh=pPs0YjBjXM/18Y1S7kkFJopoDwpMm0eouSydNttbyDo=;
        b=Z7vcjUteIMZSitDOhbBfSPzYUiLIpYjtKdTDXENv019CyEGuf20HZewx8v7C7mgL9H
         RJOuKQQQR/A00zYqXOghm5qCbHfaJu65KdeXFODKg9WYTAxu9UZw7TQWY36uwVR/a2l/
         y6MWsJJJwrN47KgDIKCM3tt9ezbv2nt2RbRtN0Ee604FytuNtMV413KCyJHbbfI1Qmb8
         QLGJavlEAlaPRXC6fxILTCc8dJ6nutGBY3/2YsGOQYPD6dQxj8XwCIDHyZQkw0qG7bDi
         80U33HTzMpp1IeGr5lBV5v9zgJd5vpyaE3VZPLTcYdLJOgIiBerjs+EXiWLMTtb6eYy3
         VNvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775675240; x=1776280040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MgGWh9XKK+ZjwM7NdPVqoY4t2PvZ9URXYNukPgpet0=;
        b=s/M1AyMBB5e2sxLEfQIqfiZIyfUaXqOjICexrX0SKdAUsvVWMeuvYOoAhzBdTzf2bw
         xBJ63mSU5ZXelSXY+KJxR9nnf09ANhhECwVl9ChjBoM8tYLkC7UW0TZ5SxvIf09jYDsr
         G5aYsY18cigRVLX9clbT2C2AT2iw4bH9EISpbjHwK7QxwmTe7QUswV6kWMsM5f/Gq9TE
         VXOHPvVyOEaNYfNUguYhaeo+EmsbcgiIDzRqURQj3f20Wuj2wCgvLlgvvBrV+vIJL5rA
         I8iLoCEBntJkLYaTsHYM+YQd7KV8zIU9ETXghzvZ1jXz3pORohC320VpzOvuWXdpHUbI
         TRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775675240; x=1776280040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5MgGWh9XKK+ZjwM7NdPVqoY4t2PvZ9URXYNukPgpet0=;
        b=LeYcmaIRzONWL2hbx0mp+wPHvGY+hFDrGKXrtItjPJo/JZgwDOows+wfdWnlHwiRe1
         eiH7ncRcwsBtdjd2jwKOaI2Iq1x7uC+IMoz2+XaCHUW/93Ff7SOglnkyPtrpuW1y74wU
         fZYB7z8wX0m817IFUQ6v3CmEeSgyhBcVNW9ratunmAPfZO2LPS6VP9F8ZhdmWyuIyzA2
         W0CHTWtJ2/UHuciDGdCcCvf1nU7lC+kL3fZRjXfH515TPrM1twNtQrbnJwtD26grkwJq
         EVkkX7c70+HmYQRc8l7cc/oI7nRNR+yZT0xNISmMvLAJr85puWYOSWyP+K8/fY5TV1JQ
         TbUA==
X-Forwarded-Encrypted: i=1; AJvYcCXF4J52aZY0TmmxGzOKYsmSlmizLc02QoQm17g6qKau4Yy7Uke9iSGpHDUcL4XrcOc6C/H10iEn93JZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPytdsqg5Fu4Ly/UP1/fHbMlxehhdoQ5wwHi0NVOBAERA0HljH
	VYqQVb/Fd46052jyaCVTRxqVrUR8I2pnmeKQaiVrmg73eNMEjuIgjlGuCb9x2iMrSQ5WKGC9Y3V
	BHxXd/hsdIkN9tLOVRrNgvtyO143JkfE=
X-Gm-Gg: AeBDievlQjYCxTatAsnrjl27AtEFPLbOooDyKwvAHO4OidcSvgrR4SD2LR+E9dXqzi9
	d01T2Q0jVswoD1KgmpsxDZHTqUDwcvU8Xhak7E1Iq2MJQ/gawIiAhVaXvhkYJz+3sCNtR3o6nzl
	kKUidCuubvFHjCh5AiR96nKJksg9IwFow6e7Jiv0R3JJYHCKP8lfN0X9IPwxJEKB4i+womXrY+R
	XYVo02tAvAH2X01ASdfqykZgbZVpo4fRV7ir8MjCdg+7N8R98eMAuEZi7QS5/TPadC8CpN82Xsv
	QdctekQzBWuyZXK1zsEjUKDJdyLPAHjI/kb1uvc7hHLeTgMkeY7PhvmCiRENGt7iHzvoH92xvlI
	h0rgN3Kg=
X-Received: by 2002:a17:906:fe04:b0:b9c:7ba2:4168 with SMTP id
 a640c23a62f3a-b9c7ba2434dmr1035145666b.22.1775675240023; Wed, 08 Apr 2026
 12:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-swnode-unreg-retcode-v4-0-1b2f0725eb9c@oss.qualcomm.com>
 <20260407-swnode-unreg-retcode-v4-1-1b2f0725eb9c@oss.qualcomm.com>
 <CAMRc=MdWSigDmTGSCe-ggAC+rKcCLimKgKU_kAGh5N66jyXGtg@mail.gmail.com>
 <DHNVOVO67YMW.1Q763BB153CGF@kernel.org> <CAMRc=MchUSdWo=BXrYN-qS3YFer2R3J02HyJxKJje-a1QvWdfg@mail.gmail.com>
 <DHO01A7B9M0Y.1QVVS8600WRJ5@kernel.org>
In-Reply-To: <DHO01A7B9M0Y.1QVVS8600WRJ5@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 8 Apr 2026 22:06:43 +0300
X-Gm-Features: AQROBzDJGzBec5JWWeiqiBKbeAoL0ZpHkqC5pUPiuXH6__r4G5qXrWhTK62d4tI
Message-ID: <CAHp75Ve67JDc=79Ynp29wHPFA0s7Tv_cDcyrB=0U8Q+ydAifmw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] software node: return -ENOTCONN when referenced
 swnode is not registered yet
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
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

On Wed, Apr 8, 2026 at 9:53=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
> On Wed Apr 8, 2026 at 5:52 PM CEST, Bartosz Golaszewski wrote:
> > On Wed, 8 Apr 2026 17:28:46 +0200, Danilo Krummrich <dakr@kernel.org> s=
aid:
> >> On Wed Apr 8, 2026 at 9:19 AM CEST, Bartosz Golaszewski wrote:
> >>> On Tue, Apr 7, 2026 at 3:28=E2=80=AFPM Bartosz Golaszewski
> >>> <bartosz.golaszewski@oss.qualcomm.com> wrote:
> >>>>
> >>>> It's possible that at the time of resolving a reference to a remote
> >>>> software node, the node we know exists is not yet registered as a fu=
ll
> >>>> firmware node. We currently return -ENOENT in this case but the same
> >>>> error code is also returned in some other cases, like the reference
> >>>> property with given name not existing in the property list of the lo=
cal
> >>>> software node.
> >>>>
> >>>> It makes sense to let users know that we're dealing with an unregist=
ered
> >>>> software node so that they can defer probe - the situation is somewh=
at
> >>>> similar to there existing a firmware node to which no device is boun=
d
> >>>> yet - which is valid grounds for probe deferral. To that end: use
> >>>> -ENOTCONN to indicate the software node is "not connected".

> >>> With Andy's Ack, do you think you could still queue this for v7.1?
> >>
> >> Yeah, that should work, but I have a question about the patch.
> >>
> >> The comment added to fwnode_property_get_reference_args() says:
> >>
> >>      + *            %-ENOTCONN when the remote firmware node is a soft=
ware node that
> >>      + *                       has not been registered as a firmware n=
ode yet
> >>
> >> This seems like a bit of a layering violation to me, as it makes it ex=
plicit
> >> that this error code indicates a software node, while
> >> fwnode_property_get_reference_args() itself should be agnostic.
> >>
> >> The caller can easily derive more specific semantics with an is_softwa=
re_node()
> >> check as you already do in the GPIO code.
> >>
> >> Can we describe the same condition, but without explicitly naming the =
backend?

> > Yes, sure. It can be something like:
> >
> >       %-ENOTCONN when the remote firmware node exists but has not been
> >                  registered yet.

FWIW, good to me.

> > Does this sound good and doo you want me to resend or can you change it
> > when applying?
>
> I can change it when applying.
>
> One additional question though. I think it should be fine, but are we sur=
e the
> change can't regress other subsystems? It seems some of them (e.g. sfp-bu=
s,
> v4l2, iio) special case -ENOENT.

v4l2 uses the ENOTCONN in the cases similar to this

https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/media/v4l2-core/v4=
l2-async.c#L744

There are two more, but they seem more about connectors.

--=20
With Best Regards,
Andy Shevchenko
