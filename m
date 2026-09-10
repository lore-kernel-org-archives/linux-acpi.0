Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69784419318
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037877; cv=none; b=UgY8CQYylzwLUP3lry1CEH4y21UCePB5h8X2zdoeS38COG8eVmTBaL6OT9wR7OyjhmCzs6wIMvHCR6D9+B4SA8yfSf3U9v7Isj5xFXikyJEyhj4ZtYpVru/uIOKA7RtQsMaCFEQuWM9Wk/TVMwWhbIUIdz14mA40YNvkyoU6O/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037877; c=relaxed/simple;
	bh=UVr15BsXAEj6heXVyr+gv3vp9cLU9vPBS+f7O60WSds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ks827KrlGEKfG3XF4n49jHc7+8M2/CB3Yw1V89wUQOPYNmoZ30bsRvqujVES6L1yPVW2t8k+Yiutn4aCL31tCBO3jCqK/tnEXD1oeBmqpetD8sII1R6Vpgphu63uYphwXAF7btLy84BG8niEQiRdZWE/jzH6L4v9i6HrsmG2r7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq2+Dd8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq2+Dd8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E161F00898
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037876;
	bh=fq3Bb2asEEMP1p/DxlpgXHJ61gWl8ROH4kaSWZKRojI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Sq2+Dd8aMe7SCUg3ENbvWr4ur8VTQ4yEHpXczCcl2QHh32Eosm+F+S3apa4FIzNi/
	 tHHteZwWONSPUvtz6oCSbTJneppqMlp8o6AJH3WACXwpUrIQ8Kd3eSHFMwLlChFRzT
	 JPPpPd4LC5AcUKcoqTKEmbyjCI8Alcis++bQ44aE5kl/0nELoaUA+ahvbyMhEuFe5k
	 uo/pXQK6kjIlLxmfNrKkVSI40x2TZ/QpdATKwOCb8Fxj0qfgUauQ5DwWOw4lWWaZM/
	 j7HAp9M2YqIO/vgJ0D+fLlwE3Ei1M2gELcNSPiLAUcGrW7lmpINfBYn31609H6Rmdg
	 glqkrZ5NNvjFg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a49d2b18d5so13864351fa.3
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 03:57:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByrtkIxn7o9x9hsHeaUUiO/wb87pCNsrdY9IwwDZHAAyJkSaXLqMENm1UVMOomZV5kBAJs5NzA+r+Qs@vger.kernel.org
X-Gm-Message-State: AFuF++lubP2wSKKOkAYCnWoRp03GS263LS/XdXjR5bK68HGGI6GwvJaX
	FuHIVdu8MCiakSc/AjJklM2Z/7JbzZ91lf2y7W7z1PK5izTcWAi3ElR5644b4m1CIPc1M1wGyjV
	PA4oO3KVaU1PVcb0jR4tLk4c6/5k+qp0=
X-Received: by 2002:a05:651c:4ca:b0:3a3:42cf:c014 with SMTP id
 38308e7fff4ca-3a371b03dddmr46198621fa.7.1789037874395; Thu, 10 Sep 2026
 03:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831180214.2231161-1-mario.limonciello@amd.com>
 <CAJZ5v0hgn+_L_yvEg0yo0vPk9_brbxsywyu_77tEyww4nV+eUg@mail.gmail.com>
 <7f86bfc7-efda-4719-a0c2-fab04fba532f@amd.com> <CAJZ5v0gFPcoC4nLFdjcfY5Ysk9Sw38r_rLpzWSxtVPTyTuh-0g@mail.gmail.com>
 <aqJ22yK9h4ZHSo__@ashevche-desk.local>
