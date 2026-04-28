Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879137B023
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359840; cv=pass; b=nopWqjd3vWBsExWCYTPYgKRgfdLE562NRIFMIg/6Jiq2+m3PFHuD8p5x5LJ9MVJGSnrrbPvxWYs8+y845KZOpplnikGnbVVUwRauQTnyJx62o1oYpWaiXwqDBv8amBoEv5MZpEE6AOP0+tFDZ1EuMlYs4YhPsDfJzXlivI5fkCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359840; c=relaxed/simple;
	bh=mXkhPMPMW40LfV3jLvR+AlhGlLzRS7y0s16BJ+z4z7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y10vD4NAaBII0vFLUT8Y6epi4xVJc+PTnjJwtepGZT+5eAXAELEcm+AVlAAcBYpmeD3aAs+EMeuKwTupFeyjc+FDxU2fFQNIWj8vM6W+JU04XP2JBqQsJN0a5qZi+IVkkMd3phV/G9kdm/jC6ASjwSnDUmUj+r4NQzcSKHDpjx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2WE72/B; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2WE72/B"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6530287803cso10700018d50.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 00:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777359836; cv=none;
        d=google.com; s=arc-20240605;
        b=BRsBbSvw+nPLSdrWEZM/WWOZkHeyM+eCNiQO8yck3iIKm0r1jb/A46hyRV44okB5ei
         zMSbYFEzoZDZW5BydMpdBmsEruXz1Lh6yOmT+sQB9dq1bPD6hCFxRsSxqnYMvANu9cjz
         HnrrZ0tkYA1Cf+xgNFvstRmHMtgNO2aB6shDN7zx3DFtf/kKZXm4dzpkpMl8d00Mbnj0
         rX2EnhTj1t505eWbheHUwlfGR3EXj5kVBz+YMLiDyUZxhg/sBSdNpGQcxOb6NySt94Hh
         b3Y0JYd7za/xUbDrPA0q//bSivjE3d0nLm8WjhOlUQ13yIsew4ccZQ97Oyma/Bmnrg2d
         zZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4M6OujuI8q7rgwRkaYYjLztp42BViLFaAVH/wz/ntoY=;
        fh=jIsR+NnwZHl5y8Xyw/xUHj7zCZoR24brmS+ziluhd94=;
        b=gjyMeGSNYdQoqqPOTAsNKmWysY0WmJF+64LMJGRdFS/UzhJUgXMlEdVUIdWnLSmAdq
         fTAiqJ0y4fStaDqOQ4JdUhGBARsbcwiyR6Xp99R4y6iuYq+5A/1GKRYgxRFc1wcgO+dV
         BMlVsPr9IlzLFPZeVtsZbV9s7RENkZ/3/vvX/5E6fbu81OCSoz4yiZaUO48l6uU5G0di
         FqXMG6r3+0yep8oxVGeWMxbqar7TQ9gm6kIGnRMmTiE8S4nfIghoItUgKbE/+gSXFOtH
         Kr2OvNCk092c8adh2AuJCe7cjtBMOcE4TRUbWpDvvsUKlIGQ4XDhKGo5n00EtJ0TihfV
         Ap7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777359836; x=1777964636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4M6OujuI8q7rgwRkaYYjLztp42BViLFaAVH/wz/ntoY=;
        b=N2WE72/BBAA8LvcIMlLkcIUKU6IOQDPtjHrVAQym8ZxAQ/6cBLywikkyiKpNKwm0Y2
         9GzZ8KmsT/aWY7Tz+eymP37zaa+2yNy26mj+t/VklwdNhIFthI+agY99A3vCiTKXu/Yy
         eI19qMttayMNIfXRGwMpYqgMWXb2+i2Q8juWF/q2IroDIclnLH3PptLaAp6vnvgG4mFj
         jDybzgihV6Y5/iPhYhvcGSEPuncaSggM7tQkAjSQiZC6Y+K0hmiaf0x0yGhGjfHUMrkm
         +iP5odf2Ed9lvY1ll8HZlsZMa3rFKWTDiZSXUFw6l1cUOfb9l+V7F0Rin1AM2U33aEWR
         HT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359836; x=1777964636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4M6OujuI8q7rgwRkaYYjLztp42BViLFaAVH/wz/ntoY=;
        b=kqL+6uV8hs3hbBLuY+Qvl2yJNoF4tZq9QXh8HNdWBQiSJZbmbm+7tounR+fRq0sGrK
         3fmD/ofwBFlTiVxu2kQZUTdokBGVOKbz/20wtwsBx9wEi4x8BWLytvEjE/DyhIpEGpak
         cmV8prph3Y/UiSRKzrVEAlFxnsmtGTXzllkMG2cSQwC5sxl3t3KcicGdGdKl4We+GDW/
         bPrhb5kDai9bLrNH704ZeXryurry9F14/NpP6EzaEadtdPz/Tfm2Rj1mtuPA6fEsaZMY
         TPYuzlIWzFcyVOPpa/9eDDD48f/MjR6Ko3lRLRHoI9IR3XMdMfEdjtiUQ718+bYBWf8+
         CYTA==
