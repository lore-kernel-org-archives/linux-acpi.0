Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2854449EA8
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036486; cv=none; b=XNCYeE2AVqn2rPxjhI1Y5d2Od0+r/yCXItkFNPsVxMXgvYwDanJ5f9s34+5GbEPq9bnfqI1fnlsyjnOAcS6dWtrhwBsrlonmC+5p4W6c+pDLqoKF9zRQqbevDJfSwHcLSpmzVO9FZto4QPjB2Yt8XcgmFCzi4pxVEym4D5e/vkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036486; c=relaxed/simple;
	bh=eCIFonh2Bd5KIEl4+ddUkpvZDEI4AnLThiR0Y+Z+jYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZvT9xU5Dmtpo8EOM4/4BleX14xtZc3UrEFtBYapseV3xMq1L0T7ogn6VmR+lTiqFnJWDFh387zaevCNimXzscnzc7GuuwctFZZbZIHGfnQAFyzn2l6U23NaNzHbM9ra67xQ4+p+LxG/pCG1PIzFMnpze3RR37jbL0FLAOVaRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqfP10er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqfP10er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E9B1F0089A
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036484;
	bh=eCIFonh2Bd5KIEl4+ddUkpvZDEI4AnLThiR0Y+Z+jYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hqfP10erMCyy2kwWOxdekD1kTY7x+KKfTxSanAD2jc0LHSaavND46uZV5gX1Wio1t
	 Qp3ypfCh61THuGyvrfM2EGbzRlN8nvkWBanWCzYqajCZZr2ttbuGNywETPmgf1Atzh
	 WzLCcoOw7bCt1ANSaY7ORxZVPM3dyOsgKSdvXcDFiykiNZOL1Xhrn0zpK5NV+ix1PB
	 z1Oem7BEO5fz+vgvbuth6KSujs/AogPhGweaglQbUcrZO7ZYwbCgwOobKxx7vEnq4O
	 Pbjb8e2Fo3V0X+y3EDgwcfBslMWZ4mqjw+0Gu83P0sJeiif919aCs3fRBZiSZg4PeZ
	 W/lVhT2gUd8Yg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a595487d43so4078741fa.3
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 03:34:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxtwfRn+8tsXumLz+L98G96ZNehayyvZ2QnNdk8csJ5WC4Q/p6t2s5BWxrTv8knYEevyxBpOFOUoqPb@vger.kernel.org
X-Gm-Message-State: AFuF++nOpjf235/yObued519xN2tuIPPb02+EPGYomLBXR5SU91z4tvn
	GQYdWXl87S13VC1ahHAe601+cJiOwQjQFJUaBxK8DY3z0etzUl5Z61Up3TEycpsxxxnHPBIkNAc
	ZX9CHEYF2iPgjk+2ucBiTEBr18WfjWH4=
X-Received: by 2002:a05:651c:4206:b0:3a3:7682:49a8 with SMTP id
 38308e7fff4ca-3a376824cc0mr42103301fa.29.1789036482879; Thu, 10 Sep 2026
 03:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806233817.622975-1-W_Armin@gmx.de> <f2f17b0d-22a1-4a57-895b-318bb50456f3@gmx.de>
 <CAJZ5v0j4EAZnrEA3Z7EKX5fdfhTWYbb=f0rOPnLsz5zaEMguGQ@mail.gmail.com>
 <dec5d721-8bc5-4be3-81cf-16b63829cbf0@gmx.de> <CAJZ5v0j67n7N-Eogik3njKV92E=FyW33bTvg6FnVfiT_AqwXug@mail.gmail.com>
 <d73d4c8c-f80c-428a-823a-f47cb194f0bb@gmx.de>
In-Reply-To: <d73d4c8c-f80c-428a-823a-f47cb194f0bb@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 12:33:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iL1guaTsR-r4M1YHVyaYZYCKqcrbcXcC8oMtoFyuoRZA@mail.gmail.com>
X-Gm-Features: AcwNN1UGayEv87PF-23NMJYmjq8od3VZDELoehlBIj0pyXfsCOrFielIBuElJ5Y
Message-ID: <CAJZ5v0iL1guaTsR-r4M1YHVyaYZYCKqcrbcXcC8oMtoFyuoRZA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Fix bogus cycle count values on systems
 without _BIX
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wse@tuxedocomputers.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:40=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 09.09.26 um 16:27 schrieb Rafael J. Wysocki (Intel):
>
> > On Tue, Sep 1, 2026 at 10:18=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> Am 01.09.26 um 22:16 schrieb Rafael J. Wysocki (Intel):
> >>
> >>> On Tue, Sep 1, 2026 at 10:11=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
> >>>> Am 07.08.26 um 01:38 schrieb Armin Wolf:
> >>>>
> >>>>> Devices supporting only the legacy _BIF ACPI control method cannot
> >>>>> know the cycle count of the associated battery, so cycle_count alwa=
ys
> >>>>> remains 0. Claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT on
> >>>>> such devices can thus mislead userspace applications and prevents
> >>>>> power supply extensions from supplying correct cycle count values.
> >>>>>
> >>>>> Fix this by not claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT
> >>>>> on devices without _BIX.
> >>>> Any thoughts on this? I tested it on my device, and so far everythin=
g seems
> >>>> to work flawlessly.
> >>> It looks good overall, but it is quite substantial, which is why it
> >>> didn't make it into 7.3-rc1.
> >>>
> >>> I'm planning to apply it for 7.4.
> >> Alright, that works for me.
> > And so applied.
> >
> > Sashiko has a comment on the _BIX failing case:
> >
> > https://sashiko.dev/#/patchset/20260806233817.622975-1-W_Armin%40gmx.de
> >
> > but this can be addressed on top of the current patch IMV.
> >
> > If you think that it's worth addressing, please send a follow-up one fo=
r that.
> >
> > Thanks!
>
> Thank you :)
>
> I do not think that Sashiko is right in this case, as failures inside _BI=
X
> should _normally_ only be temporary. So i think the current strategy of t=
emporally
> falling-back to _BIF if _BIX fails is fine.

Sounds good to me, thanks!
