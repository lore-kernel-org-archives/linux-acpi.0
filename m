Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2942F57B
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136139; cv=none; b=IUoZ06UBhppOqI+WOhCM/2qVWtw/bFSIwutqPfnTG/cfVuPjeZNFGq5aw+Dc8ewtpRqrAbFFNI9ucWVxfLorr3rghxSdAMtYDGb7gSm3kcFEe4ys5S+nhbpwT2irCHBl1U2HU4OnvGD2lIy4VPNaz546KQdvK1bbsF93NT6YEjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136139; c=relaxed/simple;
	bh=2qs/obur14fQtCTYO2vP8eYycOQdvXQ30T0NqUMlwmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MltWL0qeNeblfPXKa3bLlBEMOhGSflgK6fx884XnLbdRXElK5i2rsi2AZNBRUXTuPnZRgxWNSnNKZiPOYfP96r29jFS1TS/Q7SfOnEGQDZj6jIbrWmgp4X1tCwueJKqKmr/YgPOX+gCeEGYqHKqHLPbckrtvawaU5Da/LCWONq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMmSK+cH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMmSK+cH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD08C19423
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 09:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136139;
	bh=2qs/obur14fQtCTYO2vP8eYycOQdvXQ30T0NqUMlwmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UMmSK+cH+BQItUHo8xhUPY6E1CQiwXs0ji0oQwhUky+ZFGOI6LcPWpHOQkh4nL8EJ
	 9zB1LyRelCVsnCv72qeOAqH00PpPJWiSkbyrqBvTPSUKgHirOF0CptNJsL6Q7EnNm2
	 RGItOP+jeKuMtTLMg66cmo5cdvCmwNhvlafWtLcRheQu/MdfQvPVPyw18HX0mmWLJB
	 b8Z1wGCD1rei3zIib+wygZ2udGUyTQExGcM5mT+1KGW8gCfN1okHwwC4dQL1I3dOtH
	 9Rotf+NhoaRoeyhnCeVNoreUWiobwjz+pDAUv93VPOKx95ONB9G+pwQp1FzhX9t9oY
	 YuJT2oOZ43rgw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4648447e29bso4699567b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 02:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWl1gBXfksdlehN/ggiWUJ0x0q4rbMI570RaJf7mmSiSBUEyZsCKn4G1FJmiEwymu+nayfzvm88nVcz@vger.kernel.org
X-Gm-Message-State: AOJu0YwRoKC7l5XO+nB1c+1u6PZXmtIqK1gIrkdGIWJn3OGInvXyXo+P
	KV045A76UvOK0iUDEITvNXY9ZKEHOpVp4iM9unfRpK2A4n3rxQwSznMEAv7E+5Y2AlNUY+dHmkL
	o7AQWC6M02faQWl4aWaXmEPH4WX03YiA=
X-Received: by 2002:a05:6808:50a4:b0:467:fd2:69d with SMTP id
 5614622812f47-4670fd21b99mr3224175b6e.17.1773136138192; Tue, 10 Mar 2026
 02:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12863082.O9o76ZdvQC@rafael.j.wysocki> <aa9nq0JjDVxja74d@marvin.atrad.com.au>
In-Reply-To: <aa9nq0JjDVxja74d@marvin.atrad.com.au>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Mar 2026 10:48:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4nYMGY9W8cS0UjT5Lfttrv27DP2grAwYsAJJ1YGE_RA@mail.gmail.com>
X-Gm-Features: AaiRm50zWEG-wOGEmskTIrfFX7NHacZt64zElVK9lCHSn6fh6NapshRzyGOB7N4
Message-ID: <CAJZ5v0h4nYMGY9W8cS0UjT5Lfttrv27DP2grAwYsAJJ1YGE_RA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] platform/x86: fujitsu: Bind drivers to platform
 devices instead of ACPI ones
To: Jonathan Woithe <jwoithe@just42.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:37=E2=80=AFAM Jonathan Woithe <jwoithe@just42.net=
> wrote:
>
> Hi all
>
> On Mon, Mar 09, 2026 at 06:03:02PM +0100, Rafael J. Wysocki wrote:
> > This is an update of
> >
> > https://lore.kernel.org/linux-acpi/1968442.tdWV9SEqCh@rafael.j.wysocki/
> >
> > that fixes an error code path issue in patch [3/5].  That change also
> > requires patch [5/5] to be modified, but the other patches are the same
> > as in v1.
> >
> > The patch series summary below still applies.
> > :
>
> I'm not sure if I need to explicitly ack v2 or if my earlier ack for v1
> suffices.  If not:
>
> Acked-by: Jonathan Woithe <jwoithe@just42.net>
>
> This is for the entire series.

Thank you!
