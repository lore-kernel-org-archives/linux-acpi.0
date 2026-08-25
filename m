Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA84562BA
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663334; cv=none; b=nonFDRzYGbUa7ksG8eduT9msJ0rsf2GCJJKQsDkTBsva6STA0awO0uMgeZdZ2/JBmw0hLRZwK0rR4MQLm4v/vVhXwfTRbPbSDCrWaCiAjpJHKibfcfLC2yQTNdWlHbNoE3501JVaD5C02d/jvUkIWY04KDVuZR8Yzjf2VbWuvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663334; c=relaxed/simple;
	bh=1KnSQva2h1oeS5/72JRgpuGAUpEaKt0ODQmda1ZAulY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4ggjLWxWiMag/PvEYiUZIJwYHwE7wtKs83IAiqy07taYBx6dRtu4up84nPBAms93NLiUPKnX2MZgWIVYfCnImoZA2N7pHVD+zVvHQABwZdkjUelPMSbpMYMYLaUDK9I7dzSq2hJ4BvlD1806Dt67RubVr6ZYZ5GZNMnW05I19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONsm1COD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONsm1COD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FEC1F00AC4
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663331;
	bh=x06oGbiv+42H/+Zvm7fBv5AwzKRFHbxQQ029KyVWRC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ONsm1CODALKY+q5JtQVD7dMsd6qqzVzds3Ukiw37tbXble7D/4E2tivjGQy1gllvW
	 oDRAEDiFm30lA5FHQW8lUuZHe+DOItUbYcrDsrTmZdjKK/Ia0HLR9jCpGabv6yw7yk
	 otEeD5guCLjjkbdvZ5eJ8bRkyy0KIvRPe3xBmQuFzvWMpqksJ9VQ/6uJrJMrkAexQY
	 L2H1DFpRwzQOjh/D+vjj4Dw8Gmr5SLE9324UVWxJDlX38mbxJy9wx1SepjDFZrILey
	 4DtcXN8dfiWPDz0aSxNFKpnSZHaMouXipP9Ajr24rQZrFzaqU+42PM2dT+ClRAlZqe
	 +ZTl8LdonBQ4g==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c86ce9e29so35754861fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 06:08:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RppJ1jVsRkZcBbkkD4UY4zFlINrjRlOuzBPga5EkOH617MZkOvTJzQXZ5EiZvgUANrOtQCvfdeVnupP@vger.kernel.org
X-Gm-Message-State: AFuF++n1LVjz3qNthEyZrtObsNflr+gNuRJFMami8d2Nkr9Jg7t4R+Y4
	OUvvmhbn0eyJfs9r4ZSuE8cT8SVLaGvXS/O3T6fMptWDHB7h0eUa6u1xN/AY8hy8Ue3vS/9V2i8
	OS8YRqvSRYK/33SRc1sUqPvdvGVHs3nI=
X-Received: by 2002:a05:651c:43d1:20b0:3a1:31c3:961d with SMTP id
 38308e7fff4ca-3a1aec64cb2mr62316921fa.10.1787663330131; Tue, 25 Aug 2026
 06:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
 <20260824211338.3583976-4-sakari.ailus@linux.intel.com> <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com>
 <ao2FmNRFjSJVxhrL@kekkonen.localdomain> <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com>
 <134e9566-7913-86d7-1e8b-b2ca9ebec55c@linux.intel.com> <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com>
In-Reply-To: <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 15:08:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com>
X-Gm-Features: AcwNN1XmqJmnl1zaPpEQFFbnrAS9V7eNkgvdC8M9MPRx8JuoUnPzfAIobJdmns8
Message-ID: <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI objects
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Daniel Scally <dan.scally@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:02=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Aug 25, 2026 at 2:32=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:
> >
> > > On Tue, Aug 25, 2026 at 2:07=E2=80=AFPM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On Tue, Aug 25, 2026 at 01:51:18PM +0200, Rafael J. Wysocki (Intel)=
 wrote:
> > > > > On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > >
> > > > > > Use DEFINE_FREE() to allow ACPI objects to be released automati=
cally.
> > > > >
> > > > > But at least some of them are allocated by ACPICA functions like
> > > > > acpi_evaluate_object() and so they have no proper constructors.
> > > >
> > > > You could still assign the return buffer to a local variable. It's =
not
> > > > ideal API-wise though.
> > >
> > > Exactly.
> > >
> > > > I'm not quite sure what was the point you wanted to make but I reck=
on this
> > > > wasn't an ack. :-)
> > >
> > > Using the _FREE with variables that are not initialized through a
> > > constructor is questionable, so this is generally not particularly
> > > clean.
> >
> > The driver does call ACPI_FREE() for that pointer so clearly it's alrea=
dy
> > using something ending with "_FREE" already. So unless Rafael is
> > suggesting ACPI_FREE() should be renamed, I'm a bit lost what that
> > even means on concrete terms.
>
> Sorry for the confusion.
>
> I just don't want people to do things like this:
>
>     struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER };
>     union acpi_object *out_obj __free(ACPI_FREE);
>     acpi_status status;
>
>     status =3D acpi_evaluate_object(handle, METHOD_NAME, NULL, &output);
>     if (ACPI_FAILURE(status))
>         return AN_ERROR;
>
>    out_obj =3D output.pointer;
>
> > > There is no cleanup.h in ACPICA that is a more traditional C code
> > > base, so mixing up ACPICA code, which ACPI_FREE() is strictly
> > > speaking, with cleanup.h stuff is not particularly straightforward
> > > IMV.  I'd rather not do it.
> >
> > Perhaps add the DEFINE_FREE() into int3472 driver then, it seems to be
> > what intel/pmc is already doing (I don't seem to anymore recall why it =
was
> > added there). Using cleanup.h for that variable it clearly simplifies t=
he
> > code flow.
>
> Well, fair enough, but as I said elsewhere, the code flow
> simplification can also be achieved in a different way.
>
> > It feels a bit stupid to duplicate it there but I guess we'll
> > just have to live with that if there's no place in any acpi related
> > headers for cleanup.h.
>
> If there is a cleanup.h "free" that can only be used with objects
> returned by acpi_evaluate_dsm_typed(), I'll be fine with that.
>
> Or if everyone agrees that doing
>
>     union acpi_object *out_obj __free(ACPI_FREE) =3D NULL;
>
> is not confusing and fine, I may just say "Hey, I don't care that much".

And particularly there is this paragraph in a comment in cleanup.h:

 * Given that the "__free(...) =3D NULL" pattern for variables defined at
 * the top of the function poses this potential interdependency problem
 * the recommendation is to always define and assign variables in one
 * statement and not group variable definitions at the top of the
 * function when __free() is used.

regarding a broken code example, so I would think that this is not a
made-up concern.
