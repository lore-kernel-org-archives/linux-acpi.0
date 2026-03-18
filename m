Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988AC253932
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773800667; cv=pass; b=Hea4268svmwoiE9UTPT4YViq4Z/88x5Ue267UY7R7xA6QUBHVjojJMm+H7myc1vI8xs9GudXmrQNoDEUDT03vDLSZ2e3w3TZqNHVdNJnmfy+ha0KVDaHUH4SHvZFw9NgPyYcBGSGXR1OaZhyMkYy44LQYUwtedKcrFBTB/LA1us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773800667; c=relaxed/simple;
	bh=FaSgqPgpLs2Ef5gPT0AOoZGzKimFlhTpsUifJjQBByM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOLHD+gnzLpMdDSbsBsfNOSqQqDWU+kTgIb7iOWw76yoc/9VwyZ5sBdRaC/Q7iGhgj2oNaYSiAgPi+Rxrk/5LQhgkYELUV0wb2akjSY7/piDkMvp4xgRAfNqa7fZTZ6hKoD5HVY2ge24F5fFVAgQlWgG4cgrm+FDecb7RoK7vWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTJCbXjP; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTJCbXjP"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso8538233c88.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 19:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773800665; cv=none;
        d=google.com; s=arc-20240605;
        b=KOL5C5W+Bwcpo9uOYJD/JqhKIz3SBQpgCJYHQYwpOseXoK0yldpLJZX4XUWOiDt6uM
         M6naD6hUFRVshoxaPCfbLE1PE4QOZOSJ9jdUTdS0KyE+B7seTWkpf44PTp26nmpUJ8eL
         FgM5kuUoNYgNg3S1ZFV2OEezeAUR+R7PFHLNAJYSpcWL3MQzjVGUhZS+C3/UWcxJzP7g
         QWaKdPpIYiEZHLzGOvQvXzWiEu05iuarcubzSLBR4rRSQLDX99vPbI1sRgmiqGiW/0Lp
         PIUSi8b5bx7Ufg63m2GMyL6cWUy8odNNqZwZCLLC1oKTsQfeL/vFADcKJVrnmaiBESP2
         g55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=viojiY2S+ucyqJjwH7zfRoMUsuul0m89jhJPIm/18a8=;
        fh=MUnqRRVX1nN1TMTuNBNjvpENMmDvY4GujWBRJOGpSu0=;
        b=AIbe60jkOp7ZTcOow4mnCSY9xhLmZdwNlmkoNY742EMouw9bNyFEKZFLi0YyayJjoF
         0gS2/nWEa/kSvhXXbjbA/hWnPvBgQH8ZF5ogWwH5LhzXkrI4OgxWgvwBSLyv375tr6Yg
         93BubYQmsjSi3RwNZ4L4yVbeacFLRWnyjvwDbCRKywgdGkrxsQ0uPwfHLJ7zqriRpAbq
         8hgiq9UZietXOi1WyYX6mPwZe3NUwlv5UsPb/+om5mpUkYjd9sbx+8FFo6CpnV0z1pi1
         LZl0NCy1IVk9F/iHotS6d4GvN/8l8nPdrIwR6Bx3nxwSj64bCRjud+flHHxRc6K5Zv8L
         LsnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773800665; x=1774405465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viojiY2S+ucyqJjwH7zfRoMUsuul0m89jhJPIm/18a8=;
        b=mTJCbXjPbTHpRkeWoxkZMZiQx2LTdq4eQ9vZRGGgN0zGpehdicL7mOmjcwwxRi2PEW
         +Mk1hSIUbSc4UDNFJAqQDavqldZ6DuhHNMYYcUedwNF7SsEcDRfM42rLYbCpbAi1qpbf
         4vJQ3ytYpB4pFGB6R5teXHanIabxy7pFmc/AM7WTwQPvNLMjURnFedgdNfJ8f62pMb8o
         IoEM/bkCpAotoHfJ2rBAdTZwj63VV1/tKMRxFZVKLFKL4q6S/XHYynMMcbVabMGHPxvI
         mHxtpRYPkGnzCuy9N4q/g1AkCDaBCokrjsj4F7xtPWhk+MdUQw78y1MPC/cgJQ40m43o
         wERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773800665; x=1774405465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=viojiY2S+ucyqJjwH7zfRoMUsuul0m89jhJPIm/18a8=;
        b=qCsIlpdQZXlr3KEc15yHG8v45r4WbEY/E6zzaHUdz+3wjyeP6czKTUTbg7s6x/LYtz
         5WH2fqfEZ08UGYi0FNy2TrvqawifvL+jarRIFZa8X0DkmKH+J/jc0PoZSK6THn4cLse9
         gR/M5jqZ5eaWhRiORlNiqOH9MOmD8Da3Y5GkZBM9jztHSTP1yelIOXtkH/nsAhisgLkE
         1MxEl2LS62rMH7f7Whps6xAv4u1W/cTzdP4fUH+XtXCLoH/Qrl6y41rgauqGot89vv4E
         OsXoIGzyAUAb0sha5LVoZinruDtXlSCcJ6j/ukpMHdHFbaOnlNZGFzMGWOJHge0I0t7a
         3Ntw==
