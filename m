Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D530216D
	for <linux-acpi@vger.kernel.org>; Sat, 23 May 2026 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557368; cv=none; b=gcMOjvqT7an4eeDbNlfYeU5jPOfVOqUAehMqAK1HsGKbHeeD9o8vz7VHXLXF44gjv0z/ESz+hJWQqNl3DUSFmx1D+XGTbeszP8zo4svnUOTDcDnnMCjMEwbpAy/q8K4PniHn2G4c8oma7T47a44b/a37Fi0caUxBbH6mqRLZ9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557368; c=relaxed/simple;
	bh=Nkd72RKNOdoFWkGOI+imzwzWpe5ErcrsxILdU3grj+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZWS/3uSlYtBizMqtU0vl79s1N8+tobL8GhCMPZ8kVNimkAeQuOwJPhdOjhbixZzmOfbuHgN2imaS/UQfpyZXaUZKW8LEfdhXiIPywRDC3mnOjdxd84U6jkVRMclzcP0qatY432Rts6rf8FJlkj7OcI0IRJwu351GMBqWKvwqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQtuXKsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQtuXKsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E0F1F00A3C
	for <linux-acpi@vger.kernel.org>; Sat, 23 May 2026 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779557367;
	bh=QdSv+AjOh4NS99kcWs18rYe/wSOKRsMQLmLZ0YM0+G4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mQtuXKsGy5h+JWqaHNd+vSAIgroPVpgnc9hsz6WR5fgDZ84lg1AKihFr5pdBEezxw
	 ehbqr/y9GqhEqnYHp/ReaDbmMXnNr/06ohU4pQBhMbDgbnv5i6jhiW6fgZdwKRAo0n
	 rC2CVHHJ28tTatrzzYbnf5wshR51SxxAKEpXWhzc0308/jWtcPZQlB7DfyremAq2MV
	 dK4LAA2uYzznnRgMORXi8cwPiuzKQt1Ibvc8tXYzjh+StEKfEDKV98sPAnA/jd63ee
	 NZXzcnko18rIkvenAbhiwquAa43xQDKJ5tj+9vQNg0Qj3TKf9AMxzT1vzEqZ+fikJc
	 UEFzS7xZAhWLw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa2691db86so6819306e87.3
        for <linux-acpi@vger.kernel.org>; Sat, 23 May 2026 10:29:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8bPfyxGUPIUBxdWB7BMTSnoh3dqh9ENs4JbparBsCWjUChezUskx9bTgQh5aGlBoJmdnrpzeoXOL1O@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMCWFXF9qr8JgBLdaXtBaTKO3Cdook7TAF/A6G1mx+qVh9Uw+
	o2wF5ljOsyGdyh9Xh1kM/+TjBrCnCLlx8BM8R6CJADgYQWZLB4T+1l1EYlZMqnv2ckiGQMHaeVi
	+9WxuYHgMm1ekI24kMiaCWvraV3ZO1EI=
X-Received: by 2002:a05:6512:230d:b0:5a3:ff48:f7db with SMTP id
 2adb3069b0e04-5aa323b2930mr3050281e87.34.1779557365965; Sat, 23 May 2026
 10:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2046403.PYKUYFuaPT@rafael.j.wysocki> <9629117.CDJkKcVGEf@rafael.j.wysocki>
 <7B2E2495-8BE8-41F7-9432-F1775612337E@kousu.ca>
In-Reply-To: <7B2E2495-8BE8-41F7-9432-F1775612337E@kousu.ca>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 23 May 2026 19:29:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jEK5QqdVktqXO_+U-Mg7nQ0nZWMF0iPveFLp+=dRMjGw@mail.gmail.com>
X-Gm-Features: AVHnY4KLlQIE-EV4pPQnRA-q4vV1RY-tYyhQ9HMJsq213g-B4Usd2dKl782vP_Y
Message-ID: <CAJZ5v0jEK5QqdVktqXO_+U-Mg7nQ0nZWMF0iPveFLp+=dRMjGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI: button: Enable wakeup GPEs for ACPI buttons
 at probe time
To: Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 4:15=E2=80=AFAM Nick <nick@kousu.ca> wrote:
>
>
>
> On May 22, 2026 2:52:10=E2=80=AFp.m. UTC, "Rafael J. Wysocki" <rafael@ker=
nel.org> wrote:
> >From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> >Prior to commit 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake()
> >for buttons"), ACPI button wakeup GPEs having handler methods remained
> >enabled after acpi_wakeup_gpe_init(), but currently they are not enabled
> >because acpi_setup_gpe_for_wake() disables them.
> >
> >That causes function keys to stop working on some systems [1] and there
> >may be other related issues elsewhere.
> >
> >To address that, make the ACPI button driver enable wakeup GPEs for ACPI
> >buttons so long as they have handler methods.  While this does not
> >restore the old behavior exactly (the ACPI button driver needs to be
> >bound to the button devices for the GPEs to be enabled), it should be
> >sufficient to restore the missing functionality.
> >
> >For this purpose, introduce acpi_enable_gpe_cond() that enables
> >a GPE if its dispatch type matches the supplied one and modify
> >acpi_button_probe() to use that function for enabling the GPEs in
> >question.
> >
> >Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for butt=
ons")
> >Reported-by: Nick <nick@kousu.ca>
> >Closes: https://lore.kernel.org/linux-acpi/E2OXET.4X5GTP37VTNC3@kousu.ca=
/ [1]
> >Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
> >---
> >
> >v1 -> v2:
> >   * Change the acpi_enable_gpe_cond() third parameter to a dispatch typ=
e (or
> >     "any type" value) and modify checks in it accordingly to address a
> >     problem pointed out by sashiko.dev
> >   * Adjust comments in acpi_enable_gpe_cond() and acpi_enable_gpe()
> >   * Update the changelog
> >
> >@Nick, It would be good to test this version of the patch on your system
> >because it is a bit different from the previous one (which was not entir=
ely
> >correct).  I'm not expecting it to behave differently, but additional
> >testing would be welcome.
> >
>
>
> I tested this on top of 45255ea1ca096. The keys are still working as expe=
cted! I compared it against 6.19.14 too and all the keys seem to behave as =
before.

Thanks for the confirmation!

I'll add a Tested-by tag for you to the patch when applying it unless
you don't want me to do that.

> I noticed one difference, but it might not be directly related: KEY_SLEEP=
 takes significantly longer
> to trigger suspend on 7.1-rc4 than on 6.19.14. On the older version it su=
spends in about a second;
> on 7.1-rc4 it takes about a minute before it fully suspends. The lid swit=
ch on the other hand suspends
> in about a second, and so does the suspend button in my DE, on both versi=
ons.

This is unlikely to be related to the issue addressed by the $subject patch=
.

> I guess they're doing different kinds of suspend. That's probably related=
 to the other ACPI changes
> that landed in 7.0.

One thing to take into consideration here is that the kernel doesn't
trigger suspend by itself.  The
key press event first goes to user space which then decides what to do
with it and may (or may
not) trigger a system suspend in response.  It may be doing different
things for KEY_SLEEP and
the lid switch.
