Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337F1429D
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243199; cv=pass; b=PyGfesZC86MDO7EHBOmJl3yqmlllbwUJe0CLJR0W9ygI5BZQIf/w/QzGRcCpawW5W24UgdVj1tFA7qbR4SdxmSN9HZZVXGK8VDkKwSkDqOP6dOdaCJxBCcoNeXFz1lrKf9RvL79s4Xg6NLtoSx8bWbaWmI1vuRblJzVa94mtTAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243199; c=relaxed/simple;
	bh=uxhicmxU+8eIG2C29hx4vflsMsbZnUfDPDvn7qOTo6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktY5HWKWH9LmAkpw1YgJMGP4OntFS3iNq6XNsWAXa0qfCHzqzZSpF6qMqx/Hu5tAJyQkA0wpr0/1O8P/qcPjszc7kvxdGRVjQUsn/fj/Fw7fHlFV8K9d938ETSowe/MTwVsYs5E/Hh7x1brJmc+edSEh3216H1GN99sIqih1G1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fZo+warr; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fZo+warr"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e87602f26aso6785087b3.1
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 22:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781243197; cv=none;
        d=google.com; s=arc-20240605;
        b=kcCxCMHNztLH4JIAVVQxqMj6W+FQjon45Snfq65FJE+HOZOQ0WoVPogb0LuWdTCGB1
         gJXuc44CCW5MXdVqQK51/ta0mzfIoh4iaxemk1qPN2gpF8tu/FUhI9QY8iCYCU+7pvPM
         J1fHvvL8Sq8CF7O8S6yMkeuVg+XnKYUrha71WZ38FNaGgRcGNB1+M3nR/dM8Hj+exY6b
         XcS+Skqr44lmlKN3B2UYPKi4BEf6dpvSvcJWZWE+uakDcCmNFt1Lg/Dg7twm5W5EzRy2
         UQPrFPp8ZRxQdGO8lICrUMQZrofMwftrT58yiCeab+OlRAC//K+EulOLiwhJiRFaG5ga
         hGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MHHVj+Zx0+/vBQAJBv7r1n57GCFzoErkyz4ZsU3+esc=;
        fh=uSt1qd8k1/u9aLU9a6JOfHKsSHoXBbFcjhbX9cW/OH0=;
        b=cQUgniW4bHn53pj4jXFGz8uUtUo3sw4x2Gtk6IMHsOnh7YxGmOrP13irrp+demrc0O
         net8aYNx9T4KjqPUNfbGEqAfjdIGzA3rMj1e4+cmMJQ+uYVx7Vafh6RP0iyUMQleaAo8
         3OAeJo/8y+w6GLxy2QESxdEyomtSzwJg2zT/mue8S+Z0VOpm2SoVTeUtnfUspZGdpTgY
         pKzLlWWE7YZ8g67Pp+PPRyi9URkROf/tZlSdPdO1Dw0oTMiz5uzJg4GGnnlkUHbJ80qq
         f5177vMn4uBh7VpNV9JXdnRMpdFzKkM8ZfzrK9mEo6fUgQQQyjxxiwjIXzqzbiEqwMn3
         y6nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781243197; x=1781847997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHHVj+Zx0+/vBQAJBv7r1n57GCFzoErkyz4ZsU3+esc=;
        b=fZo+warrrCYk1a41/ryhx5xh3MVD3vgwycLGsaleyAecG4cRy2k4u8MiUX6+LC8b/t
         D4MczgmKUGOjpZE1Dz7V7xrUOCZSG7PBGNlAj2xhqCkIMgqYmcDOuiuuOd2+bRWNssq7
         YbD3pZJ7HT6EUUZK64WOhdFga6L8gjyWea8TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781243197; x=1781847997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHHVj+Zx0+/vBQAJBv7r1n57GCFzoErkyz4ZsU3+esc=;
        b=JIwBR1s7OJSUSqfLHLqMgsnLU6enx4GPahP/c+CKgSQZ2BSKrFIQBRCg2d1dncOPgE
         dzexzlcrsnakSB10aCLSsvi39HeoPBBD3DeRWXUHFMUIrJAGPh2xk/NqvE363TEyLAVh
         4pQ5Vhahux2pDT8FCeLmUzd62G2OwODBEhYSTqT9UUnHd5hycA5xohhSCRfyS9e2xwb/
         /FU6ia7pMSKEI7Va8Iap1heHeyan1l4uWAsAy5TQjj3LeI7RQUl8OajXri8ywARwdTIV
         0YdYy12WdXM1GJGTF6xuXHG1ISmGK+2ktqHkBAoKpiHx5boRYphKJfTH9W1K8pNf/dgH
         /HbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4pQUISpO5OPzhAIcoEjpzDxhg5uXB/lGGCEE9tw/tLQrs5PA92yEYPgJJQaBFY08tcsBqh9pX06tW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyti1HagFh97pOf6PV/32lpg/XKS0kbHxys0XYBKV7mQSCA9/pv
	OCnOFbLvAktBWZH2JrnNjm3ilrn+49W+lsj23J9ATReNSTdj0wGpBvu96C3tR+u43PIhXcciHJ7
	kmj4z1Thlalbh1QdUV7qnCoaZ3LkL7egg59NBw1it