In-Reply-To: <aqJ22yK9h4ZHSo__@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 12:56:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-229tKZ-=eXpWrSD9Y+2YBa4cPNiYoeu54k=T412N2g@mail.gmail.com>
X-Gm-Features: AcwNN1UoW-g5DwUzSiZo08kjEK4k5ZzmuDjZEQQ4h2Cu8wEt1GtD1GeNRezqbV4
Message-ID: <CAJZ5v0h-229tKZ-=eXpWrSD9Y+2YBa4cPNiYoeu54k=T412N2g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: utils: Ignore leading root scope prefix in string
 _UID match
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Cc: maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:22=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2026 at 07:58:56PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > +Andy
>
> Thank you for Cc:ing me. And sorry for the late reply, too many emails
> in the box...
>
> > On Fri, Sep 4, 2026 at 7:32=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > > On 9/4/26 08:26, Rafael J. Wysocki (Intel) wrote:
> > > > On Mon, Aug 31, 2026 at 8:02=E2=80=AFPM Mario Limonciello
> > > > <mario.limonciello@amd.com> wrote:
> > > >>
> > > >> Firmware may express an ACPI namespace path used as a _UID with or
> > > >> without the leading root scope character ('\'). For example, an AM=
D
> > > >> IVRS IVHD ACPI HID device entry may carry a character UID of
> > > >> "\_SB.MHSP" while the corresponding device's _UID evaluates to
> > > >> "_SB.MHSP" (or vice versa).  This semantic difference is due to ho=
w
> > > >> Windows PnP enumerates and uses devices.
> > > >
> > > > Can you please elaborate a bit more?
> > > >
> > > > I would expect _UID to return the string without the leading
> > > > backslash, so where does the other one come from, exactly?
> > >
> > > It comes from the ACPI IVRS table.
> > >
> > > https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
>
> Link is behind SSO, which Intel employee most likely can't get :-)

Yeah, good point.

Link: tags should point to stuff that is available to everyone
potentially interested.

> > > p306-307 talk about this field.
> > >
> > > Here is a sample entry decoded with iasl -d
> > > (from BIOS on an affected system)
> > >
> > > [223h 0547 001h]               Subtable Type : F0 [Device Entry: ACPI
> > > HID Named Device]
> > > [224h 0548 002h]                   Device ID : 0068
> > > [226h 0550 001h] Data Setting (decoded below) : 40
> > >                                      INITPass : 0
> > >                                      EIntPass : 0
> > >                                       NMIPass : 0
> > >                                      Reserved : 0
> > >                                   System MGMT : 0
> > >                                    LINT0 Pass : 1
> > >                                    LINT1 Pass : 0
> > > [227h 0551 008h]                    ACPI HID : "MSFT0201"
> > > [22Fh 0559 008h]                    ACPI CID : 0000000000000000
> > > [237h 0567 001h]                  UID Format : 02
> > > [238h 0568 001h]                  UID Length : 09
> > > [239h 0569 009h]                         UID : "\_SB.XHSP"
>
> As far as I can tell this is weird (very unusual) interpretation of UID f=
ield.
> Whoever created a specification should be informed about this.
>
> > > Setting this field to _SB.XHSP does fix the issue for Linux, but this
> > > has problems on Windows.  So my hope was to let \_SB.XHSP work for Li=
nux
> > > too.
>
> > So how does Linux process this table?  Maybe the leading backslash can
> > be removed in that path?
> >
> > But I guess it may not help because _UID may contain a string with a
> > leading backslash.
> >
> > > >> acpi_str_uid_match() compared the two strings verbatim, so such
> > > >> entries failed to match on the UID even though they refer to the s=
ame
> > > >> object. In the AMD IOMMU case (get_acpihid_device_id()) this cause=
d
> > > >> the exact HID+UID match to be missed and the code to fall through =
to
> > > >> the HID-only path, spuriously raising a FW_BUG.
> > > >>
> > > >> Skip a single leading '\' on either string before comparing so tha=
t
> > > >> paths that differ only by the root scope prefix are treated as a
> > > >> match. The integer _UID path is unaffected.
> > > >
> > > > But this sort of assumes that the string returned by _UID will alwa=
ys
> > > > be a namespace path, but is that the case really?
> > >
> > > For IVRS entries this would be true since this is what is in the spec=
:
> > >
> > >  > If defined as a character string, the ACPI UID marks the instances=
 of
> > >  > DMA-capable devices with the defined DeviceID (e.g. IOMMU visible
> > >  > Routing ID). It should match the ACPI device name space strings wi=
th
> > >  > unit number, but without a trailing \0 character (as the UID lengt=
h
> > >  > specifies the size of the string already).
> > >
> > > But I don't know universally it would be true.
> >
> > In general, they can be free-form strings AFAICS.
>
> Exactly, the semantic of the content is just arbitrary set of characters
> that is agreed to be unique (enough).
>
> > > I suppose one possible modification could be to look for the length o=
f
> > > the string being at least 2 on the string before incrementing the poi=
nter.
> >
> > I guess this change can be made because it will only possibly cause
> > problems when the only difference between the supplied UID and the
> > string returned by _UID is the leading backslash and they are not
> > supposed to match, which is unlikely to happen.
> >
> > However, the kerneldoc comment of acpi_str_uid_match() needs to be
> > updated to mention this.
>
> I don't see the direct question to me, I assume you want my opinion about
> the implementation. Ideally the specification has to be fixed, so we do n=
ot
> interpret UID as some "special" string. In a new version of the table
> specifications it can be amended with a new field, for example.
>
> If we need to solve the old behaviour, the skipping leading \ (and backsl=
ash
> only) might be good enough quirk to make sure that the rest of the caller=
s
> (and possible future interpretations) won't be affected. TL;DR: Make quir=
k
> as narrow as possible to avoid false positive triggering.

That is a good point either, but I think that if two UID strings
differ only by a leading backslash, it is kind of reasonable to assume
that they were intended to not differ (or conversely, it is hard to
believe that someone would intentionally add a leading backslash to
distinguish one UID string from another).

So I'm going to apply this, but I will remove the Link: tag mentioned above=
.

Thanks for the feedback!
