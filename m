Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095A3E44E1
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277180; cv=pass; b=JqLR9LB9GKW5qTlCXcPIxbcFxru8zEzn1NexXjkNjl4VsNtecHivSfpt19WgOxC1oHPHtaNR1O8yuTHAM4NI0xpuHEfgvwO2xXnCvRWs/oQ80fl3sBpWiOBJd+pKKM1/neFbdbvjIxaNkwwoAxzK9aCmz3w4/cXbe0/Q//i1znU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277180; c=relaxed/simple;
	bh=K1k6G6+5zpiLdWHibg60JQFt+WiCSRiOFiAgjC0rwxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GysQWkhr2ZxzaSdk3PNd/+qRLhE49c1depQvtz7g4pwYZ6M24WkILQJrUtfZMf5r4pukt3JTABUfosekg8dDsI+xRldbynzDgnGn7IgYtJrgSIpP7aiujHls9gj1UFcffeyoWD+Wkc2OdQ5wE7NIGo6I140RC+5UA5qzgob6LmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l2kCj847; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2kCj847"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664b05d408bso3671949d50.1
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 01:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784277177; cv=none;
        d=google.com; s=arc-20260327;
        b=hJAliZhnzVOhn/tZDPXunrBZUH3Re5LhN1XEZfoHd08Q3Fll7b7CScJHMAjfaEZcpW
         BZ1HJ7MHJe+3XFdMklqiuPna/pFsYDUDduZndyndIbQbTmGux7dsPJDhpQzriOvvD2Ig
         0z8l/70A74ZHk+hysOHPwsQiSz2RBhIEMdB1Tr/jOsmF1whn5ehYcsouz7xzZ4cSD85w
         zsqUAS6m5le6H8o47/72EtQVQoZ3duc04I09Rld+UbV7t2B0VbT0hDEvrsKwJC/ZMn4e
         XUE0KkpPpmyLFyZHYT78WzVLwFtZz1QJe0P2gOSg0kQ4K1T67SMFtyutMPVuSWrnw0Iq
         Yevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1UhkOJ+I5quk7xrKkpQoT029NfPFJUjtkpwNCEPA8Ig=;
        fh=tfIHdGvd7r59qY1LHu5dKD8lcSs3izmm4L/emZMbLYU=;
        b=bSVud5GCiVz46ZMGgstmt78qIRYuiy8tmUnAu2hZIM4H4/4O1pH13zomNOHAhnTPWZ
         /FolZY+UjMUBAA0+4MrgkCX9EbkbuTECt4FntRcdfpKTq+g1GyOVf+JuMQcm28Hs1Srm
         xy1lzRrwzGuHIBJRkAfv6hIf2aPia2O5StgTO1z00StmU7WHYTx9gfZX5YTPiJlLkrFa
         dNBpiFseG3H8WFldID4tR2BHV/CWYivZ1uowcnz/8UQxnbHJNq2BjC6wYyIvRpHBw6l2
         5pQX7EtFuyBDhFpsFmWZrqs/yLsNHlRC/LND8kBYl/hWDQolS0I7FT+1C2VImmdTk2DL
         Nw1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784277177; x=1784881977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1UhkOJ+I5quk7xrKkpQoT029NfPFJUjtkpwNCEPA8Ig=;
        b=l2kCj847J02c+DpoVjLzUfMi5eK3O+d8hOmWkSba4h1OeBWn02zqqnCMEZfsFR5NnQ
         6uZVDWY9PNLRBlnnAmmS6gLMB0U8yjYxTt+730Xfts+gWiaiJKGEVNhsD8oG+Br5IV/K
         S4Vwq0BI0f/o8pRRZ4vw9ouPi0UFxLlEPUi5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784277177; x=1784881977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UhkOJ+I5quk7xrKkpQoT029NfPFJUjtkpwNCEPA8Ig=;
        b=HUFl3MUwpMmRKh4NZ8I/FW2KWF4wMoesjF5iFDg/xfRweUkPcQBEaHENkAKqBqJlUC
         /58A84m2bWExAVX/DIR/QwZtpJrLVkkK+ZHiD7iyvgGdanjVdPBEgSfnMNEaH5C6lxaD
         TkYRU8H68DewewolGUge+5IEoFV9zlyQXY8nooMzsXHCfo1mT7i+D+qzTC69oq7rUrA5
         LQeipD37BWz8B1mg97bGRlrmfzZabuI5fco2YyDywFUwa4F2Uwg37evHNMEUz4chSqLI
         ecRn1Z4wgXNjXTfUeVs7ln8oXjdXkHZOLZU82kLUWqs79SQ/56+/igh9+TbIQMEBxd7u
         ccCA==
