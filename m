Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691473;
	b=cZp4ZUWzWTG81BnP12FhTPCr9871mETOhJ4iR56slKikRPX0K5IeqqDS7zZRFEwwohvu
	 1xnD957hMu1vQ27TPHgOAYMC8/Yx3UNxmWxf+JBfYAt9PnEuQ0TXFjNWq25z20TVqTmj8
	 W+QSkG0HIvMNK5XhayvJVejGfTlz3d3dN/Y7YJkLSprc4Q9XebPvUdGSus/cS+MhXteJP
	 MLWp1Uw1L0mB8B44nEiHMBe4hmcCikVle36Z5mvhV+3Nxe3B7siHTlmcBsLkJ5DIt8UJ7
	 m89DHT3ChWIGiUi2Q5vYgQBA/ZkJuC4HzYmXfqI41ZblKtHRp7GgebXPcvoS/iMbmMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691473;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=R9bdZDRYMZKsVAULKpGjrw6cvUzg31C4HzoC6qyPpxg=;
	b=T+LdG/255bNtwhIkFO95eIWFRlWJsjYZtuEFIsdi6Ur/jPEeRs33mF7RlocVPGFHu1Gp
	 cD5nTf3ad+8ZA5z+sEAMQ+30y7xvXQdDlo6FLG0e+5B7UZUJGS4XSr5nyPfngxEpMH+xK
	 dns5F8E5puSu8uwdpdepd2Uk0dj1DvZ96i2iFU9lYegeC+2eykXSe9biaSsSxmOHCi5cQ
	 sqZiEe5upDPljVg9EXMC+A11Y2C6kfmzeLKC7Wk8mE/8aYo/XQNVJveUmloGEbISN6FRT
	 18DU7NPZjYy+Izo0L4fTBTj7gU8W0yqX7GmCYZSVgRoVQoazHnWonvYgSAgrcalNy9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9IbipuY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62249606A320
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9IbipuY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FB71F031E0
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691473;
	bh=R9bdZDRYMZKsVAULKpGjrw6cvUzg31C4HzoC6qyPpxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R9IbipuYeS8U8DQjU7FPkEmEfIf/NPdYmnwjw4RBtvBDFJyTi4hs16qhmd1n58ea/
	 s5839OU9KCvFmKdlWE4KfWSONHMELitgDXuZ+X8ruWu/dWqnMhlqZMaMR7jUnMpCYU
	 JzKya07J0bW4TOMQn9gyKSU1QoWuBGjlrtmQ2KzcBq53aT6HL/pXLn26yVpp6aPYb8
	 uhXN94xc6uQogzFzd2wU0TMDYAWu8XqvRMxEOfjXiREuGL4mZjWzBVGLioOf2GZdfR
	 y68MvYNYbWEOpHzRTtnH0/qTdYWF08wrm2dzfnac8RUBPS+JhpgafVsw++RPCYsbF4
	 9cpr/6urTomQg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ba328513b9so1925073e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 10:51:12 -0700 (PDT)
X-Gm-Message-State: AFq9FYKsNMhoLV70W6Tc9bwZUPj4Jq7daM4iea9jMop1UhCozjxeqJZT
	5ttaeMDehiJIPXLstGuy0W4uzub6xQkCQIgZQUI8BQNI5o90GIjBL9rsBNbHodwJZtTUbx4WzUE
	U1+fPpchNlbrp0g+nK7b2D83eX7cUHhg=
X-Received: by 2002:a05:6512:124e:b0:5bf:a036:3e4b with SMTP id
 2adb3069b0e04-5bfa1bb87d5mr2514627e87.7.1792691471347; Thu, 22 Oct 2026
 10:51:11 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929181056.4746-1-mhklinux@outlook.com> <CAJZ5v0jNJBCK1Zj0cVuTK3mtyJFF3MbEH8HKvTNKCa84eMUdmQ@mail.gmail.com>
 <MN2PR02MB6863A57660077B2466B77FB8D4652@MN2PR02MB6863.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB6863A57660077B2466B77FB8D4652@MN2PR02MB6863.namprd02.prod.outlook.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 19:48:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iSn8_sxdaXcSv8zvzwUpUPVTHpZw0Tg-OEPmq+xAFOmw@mail.gmail.com>
X-Gm-Features: AclHuK9OQn02mgBMGrBtFonnYHv87q3DVWCFzjepFTk63xsOK8_QFIiC_dLyc3Y
Message-ID: <CAJZ5v0iSn8_sxdaXcSv8zvzwUpUPVTHpZw0Tg-OEPmq+xAFOmw@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in pcibios_root_bridge_prepare()
To: Michael Kelley <mhklinux@outlook.com>, "bhelgaas@google.com" <bhelgaas@google.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 7:14=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Rafael J. Wysocki (Intel) <rafael@kernel.org> Sent: Tuesday, Septem=
ber 29, 2026 11:23 AM
> >
> > On Tue, Sep 29, 2026 at 8:11=E2=80=AFPM Michael Kelley <mhkelley58@gmai=
l.com> wrote:
> > >
> > > pcibios_root_bridge_prepare() currently has code to handle Hyper-V
> > > guest root bridges with the sysdata parent field set to NULL. While
> > > this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
> > > Support root bridge preparation for Hyper-V") was accepted, more
> > > recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
> > > device to PCI device") always sets the sysdata parent field to a
> > > non-NULL value.
> > >
> > > No harm is caused by leaving the special case in place, even
> > > though it is no longer needed. But in the interest of overall
> > > code cleanliness, remove it.
> > >
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> >
> > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
> Is anything else needed for this patch?  I presume it should
> be picked up in the PCI tree.

Right.

I can pick it up, but then I'd rather have an ACK from Bjorn.  Or we
can try asking directly:

Bjorn, if you have any objections or concerns regarding this, please
let me know.

> >
> > > ---
> > > This patch does not just do a revert of 7d40c0f70d92 because
> > > an intervening commit moved the code to a new source code
> > > file.
> > >
> > >  drivers/pci/pci-acpi.c | 12 +-----------
> > >  1 file changed, 1 insertion(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index 42d545edd7fa..452a90317c58 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -1572,17 +1572,7 @@ int pcibios_root_bridge_prepare(struct pci_hos=
t_bridge *bridge)
> > >                 return 0;
> > >
> > >         cfg =3D bridge->bus->sysdata;
> > > -
> > > -       /*
> > > -        * On Hyper-V there is no corresponding ACPI device for a roo=
t bridge,
> > > -        * therefore ->parent is set as NULL by the driver. And set '=
adev' as
> > > -        * NULL in this case because there is no proper ACPI device.
> > > -        */
> > > -       if (!cfg->parent)
> > > -               adev =3D NULL;
> > > -       else
> > > -               adev =3D to_acpi_device(cfg->parent);
> > > -
> > > +       adev =3D to_acpi_device(cfg->parent);
> > >         bus_dev =3D &bridge->bus->dev;
> > >
> > >         ACPI_COMPANION_SET(&bridge->dev, adev);
> > > --
> > > 2.25.1
> > >
>
