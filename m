Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4A30FC33
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jul 2026 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398558; cv=pass; b=kX+zDU+8ac2VSLG3fvxpMFxR+Ks7amof1SNfAownzQbG3QT+hyZkmwmXeQo+V6reWahisBXyQN1Jfy+XFsyxwy0CshX4pNzwyII/iCB4P683UEwmCj3Vup0q8MHX40JiYBNyMc3QGyAkhr8iyU9DZqZ+uCDwAlb9koisAGpH9nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398558; c=relaxed/simple;
	bh=PSqME/IPugtczex5NRAm1XmhU5y/+03GI6oS0AsEg0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgkfs2m94W2qpyxhpIVA7lm3N9ifpJgNLm/Q1Kk75tCZewv5sqywbtmuhwZuLNbz9USddX+CMaIs6b2ZFyGwpeKt3fhBprJevt+4K1g5nD92bX/QA5EY4pJ+LaqRlelHwUw+XqwJsky/aZ+p8jL+i0ZjvhOeLRrL0jxhkOqBsX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S52CYQCo; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S52CYQCo"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664dd23829eso3376203d50.3
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 21:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783398556; cv=none;
        d=google.com; s=arc-20260327;
        b=RD0JcwyBJHG/AeGfgGX9o6HdpnZejOGl+hhSvELObEaQma4iImyFbfV2KmRek3g0dO
         cdjh8xMCcUtfY2DNUiH4vkasBDKc4W0u02wj+06ekVMEn5f+7ELS13H875DNhO+qKvJ6
         /MyQK6jmLzIgB9qTKdUwJDzOYh/qR20vqjPJROnnJM4tPBd3mjsLMSt+xTqfmc165vDn
         ECh5/k4ZrQgD4ItjVjcsevysy4skrjouvPRKXlweMyEPMDzG02Ftu3HPKQHKUiPvSQ68
         3XkYjSXcgXlS7IsX0ohIpe6OnNHTg7+XhwPqNe97+M+p9QA9REGaCGi2yjDP/nEJeIfX
         QV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bHz8pIdj5qCHMVmE3ZgrvqBvuIVwQ8F/DhCqlx20Pk=;
        fh=IJq74g5PsEA3KAsa5uydQlCVi+mjzARp2ldjInq4tho=;
        b=DmALTuTuwWKaWiX66CqtjaP6TLAh/14LUu8TQn0MEcYm0EycTAs2PREd88VhcI+KY0
         /wATKFKsXCmmMTtzjGg90beABeXrMyl1v3TtP9cFGlI5wD5nlAVH0ADtRrpYBTc0+EZN
         gDYhRlUnKX6f3fM84f/btZCaHMcJBEQRaE8GkLt5+UmkKB6922Rtf64+V0srzzZ12zax
         IMN7xuMOiIqW263CDypIZF+AfVIYe7AnzLvWzcF60vT6GDyddp7v3tuxf3VjWEfMHSD6
         8FimGpbLdG1yFvBTnP1w82ahJK0cCfuZ07V1GdbEiZZ2Aj/pB4r47bGZCgY2Uf4bDH28
         rSIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783398556; x=1784003356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bHz8pIdj5qCHMVmE3ZgrvqBvuIVwQ8F/DhCqlx20Pk=;
        b=S52CYQCotEH8dw3N4wHAkEvIGgiFgLyj8Ojw0yloH6rv4EsRH1/NXDuhCfIZEpAiQC
         ZRYNEp+gcPgEJMfIdlVEIu9mqaDJk7q0OIhMYpdFIXVGCSlfBkfekpao1lwjYzmcipib
         J35lfe6nc1sAxtwhNAT9CNHR1/iO9PltWiY1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783398556; x=1784003356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bHz8pIdj5qCHMVmE3ZgrvqBvuIVwQ8F/DhCqlx20Pk=;
        b=oxZ4ExcfQ8wJicYr1R9zEYiMUKwOvelHGwOznwzmVysZCb1JkDp7c0K5RBuNsu/YUk
         lSXd+/INKzIUobzCa4ttUNVd06K3Y5JisREKxBIrJn0B0kwK1H8f4JS1Aka+DXzDhRkM
         9cTSw5APWdMHYgQ5Ky8t369/X2hsClntU32eKOKj77whGoLaqttgxpK8d9bNVzE8jvNC
         DgwjE6ejK8zY7EkomuMPcqjbQqR3jWMs8PIwUw30HBhlUtBYY/atE22LyR/ladhMLEpz
         jpi0S+7vtkNKlktcb3q+fQyMRXSYl4xLsUac39Czeth9xleM0bu7EUAUwqReKiXX9f58
         eqsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcuTvj8MuKe0NrlnXEvItV3QOtro/LiyARQsnc/YZYH1YRCRp1kIR4NjanEoN4mYaiCjuBgTPHKIdZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxHzGxqOEXsp9Ra7kGzyrgQ/2k4EkfyTAduHrz1FLA6aXVjpB
	iTTSLxkM8VAle+yaoLX6PrOGPcG7JkZb+B6p5Q23lOWcTODvsAQxQbufiak7C51NVlSaam5bcxw
	YhiBu3ygBHmxE9mACEXHDxz7qP3aypberRf0+7z9D
