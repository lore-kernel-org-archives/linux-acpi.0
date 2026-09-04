Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F69456E00
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544801; cv=none; b=bJDK7g4HbAvTbLmnp2RtuH71Hkep2frL1idRhzQpYrdeCERkArXhEMqUV5tqEZ6m4efZ7W7KnBiq64yUUBzGd+z9yQ3Zz27zQolaunlwpzkOpOvgI0b4m9Eo2wsVTNr9HANSIt+6+cX2IvSBGLpgmDnMIMqyv5d0F2sKRD3fTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544801; c=relaxed/simple;
	bh=LsNKIz5CCqhEvP4SdIlx0QnNojwGVi16fh/ZcA697TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG73EF0CXbd3eGSdxgzBRTdTrIOLJvHiz/zY41lEhL6TsTCPrS0wLfIClR2GT/oawT/K78twyX2WsRP3jET5DFHEvEC4oWNE8nGvUz3DyBt3fHJuGmHHz2U3o9NO0k9ltIAkuKUCPdA1B6tTYeHzFMgeUKXk8Dkm2jwpxAzSRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3KMf/iH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3KMf/iH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A711F00A3E
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788544799;
	bh=f98SNxmb0gJzAqpbbHF/J/24bNNt/KKbIWVpvAJoAXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y3KMf/iHTWXe8S8FWacJlhRyKpS420aunu9vu6/aCEAXP5hgvJwKnPT/9+Tquu2Cy
	 VJuutOJDSQ7z3MMyC7rfZe/XQnuAWjtIw3AQGPvZfRtvOCTeanDyWga6lYQ6JHA+ON
	 DP8ZUqjLmoe0lR34TUexqm+GzjELUIjgAGrJWYIuFX/kv0HrP3pz68q8cUrvkafcWO
	 EdoAE7OU9A+NhoRvA6DvQ/a+739yw9A7KQYWuOMIBdYGnlHUfs91E8QU4c5Cpr2wGg
	 H0S7cL5HxLhDkNFsnMgSWsYk1RhdBvVgV1AefSx6uJy8sOM59EE2v0my7Dohp0dpdg
	 5J8pW67iPfsng==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39f20d19895so11152601fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 10:59:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxXX2tJGmx0aIgiSW5VYy4oJrTD9f/VFas/Ae8cgGqpIWUhH546aElT/aU78Cr6GSo3QG/d/muV2tKe@vger.kernel.org
X-Gm-Message-State: AFuF++k78E/RgDY8Se0Asrs6jKb1v6ppxxyhLQOTov+ImyYa3nUxojMI
	aDlKaG18o+J0U9SNpEACOKrnC88Xj7VYZ/ugDYQhGrYZH4HqpLM7OzKUULwS8o1hWXvQQAyeQ8r
	1rekn/uIyQc9oCjoj4JW0F291Hqp6zgE=
X-Received: by 2002:a05:651c:15c1:20b0:3a3:476:2e37 with SMTP id
 38308e7fff4ca-3a371b2d735mr6515681fa.6.1788544798061; Fri, 04 Sep 2026
 10:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831180214.2231161-1-mario.limonciello@amd.com>
 <CAJZ5v0hgn+_L_yvEg0yo0vPk9_brbxsywyu_77tEyww4nV+eUg@mail.gmail.com> <7f86bfc7-efda-4719-a0c2-fab04fba532f@amd.com>
In-Reply-To: <7f86bfc7-efda-4719-a0c2-fab04fba532f@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 19:58:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFPcoC4nLFdjcfY5Ysk9Sw38r_rLpzWSxtVPTyTuh-0g@mail.gmail.com>
X-Gm-Features: AcwNN1V527BmisDd60oaR4lUKRGoT6qzov8X741K6DUy-x5835bJV_3Bci7tNsw
Message-ID: <CAJZ5v0gFPcoC4nLFdjcfY5Ysk9Sw38r_rLpzWSxtVPTyTuh-0g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: utils: Ignore leading root scope prefix in string
 _UID match
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Andy

On Fri, Sep 4, 2026 at 7:32=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 9/4/26 08:26, Rafael J. Wysocki (Intel) wrote:
> > On Mon, Aug 31, 2026 at 8:02=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Firmware may express an ACPI namespace path used as a _UID with or
> >> without the leading root scope character ('\'). For example, an AMD
> >> IVRS IVHD ACPI HID device entry may carry a character UID of
> >> "\_SB.MHSP" while the corresponding device's _UID evaluates to
> >> "_SB.MHSP" (or vice versa).  This semantic difference is due to how
> >> Windows PnP enumerates and uses devices.
> >
> > Can you please elaborate a bit more?
> >
> > I would expect _UID to return the string without the leading
> > backslash, so where does the other one come from, exactly?
>
> It comes from the ACPI IVRS table.
>
> https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
>
> p306-307 talk about this field.
>
> Here is a sample entry decoded with iasl -d
> (from BIOS on an affected system)
>
> [223h 0547 001h]               Subtable Type : F0 [Device Entry: ACPI
> HID Named Device]
> [224h 0548 002h]                   Device ID : 0068
> [226h 0550 001h] Data Setting (decoded below) : 40
>                                      INITPass : 0
>                                      EIntPass : 0
>                                       NMIPass : 0
>                                      Reserved : 0
>                                   System MGMT : 0
>                                    LINT0 Pass : 1
>                                    LINT1 Pass : 0
> [227h 0551 008h]                    ACPI HID : "MSFT0201"
> [22Fh 0559 008h]                    ACPI CID : 0000000000000000
> [237h 0567 001h]                  UID Format : 02
> [238h 0568 001h]                  UID Length : 09
> [239h 0569 009h]                         UID : "\_SB.XHSP"
>
> Setting this field to _SB.XHSP does fix the issue for Linux, but this
> has problems on Windows.  So my hope was to let \_SB.XHSP work for Linux
> too.

So how does Linux process this table?  Maybe the leading backslash can
be removed in that path?

But I guess it may not help because _UID may contain a string with a
leading backslash.

> >
> >> acpi_str_uid_match() compared the two strings verbatim, so such
> >> entries failed to match on the UID even though they refer to the same
> >> object. In the AMD IOMMU case (get_acpihid_device_id()) this caused
> >> the exact HID+UID match to be missed and the code to fall through to
> >> the HID-only path, spuriously raising a FW_BUG.
> >>
> >> Skip a single leading '\' on either string before comparing so that
> >> paths that differ only by the root scope prefix are treated as a
> >> match. The integer _UID path is unaffected.
> >
> > But this sort of assumes that the string returned by _UID will always
> > be a namespace path, but is that the case really?
>
> For IVRS entries this would be true since this is what is in the spec:
>
>  > If defined as a character string, the ACPI UID marks the instances of
>  > DMA-capable devices with the defined DeviceID (e.g. IOMMU visible
>  > Routing ID). It should match the ACPI device name space strings with
>  > unit number, but without a trailing \0 character (as the UID length
>  > specifies the size of the string already).
>
> But I don't know universally it would be true.

In general, they can be free-form strings AFAICS.

> I suppose one possible modification could be to look for the length of
> the string being at least 2 on the string before incrementing the pointer=
.

I guess this change can be made because it will only possibly cause
problems when the only difference between the supplied UID and the
string returned by _UID is the leading backslash and they are not
supposed to match, which is unlikely to happen.

However, the kerneldoc comment of acpi_str_uid_match() needs to be
updated to mention this.