X-Forwarded-Encrypted: i=1; AJvYcCULlQmsxERL40c3duPqyu3R9rwqaTmrU+LVPFJy9wfwiHpxuddODWOJ5/X5F63gdjzOV4LUIUr9HIEQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18dMv5oF6s94vY8bIPjo75hHbWDE86BqatAv2HcAMMRnh8w9s
	25D8hPR4Qs/1xl2XQwEEjP8yIUNcWRRBf3r8wTbbLu3+dk7B886b+zeHtYOh10NoVpIdbEZC2V3
	qMppM2cGn+uy3QLFNL2h3zHmF2x2J6hY=
X-Gm-Gg: ATEYQzw1g6bi5DolCbSwz3n9rv3MfGL4NWPIpKlhm5o2KwX3m55PHp7kwZ69IbFpxc4
	x/xMOrqIVhvdQYFeRFvAdUkzhX+MnuBJKq9r8CvXvcRPbEuK28A019Lur5psSB8/AhECrfHVt69
	/xG6GFdaMoqH0SwofSsMx0mblsms1x61kQUcMPGbz9lK5yoooFzAvTdKHjqoQ8eGNZq+OJxdDMd
	wRPP/QYuHBf1WDeTP0eXunFNB4nzcKzkqnnNs64CyvQ1QaABQv64rTUw5w6Mtzai4rw+CAQgQnK
	bdeR/QrgG09SLloXbE8=
X-Received: by 2002:a05:7022:692:b0:11b:9386:826c with SMTP id
 a92af1059eb24-129a715a6b9mr978477c88.41.1773800665385; Tue, 17 Mar 2026
 19:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163214.202262-1-islituo@gmail.com> <938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net>
In-Reply-To: <938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net>
From: Tuo Li <islituo@gmail.com>
Date: Wed, 18 Mar 2026 10:23:35 +0800
X-Gm-Features: AaiRm51U_JuIclZnayN8ai-xrcV4F1Iqh32uu_8nQqz-Dgr0rn7p-xNyyWFMOEg
Message-ID: <CADm8TemhLAd27PK+G-Pmn+Yqg92xuDRFYjAOOM2y9ZuENH+SdQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: processor: Fix a possible null-pointer
 dereference in acpi_processor_errata_piix4() when debug messages are enabled
To: Guenter Roeck <linux@roeck-us.net>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Wed, Mar 18, 2026 at 1:27=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On Mon, Jan 12, 2026 at 12:32:14AM +0800, Tuo Li wrote:
> > In acpi_processor_errata_piix4(), the pointer dev is first assigned an =
IDE
> > device and then reassigned an ISA device:
> >
> >   dev =3D pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB, ...);
> >   dev =3D pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB_0, ...);
> >
> > If the first lookup succeeds but the second fails, dev becomes NULL. Th=
is
> > leads to a potential null-pointer dereference when dev_dbg() is called:
> >
> >   if (errata.piix4.bmisx)
> >     dev_dbg(&dev->dev, ...);
> >
> > To prevent this, use two temporary pointers and retrieve each device
> > independently, avoiding overwriting dev with a possible NULL value.
> >
> >
> > Signed-off-by: Tuo Li <islituo@gmail.com>
>
> AI review feedback inline below.
>
> I don't know if the device lifetime issue is real, but the now unconditio=
nal
> debug message is definitely a functional change and potentially misleadin=
g.
>
> Either case, why not just move the debug messages into the code setting
> errata.piix4.bmisx and errata.piix4.fdma ?
>
> Thanks,
> Guenter
>
> > ---
> > v3:
> > * Initialize the new variables to NULL and drop redundant checks.
> >   Thanks Rafael J. Wysocki for helpful advice.
> > v2:
> > * Add checks for ide_dev and isa_dev before dev_dbg()
> >   Thanks Rafael J. Wysocki for helpful advice.
> > ---
> >  drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 7ec1dc04fd11..de256e3adeed 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev=
 *dev)
