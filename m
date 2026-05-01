Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5C3EFD15
	for <linux-acpi@vger.kernel.org>; Fri,  1 May 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654869; cv=pass; b=edRTS3qU4wzji9ICVLhhW7EH1SIh6VZY0jJGtCLtHizF5FD4lDNdWwUbYwxWciYbK+7rUN7o6JxqQ/tChla5mB1X6Dd4mcVIQZXKIJGoUstKNg+GmoED+Pwpu2UOFp9zbAepeMCraNl50P6ihZ/qnWWPrlNQbMmjSUr9I6HpnJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654869; c=relaxed/simple;
	bh=xHFOReJJ3GwWdevOrpiEBp6Ziym4Il+TM/4Yk1XBJY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ9fFx8zFgIlZlOTTIpGlxlQB+2tk547nXcTvDvpWRIKl4chllQdwSZRspJmkkikjlA3UGBdaVBsM99f8KqPY+WEQttOMRd8ArjaEdY6hJUg0/62UGfOl/RDwxNwCFs1ie8uZKUUAM2DWvE461d9kJPuy4igJajk2mWiMoik4/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbRrs+bc; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbRrs+bc"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6587cee8b57so2338816d50.2
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2026 10:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777654865; cv=none;
        d=google.com; s=arc-20240605;
        b=OjOeBcBB+eqczLl7qMYxs85S/7v0TQOTRRV7NagPxpMNtO666PRzf8mlmvp09ULMLM
         d6OtNyu0mtH6PylZZocZ+jwuFKWxwGtIJLL4rpaNLr199HBLgYSpDpLQPDL56HzJQNow
         MXPiEEa3Xrpb409T0MI0tktrME1qW8RjIww612Ki+4fZUqQt7vGgrdezgKma/R4zJvLT
         MJTIbxpf+Ffvx7H8vrYRgTxg9hWYKCvPYWGhbZ2PvN1z3dG9I3/Zdr4lgyS3Ojzw+RmE
         n8z/RyHusDpeMLSsPSlhvZhFS3sxdq6zjU/IxglX6AcMCyt+pfqCH9XmBSKIGrFgIuks
         FADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dj75v+m4Zg12y/Tib1fph4yY1U1gWCjn9O9q4z2P2g4=;
        fh=MGa4izzn7fzDAzMkPUlHXrrDtUWbHmSyVOcB2lDxny8=;
        b=Ug9twLmdlRBRW1FvEej4A7mGxqjunO599F2b3BaEfS1f5LMD9mDCZNvHTMuIeeq4dW
         uCdhy69g06EPMtw06WLtCOh6YGgGRo38H+dwAA459yvYE5z/v+dDvJw4ijRBa7+tuekI
         W9mr6nHgyFoifjnprw7shdJHChBgihMm4CMgPzh220UOSs+CK4VfqkNJMbZn7zNPAfUj
         7LrDyu4+A7CDhtP5ccOv7D1dQagKIS8Uxt489+DOU761lu1VB9KjtUBKRx8iQYBK2HWV
         kUxhruCEPdVRhd6kHn32egsTb6hRYjnzQLhBwMhZJUCh4PNunkGnvw+1rncW7JamzpNd
         NpfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777654865; x=1778259665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj75v+m4Zg12y/Tib1fph4yY1U1gWCjn9O9q4z2P2g4=;
        b=EbRrs+bcBS08J0saQEQ3hKj/t7poG93SLV0QpZExWEk9LX0eALCUrmBVWAEonaCog9
         GR9p42onvOuUHlAY0X3s8qgJ3hKoGLJKCb3JA618vFONb+kChAiSNYrn+5BVFuGix6RP
         DDN9EWCGpYy3yyMBSmIBwFaDvexQJ9vnQUulUNvrm++2w2WOleb6RlrrJ2WwJHP8m2Lh
         qeHUWINRFAyWSEJopRQNumFiEz3CjK3/OSpyzBFuht0Q+KpGBMuIHXFynMGxqNv+RrVU
         D81+jIenM0NKlMZ0Tmb143fZE2fI1a6/PyVN2XrUQvMwaE9p0M9jqQ+bhPTvpq9EyjQX
         uvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654865; x=1778259665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dj75v+m4Zg12y/Tib1fph4yY1U1gWCjn9O9q4z2P2g4=;
        b=M7m4pttrAthYCGQzr/QI3PPVX+QEZaUeZ5Ki9GTgq95pCx79i8xbSbbFiuJRPxfh75
         YIGhildvid68IZrS7YXMjME8WYRCAXZg8VDAxYtn1JBxa+c0Jnuc7N5ZL9opGDu+JnYC
         XJvmrLM39k4b6dA7se66/aoFD/cdDUodxbHy885B6BAqokpbRrpliYeNIAsriRJC2ID9
         DNWo4lGv+7I2hJTt/P4/Wpfb6P83m+DpbvckhPdsgqUTrVWGOHaAj0UqnISOzXzhTRcf
         bhscKXsSPY5zlWviV3f8SdBMyMrrUtXNvL3QIqG7+9Vj1ly6Rhgw6P/odseoRlVjGUuV
         ycbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EMt/eH/IhTJ9eApFVRH1A6yEFKt2qtiqB+H3fTWhFJdIP9ogl24INhbFH4u545LHAdlUxs1wQ897X@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJhnfj3rBa67xr8OA4SrkNOWHt9Y57qPaqO7EnrgAaCkMkoQi
	vPeqIIcdQhYjhgR0I6D0D8GzSeqNXlE0wqFAqsJ8uM+V618V0aZCGpM61dhou/exL1DZS7nFEP0
	aXcPDPwyEbzW9n2srOSOpHj+/c4FDQRg=
