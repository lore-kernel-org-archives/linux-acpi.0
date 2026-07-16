Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E13277818
	for <linux-acpi@vger.kernel.org>; Thu, 16 Jul 2026 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176309; cv=pass; b=iU+V1n40IKtkbSzShSC0KI8E/zlc/1OzOjy8QVkVMiIC/nV7ic10aJ7787XmRjHj3OfJvgeJQE9gPXtCMWJ2w8efs8Jln0bndtgeRNJkVJmHQ8kmDAxT899p8RNOpoKrM/X07HX5W5j8r9yUOSYuc3qFXX77Vz8mquhLjH+YEqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176309; c=relaxed/simple;
	bh=nhYyNn6r73D9XtB76IT5BMo5NhG30UFFcOOZMpuXDho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6pyQr0cyLioqIJixavDVqIcKD+pm9LtdiqrTrwuC3Xnkgf8JbKf1/ETweNcPT3dkn80koXUrQy/5VNBkzsy/fyUJEp3ICkZ6g4m9CUFf6zsNArLoTfAHVuERM7M3OL4FMRN+e6Nnv809MrfiZB0EwtFfFfLPzyuhvBNG2qm7B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BbIlmPiT; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BbIlmPiT"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-668233388ceso757132d50.3
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 21:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784176307; cv=none;
        d=google.com; s=arc-20260327;
        b=kB/YSZAxondw7vHwG2nuEHIHDbrscL1DK8QPJNGOAeM/wUSMoZnNKXZNgThymrbTDc
         dG4jhXw0Kbjq04LihyGw1sCxucy7uePopaSN3nYNMK70Zqb3OC6FE2I9HCWeIwulgbkg
         OzOqOKN1MAM7Vo4Xn9QFW90ZvPaOXLKFYrPdmLOw664nIGdS7qdTkJLRTnWZvRrl9b7T
         BkkuqclGGjT94wggH+6MT7IUH3lICZ8Cjxs2iDzCi3xzRNXjZADfhyfWLWu2SecEWK4u
         hwxbiD6S/kEELjod2hPLdBkd2z9H9Ui+BY+Arf4F6ZyxfxneEBf0ZM0v3Dm+Y8dbF7TO
         9sZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWTekTqlq1/95QNv5fW/dcyHl3msvMXWSc0NTUyJpNA=;
        fh=maTdrviJBCGN1uNEkn1UxIMDXbSYoOeEvN8mD7cAM44=;
        b=sohoG0KxbkcYKWG8R+7J2i4gmMD+3P2qYHzSkrHPE8BOFSZDVadNOST2vZ6CKaLrWx
         Yi7JSdgMLr86StWCoH024m2p+KwPtvJIDbcSpeWv2vMPV3t7x4wHKk2x0f8CZhmfGnDe
         IZXhb2zj5FfZJnbw59VFEEwjSpWLXLgWzTpRwdyZ7AoaQbLO+dQlmyWLFuTh+GPXDOjl
         Wxd6Hj87x+d2dIHAkPYTLnwPHODUx9BNqbDaXHfzNZ0lr23i6sOg6lJfrjguzNVczdmH
         d4fqqJMXvdH8IQKpHPlrCVjDJ6bcYIX0ubcOJBRljEfk0zJBa4e6613CxXAZCKWiDYmf
         QWbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784176307; x=1784781107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWTekTqlq1/95QNv5fW/dcyHl3msvMXWSc0NTUyJpNA=;
        b=BbIlmPiThl4qtC2ZN7JQZl+L2ZooPvu5YEwEDvQfZB+ebI+hS/c29Vq0ahKfNxgu3H
         Y2dKQR08UIvbW04KcyCZxX8NOGetwY5g3XdreHta5FewJNT1+6IGkqv4QqXcQKnXrya3
         CREYMhgoOS0wLEmkqgUzYoB3Kjlg3MA3uZjMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176307; x=1784781107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWTekTqlq1/95QNv5fW/dcyHl3msvMXWSc0NTUyJpNA=;
        b=E6iu4VP5v5GYDGpo5vbjuRbD6Vwc+x+siPL2pDjDuX/0GTY4WRyEpfqmHo40/EuKWd
         2lZAwejDtWVyse5+lNZLDUhT1LdHZE124BOMm4Ed2N+Zd6qhyGSRQGmhOJVmoMvNbGq/
         kvYo1JCj9Ld7tlgUSyezS0nleVj41vatgGo/t/epeWTkgFzUUaoErAP8bZNaDfaG/8pG
         sBqXyMil35KbAXFrO8SGNBmOqPa9p1Lpql3Pbx8zZmebxPpSgPQ3k4HcGQGjj9NBdzEl
         9vhw1He0TlY2vnSQ9M186GA5kD/jUKM0h/mVdoaOHzZPlOm5L/+7lUk3iTK/GXAk1oZu
         Mlpw==
