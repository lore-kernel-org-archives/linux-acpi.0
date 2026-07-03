Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CE3D412B
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083553; cv=pass; b=ELHsB9/8AQnPKkqmyGkOwReeWefTfbkCMjrO1TP7/nriCxGGPV5YngoFoQ/Q4pzSCBbiDYuXGm93jj/0zkyLJdMYmqjFlbRD8eGsR17kCU5u9AA5fL+RGDiGpXnInat5I8GMyWdn7CBTCV1fHNQM/coigedRHKKXeUJf8WmM+3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083553; c=relaxed/simple;
	bh=5nft3AHBmBM/Bxl3hydeIyKsjDil7snVnqIN4LBKVNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwl+cyjMiQ8QW6NHisRPEmWAqr5eTxBAZivvxJUica992IzvRmwGfiQ/rlqrqamtT6u4FG08+uRUHf4H6X9daWoLTpvjbvFUsiftryncIG5Rtx0+cQ46ptMmYgsdku2vZ9eNBkLUOWWZJTwgE+tanVDTaYxBvDmpGL9G/7VY8uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Extu2FZq; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Extu2FZq"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664ee752958so769373d50.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 05:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783083549; cv=none;
        d=google.com; s=arc-20260327;
        b=VR/F6Cr0g4J9EagBRh0PfCHWC7nwfjPc4h/U9gilmF6gNbtPmmCx5FQYx0pSz48P8U
         tqbFwB5ASIwRZONPOffP+Uxm0MN8Z3fomnPN+s0q+xA8JBpiiBpov8723vbxRsc6RN4s
         DBh80QBrBbG53SUKTlvK5sld3sE9eJSK1dwnpdRxMkzu1g4qWa5Ob2d04o5rJecxMruO
         Q1FU/+lY5nXjbiIVAPhXLPFs5jgO9GShuKP/yWB0i15bLH5XX76X3LdVDtXn3ipZfv5z
         DbfqdjTbPtP0uOVy0Tpx7OcJYdB/6a5r8HNmXYDqRPFx30zTb1tt2zPbId5k2RdrTSsK
         30jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZpEgYLnkdRe+6URxXdbXlH7fdAucEfU8965vZ1JNkpE=;
        fh=JH/umvhcNPNtZ3GPQCsMWyO8nHrLbAZzHpp+BIN5qGs=;
        b=nRgpeLR85laIIq2QUh16321mCfwYBAIkKkLaGH/YuLNVejSYud8hrNKyNOR1UpFEj2
         rM7jd6ZaveBJpDqGt06R09lenvaTqtPYKdoduh7VeF0o0kdqxKhXkhKNHzifcJQFYqHi
         MThY9nBkaazP5rNSO4npS1+5OLTKAkB2tKdOCCQE4/eTW94njfCt5s++hdGnwvrIYJvb
         62UOdaNNOnQE3DaVwx/pBq7Pe9C9PftWrdb/l9d7YUhnmSzvSebJ+r4Q13B3WTlAZQcT
         IQH6/2DwfuGQ6SOPM7rREdxiVOIG/1Y+uLwS+GnENbiSc49tyRvM0odM7D1fYrXBQax3
         I82A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783083549; x=1783688349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpEgYLnkdRe+6URxXdbXlH7fdAucEfU8965vZ1JNkpE=;
        b=Extu2FZqzn4ClU8L4NNnO2llwM4UFE3ZM7uCH0/92mwMN0NbafecLi6Cy7/2SomdWB
         t+OCEV29btprJClH+4XsA/eUkIFuP5vCd3XNe4+K/k92/v4PEI/kVAL8Jq/sjRwO4MWO
         5x/O5nV5L/0p5pQe9AomnMHEjuUZk5UoSL+0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783083549; x=1783688349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZpEgYLnkdRe+6URxXdbXlH7fdAucEfU8965vZ1JNkpE=;
        b=aWk6e5cYi9Q07aBFcj4cwld0rvZilXQ2z45E91jQIzZfWzyl/21ml5ViGyfc09RMLo
         8Whscjk+q6NG050IXq7ofGTXNM7PNGwDrABo2Q9F8NdHi/eLYhkmbJOewDpM83yt+wY+
         4Dm3mOOQD/kIMHs1j7xVnf9lc7uUHKA5+yEcwLuCGfirNcEaLjz2V4V3jGVGfqDmMucW
         U89KSCGWXfevyqn2PlwRX5UEAhM87hgUhdgJUbsJ+s4Wo61Qhdy555cplsuHBwmjyJf+
         UEDTVXd6J8Raqt3QT8HIsIMIZnP/Y2x/II8NVj5m4vi7gWATQvUZpNz+AVo2mkdes6hL
         z2mQ==
X-Gm-Message-State: AOJu0Yz445LKurbeER8yf3QUCGVmI73yUimX/p+OYEQ1RfDzQEOCU0wJ
	qHbBYAhKnoxmJ8KBxgfrrQz1rrkkQqTJwIMGRtWtUQ28dpzLXyAyBOZXmKivkja5Yg6u/gtrP7G
	2VE9w5lo00l3PXx2WJENaH0vKbeXSaTrEem8piUqI