X-Gm-Gg: Acq92OEK8Rihddsf1QzMUFio52qyzv05xr4qFFbzE8YHr7hNbI+Erzv4v2U8NFPf+kn
	3Uv1DbaiBUZjhZoLU6TRu13GoJuABKXDVNkRQ7HoJfswQAgWJIXnoYSVKdoG/MiET7H8KiqkUhW
	UNGaICS1VLJ4NgQjawVz/xKjl4cRlUHeNxHJtI3r5Wb/PYxQmjYqgFeLTamQ8jv79Alg1MduG0+
	rM5jJYxFPIkgs6x2qCs6xk1j8F9s7FG3Cppl1kYFEO00mDOWH+P9unhLmH0t2nApDSU7xdzQWir
	WUmcf/bZ
X-Received: by 2002:a05:690c:4441:b0:7cb:93d1:d804 with SMTP id
 00721157ae682-7f7cc52611amr7898237b3.7.1781243197392; Thu, 11 Jun 2026
 22:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-6-wenst@chromium.org>
 <ailxrP-_9_NL8qnN@ashevche-desk.local> <CAMRc=MdiwQM6yk8FXcc+RisVP2iqWKWzVsn2-Yy6dyJXt-1X=Q@mail.gmail.com>
 <aipz2zMFcdnZYTxS@ashevche-desk.local> <CAMRc=MdRN7YitmMX8PknbzLh+MdsWm+dDg0MLtCVYOorqNobTw@mail.gmail.com>
 <airY6IMz2KFz_z9j@kuha> <aisEccAOm3qoXjxd@ashevche-desk.local>
In-Reply-To: <aisEccAOm3qoXjxd@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 14:46:26 +0900
X-Gm-Features: AVVi8CcqLILhEQ5p8_o0FiDM5Wwe_hy_cZp3NZb3BqN3lFzIwdQDiPu3OCyJS60
Message-ID: <CAGXv+5Hf_V4=mkAc3pN8_K9i+FfH2Wv7HVJBq71-f8sMFYL3fA@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] usb: hub: Associate port@ fwnode with USB port device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:54=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 11, 2026 at 06:48:56PM +0300, Heikki Krogerus wrote:
> > On Thu, Jun 11, 2026 at 11:35:13AM +0200, Bartosz Golaszewski wrote:
> > > On Thu, Jun 11, 2026 at 10:37=E2=80=AFAM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Jun 11, 2026 at 04:20:58AM -0400, Bartosz Golaszewski wrote=
:
> > > > > On Wed, 10 Jun 2026 16:16:12 +0200, Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> said:
> > > > > > On Wed, Jun 10, 2026 at 04:40:39PM +0800, Chen-Yu Tsai wrote:
> > > > > >> When a USB hub port is connected to a connector in a firmware =
node
> > > > > >> graph, the port itself has a node in the graph.
> > > > > >>
> > > > > >> Associate the port's firmware node with the USB port's device,
> > > > > >> usb_port::dev. This is used in later changes for the M.2 slot =
power
> > > > > >> sequencing provider to match against the requesting port.
> > > > > >
> > > > > > Okay, would this affect ACPI-based systems? if so, how?
> > > > > > Can you elaborate on that, please?
> > > > >
> > > > > Is it possible that there's an ACPI device node associated with t=
he port like
> > > > > on some DT systems? I don't think so and there should be no impac=
t IMO but I
> > > > > also don't know enough about ACPI.
> >
> > There are device nodes for the USB ports in ACPI, and I think they get
> > always assigned in drivers/usb/core/usb-acpi.c.
> >
> > > > The API is agnostic. There is a possibility to have software nodes =
associated
> > > > with the port. I think the best is to be sure that ACPI-aware peopl=
e who are
> > > > experts in USB will check this (Heikki?).
> >
> > I can't say what's the impact from this patch - I'm not an expert with
> > this side of USB. Is there a danger that we end up overwriting the
> > ACPI node for the port, or something else?
>
> Exactly this one is my worrying, but I haven't checked the actual flow.

Looking through ACPI code, ACPI_COMPANION_SET() is used, which boils
down to

    set_primary_fwnode(dev, acpi_fwnode_handle(acpi_dev))

This is called through

usb_hub_create_port_device()
  device_register()
    device_add()
      device_platform_notify()
        acpi_device_notify()
          usb_acpi_find_companion()
            usb_acpi_find_companion_for_port()
          acpi_bind_one()
            ACPI_COMPANION_SET()
              set_primary_fwnode()

Looking at device_add_software_node(), all swnodes are secondary.

set_primary_fwnode() seems to be able to make the ACPI handle / fwnode
the primary, keeping any existing fwnode as the secondary. However
if we do end up assigning a primary fwnode to the device using
device_set_node() as in this patch, set_primary_fwnode() is going
to complain loudly.

On another front, the ACPI representation of the USB ports looks nothing
like the OF graphs, at least on my X1 Carbon:

For a usb port device on the root hub such as

  /sys/bus/usb/devices/4-0:1.0/usb4-port1/firmware_node/path

looks like

  \_SB_.PC00.XHCI.RHUB.SS01

while a usb port's firmware node link

  /sys/bus/usb/devices/4-0:1.0/usb4-port1//firmware_node

resolves to

  /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:19/device:1a/devic=
e:29

Neither looks anything like the graph "port" / "endpoint" node names.
So maybe we're in the clear here.

Besides the loud warning from set_primary_fwnode(), the major issue stemmin=
g
from a wrong node is that power management (through ACPI) is likely to fail=
.

If we're still concerned, I think we can skip the assignment if the fwnode
is an ACPI node, i.e. check it with is_acpi_node().


I've never worked on ACPI systems, so this is just me checking the code.


Thanks
ChenYu