X-Forwarded-Encrypted: i=1; AHgh+RpBuFZhjvqawE7iCkMO7PFa7muiASG9rJxDpYt7tdRV0mH1KOENykfwsa6dFUQ4ss3LanABnwVlrEGn@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQ/25E1qcVztUxC6TT4XB1gzRaRbGRSLcz/IaZpHbhfzbdnzh
	j7Y3wyc7qq1JTYtzm2Vtp6qlaLHrThoj68XIlcvSLNawVw9kB2jrosu9ercOmM5+rFJP4H34cmW
	XC8RKAoBfClusk4tDhQ7ROXV40AsT8dMg7ezIcBjw
X-Gm-Gg: AfdE7cm+KLjmakOTJnjjhVh+AzrXy06zIFYVdrYaLjKszAnIbyEMsXuWEzaMhDjSluK
	G5l5kk/H/XF3c7xjzrfguxebS9Q2elwMtapG5FFAZ4sMuAcKgQem1owdM+HIALXjKfX75B+6PTf
	EsDCqgEtmZlj+OZmDzYjmTyPWjnqhO78CqbADaQh+h+2jW++jSVbXFdA377IdEXvhreIr2g0vri
	wStonGxeiM1/1J8apeDvOarDZjUHVjB/oePTqe3d2ERKy3V7ESeOB4GnBVjN2RjOoOTLB61xOh1
	sm8guSvzXEauXj2a
X-Received: by 2002:a05:690e:1c0d:b0:668:19ff:7eff with SMTP id
 956f58d0204a3-66819ff937dmr2943635d50.38.1784176307120; Wed, 15 Jul 2026
 21:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-7-wenst@chromium.org>
 <aldQ5odptfmK5aCw@ashevche-desk.local>
In-Reply-To: <aldQ5odptfmK5aCw@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 16 Jul 2026 12:31:36 +0800
X-Gm-Features: AUfX_mzQbv55XMQ4uR8jO2hQgRvrbYnVnLlttvP6FASpWrSMQxMLCCNzy4VYT9I
Message-ID: <CAGXv+5FAHZP-u1ZyWSUkUrOx7R5-YgBs5y9V4mGTycyrJG3UKA@mail.gmail.com>
Subject: Re: [PATCH v5 06/16] usb: hub: Associate port@ fwnode with USB port device
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

On Wed, Jul 15, 2026 at 5:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 15, 2026 at 04:53:36PM +0800, Chen-Yu Tsai wrote:
> > When a USB hub port is connected to a connector in a firmware node
> > graph, the port itself has a node in the graph.
> >
> > Associate the port's firmware node with the USB port's device,
> > usb_port::dev. This is used in later changes for the M.2 slot power
> > sequencing provider to match against the requesting port.
> >
> > To avoid potential conflicts with ACPI firmware nodes and then causing
> > power management issues, only assign the firmware node if the hub's
> > firmware node is not an ACPI firmware node.
>
> ...
>
> > int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>
> What about adding
>
>         struct fwnode_handle *fwnode =3D dev_fwnode(&hdev->dev);
>
> to the top of the function, and...
>
> >       port_dev->dev.driver =3D &usb_port_driver;
> >       dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->de=
v),
> >                       port1);
> > +     /*
> > +      * ACPI FW nodes are associated later when device_register() happ=
ens.
> > +      * Skip assigning one here to avoid potential conflicts.
> > +      */
> > +     if (!is_acpi_node(dev_fwnode(&hdev->dev)))
> > +             device_set_node(&port_dev->dev,
> > +                             fwnode_graph_get_port_by_id(dev_fwnode(&h=
dev->dev), port1,
> > +                                                         FWNODE_GRAPH_=
DEVICE_DISABLED));
>
> ...shorten this a bit to

Makes sense.

>         if (!is_acpi_node(fwnode)) {
>                 struct fwnode_handle *ep;
>
>                 ep =3D fwnode_graph_get_port_by_id(fwnode, port1, FWNODE_=
GRAPH_DEVICE_DISABLED);
>
> // Is NULL or error pointer is fine here to be set as fwnode in port devi=
ce?
> // Perhaps add a comment?

fwnode_graph_get_port_by_id returns NULL, but not error pointers.
And passing NULL to device_set_node() basically erases the current
associated node (which is NULL anyway, since we just created the
device) so it's a no-op. I'll add a comment.

ChenYu

>                 device_set_node(&port_dev->dev, ep);
>         }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