X-Gm-Gg: AfdE7cn/bneRlO0UStd642Uwv800WClP5W3mxjDdSeWbChkH82LfU46QrPOLeMOD9jm
	G8IeeK6oXkH2550pupHw8LEXCIk63OgLkjaOxrVrwyTA2AGqm7gOHBumKo9AxOR3QO+vMWjF8If
	RY0kUau6Gn/mXhqGJaxRER1N47+JbYA3bv9Ww56EBb4aH8QSweEyFNaFPUvwHj/hd4nf3rlHzqq
	vvgzspSZ827HDISj28IXx0HwRlSCWwmJCgfFNBh+N7Nf45oKBkRr0Tkizg3fKH40Oa+TkzkNBtw
	8eFwhZD5Z2ZnV9j8fIzbI6Z1Ac4=
X-Received: by 2002:a05:690e:1908:b0:664:ef34:33 with SMTP id
 956f58d0204a3-66521d1c65emr9453570d50.74.1783083548882; Fri, 03 Jul 2026
 05:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-9-wenst@chromium.org>
 <CAMRc=MdMhr6qAnAtUePbuBbsH=3MzRC+BrL5GssbNTwGjp_ayA@mail.gmail.com>
In-Reply-To: <CAMRc=MdMhr6qAnAtUePbuBbsH=3MzRC+BrL5GssbNTwGjp_ayA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 20:58:56 +0800
X-Gm-Features: AVVi8CeKAFgvldQwkCHupVnLS-0_fUDpMC-9BOMhYWR8u-1abjmchaeDfiY7p3M
Message-ID: <CAGXv+5GHFnMj3qr5BcpLCQk25rWYOgnMKUX079ScELs4uqEdVg@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 8:41=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, 3 Jul 2026 13:03:09 +0200, Chen-Yu Tsai <wenst@chromium.org> said=
:
> > The new M.2 E-key connector can have a USB connection. For the USB devi=
ce
> > on this connector to work, its power must be enabled and the W_DISABLE2=
#
> > signal deasserted. The connector driver handles this and provides a
> > toggle over the power sequencing API.
> >
> > This feature currently only supports a directly connected (no mux in
> > between) M.2 E-key connector. Existing USB connector types are not
> > covered. The USB A connector was recently added to the onboard devices
> > driver. USB B connectors have historically been managed by the USB
> > gadget or dual-role device controller drivers. USB C connectors are
> > handled by TCPM drivers.
> >
> > The power sequencing API does not know whether a power sequence provide=
r
> > is not needed or not available yet, so we only request it for connector=
s
> > that we know need it, which at this time is just the E-key connector.
> >
> > On the USB side, the port firmware node (if present) is tied to the
> > usb_port device. This device is used to acquire the power sequencing
> > descriptor. This allows the provider to tell the different ports on one
> > hub apart.
> >
> > This feature is not implemented in the onboard USB devices driver. The
> > power sequencing API expects the consumer device to make the request,
> > but there is no device node to instantiate a platform device to tie
> > the driver to. The connector is not a child node of the USB host or
> > hub, and the graph connection is from a USB port to the connector.
> > And the connector itself already has a driver.
> >
> > Power sequencing is not directly enabled in the connector driver as
> > that would completely decouple the timing of it from the USB subsystem.
> > It would not be possible for the USB subsystem to toggle the power
> > for a power cycle or to disable the port.
> >
> > Also rewrite the existing set_bit() and clear_bit() branches with
> > assign_bit() to make it cleaner.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Expanded subject to mention power sequencing API
> > - Dropped commit message bit about power sequencing Kconfig symbol chan=
ge
> >   to bool
> > - Added optional dependency on POWER_SEQUENCING to USB
> > - Split out pwrseq_power_*() calls into separate helpers
> > - Rewrote set_bit() and clear_bit() branches with assign_bit()
> > - Dropped the pwrseq_power_off() before pwrseq_put(): pwrseq_put() does=
 it