X-Gm-Message-State: AOJu0YzYYCOEgXkQ+Y88l3bt2CJrLmVOTJZus4Y8B8Ejb69L67hKfqe1
	P+Bgi+BpOUvuHJjGwO8Ozq7m3sJJS4zxn77tGG00T+dJJPNL9kEwYCUIHkcC0fm4v4jdos2Yaha
	EItENxciAtjYXom/LINAWpwCecCGMOxH5dA==
X-Gm-Gg: AeBDietGqkvJtQvScYap1tdFVT9jmhzyXTcKRasIFbhYCyPiSnSI3poiB6A69N+09XB
	c4Oxv92Nc5pvJj/v317wrExBMVdwvbRxyaoagz40TjmzvKBkn9XiwAYgXvealEuTPx+O5Lr2Nb7
	EN3j9yoMMmzxf760a20/NeuJniv81bdtkPALe6lPDBJI2DVL1qBfdbj7crfmxEXT7AhdehFoY5l
	daVFKcgKvvCTVr0ljiv03p6b9jUKlD+LCfOWDHRcUGvquufNTqPgofx5/7hAtYcL9vZR8kl+LCy
	1D/Ggf5IXEPb13pR1rW4xcYbItqjZOQieV6NmmKPZFtVT+UnW6glgKDLzbFK3tpy9aOHFb34wsm
	Ed5/8mdtkxkFQzBBsSswWtt7UJEJCEX9Fo2Yj
X-Received: by 2002:a53:b4d1:0:b0:654:1dfe:ca8e with SMTP id
 956f58d0204a3-65beef02645mr1034137d50.65.1777359835905; Tue, 28 Apr 2026
 00:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXn0zehxT90bNogCu44fRu4ANZmjjrcd8WzX_ms-Bb_JxA2Kw@mail.gmail.com>
 <4380e659-c807-43c4-9fe3-97e1403cc8a7@gmx.de> <CABXn0zdTmaR_pXR1Q73uHWFL=62V-VdGt3+M1Kig6LBpCnXZrA@mail.gmail.com>
 <673690f1-cdb3-400e-b11e-8490e80a23ef@gmx.de> <CABXn0zeBHt7CkJOBpyE5=nhj3AOxiAELZLk7PzjSUmwi4BoU3Q@mail.gmail.com>
