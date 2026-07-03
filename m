Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DB3D45D5
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084650; cv=pass; b=OuqLfzdqaK9PjBkvkY/q7podJ/RiAwPOHTV+CiNo4jVpeVGj7zSIfDWhgTYkwUX0UJdvTw/GMz6apCcJuzhStlwmeVn5ui9GdEjvw321cIBWUUu1QzfCxcPycmZRWmfKtdtYGFVUoxHgGBw89Rl1p3Oav5eZr9mbHNPFNywliBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084650; c=relaxed/simple;
	bh=3AQ8P2Il+2wWlMlJMTJ9+9roF3hePCnmEzgS9nHgr5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5C3JS5+qw+f7YjrFJ78xcC4KpCzDtIDl4XKLnUt4qHwCwabZDVnN3OSW9WyTeu3BT08py7GG2GfKFG5VAq2+e1uYKoxajOAYn3E9bc1y0h0XEtKRDIAt4shjyT9i0ExqJLkk/vUVxvgyUlFsNXStbwmWAaZRsL2ipK/IeddYqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kOR08oau; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOR08oau"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6651bc5730dso803496d50.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 06:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783084648; cv=none;
        d=google.com; s=arc-20260327;
        b=dvN0KXGiqWJkFAX/bPp/tHIkThNcC8aqU/UDAe9zxff2hh7AuyXa5bnuCsrGCz7Efp
         +zrPQo34PAaoZCAwsEoIVLGA7T4WiQlkIAiWyqriIGAqNT8WleInRjXP4pnY9T1uzgcG
         emWbVlA4JDm/l3AdyQgdvic7pU2+q1e2V6b7OCKCRmu1I7+nSg1BijNimDC3M3rrJcqR
         Ci0THBqRlACGUri0AgsOM3B2rNLwYjI2d0YoWXvCy/rT+eapz4lMHRiicJN64UgS2QMs
         dwxpum7IJqSzQWJcabORvYohFxizrCF2aeBlhN6WpSTjZbAKN/bQgDcAz2fCJVzlHkV8
         MMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nyHYQJiH0grz6FfspPAI6IMD2L9btQY/X/z4yRA/W0Q=;
        fh=ETlBmvHNLuug8O0aB8P4uUONRaEzS+6mgcrXnMWSalw=;
        b=Opv3uEiKuN2IB4oohWZCw521b+DT3gBiPki7iUsD1zVnSLvdCncFowIT7ElzQVGKeX
         wdN0cqX6rD/VDWMFawbALFTM8RYvoFiNtJhCX97ZIJCGMUV40fEkVJFNJPhiKuHDmlVo
         dJv2fzme3zHFW//oVEGmC7tCOcSNHaJMGjE6LmhoatqKytaRD3laGa3NLIixe1KqhFHp
         W00w0bYA52ZFTCHvgENDmxWi14AA3H+qRMD3C99rzcePsWj5RPIk9KRh7JmPww3O9c9o
         BGVjtHRAD32J8YaBIZG2qtczXD//FffnBuXNVThh+7USqRr43oJ4+3Ne6/PX8h0CU63w
         hKYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783084648; x=1783689448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyHYQJiH0grz6FfspPAI6IMD2L9btQY/X/z4yRA/W0Q=;
        b=kOR08oauuwV5CLqCy06oOJwcI6DpRd1hNhBsKq/nfPh6QJN16cVAx7Mip3GeT8ANUp
         m7qaeRrH/XlhHNvaMrYHCKdwyWD9TZVycZzUJIJPXPCLG9121GNkBTf2uT+rmCH/3xyk
         TaW8UgqV8xCVN/aNj3+aeNcKMEa32VisLPT1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783084648; x=1783689448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nyHYQJiH0grz6FfspPAI6IMD2L9btQY/X/z4yRA/W0Q=;
        b=DdYTVB3Sb0+Lt4x9lCCpBuMkE9VvdnVDMBlJQMqG9Ex7JnbILyMJ3G+MhMkwhAHg+/
         pZf9X+WM6UvKp7qJTEf0YyvCFn32pNpiIU3u8gR4YEVFDsTL0dpTGfwthQpT1qOtGhOt
         xRwMgOjG3zkHiPjNdsauWAsBvmvdqozUO+93uqCtMtbnGCHPyAVZa42Mn+kNkSE58xne
         fhFQVDvJatqlvPYnRFUmxIgz/R6Z7AxfRdO3NV+m1RvL3YsyD55RgsXxIIXjrgj+n3kE
         tkury9ac7ObWF8iq+DC+UoVScWDC+gJePDTCSNlRftoIjCXe6pfK9PdK/mipzw9JOv6J
         cFwg==