X-Gm-Gg: AfdE7cnt8wiXSXbb0OoEIu+a2W3v/lCHoaRTu+uSl7xkvMZ2LTWPtWaP3vf4FZD41MV
	oQsamLmhgKV8BTvs9YOqvKumoVYLeeV7SgEVN8P7h6ZA7y16LUY5k712em+UVRNSY6Ko8ka4ALZ
	XcQLqJ+FNL5QiNngIYRUCPNTp318C4HgbNcz2M8cOTuAJmb93Z56hLoGsoQaAxBjDiqeINmzkzX
	WyIvm3sUVeQ6I4jAPHYgdOC/asCvcnCciF0MH4x8+4E5qRm6uis/qWM8ipgewxKS2hAenmLGXhS
	9MXOBsZKZutc9NV+Cj1q1Ajw218bnGH4GbMiBw==
X-Received: by 2002:a05:690e:4549:10b0:662:b6fc:ab84 with SMTP id
 956f58d0204a3-6677fa2ea7bmr2174279d50.17.1783398556262; Mon, 06 Jul 2026
 21:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local> <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
 <ake6FNy83LLtCs3b@ashevche-desk.local> <CAGXv+5EgpizA3Pc8ScNuChPhvFKWd5F6dxB-wT4-7EwabE-9dQ@mail.gmail.com>
 <akvRMcGnUPxE3sxR@ashevche-desk.local>
In-Reply-To: <akvRMcGnUPxE3sxR@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 7 Jul 2026 12:29:05 +0800
X-Gm-Features: AVVi8CeDQS-P0cN7_fGlNwSI_p7eUQN2BPzLo_iMICLRCJ8sboVGUDAVuWI9R6g
Message-ID: <CAGXv+5EqsDbzTg9eDMGK3Ph6Pe3_uDoSrjVL4q23cy6jZCk2tw@mail.gmail.com>
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

On Tue, Jul 7, 2026 at 12:01=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 06, 2026 at 07:08:07PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Jul 3, 2026 at 9:33=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Jul 03, 2026 at 09:17:16PM +0800, Chen-Yu Tsai wrote:
> > > > On Fri, Jul 3, 2026 at 9:11=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
> > > > > At a brief look this will be the only function that takes usb_por=
t
> > > > > instead of usb_hub in the entire hub.h (I don't count container_o=
f()
> > > > > as a function). With that being said I would rather see it to be =
moved
> > > > > to port.c altogether (yes, it's more invasive change, but looks m=
ore
> > > > > consistent).  I would even dare to move struct usb_port (and cont=
ainer_of()
> > > > > accompanied with that) and this function to port.h. This might re=
quire
> > > > > a separate patch, though.
> > > >
> > > > I agree with the reasoning, especially given the function name. How=
ever
> > > > I wonder if it would cause problems given the linking order. I'll g=
ive
> > > > it a try nevertheless and report back.
> > >
> > > Thanks!
> > >
> > > In case it won't fly (but I still think it's better to split), can yo=
u at least
> > > group usb_port APIs and struct? Means moving the proto closer to that=
 struct
> > > usb_port followed by container_of().
> >
> > Looks like it works out fine. port.o is linked in after hub.o, so movin=
g
> > the function from the latter to the former doesn't cause issues. One mi=
ght
> > even say that it is the correct thing to do.
>
> That's what I say! :-)
>
> > > > > Perhaps something like: 1) "move struct usb_port and associated A=
PIs to port.h";
> > > > > 2) "...this patch...".
> >
> > There are still some left in hub.c:
> >
> > static void usb_lock_port(struct usb_port *port_dev)
> > static void usb_unlock_port(struct usb_port *port_dev)

These are only used internally in hub.c as a wrapper for the port mutex.

> > static void port_over_current_notify(struct usb_port *port_dev)

This is only used by the hub's overcurrent event handler.

> > static void hub_usb3_port_prepare_disable(struct usb_hub *hub,
> >                                           struct usb_port *port_dev)
>
> This one takes hub as well.
>
> > These are used only in hub.c and moving them probably makes things
> > messier?
>
> Perhaps better naming to each (kinda moving to usb hub namespace)?
>
> > OOTH, the following bits are in port.c but declared in hub.h:
> >
> > int usb_hub_create_port_device(struct usb_hub *hub,
> >          int port1);
> > void usb_hub_remove_port_device(struct usb_hub *hub,
> >          int port1);
> >
> > Any preferences for these while we're reorganizing the code?
>
> These ones would be good to be in hub.c if there is no circular dependenc=
ies or
> alike.

Those two, along with all the static functions they call, ends up being
half of port.c. That doesn't help the size of hub.c, which is already
over 6000 lines. I think I'll leave this one as is.

Both this part and the remaining bits in hub.c I mentioned above are
outside the scope of this series. We can discuss whether they really
need to be moved or renamed.


Thanks
ChenYu