In-Reply-To: <CABXn0zeBHt7CkJOBpyE5=nhj3AOxiAELZLk7PzjSUmwi4BoU3Q@mail.gmail.com>
From: Alexander Zubkov <zubkov318@gmail.com>
Date: Tue, 28 Apr 2026 09:03:19 +0200
X-Gm-Features: AVHnY4If2ddzJZMxXcTFvn8XUqAAVAKnXSK2eILQoMYYzldoQxg2KcrTGgnagQg
Message-ID: <CABXn0zeKbNvWHRrV-VAnffAi4a16i8T0r13sEJDmvcQe0E56UQ@mail.gmail.com>
Subject: Re: [BUG] ASUS Vivobook M1502NAQ: ACPI DSDT namespace collision
 (ASMI) causes early boot hang
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 10:11=E2=80=AFAM Alexander Zubkov <zubkov318@gmail.=
com> wrote:
>
> On Thu, Apr 9, 2026 at 11:00=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote=
:
> >
> > Am 09.04.26 um 21:19 schrieb Alexander Zubkov:
> >
> > > On Thu, Apr 9, 2026 at 4:58=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
> > >> Am 07.04.26 um 22:53 schrieb Alexander Zubkov:
> > >>
> > >>> Hello,
> > >>>
> > >>> I'd like to report an ACPI issue on an ASUS Vivobook 15 M1502NAQ-BQ=
067
> > >>> (AMD Ryzen 5 150 - Zen3+ / Rembrandt platform). UEFI version:
> > >>> M1502NAQ.302.
> > >>>
> > >>> Linux kernels (tested with recent mainline live images of Alpine,
> > >>> Void, NixOS and Fedora) hang immediately after bootloader when ACPI=
 is
> > >>> enabled. No output is produced, even with earlycon/earlyprintk:
> > >>> earlycon=3Defi,keep earlyprintk=3Defi,keep loglevel=3D8 ignore_logl=
evel
> > >>> initcall_debug acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF
> > >>>
> > >>> I've tried various ACPI-related options, boot works only with:
> > >>> * acpi=3Doff (but system resets with no error several seconds after=
 the
> > >>> boot, keyboard does not work)
> > >>> * acpi_no_static_ssdt (system boots, keyboard does not work)
> > >>>
> > >>> Notebook's firmare was upgraded to the latest available version. I'=
ve
> > >>> also tried to boot a windows installer, just to check it is not a
> > >>> hardware issue. It boots normally.
> > >>>
> > >>> I'm not an expert in ACPI, so I used ChatGPT to lead the debug.
> > >>> Although I suppose it misleaded me sometimes, it turned out to be
> > >>> useful, because I found a DSDT patch that fixed the issue. Most of
> > >>> debugging was done using Alpine's kernel 6.18.21-0-lts.
> > >>>
> > >>> The issue was traced to a namespace collision in DSDT:
> > >>> * Method \ASMI defined in global scope
> > >>> * Method _SB.ASMI also defined
> > >>>
> > >>> ChatGPT presumes that unqualified calls to ASMI appear to resolve
> > >>> incorrectly under Linux (ACPICA), leading to a firmware-level failu=
re
> > >>> during early ACPI initialization. I dumped ACPI tables from UEFI sh=
ell
> > >>> and tried different overrides.
> > >>>
> > >>> The minimal fix I found is renaming the global method in DSDT and i=
ts
> > >>> single call. After applying this dsdt.aml override, the kernel boot=
s
> > >>> well without additional acpi options, does not reset after boot, an=
d
> > >>> the keybord initializes and works well. The patch looks like this (=
and
> > >>> I also increased the revision number):
> > >>>
> > >>> --- a/dsdt.dsl    2026-04-07 18:31:52.727022684 +0200
> > >>> +++ b/dsdt.dsl    2026-04-07 21:30:04.393990891 +0200
> > >>> @@ -10138,7 +10138,7 @@
> > >>>                SMCM =3D Arg0
> > >>>            }
> > >>>
> > >>> -        Method (ASMI, 1, Serialized)
> > >>> +        Method (ASMX, 1, Serialized)
> > >>>            {
> > >>>                AL_D =3D Arg0
> > >>>                SMCM =3D 0xD6
> > >>> @@ -10151,7 +10151,7 @@
> > >>>                DB_2 =3D Arg1
> > >>>                DB_3 =3D Arg2
> > >>>                DB_4 =3D Arg3
> > >>> -            ASMI (0x80)
> > >>> +            ASMX (0x80)
> > >>>            }
> > >>>        }
> > >>>
> > >>> Is this a known ACPICA behavior difference vs Windows, or should th=
is
> > >>> be considered a firmware bug only? I can provide full acpidump / DS=
DT
> > >>> if needed.
> > >> This might indeed be a Bug inside ACPICA, please provide the acpidum=
p
> > >> so we can inspect the caller of ASMI ().
> > > Please see the acpi dumps and override attached. I noticed that dump
> > > from Linux slightly differs from the one I made from shell.
> > >
> > > acpi-shell.tar.xz - dump from UEFI shell
> > > acpi-linux.tar.xz - dump from Linux with override applied
> > > asus-fix.cpio.xz - early initrd with DSDT override
> >
> > Thanks, please use reply-all next time so other people can access the A=
CPI tables too.
>

