Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2D370AF3
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211808; cv=none; b=GQHeBYCTQ7xjDKYsWO4bZRFN4keUgcCrVuQg4W4HI8kNydWdhbxYgfGCMTFGiJlDmepmMrACI+LTiGktbd4lL45wr1fswPn74Q/XCp8UN6P0LaHBRetxZachPvrar5BQcKdYnvxKyaOgX7qv6hZlmCH8/5atScnA3r+/aev6PjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211808; c=relaxed/simple;
	bh=3BmKNyG8Id8m/mrBAzgNxDhu6gPysgpKz5KpmqDL954=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjpTJT+M1WB7q37RZuegMM3TVe3YHmV3eZL9vL1V97MJZGmOZjmlLeZRibISUMFOo0gdd4Dx3gd1hizLUFeYRPbNSvx8EI08ROjMZSCFa1Kk9xlh5dqsA39NGfIJB6xYZpg0wUbpdX7B4ejhPoIoTOmQkGZ1XQDafGrapBfM8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGyC84vR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGyC84vR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F8E1F000E9
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782211806;
	bh=Y9whw2scq8Z+yRwla/O764FtKys/ISm9e03PqEPnDmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OGyC84vRfbzHpkx/cCrEpuikj1B9n4fMUqjGTxMQJg4/ABgrwwNCj8Cp8R0qo61Bj
	 HrVKQDlbG8Z2W4/6ZEZRWM6/3bzyo9Y2brmY349Cd8SXm5IAoohmKSTj/qu3l67Bht
	 lcO4RBLI7f2F/Obv0rzdkTuAVnWSf+sIqYshsLJ2nIch0dV2lYc1mcpRmvv6xZfzCH
	 d0eM7slDWfznh4zHBIt3VEPPlt7oRtfuaut0evn0ITHS7zh0pay5udWcQjAlluSlDa
	 rI0O/DQMiQMD2iUPJqF45gRJqVjpTb9EogqqD0bqJesyxntoNJj6fZHBASr7W7a2gN
	 SHYelX1sQ+5iQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ad578c49afso3590207e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 03:50:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9rU8lpJIEBJ5z4kZtqlaxWTFG+edZE9j4vurr5H51XkWQV6Nm5ouJ4V7nEP/tvah8k2yYeMb5RY7KW@vger.kernel.org
X-Gm-Message-State: AOJu0YwOa6jO5Glq/5e1HS4o6eT38z8FsHo0N3EsDQuPuL7ilvXrHC4I
	KF3hfp/XjcRdmHc+nT8uPC76bfgJkqYG9q+taT+kl1cF12WLAtJZT6w/SB8fKflLl1gas3i8eT/
	u5QbRW+qAA/82DpwJMD3g0kRtdhWD32Y=
X-Received: by 2002:a05:6512:2c07:b0:5aa:7aba:2a5f with SMTP id
 2adb3069b0e04-5ae350ff73dmr530900e87.6.1782211805314; Tue, 23 Jun 2026
 03:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12923581.O9o76ZdvQC@rafael.j.wysocki> <d9379a5b-0b82-4df1-a034-03f82bb0e3da@kernel.org>
In-Reply-To: <d9379a5b-0b82-4df1-a034-03f82bb0e3da@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jun 2026 12:49:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jgZ+scDMCBxHwXtOLeJHkiZdZhbG5_R5b06HeVapnS0g@mail.gmail.com>
X-Gm-Features: AVVi8CdSVgxZ_-n9mf0VXUX29a5ygnb-kUCXF0Ywg-oPzPx-N85k4NrIAQxsSqU
Message-ID: <CAJZ5v0jgZ+scDMCBxHwXtOLeJHkiZdZhbG5_R5b06HeVapnS0g@mail.gmail.com>
Subject: Re: [PATCH v1] ACPICA: Unbreak tools build after switching over to strscpy_pad()
To: Jiri Slaby <jirislaby@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Thomas Renninger <trenn@suse.com>, LKML <linux-kernel@vger.kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Kees Cook <kees@kernel.org>, 
	"Chmielewski, Pawel" <pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:02=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 22. 06. 26, 20:23, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 97f7d3f9c9ac ("ACPICA: Replace strncpy() with strscpy_pad() in
> > acpi_ut_safe_strncpy()") switched over the ACPICA code in the kernel to
> > using strscpy_pad() instead of a combination of strncpy() and manual
> > NUL-termination of the destination string, but it overlooked the fact
> > that tools also use the code in question and strscpy_pad() is not
> > defined in those builds.
> >
> > Address that by using the original ACPICA code in non-kernel builds.
> >
> > Fixes: 97f7d3f9c9ac ("ACPICA: Replace strncpy() with strscpy_pad() in a=
cpi_ut_safe_strncpy()")
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Closes: https://lore.kernel.org/all/79e9e913-0fb1-4110-804b-c3b5d0edafe=
4@kernel
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/acpica/utnonansi.c |   10 ++++++++++
> >   1 file changed, 9 insertions(+)
> >
> > --- a/drivers/acpi/acpica/utnonansi.c
> > +++ b/drivers/acpi/acpica/utnonansi.c
> > @@ -168,7 +168,17 @@ void acpi_ut_safe_strncpy(char *dest, ch
>
> Hmm, how could this become 17, provided you are adding 9 lines to 7
> lines? Fixed to 16 and applied -- testing.

Yeah, I manually updated the comment and forgot to refresh the patch
afterward.  Sorry.

> >   {
> >       /* Always terminate destination string */
> >
> > +#ifdef __KERNEL__
> >       strscpy_pad(dest, source, dest_size);
> > +#else
> > +     /*
> > +      * strscpy_pad() is not defined in ACPICA tools builds, so use st=
rncpy()
> > +      * and directly NUL-terminate the destination string in that case=
.
> > +      */
> > +     strncpy(dest, source, dest_size);
> > +     dest[dest_size - 1] =3D 0;
> > +#endif
> >   }
> >
> >   #endif
> >
> >
> >
>
>
> --
> js
> suse labs