> >  {
> >       u8 value1 =3D 0;
> >       u8 value2 =3D 0;
> > +     struct pci_dev *ide_dev =3D NULL, *isa_dev =3D NULL;
> >
> >
> >       if (!dev)
> > @@ -107,12 +108,12 @@ static int acpi_processor_errata_piix4(struct pci=
_dev *dev)
> >                * each IDE controller's DMA status to make sure we catch=
 all
> >                * DMA activity.
> >                */
> > -             dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> > +             ide_dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> >                                    PCI_DEVICE_ID_INTEL_82371AB,
> >                                    PCI_ANY_ID, PCI_ANY_ID, NULL);
> > -             if (dev) {
> > -                     errata.piix4.bmisx =3D pci_resource_start(dev, 4)=
;
> > -                     pci_dev_put(dev);
> > +             if (ide_dev) {
> > +                     errata.piix4.bmisx =3D pci_resource_start(ide_dev=
, 4);
> > +                     pci_dev_put(ide_dev);
> >               }
> >
> >               /*
> > @@ -124,24 +125,24 @@ static int acpi_processor_errata_piix4(struct pci=
_dev *dev)
> >                * disable C3 support if this is enabled, as some legacy
> >                * devices won't operate well if fast DMA is disabled.
> >                */
> > -             dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> > +             isa_dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> >                                    PCI_DEVICE_ID_INTEL_82371AB_0,
> >                                    PCI_ANY_ID, PCI_ANY_ID, NULL);
> > -             if (dev) {
> > -                     pci_read_config_byte(dev, 0x76, &value1);
> > -                     pci_read_config_byte(dev, 0x77, &value2);
> > +             if (isa_dev) {
> > +                     pci_read_config_byte(isa_dev, 0x76, &value1);
> > +                     pci_read_config_byte(isa_dev, 0x77, &value2);
> >                       if ((value1 & 0x80) || (value2 & 0x80))
> >                               errata.piix4.fdma =3D 1;
> > -                     pci_dev_put(dev);
> > +                     pci_dev_put(isa_dev);
> >               }
> >
> >               break;
> >       }
> >
> > -     if (errata.piix4.bmisx)
> > -             dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE=
) erratum enabled\n");
> > -     if (errata.piix4.fdma)
> > -             dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disab=
led)\n");
> > +     if (ide_dev)
> > +             dev_dbg(&ide_dev->dev, "Bus master activity detection (BM=
-IDE) erratum enabled\n");
>
> Is it safe to dereference ide_dev here? It looks like pci_dev_put(ide_dev=
)
> was already called above, which drops the reference and might lead to a
> use-after-free.
>
> Also, does this change the logging behavior? The original code checked
> errata.piix4.bmisx before logging, but now it logs as long as ide_dev
> was found, even if the erratum is not actually enabled.
>
> > +     if (isa_dev)
> > +             dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 d=
isabled)\n");
>
> Similarly, could this cause a use-after-free on isa_dev after
> pci_dev_put(isa_dev) was called?
>
> Additionally, does this unconditionally print the "Type-F DMA livelock"
> message if the ISA controller is present, skipping the original check
> for errata.piix4.fdma?
>
> Since the original `dev` parameter is no longer reassigned, would it be
> better to keep using `&dev->dev` and the original errata checks here to l=
og
> against the original PIIX4 ACPI controller?
>
> >
> >       return 0;
> >  }
> > --
> > 2.43.0
> >

Thanks for pointing this out, and I am sorry for the oversight.

I think these issues are being fixed in a follow-up patch:
https://lore.kernel.org/5975693.DvuYhMxLoT@rafael.j.wysocki/

Thanks,
Tuo