X-Gm-Gg: AeBDieu2oSdGydI6HJRQUhlZdVymcPKf6Xr9pCxfmCWbE7Ew8AGmq6+PzTGjF4PGDrt
	2pCtYdEQaGk4eUl1DFUIsNhmPgE7T2UIr/YzwYne6hZu13vR7pAdlzxT/fF4Zn5dKllR3MkGQua
	MMU6zIKjTg+3cOsuuuYqd21ws8K7amuBNvOBEmHSUQn3xmC6RlaPZ8ucNHea5i2l9ucz7hOSokM
	3amhpwBROWVczCmtybOPdSsfCfSMo9Q5tELqYDIbarxgS5xqWrSpBzKM5s6QnjPsoapUnQjB79S
	R3Svt137hIDsWVQpZYcnN753BziFe2VPlPo3q2ii8wMw4gcHEemopJfA7SJFBGt7L3dgqUAUni+
	6Au3him+tm+Cl+qj2P4YoxdtAO8lXMRiHmSmy9304dxLrTdM=
X-Received: by 2002:a05:690e:14cd:b0:658:a18:cdf3 with SMTP id
 956f58d0204a3-65c18ca0d0bmr6926526d50.27.1777654864488; Fri, 01 May 2026
 10:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXn0zehxT90bNogCu44fRu4ANZmjjrcd8WzX_ms-Bb_JxA2Kw@mail.gmail.com>
 <4380e659-c807-43c4-9fe3-97e1403cc8a7@gmx.de> <CABXn0zdTmaR_pXR1Q73uHWFL=62V-VdGt3+M1Kig6LBpCnXZrA@mail.gmail.com>
 <673690f1-cdb3-400e-b11e-8490e80a23ef@gmx.de> <CABXn0zeBHt7CkJOBpyE5=nhj3AOxiAELZLk7PzjSUmwi4BoU3Q@mail.gmail.com>
 <CABXn0zeKbNvWHRrV-VAnffAi4a16i8T0r13sEJDmvcQe0E56UQ@mail.gmail.com>
 <cdc2b171-0b13-4795-a615-6f953dc4005c@gmx.de> <CAJZ5v0gFXHYjpvJu++0bnAZFPzt-Nc7U7NQiS0M9_xRH2OB3Qg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gFXHYjpvJu++0bnAZFPzt-Nc7U7NQiS0M9_xRH2OB3Qg@mail.gmail.com>
From: Alexander Zubkov <zubkov318@gmail.com>
Date: Fri, 1 May 2026 19:00:28 +0200
X-Gm-Features: AVHnY4Iz2A7TWxOJsgVhj-tO-yRL4A92pyCAz929swggetZCM8FlTmFwEoZ57Lw
Message-ID: <CABXn0zf9b_B1uE+-bQjX78uj=+qpzHje6E5TWsiKxmpTV-z4og@mail.gmail.com>
Subject: Re: [BUG] ASUS Vivobook M1502NAQ: ACPI DSDT namespace collision
 (ASMI) causes early boot hang
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, linux-acpi@vger.kernel.org, 
	Saket Dumbre <saket.dumbre@intel.com>, Pawel Chmielewski <pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 12:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Tue, Apr 28, 2026 at 11:28=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
> >
> > Am 28.04.26 um 09:03 schrieb Alexander Zubkov:
> >
> > > On Fri, Apr 10, 2026 at 10:11=E2=80=AFAM Alexander Zubkov <zubkov318@=
gmail.com> wrote:
> > >> On Thu, Apr 9, 2026 at 11:00=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> =
wrote:
> > >>> Am 09.04.26 um 21:19 schrieb Alexander Zubkov:
> > >>>
> > >>>> On Thu, Apr 9, 2026 at 4:58=E2=80=AFPM Armin Wolf <W_Armin@gmx.de>=
 wrote:
