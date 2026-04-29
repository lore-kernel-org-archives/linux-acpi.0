Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4C2EA498
	for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457462; cv=none; b=iwJ+3iK8QwVbkuSf6+EmttIXwwLdW97qhhIMN94hD7AorNBXXK7Q4RN9wL3zdfgyi3rZXE6PIZZ6ye6uRGWxTjzBch7JEt44WBiEumWnH7FzGajKEYtNeGI/aTlaq3yg6nhKO0LWBqJ53SlBxgsLepWhrRO33guMoW3yJODqMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457462; c=relaxed/simple;
	bh=3pC7niAFFvqgXTBmCRej2t0P6tbDDSy87RigrSH57Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qb2QuasIZf5DmpvpkbfLlSQmxd2V6cYymlNE9zg0ksc/TgeB382+ztz9ZTDFZPEJpC5cEWxHPsGk8haxudStMFXqUwokgDWGyghPEQGmP36scQbM9A9J970bRD6p2mZJkyM9LUic7UPMrw/8bOmyKc0F3fi4agRB7ANtloANyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEMKYp+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEMKYp+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2D2C19425
	for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 10:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777457462;
	bh=3pC7niAFFvqgXTBmCRej2t0P6tbDDSy87RigrSH57Bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VEMKYp+q4/n7Rs1ESJXIDaDe4B5em25B9cgIevSLzeRZ4g+qezQfgy6k6lpgHo0RM
	 qSIaLjtJeoRaxzi7KfwN02uUkkDhDXb04SQ8priM0YBd8aXSDuUskqj3vjxrq2h5SC
	 PTMcfRyV571cinsA/xEhYiUuSinYCyxx3H6UkP7oqPaEfEr/PagLitIdSteggPU+E4
	 Nv1txbf5KooZ8yBp42SDrKok4WMKFQAuC33P3ZEg9k/111aED99FjHb4fmPPDKuFCS
	 9O3kp27iBFlfyjPcz2BlqaVDi4pFDTKSHwFEMXcf3QpFXZ7dlFI53mQ4THvyYQSVRj
	 50VpL/t/HY4Yw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2b636b944so17295601e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 03:11:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQTrTV+hP0kEqXeFDIoIbUiNxQJ92mvMlqloo7Qrzl4cWKeHi9
	Oy8RkdeFgIQB6p+fPwC4zAhC0R4jioqxDbNZfu3abue9AvKQS6kcPtRzEKv49DW86XXDFhaaLXP
	ytmuU2k3xLXcDcSqHcD8kq8Eiv3tD5JQ=
X-Received: by 2002:a05:6512:33cc:b0:5a2:b43d:ac47 with SMTP id
 2adb3069b0e04-5a749cef71amr1134614e87.5.1777457460618; Wed, 29 Apr 2026
 03:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXn0zehxT90bNogCu44fRu4ANZmjjrcd8WzX_ms-Bb_JxA2Kw@mail.gmail.com>
 <4380e659-c807-43c4-9fe3-97e1403cc8a7@gmx.de> <CABXn0zdTmaR_pXR1Q73uHWFL=62V-VdGt3+M1Kig6LBpCnXZrA@mail.gmail.com>
 <673690f1-cdb3-400e-b11e-8490e80a23ef@gmx.de> <CABXn0zeBHt7CkJOBpyE5=nhj3AOxiAELZLk7PzjSUmwi4BoU3Q@mail.gmail.com>
 <CABXn0zeKbNvWHRrV-VAnffAi4a16i8T0r13sEJDmvcQe0E56UQ@mail.gmail.com> <cdc2b171-0b13-4795-a615-6f953dc4005c@gmx.de>
In-Reply-To: <cdc2b171-0b13-4795-a615-6f953dc4005c@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Apr 2026 12:10:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFXHYjpvJu++0bnAZFPzt-Nc7U7NQiS0M9_xRH2OB3Qg@mail.gmail.com>
X-Gm-Features: AVHnY4KrBt2mW8gUzMwB0oniPlynxzqu-DH-MhfcqdwYHi9XcwNwG-t8qThhgME
Message-ID: <CAJZ5v0gFXHYjpvJu++0bnAZFPzt-Nc7U7NQiS0M9_xRH2OB3Qg@mail.gmail.com>
Subject: Re: [BUG] ASUS Vivobook M1502NAQ: ACPI DSDT namespace collision
 (ASMI) causes early boot hang
