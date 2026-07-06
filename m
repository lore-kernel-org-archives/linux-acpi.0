Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A113F0773
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336102; cv=pass; b=Z+LdMUwePYGoy0PgYXkl9nq5DBMms0h0D+GXt/57QhFS3fjxGm0GHxTIKVHc0dtu8jcQfqstfanji0KWSFqnar/N58t0OjhdV07FfVtBHl5R86zXrzFREIq/umtME1wyn6Dl2pDrRPcBOXzb8qNunqVjxN2ry7zQT7z7fIfZFLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336102; c=relaxed/simple;
	bh=4F/mamksgE6M36asyjHLz+r3WuYlAy4EjSD04V58GmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkadgPpFOslO06UEN8Nv2svMW0HSiZ9HVyVzAnJhQOo06X+sCZevQujYJSenZDvxPcSFYYyXUyRZJvwi77x1+FBFmJZF/CNBMpFqBUo/TvKs+ogX0E9sgCt2tNUOlX7vJ9g8+OJyT9IH+JsvgA0PsgiSZyksNsB4oj86TiuK6EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VK26Hj31; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VK26Hj31"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664ce3000e6so2247322d50.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 04:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783336099; cv=none;
        d=google.com; s=arc-20260327;
        b=LOA4fAEU7eKMGSke7ybDVeoNrnNsc8QLtpQRRhFPN9ECk5zABNhJk+QiXfBtxIgxq5
         PaUfxlkVR5fpdFruldOicFyTVa89QohRKmjRV2L8ax2bi4b8s2E5TSIiKUkzPmOZGq8o
         16zV0MPqJCskya13tNp5uAw4Ztof34gcR796WmhPCYfD1HYRMGRckIU0pvdMX2aSG+VU
         mbye9+iGDQpnQ6CECtSP8FMscHlO1CTEDGqlTFfF2XD4KAwwlrqnEJK3aNO6BngW7vRV
         AZfERWv9LgRveF2h62TNqcizcXYq4x+9Z43ij2f5V/+WU8qrWDJLl6OoQ1vOGX72X99/
         7w9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SIs5mr1YlXuHrRAWD0Cvvhp1KPf82E28pNtyAHr0i7A=;
        fh=8+EWSAQfy11nZgpN4+OYDc/LGHhjK5vsaNxYtq1XyDQ=;
        b=h1i2f2OAnAAyAVlcO3LDrbi5b9xSDXlVFTUkjDOUDSPy7woPYb1E6vtIo65fsLqjZB
         e63lwfN6WWd99fx2fIKNhgqmAEDPnTh6kfGdOB2MWJkPeaH6YC5GqmvLG3Kn9mD/We2f
         2t20CM9DbVZNFZ83WQSm7lzELbu43r1WUEYyvRIK/wfY8YuflwXikWYD0+4vGpT9pYQd
         pS6gTjCtXb1NivP9O592I53V9laWCG0mXUrajvg8IQgHlX3QXRiQude0NOGoazD5i/Wl
         qXj5p1J6//acT+R5ZQk7i4r7PxGaAuHoGd76PDne/z5CBLMcU0eAz8A/N2EPcmoVkjXI
         X+5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783336099; x=1783940899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIs5mr1YlXuHrRAWD0Cvvhp1KPf82E28pNtyAHr0i7A=;
        b=VK26Hj31UayrVs/4ulgCbhVpWYBWmOwQVZ1cZulYxavWOit5dV5tCoKEG/g9vtbHcq
         jhq50FZ57MBVX950hnpmnOE0FU+iWtFgnmz5tmrHk7jVAY81/sx7woV1a6TxIltEifKE
         kYm0CCbgjBlkFhMAdJOKvmmF1T8y4EHhE9Dcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336099; x=1783940899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SIs5mr1YlXuHrRAWD0Cvvhp1KPf82E28pNtyAHr0i7A=;
        b=TWk8ud7q+KzLgKZ1YRdC3dVnqCWu2CXKeebIEnUdZ2OXVYNIcaB2WF+FDpG+z3uKO/
         75zaULXqcv3aEdqm1kBCEwrv0+NFzBqyY9b6xFOX9vc1sklL/FT8Pab4Oy3XMyxOFP3p
         qY6z5TDu2AmuIyeYFjt0oFZqB6TXmoqpUy3xOuib3K+MYXqFdlnCb11bDPipn+qo1Uyx
         7w/iCsTR9WiJTyj0kiHoYOyealwuIncyxwhDyao1RdSmVfUkLjA/srmWrEQusKrCEog6
         vyUY2rJgt1nkvRy7Y2bSfBS6AfklfSiLfQgoJIu6XDncc6XXG9QH2WTBSDdjepicwygE
         p0fw==