X-Forwarded-Encrypted: i=1; AHgh+RqDagQ1D4oEIzH92LajKMtFr8T2Vtm9ig6Fnk0cRnG2VBXtdKI/x87/+AtWnUh2SxA8Zr+KnbWUnnja@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwaYJGYhdFsusdmVXwqf3pgHNz8h7AZo57b+UBL+C220SmGig
	+ZWNZthTJePiPnwLOZNa4RUcxhrlyf7WMQWNWI4gt3mNfAXsvUxdmSYNZzX0JuNrY+NNBdJ9y96
	N2VOsppbvMsvugOF7/ycZffyUdw/prbqXPW9k9Xez
X-Gm-Gg: AfdE7ckTdvMpzIkGCA1ZGSY59N70IhZIVSRCMRDjwd1LoxJG5Yu36uzfdHiJom/CO+S
	fIV1PeAP6uyNw5ab2XYF9bZ3sT55jyHcbAM9vgH1Eq0hBkH/bTCkFtOX+c9b4oDsm87QiYFUxKY
	f+A6rUDztLoXpywObW/8lBBD7HFNyU2vkfDxP5yD+DsSBwvlEuqGiBEqk/qIBZg9kE57dE5HXom
	/fyer4+lacw4rybvivY0CJmSknVyUxQNd4veGfBgvNNL029nYQ2kyXDjddK6NqStM9qeHYVM868
	5Wh466bvkcNhPkUkXoc7tjny+t0=
X-Received: by 2002:a05:690e:4805:b0:664:de7a:a014 with SMTP id
 956f58d0204a3-66521a07484mr6637877d50.34.1783084648062; Fri, 03 Jul 2026
 06:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local>
In-Reply-To: <ake09vk4fEv1D9QC@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 21:17:16 +0800
X-Gm-Features: AVVi8CfejZEcwq-X4tSLhB9B5zlOpwIE7AknFvssi26xknUZgb1hl9QfxXck8os
Message-ID: <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
> > usb_port_is_power_on() currently takes |struct usb_hub*|, but only need=
s
> > it to tell if the hub/port is SuperSpeed or not.
> >
> > In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
> > state tracking field in |struct usb_port|. Either structure can be used
> > to identify whether a port/hub is SuperSpeed or not, as the field in
> > |struct usb_port| is inherited from the hub:
> >
> >     port->is_superspeed =3D hub_is_superspeed(hub)
> >
> > Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> > |struct usb_port*| so a subsequent change can use it.
>
> At a brief look this will be the only function that takes usb_port
> instead of usb_hub in the entire hub.h (I don't count container_of()
> as a function). With that being said I would rather see it to be moved
> to port.c altogether (yes, it's more invasive change, but looks more
> consistent).  I would even dare to move struct usb_port (and container_of=
()
> accompanied with that) and this function to port.h. This might require
> a separate patch, though.

I agree with the reasoning, especially given the function name. However
I wonder if it would cause problems given the linking order. I'll give
it a try nevertheless and report back.

ChenYu

> Perhaps something like: 1) "move struct usb_port and associated APIs to p=
ort.h";
> 2) "...this patch...".
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>