X-Forwarded-Encrypted: i=1; AHgh+RrkvA3PKn2nKnT/MUZOSqom18U2FAvEdy82pwjdTnTqMYUziHW5XuorwnfrOBopFHN6WZnqDGfFIhxD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dtxLAzlgUUkARAiA6KvCWyj+YQohIxgTDpeHF0PleBuTzsTa
	QJ9HMo24GdxTaGMJwdFOIHbEoXTvKdzbQk4Yhkymm88TUQhIaiO/Uvgse96k9P1fNKXbQzoaw4S
	ypR16Hj8d9B/+MrvxkDrB1rOsTtMmEEPAVxVSnNLJ
X-Gm-Gg: AfdE7cl2ilpXDE5aBy9dOd2EZ/BznzEfz9zQb2/hykJNPrVINhn4tf7zkJdOtwILxm9
	p2czNuTxSnsVmw9pv/jqNIIGQi3BUpAm1AloHdoxjNkSa7FmnrwKQiaQiIpOoDourJV5y0JflhZ
	2hHFLSeKLXpk89djwUKuqHOGysT4//DAM8HO2zK11iwV1lIEw/GQ5wauSu5wnL5F6SBx8aSa/AV
	G/6YkgcxKiBZ/lpmYzBSiw1psJdAqO12la+wlYPS/c+1CIg0qYEJk8yPJY+FIsU+eFMg5L3HGXV
	2WoVdCV8Zo47
X-Received: by 2002:a05:690e:1644:b0:667:af05:2e8d with SMTP id
 956f58d0204a3-6683bde30b0mr341998d50.79.1784277176987; Fri, 17 Jul 2026
 01:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-11-wenst@chromium.org>
 <aleKQKH2V-ck-SX6@ashevche-desk.local> <CAGXv+5Ed9Cn-NeHiXJ58er7NJs1P2ZUMrjqYac-gSky-TNV8Lw@mail.gmail.com>
 <alkWE-bQ9gGIXIJj@ashevche-desk.local>
In-Reply-To: <alkWE-bQ9gGIXIJj@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 17 Jul 2026 16:32:46 +0800
X-Gm-Features: AUfX_mzoGIeMcv7EV_g3RqR3VRvLvguofP9ZSODwjiLGO0JAlL2g0unPo14vZls
Message-ID: <CAGXv+5FJkmOJgpwRBp4nAea6_moF=gH6wGmNpP+g8URNd--jbQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:34=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 06:02:38PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Jul 15, 2026 at 9:25=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Jul 15, 2026 at 04:53:40PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
>
> > > >       fwnode_handle_put(dev_fwnode(dev));
> > > > +     /* usb_hub_create_port_device() could leave an error value */
> > > > +     if (!IS_ERR(port_dev->pwrseq))
> > > > +             pwrseq_put(port_dev->pwrseq);
> > >
> > > Hmm... I would rather make pwrseq_put() NULL and error pointer-aware,=
 so
> > > it will be no-op in such cases. But I think Bart has his own opinion =
about
> > > this.
> > >
> > > >       kfree(port_dev->req);
> > > >       kfree(port_dev);
> > > >  }
> > >
> > > >               put_device(&port_dev->dev);
> > > > +             hub->ports[port1 - 1] =3D NULL;
> > > >               return retval;
> > > >       }
>
> ...
>
> > > > int usb_hub_create_port_device(struct usb_hub *hub, int port1)
> > >
> > > > +     port_dev->pwrseq =3D usb_hub_port_pwrseq_get(port_dev);
> > > > +     if (IS_ERR(port_dev->pwrseq)) {
> > > > +             retval =3D dev_err_probe(&port_dev->dev, PTR_ERR(port=
_dev->pwrseq),
> > > > +                                    "failed to get power sequencin=
g descriptor\n");
> > > > +             goto err_put_kn;
> > >
> > > OTOH, how pwrseq can be non-NULL and at the same time port be created=
?
> >
> > I assume by non-NULL you mean returning an error?
> >
> > device_register(&port_dev->dev) is called some lines above this.
> >
> > usb_port is weird in that usb_hub_create_port_device() does a bunch
> > of stuff that is normally done in a driver's probe function. However
> > usb_port's driver is just a stub driver add for userspace compatibility
> > reasons. See commit d99f6b4130877 ("usb: rename usb_port device objects=
").
> >
> > So at this point the usb_port device has been added to the driver model=
.
> > Or we can just zero out port_dev->pwrseq instead? I guess that is clean=
er
> > than having some weird check in the release function.
>
> So, why do we need to assign the error pointer to the field directly then=
?
> Make a local variable and assign it if and only if there is no error poin=
ter
> in it. Would it work?

That's the next thing to do on my list. :)


ChenYu