X-Forwarded-Encrypted: i=1; AHgh+RqoAXgTPfXhSJw5ZjviK0oeNr03KfZ7yozDDzzrIcW4HTf98I11oX9CFNV7p2vAIDHhoU//wm1jeSWH@vger.kernel.org
X-Gm-Message-State: AOJu0YytYVAwNaSEVinl/d5DUWuxt9ya51iy9EP4Oi+8+bno6Q3soHmC
	dDApapVtggbeCc2Rj+lHnBJ4EfHxL7XPVw08nkQBk9kCmOHQfZ2kN16r2ZQWtxbyfN09c4ddmwO
	XB9+Ir3tsqlHyGoMe8jwFGxM4QHHsbvJFRSdmHtFf
X-Gm-Gg: AfdE7cmkS1nd7CR/QpGAepDlT0ZoCWbozl8HO8O0bvlWJKms7L5O2CDKhE4YcqFJBdb
	m49iQy1F0TLDIhgHGDIBXBSOffLAbCbJkUimm9xrG1JS6loVIUa8483l89JzKWks/YWA/oCqAAu
	h7ELYMmMFFtxM5M/KTiMmtySxyxJXuaT8EsdNEij7BWABoRRq8xAY3+I8pXsmf0Yiw5nPVnxiB6
	9YIlUx8IQbHacD85nXsqs0lWXMp8CvmqzAFCmkrSFh2gHJ4IjbZ+MINeUl2CxK27vwkHu7G8m0w
	2akmKduWxvbnq4XAsv+3Gn9NGB8=
X-Received: by 2002:a53:d016:0:b0:664:c436:e525 with SMTP id
 956f58d0204a3-6677fd49ec4mr103596d50.58.1783336099517; Mon, 06 Jul 2026
 04:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local> <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
 <ake6FNy83LLtCs3b@ashevche-desk.local>
In-Reply-To: <ake6FNy83LLtCs3b@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 6 Jul 2026 19:08:07 +0800
X-Gm-Features: AVVi8CcaHXwr5vK-Mk50Hl5ytWXCTbNUaYqO2byI6p2Q5_6clKTL9yyyDNsH5MY
Message-ID: <CAGXv+5EgpizA3Pc8ScNuChPhvFKWd5F6dxB-wT4-7EwabE-9dQ@mail.gmail.com>
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

On Fri, Jul 3, 2026 at 9:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 09:17:16PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Jul 3, 2026 at 9:11=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
> > > > usb_port_is_power_on() currently takes |struct usb_hub*|, but only =
needs
> > > > it to tell if the hub/port is SuperSpeed or not.
> > > >
> > > > In a subsequent change, usb_port_is_power_on() needs access to a pw=
rseq
> > > > state tracking field in |struct usb_port|. Either structure can be =
used
> > > > to identify whether a port/hub is SuperSpeed or not, as the field i=
n
> > > > |struct usb_port| is inherited from the hub:
> > > >
> > > >     port->is_superspeed =3D hub_is_superspeed(hub)
> > > >
> > > > Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> > > > |struct usb_port*| so a subsequent change can use it.
> > >
> > > At a brief look this will be the only function that takes usb_port
> > > instead of usb_hub in the entire hub.h (I don't count container_of()
> > > as a function). With that being said I would rather see it to be move=
d
> > > to port.c altogether (yes, it's more invasive change, but looks more
> > > consistent).  I would even dare to move struct usb_port (and containe=
r_of()
> > > accompanied with that) and this function to port.h. This might requir=
e
> > > a separate patch, though.
> >
> > I agree with the reasoning, especially given the function name. However
> > I wonder if it would cause problems given the linking order. I'll give
> > it a try nevertheless and report back.
>
> Thanks!
>
> In case it won't fly (but I still think it's better to split), can you at=
 least
> group usb_port APIs and struct? Means moving the proto closer to that str=
uct
> usb_port followed by container_of().

Looks like it works out fine. port.o is linked in after hub.o, so moving
the function from the latter to the former doesn't cause issues. One might
even say that it is the correct thing to do.

> > > Perhaps something like: 1) "move struct usb_port and associated APIs =
to port.h";
> > > 2) "...this patch...".

There are still some left in hub.c:

static void usb_lock_port(struct usb_port *port_dev)
static void usb_unlock_port(struct usb_port *port_dev)
static void port_over_current_notify(struct usb_port *port_dev)
static void hub_usb3_port_prepare_disable(struct usb_hub *hub,
                                          struct usb_port *port_dev)

These are used only in hub.c and moving them probably makes things
messier?

OOTH, the following bits are in port.c but declared in hub.h:

int usb_hub_create_port_device(struct usb_hub *hub,
         int port1);
void usb_hub_remove_port_device(struct usb_hub *hub,
         int port1);

Any preferences for these while we're reorganizing the code?


ChenYu