> > >>>>> Am 07.04.26 um 22:53 schrieb Alexander Zubkov:
> > >>>>>
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>> I'd like to report an ACPI issue on an ASUS Vivobook 15 M1502NAQ=
-BQ067
> > >>>>>> (AMD Ryzen 5 150 - Zen3+ / Rembrandt platform). UEFI version:
> > >>>>>> M1502NAQ.302.
> > >>>>>>
> > >>>>>> Linux kernels (tested with recent mainline live images of Alpine=
,
> > >>>>>> Void, NixOS and Fedora) hang immediately after bootloader when A=
CPI is
> > >>>>>> enabled. No output is produced, even with earlycon/earlyprintk:
> > >>>>>> earlycon=3Defi,keep earlyprintk=3Defi,keep loglevel=3D8 ignore_l=
oglevel
> > >>>>>> initcall_debug acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFF=
FFF
> > >>>>>>
> > >>>>>> I've tried various ACPI-related options, boot works only with:
> > >>>>>> * acpi=3Doff (but system resets with no error several seconds af=
ter the
> > >>>>>> boot, keyboard does not work)
> > >>>>>> * acpi_no_static_ssdt (system boots, keyboard does not work)
> > >>>>>>
> > >>>>>> Notebook's firmare was upgraded to the latest available version.=
 I've
> > >>>>>> also tried to boot a windows installer, just to check it is not =
a
> > >>>>>> hardware issue. It boots normally.
> > >>>>>>
> > >>>>>> I'm not an expert in ACPI, so I used ChatGPT to lead the debug.
> > >>>>>> Although I suppose it misleaded me sometimes, it turned out to b=
e
> > >>>>>> useful, because I found a DSDT patch that fixed the issue. Most =
of
> > >>>>>> debugging was done using Alpine's kernel 6.18.21-0-lts.
> > >>>>>>
> > >>>>>> The issue was traced to a namespace collision in DSDT:
> > >>>>>> * Method \ASMI defined in global scope
> > >>>>>> * Method _SB.ASMI also defined
> > >>>>>>
> > >>>>>> ChatGPT presumes that unqualified calls to ASMI appear to resolv=
e
> > >>>>>> incorrectly under Linux (ACPICA), leading to a firmware-level fa=
ilure
> > >>>>>> during early ACPI initialization. I dumped ACPI tables from UEFI=
 shell
> > >>>>>> and tried different overrides.
> > >>>>>>
> > >>>>>> The minimal fix I found is renaming the global method in DSDT an=
d its
> > >>>>>> single call. After applying this dsdt.aml override, the kernel b=
oots
> > >>>>>> well without additional acpi options, does not reset after boot,=
 and
> > >>>>>> the keybord initializes and works well. The patch looks like thi=
s (and
> > >>>>>> I also increased the revision number):
> > >>>>>>
> > >>>>>> --- a/dsdt.dsl    2026-04-07 18:31:52.727022684 +0200
> > >>>>>> +++ b/dsdt.dsl    2026-04-07 21:30:04.393990891 +0200
> > >>>>>> @@ -10138,7 +10138,7 @@
> > >>>>>>                 SMCM =3D Arg0
> > >>>>>>             }
> > >>>>>>
> > >>>>>> -        Method (ASMI, 1, Serialized)
> > >>>>>> +        Method (ASMX, 1, Serialized)
> > >>>>>>             {
> > >>>>>>                 AL_D =3D Arg0
> > >>>>>>                 SMCM =3D 0xD6
> > >>>>>> @@ -10151,7 +10151,7 @@
> > >>>>>>                 DB_2 =3D Arg1
> > >>>>>>                 DB_3 =3D Arg2
> > >>>>>>                 DB_4 =3D Arg3
> > >>>>>> -            ASMI (0x80)
> > >>>>>> +            ASMX (0x80)
> > >>>>>>             }
> > >>>>>>         }
> > >>>>>>
> > >>>>>> Is this a known ACPICA behavior difference vs Windows, or should=
 this
> > >>>>>> be considered a firmware bug only? I can provide full acpidump /=
 DSDT
> > >>>>>> if needed.
> > >>>>> This might indeed be a Bug inside ACPICA, please provide the acpi=
dump
> > >>>>> so we can inspect the caller of ASMI ().
> > >>>> Please see the acpi dumps and override attached. I noticed that du=
mp
> > >>>> from Linux slightly differs from the one I made from shell.
> > >>>>
> > >>>> acpi-shell.tar.xz - dump from UEFI shell
> > >>>> acpi-linux.tar.xz - dump from Linux with override applied
> > >>>> asus-fix.cpio.xz - early initrd with DSDT override
> > >>> Thanks, please use reply-all next time so other people can access t=
he ACPI tables too.
> > > Sorry to bother. Is my debug helpful somehow? Could it be something i=
n
> > > ACPICA, or I'd better try reporting it to Asus?
> >
> > I hoped other people on this mailing list did spot something, but it se=
ems that no one
> > (including myself) has an idea why this happens.
> >
> > I suggest that you create an issue with ACPICA directly: https://github=
.com/acpica/acpica
>
> Yes, that's the way to go.
>
> It really looks like a difference in behavior between ACPICA and
> Windows causes this problem to appear (I've added upstream ACPICA
> developers to the CC list).

Thank you guys, I've created the issue there:
https://github.com/acpica/acpica/issues/1157
