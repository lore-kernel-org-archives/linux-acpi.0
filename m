Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3EF8C1F
	for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063505; cv=none; b=ocFea+fkcCpybpARzHI25jZ7YTMJS61qG/MVpTl0a7vNNfRF/HvwBwJwqIiAEhLx16QVd7p9+G0zOHf+fhZdu51XOkB2mxxyheeJUt2CAxubAGPaqKuy05Tc5xoFvZsfsGINWYEjeb25cZy9+5TNUMkPR+184+Pg9i7iCbeiGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063505; c=relaxed/simple;
	bh=CVrH3ArWZCXYYrWC5R7+1hZYClkFwd1IM6noMmbMeE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+HejmhePoAThkGA8lq1bxE08K538AJzFp+QKW+2F9tJKsppjZtBZgKKtaSyEUcA4t5FtCaagampuyMkNv2WmF1qAHKmMTJKIfNdLhsRs0ZH0OJEDJuKMt6PMvyy3IUEtQICWoqqZ0eXZsoo8uhT3aquSBpZ0APG03pW1mBtSm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDRQy9xz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDRQy9xz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EBA1F000E9
	for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2026 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782063503;
	bh=vSTODsmBvCcAFzWG9WY21HHvHiVQBo+gCdj3T6p/YV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iDRQy9xzcGEqR5EaSLN2elcgE5Xciqw823VFtdksEtperkqvctIUmXScj1srnsvve
	 La836i6HXpNxD61ypg1P3kX9ku3NulKkzrmz4MevV31/cCza6qz6XOgyANf7D8xhj5
	 nVcFVtH80ho1bsgOqssTCX8FkcZ/XgTgxRwdXkNtLbZngkVwq7o0oAAzwJHm9/+Llk
	 EvzbROtXCaevwIgvUh7lkRcM5eyJykk/nJKsNnwn2M8t8BvM4CdLOhKG6v5+faoOvV
	 E1g5H1cTEia9RUWEvy3ESlb/hUpsnKOGzjPH8j3ODudDQToFwZ6j00vVvSdIk5Hswp
	 /KQ8YZXuTfz6g==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa6792e7b8so4110935e87.1
        for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2026 10:38:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8S/mWskemmA3NU8xy9igGQCKzbFPA8EsNT/yx8JKvIJ2uxn3mU4fJzA5T3bgfeY9nVYM703UowfFvu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZVuRj7a0Gs/ks1VcL5XNOysYyDifwEonC9mLMge2iXkiWJfo
	OHyWpx5vl+IT1sIad4VbUkHgNMMuU8OwLWCRgyoUlHoa+pkoPfit1zjKH5r5i8Ke6ZBCjbsQds0
	vH7Yh32kiwFI0cYJYJt2qZk9uvg/1R4I=
X-Received: by 2002:a05:6512:250c:b0:5ad:5620:ba65 with SMTP id
 2adb3069b0e04-5ad562d1b58mr3401943e87.50.1782063501815; Sun, 21 Jun 2026
 10:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617075633.534689-1-trenn@suse.de> <20260617092448.538721-1-trenn@suse.de>
 <CAJZ5v0hOZs3TMgdCc+cfK_TVbmDj6z=PTYcDmdqtrZWhHOHG+w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hOZs3TMgdCc+cfK_TVbmDj6z=PTYcDmdqtrZWhHOHG+w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 21 Jun 2026 19:38:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5G00LX9a5+DiH=RfTEmCK39ZUhxk3pwTzimuc4==Ckg@mail.gmail.com>
X-Gm-Features: AVVi8CcIfyLzA2PA4X6N-b49I_Vbg7bV_vwbHE9eZnR9UlKFb2hneuuV-m0fMkk
Message-ID: <CAJZ5v0i5G00LX9a5+DiH=RfTEmCK39ZUhxk3pwTzimuc4==Ckg@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thomas Renninger <trenn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 8:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jun 17, 2026 at 11:25=E2=80=AFAM Thomas Renninger <trenn@suse.de>=
 wrote:
> >
> > This reverts commit 97f7d3f9c9acb70d4eef7bcdef3218823d142733.
> >
> > acpica has it's own safe strncpy function: acpi_ut_safe_strncpy
> > and must not use kernel's strscpy_pad.
> >
> > Closes: https://lore.kernel.org/all/79e9e913-0fb1-4110-804b-c3b5d0edafe=
4@kernel.org
> > Reported-and-tested-by: Jiri Slaby <jirislaby@kernel.org>
> > Signed-off-by: Thomas Renninger <trenn@suse.com>
>
> Applied as 7.2-rc material, but I wrote a new changelog for it.

And dropped because of

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D1a3746ccbb0a97bed3c06ccde6b880013b1dddc1

The acpidump build breakage will need to be addressed in a different way.

I'll take care of this next week unless someone beats me to it.

> > ---
> >  drivers/acpi/acpica/utnonansi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utno=
nansi.c
> > index 3a7952be6545..ff0802ace19b 100644
> > --- a/drivers/acpi/acpica/utnonansi.c
> > +++ b/drivers/acpi/acpica/utnonansi.c
> > @@ -168,7 +168,8 @@ void acpi_ut_safe_strncpy(char *dest, char *source,=
 acpi_size dest_size)
> >  {
> >         /* Always terminate destination string */
> >
> > -       strscpy_pad(dest, source, dest_size);
> > +       strncpy(dest, source, dest_size);
> > +       dest[dest_size - 1] =3D 0;
> >  }
> >
> >  #endif
> > --