Sorry to bother. Is my debug helpful somehow? Could it be something in
ACPICA, or I'd better try reporting it to Asus?

> Sure, I have this by default. And I see I replied to all, my message
> is visible in the mailing list archive.
>
> > I wrote a simple ACPI table to simulate your problem (two ASMI methods,=
 on at \ and one at \_SB),
> > and it seems that ACPICA correctly uses the ASMI method inside the _SB =
scope.
> >
> > Does the problem still occur when you blacklist the asus-wmi driver? AF=
AIK all the calls to ASMI()
> > are triggered by said driver.
>
> I don't think it is related to the driver, because the boot process
> hangs with absolutely no output from the kernel, even with the
> mentioned debugging options. And as I see, asus-wmi is built as a
> module at least in Void and Alpine, so the kernel hangs way before it
> starts loading any modules. I also tried to make some initramfs with a
> reduced modules set, and it did not include asus-wmi there. And even
> booting just a single kernel, or a kernel + acpi tables overrides also
> hang right at the beginning with no output.
>
> I think the following details of my investigation might be helpful at
> this point:
>
> After the success with "acpi_no_static_ssdt" option, ChatGTP suggested
> that one of `ssdt*.dsl` might be faulty. I tried to mask them all
> replacing them with empty bodies, it did not help.
>
> Then it said "acpi_no_static_ssdt" besides ignoring `ssdt*.dsl` also
> might change something in early boot. As the boot hang very early,
> ChatGPT suggested that something might be happening in _INI or _REG
> methods, but that was also a dead end. Then it said that global
> namespace (\) is used early too.
>
> First I tried to remove all `Scope (\)`, but there was scopes and
> devices WMI0 and UAT2, that refered something from those global scopes
> and the table did not compile. So I removed those sections too, and it
> was also successful, the kernel did not hang early (dstd.dsl.2).
>
> Then I tried various combinations of removing WMI0 and UAT2, but I
> kept the section with ASMI method. Once I had WMI0 and UAT2 deleted,
> and only difference with `dstd.dsl.2` was a couple of global scopes -
> one with ISMI and ASMI methods, and I made their bodies empty, and
> other with H0_?, OE_? methods, also with empty bodies (dstd.dsl.12).
> That variant also hangs. But starts booting when I remove those ISMI
> and ASMI methods (dstd.dsl.13). At this point ChatGPT said that ASML
> and ISML names could have some special meaning and break something and
> suggested renaming them.
>
> Renaming helped, but when I was renaming ASMI, I noticed that the same
> name is also defined in _SB. I tried renaming only this method, it was
> also successful (dsdt.dsl.20). ChatGPT said something about that it
> could cause the name collision, that spec forbids such ambiguous
> naming, and Windows interpreter could have different behaviour here.
>
> By the way, I accidentally used the wrong fix as a final version on
> the notebook, the one that renamed both methods. It also works, but
> not minimal. So I'm attaching again a cpio with a better fix and a new
> dump of acpi tables from Linux.
>
> >
> > Can you also check if loading asus-wmi later in the boot process (for e=
xample after the users has
> > logged in) fixes this issue?
> >
> > Thanks,
> > Armin Wolf
> >
> > >> Thanks,
> > >> Armin Wolf
> > >>
> > >>> Thanks,
> > >>> Alexander Zubkov
> > >>>
