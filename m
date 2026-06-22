Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267818FDBD
	for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145422; cv=none; b=MkrTIunVUyEX6393Vg44LlUR7/ZqPOJ6u7+6DeNKQA7HiRP/eKxMBLifcz6UwLNsg74mPjhSlFe+6/ase9Hphv7aAjq46xxMGfKg5REv1xJw56ppbd/+g/b8dW8Qr5/DX3bUf4Wl7lLJF2wB77vklZSFrPjIwIs4hN+Sozq3dMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145422; c=relaxed/simple;
	bh=IWpQnrZ7eQWnqemYkGbSOhgw5bikc2OLIqEeArHsvjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHFy5NI3ytGtBu7P29FAawS+xGZK97c7SBPyqTWKtlUEVzGrhEjD09+/WrtoVizljybZ/vqSTJtI6KfeQLhW9qVDOYOKFV7EhjIS+5rqVvJk3bm9JC5ed9FC8hXNgOAHdm6/g62gGppfGSTp3lb9eik5VR2DMpKP83mTHCSO1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZrvutdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZrvutdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9721F00AC4
	for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2026 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145421;
	bh=vN2N2zR1k+kxnfYQ3JodmdjZIwUhqjHVgzw6oyyLKKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AZrvutdmFhdiXRLCh1fy4j9I/eZILnytcUY0NzBmqy2vGNqBGwI2pw82DWDbJ836N
	 CB07Nj6esgrfM+XoM5WHlRFTuR3nAdbxKQshjmWQx6AelU3NIV0rB0/l2PSyyYBMss
	 o4SvbJnt5V/pAr0UHCSqHAFhNGlc2taf4U5k4D2/NO4aJtiS0Ed3/l9HdHlf2sLIJ3
	 ZIlfwr1Q606BZJ+vXFljJBEFA6hD7YAW5X62SqpGULkF4rUuITYgrCusBuh8B4eUTt
	 mzRBYocykgigCbr/scM/RyRDhaditQnUNlFElFIFQvLPIihYTraPvkL014sAi6q+xh
	 uOjZu1N0ZelXw==
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59ebde7d704so1507070e0c.2
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2026 09:23:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+PLLIUYrdo2cEYAWXQgxmnA20tXe7c7+weIvGnNRUoLKytX41LVc/jh1LRCxHO6IPD5ZYFpdHK4qsw@vger.kernel.org
X-Gm-Message-State: AOJu0YwqaVkm3uwOJetxKIRwgziRNZ0Vqkcn4fOJBqL/q8ueTlnqom/W
	P8h7ntjpJstlxusem1KHjZviGmMXdSviHTXG+X60S4Lh3XOtWnqShr6Yfly9FgfOdeuXQSrf/8g
	B87sktpoXHC+35njDqtKU3klhOQsRW54=
X-Received: by 2002:a05:6122:d02:b0:5a1:fbbd:6bd0 with SMTP id
 71dfb90a1353d-5bbeba59191mr6674355e0c.5.1782145420211; Mon, 22 Jun 2026
 09:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617075633.534689-1-trenn@suse.de> <CAJZ5v0hOZs3TMgdCc+cfK_TVbmDj6z=PTYcDmdqtrZWhHOHG+w@mail.gmail.com>
 <CAJZ5v0i5G00LX9a5+DiH=RfTEmCK39ZUhxk3pwTzimuc4==Ckg@mail.gmail.com> <2799887.obQ9GjlxrE@laptop.fritz.box>
In-Reply-To: <2799887.obQ9GjlxrE@laptop.fritz.box>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jun 2026 18:23:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0id39pzy5PvtvA2643LBpm7-_ri9ZXBu8=PxpRh99LnrQ@mail.gmail.com>
X-Gm-Features: AVVi8CcCjdG5eVxzivpQBA58NQQzORdMHJGGvYXp7_7Io3u8HkOoSfnnNs-I77M
Message-ID: <CAJZ5v0id39pzy5PvtvA2643LBpm7-_ri9ZXBu8=PxpRh99LnrQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()"
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 2:01=E2=80=AFPM Thomas Renninger <trenn@suse.de> wr=
ote:
>
> On Sonntag, 21. Juni 2026 19:38:06 Mitteleurop=C3=A4ische Sommerzeit Rafa=
el J.
> Wysocki wrote:
> > On Wed, Jun 17, 2026 at 8:31=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > On Wed, Jun 17, 2026 at 11:25=E2=80=AFAM Thomas Renninger <trenn@suse=
.de> wrote:
> > > > This reverts commit 97f7d3f9c9acb70d4eef7bcdef3218823d142733.
> > > >
> > > > acpica has it's own safe strncpy function: acpi_ut_safe_strncpy
> > > > and must not use kernel's strscpy_pad.
> > > >
> > > > Closes:
> > > > https://lore.kernel.org/all/79e9e913-0fb1-4110-804b-c3b5d0edafe4@ke=
rnel
> > > > .org Reported-and-tested-by: Jiri Slaby <jirislaby@kernel.org>
> > > > Signed-off-by: Thomas Renninger <trenn@suse.com>
> > >
> > > Applied as 7.2-rc material, but I wrote a new changelog for it.
> >
> > And dropped because of
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?i
> > d=3D1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
> >
> > The acpidump build breakage will need to be addressed in a different wa=
y.
> >
> > I'll take care of this next week unless someone beats me to it.
>
> In case you agree with, you might want to take this one:
> https://github.com/acpica/acpica/pull/1203/changes

This hasn't been merged yet though AFAICS.

> Robert seem to have retired (his mail came back)?

Yes, he has.

> Please advise if one (I)
> still have to add/push someone so that this all gets synced from acpica d=
own
> to the kernel.

Saket is the new upstream ACPICA maintainer, but the overall process
has not changed.  That is, as a rule, changes are made to the upstream
ACPICA first and from there, they are propagated to the kernel
more-or-less automatically.

Commit 97f7d3f9c9acb70 was an exception because ACPICA users other
than the Linux kernel still use strncpy() and have no plans to switch
over away from it (AFAIK).