> >   automatically.
> > - Removed pwrseq_power_on() from usb_hub_create_port_device(); it will
> >   get called through usb_hub_set_port_power() in hub_activate().
> > - Added checks for port->pwrseq in hub_is_port_power_switchable()
> >
> > - Use separate pwrseq descriptors for HighSpeed and SuperSpeed ports.
> >   This makes things simpler. On the other hand to power cycle a port
> >   userspace needs to toggle it on both the HS and SS ports together.
> > - Dropped pwrseq state tracking again
> >   The power sequencing consumer API already tracks the state internally=
;
> >   doing it again in |struct usb_port| is not necessary especially now
> >   that the descriptors aren't shared.
> >
> > It's unclear to me how actual hubs reconcile USB_PORT_FEAT_POWER settin=
gs
> > from the HS side and SS side. One hub chip vendor said that VBUS_EN for
> > a port is on if the flag is set on either side; however actually testin=
g
> > on one of their hubs showed that VBUS was cut as soon as the flag is
> > cleared on the HS port. Maybe it could be different if a SS device was
> > connected? That scenario was not tested. Testing on another retail
> > bought hub seemed to work exactly as described though: USB_PORT_FEAT_PO=
WER
> > needed to be clear on both HS and SS ports to turn off VBUS.
> >
> > Under this scheme, I'm not sure how the power cycle in hub_port_connect=
()
> > would work correctly.
> >
> > - Link to v2:
> >   https://lore.kernel.org/all/20260610084053.2059858-1-wenst@chromium.o=
rg/
> >
> > Changes since v1:
> > - Switch to fwnode instead of OF
> > - Tie port@ fwnode to usb_port device
> > - Move remote node compatible checking to separate helper
> > - Use usb_port device to request power sequencing descriptor
> > - Drop "index" parameter from pwrseq_get()
> > - Do not get pwrseq descriptor for SuperSpeed port; share one for one
> >   physical port
> > - Add pwrseq state tracking
> > - Link to v1:
> >   https://lore.kernel.org/all/20260515090149.3169406-1-wenst@chromium.o=
rg/
> > ---
> >  drivers/usb/Kconfig     |  1 +
> >  drivers/usb/core/hub.c  | 44 +++++++++++++++++++++++++++++-----
> >  drivers/usb/core/hub.h  | 10 +++++++-
> >  drivers/usb/core/port.c | 52 ++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 99 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index abf8c6cdea9e..ef1959363fb1 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -44,6 +44,7 @@ config USB_ARCH_HAS_HCD
> >  config USB
> >       tristate "Support for Host-side USB"
> >       depends on USB_ARCH_HAS_HCD
> > +     depends on POWER_SEQUENCING if POWER_SEQUENCING
> >       select GENERIC_ALLOCATOR
> >       select USB_COMMON
> >       select NLS  # for UTF-8 strings
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 8ae97e8c26aa..dfa0f5dd75e8 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/random.h>
> >  #include <linux/pm_qos.h>
> > +#include <linux/pwrseq/consumer.h>
> >  #include <linux/kobject.h>
> >
> >  #include <linux/bitfield.h>
> > @@ -871,6 +872,30 @@ static void hub_tt_work(struct work_struct *work)
> >       spin_unlock_irqrestore(&hub->tt.lock, flags);
> >  }
> >
> > +static int usb_hub_set_port_pwrseq(struct usb_port *port, bool set)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (set)
> > +             ret =3D pwrseq_power_on(port->pwrseq);
> > +     else
> > +             ret =3D pwrseq_power_off(port->pwrseq);
> > +
> > +     return ret;
> > +}
> > +
> > +static int usb_hub_restore_port_pwrseq(struct usb_port *port, bool set=
)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (set)
> > +             ret =3D pwrseq_power_off(port->pwrseq);
> > +     else
> > +             ret =3D pwrseq_power_on(port->pwrseq);
> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * usb_hub_set_port_power - control hub port's power state
> >   * @hdev: USB device belonging to the usb hub
> > @@ -886,20 +911,24 @@ static void hub_tt_work(struct work_struct *work)
> >  int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hu=
b,
> >                          int port1, bool set)
> >  {
> > +     struct usb_port *pwrseq_port =3D hub->ports[port1 - 1];
> >       int ret;
> >
> > +     ret =3D usb_hub_set_port_pwrseq(pwrseq_port, set);
> > +     if (ret)
> > +             return ret;
> > +

As Sashiko pointed out, the stub function returns -ENOSYS. I need to add
something to handle that case properly in the helper functions above.

    if (!IS_ENABLED(POWER_SEQUENCING))
        return 0;

seems to be more straightforward.

> >       if (set)
> >               ret =3D set_port_feature(hdev, port1, USB_PORT_FEAT_POWER=
);
> >       else
> >               ret =3D usb_clear_port_feature(hdev, port1, USB_PORT_FEAT=
_POWER);
> >
> > -     if (ret)
> > +     if (ret) {
> > +             usb_hub_restore_port_pwrseq(pwrseq_port, set);
> >               return ret;
> > +     }
> >
> > -     if (set)
> > -             set_bit(port1, hub->power_bits);
> > -     else
> > -             clear_bit(port1, hub->power_bits);
> > +     assign_bit(port1, hub->power_bits, set);
> >       return 0;
> >  }
> >
> > @@ -3249,7 +3278,10 @@ int usb_port_is_power_on(struct usb_port *port, =
unsigned int portstatus)
> >                       ret =3D 1;
> >       }
> >
> > -     return ret;
> > +     if (!port->pwrseq)
> > +             return ret;
> > +
> > +     return ret && pwrseq_power_is_on(port->pwrseq);
>
> So this is only needed to not have to track the state in a separate field=
?

Correct. Reading the field is not the problem. Updating it is, as the
fields are packed bitfields, and Sashiko suggested that locking would
be needed, though it may have been for the peer port, which has since
been removed.

[...]

> Looks good to me.
>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks
ChenYu