To: Armin Wolf <W_Armin@gmx.de>, Alexander Zubkov <zubkov318@gmail.com>
Cc: linux-acpi@vger.kernel.org, Saket Dumbre <saket.dumbre@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 11:28=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 28.04.26 um 09:03 schrieb Alexander Zubkov:
>
> > On Fri, Apr 10, 2026 at 10:11=E2=80=AFAM Alexander Zubkov <zubkov318@gm=
ail.com> wrote:
> >> On Thu, Apr 9, 2026 at 11:00=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
> >>> Am 09.04.26 um 21:19 schrieb Alexander Zubkov:
> >>>
> >>>> On Thu, Apr 9, 2026 at 4:58=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
> >>>>> Am 07.04.26 um 22:53 schrieb Alexander Zubkov:
> >>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> I'd like to report an ACPI issue on an ASUS Vivobook 15 M1502NAQ-B=
Q067
> >>>>>> (AMD Ryzen 5 150 - Zen3+ / Rembrandt platform). UEFI version:
> >>>>>> M1502NAQ.302.
> >>>>>>
> >>>>>> Linux kernels (tested with recent mainline live images of Alpine,
> >>>>>> Void, NixOS and Fedora) hang immediately after bootloader when ACP=
I is
> >>>>>> enabled. No output is produced, even with earlycon/earlyprintk:
> >>>>>> earlycon=3Defi,keep earlyprintk=3Defi,keep loglevel=3D8 ignore_log=
level
> >>>>>> initcall_debug acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFF=
F
> >>>>>>
> >>>>>> I've tried various ACPI-related options, boot works only with:
> >>>>>> * acpi=3Doff (but system resets with no error several seconds afte=
r the
> >>>>>> boot, keyboard does not work)
> >>>>>> * acpi_no_static_ssdt (system boots, keyboard does not work)
> >>>>>>
> >>>>>> Notebook's firmare was upgraded to the latest available version. I=
've
> >>>>>> also tried to boot a windows installer, just to check it is not a
> >>>>>> hardware issue. It boots normally.
> >>>>>>
> >>>>>> I'm not an expert in ACPI, so I used ChatGPT to lead the debug.
> >>>>>> Although I suppose it misleaded me sometimes, it turned out to be
> >>>>>> useful, because I found a DSDT patch that fixed the issue. Most of
> >>>>>> debugging was done using Alpine's kernel 6.18.21-0-lts.
> >>>>>>
> >>>>>> The issue was traced to a namespace collision in DSDT:
> >>>>>> * Method \ASMI defined in global scope
> >>>>>> * Method _SB.ASMI also defined
> >>>>>>
> >>>>>> ChatGPT presumes that unqualified calls to ASMI appear to resolve
> >>>>>> incorrectly under Linux (ACPICA), leading to a firmware-level fail=
ure
> >>>>>> during early ACPI initialization. I dumped ACPI tables from UEFI s=
hell
> >>>>>> and tried different overrides.
> >>>>>>
> >>>>>> The minimal fix I found is renaming the global method in DSDT and =
its
> >>>>>> single call. After applying this dsdt.aml override, the kernel boo=
ts
> >>>>>> well without additional acpi options, does not reset after boot, a=
nd
> >>>>>> the keybord initializes and works well. The patch looks like this =
(and
> >>>>>> I also increased the revision number):
> >>>>>>
> >>>>>> --- a/dsdt.dsl    2026-04-07 18:31:52.727022684 +0200
> >>>>>> +++ b/dsdt.dsl    2026-04-07 21:30:04.393990891 +0200
> >>>>>> @@ -10138,7 +10138,7 @@
> >>>>>>                 SMCM =3D Arg0
> >>>>>>             }
> >>>>>>
> >>>>>> -        Method (ASMI, 1, Serialized)
> >>>>>> +        Method (ASMX, 1, Serialized)
> >>>>>>             {
> >>>>>>                 AL_D =3D Arg0
> >>>>>>                 SMCM =3D 0xD6
> >>>>>> @@ -10151,7 +10151,7 @@
> >>>>>>                 DB_2 =3D Arg1
> >>>>>>                 DB_3 =3D Arg2
> >>>>>>                 DB_4 =3D Arg3
> >>>>>> -            ASMI (0x80)
> >>>>>> +            ASMX (0x80)
> >>>>>>             }
> >>>>>>         }
> >>>>>>
> >>>>>> Is this a known ACPICA behavior difference vs Windows, or should t=
his
> >>>>>> be considered a firmware bug only? I can provide full acpidump / D=
SDT
> >>>>>> if needed.
> >>>>> This might indeed be a Bug inside ACPICA, please provide the acpidu=
mp
> >>>>> so we can inspect the caller of ASMI ().
> >>>> Please see the acpi dumps and override attached. I noticed that dump
> >>>> from Linux slightly differs from the one I made from shell.
> >>>>
> >>>> acpi-shell.tar.xz - dump from UEFI shell
> >>>> acpi-linux.tar.xz - dump from Linux with override applied
> >>>> asus-fix.cpio.xz - early initrd with DSDT override
> >>> Thanks, please use reply-all next time so other people can access the=
 ACPI tables too.
> > Sorry to bother. Is my debug helpful somehow? Could it be something in
> > ACPICA, or I'd better try reporting it to Asus?
>
> I hoped other people on this mailing list did spot something, but it seem=
s that no one
> (including myself) has an idea why this happens.
>
> I suggest that you create an issue with ACPICA directly: https://github.c=
om/acpica/acpica

Yes, that's the way to go.

It really looks like a difference in behavior between ACPICA and
Windows causes this problem to appear (I've added upstream ACPICA
developers to the CC list).
