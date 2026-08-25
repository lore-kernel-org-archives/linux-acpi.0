Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B52E06E4
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665819; cv=none; b=KWIv89223I641KNveGZxy4hMhhBJfeBwdZtPQaWBuDYnl0ip1WO3W4428hAHp01wCitYaFsQpA5EEdjHsS0JWzDXRm+lpgfqNmgFDhNES7uPK6aTq+YRyTFOP9Zx1JPXjQ7EAytXb5Vu7bB+3ew7r+bVCWkmlU/ST+II0P/KHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665819; c=relaxed/simple;
	bh=V6KhqcINj5j7dYarEJ4tYCTHw2zFOlDuHjfXqECi9Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5hZLnmzxd42KBDLmRJoVmVUU63knImCCunbKY6irFvhsxXypfrW82KpW/6OLZoWE1tcfdmyxj3oDOM7kBLKdWfCbkUAt+aQo+kaSYbr36mxNn1YYndI5W/nbeF1M5lfgTaswQQTrwRUs1b08cBo8vGNRnT+FwDPe0HhNRhCa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODfNbf+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODfNbf+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3241F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787665818;
	bh=H/7sjQJv5Z0N/jJ3lKfgwQCRsdOQUJnP2hzY/CyJnKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ODfNbf+MSqIzan9lBPIGx965AirA4wdYspV9Wn4EwtaJgYBdw0A5z4maRpXAsfVpN
	 RJiCVkjU/I82nSGuJwDa4ZasxG4e6Jfr+8x3jza4tzqcZpTYzClkORcfFOFAaoyfz7
	 4MT79GQBymtmESQLzftoqGyLi+HBgEMr5112DcfST3OwGWW2R89Po2n//aSgUeVg33
	 SZnUfKVTu1kYQeh9NM5GA5vPHXmlK20b35PmN/NFRP94WIPHVUTGiGPkMN1ksOpFJp
	 8JbTaEgt4UUp3pX1tk3Rm3lzbFqpezPbsDgXlXGU5n724rnJTg2S92ZX1qaozuMcfF
	 rLif0OapBy0vQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so2833201fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 06:50:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpc326GaAxRAawELO9h5uvP++WsjY/hMrlP2kks4CXn9jhfXxzK8L2j5N/DT5FeMiMyWwGrvgNulMJy@vger.kernel.org
X-Gm-Message-State: AFuF++nh1DmfqRkzOTG7tjgQUeYrpudMm2xio/XxEOMd2U9HFadjQfsP
	VvrPnTyX3lEGoR00SskZ1+M011Gg9vhjB9DTJeg2ExOXH6lbEpxLdfou42PQToKb6TX9dd1pd7U
	qgmBaNSCJO9O5+rO8srHh2G7XranX17M=
X-Received: by 2002:a05:651c:a208:10b0:3a1:1198:d196 with SMTP id
 38308e7fff4ca-3a1aeba29d7mr62284691fa.1.1787665816627; Tue, 25 Aug 2026
 06:50:16 -0700 (PDT)
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
 <3aad6baa-6b19-b441-d294-5a656ef190a5@linux.intel.com>
In-Reply-To: <3aad6baa-6b19-b441-d294-5a656ef190a5@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 15:49:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gN2Wzp8FxXS6kpE=Pk-jDTyVGws0p9Y4J7MgjweaniFQ@mail.gmail.com>
X-Gm-Features: AcwNN1X0LyQlmgiirap1-j54mU1q46agrnJQ3Idtk4nf4WdmMhP_dMhkLVZS4wU
Message-ID: <CAJZ5v0gN2Wzp8FxXS6kpE=Pk-jDTyVGws0p9Y4J7MgjweaniFQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI objects
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:37=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:
>
> > On Tue, Aug 25, 2026 at 2:32=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:
> > >
> > > > On Tue, Aug 25, 2026 at 2:07=E2=80=AFPM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > On Tue, Aug 25, 2026 at 01:51:18PM +0200, Rafael J. Wysocki (Inte=
l) wrote:
> > > > > > On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
> > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > >
> > > > > > > Use DEFINE_FREE() to allow ACPI objects to be released automa=
tically.
> > > > > >
> > > > > > But at least some of them are allocated by ACPICA functions lik=
e
> > > > > > acpi_evaluate_object() and so they have no proper constructors.
> > > > >
> > > > > You could still assign the return buffer to a local variable. It'=
s not
> > > > > ideal API-wise though.
> > > >
> > > > Exactly.
> > > >
> > > > > I'm not quite sure what was the point you wanted to make but I re=
ckon this
> > > > > wasn't an ack. :-)
> > > >
> > > > Using the _FREE with variables that are not initialized through a
> > > > constructor is questionable, so this is generally not particularly
> > > > clean.
> > >
> > > The driver does call ACPI_FREE() for that pointer so clearly it's alr=
eady
> > > using something ending with "_FREE" already. So unless Rafael is
> > > suggesting ACPI_FREE() should be renamed, I'm a bit lost what that
> > > even means on concrete terms.
> >
> > Sorry for the confusion.
> >
> > I just don't want people to do things like this:
> >
> >     struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER };
> >     union acpi_object *out_obj __free(ACPI_FREE);
> >     acpi_status status;
> >
> >     status =3D acpi_evaluate_object(handle, METHOD_NAME, NULL, &output)=
;
> >     if (ACPI_FAILURE(status))
> >         return AN_ERROR;
> >
> >    out_obj =3D output.pointer;
> >
> > > > There is no cleanup.h in ACPICA that is a more traditional C code
> > > > base, so mixing up ACPICA code, which ACPI_FREE() is strictly
> > > > speaking, with cleanup.h stuff is not particularly straightforward
> > > > IMV.  I'd rather not do it.
> > >
> > > Perhaps add the DEFINE_FREE() into int3472 driver then, it seems to b=
e
> > > what intel/pmc is already doing (I don't seem to anymore recall why i=
t was
> > > added there). Using cleanup.h for that variable it clearly simplifies=
 the
> > > code flow.
> >
> > Well, fair enough, but as I said elsewhere, the code flow
> > simplification can also be achieved in a different way.
> >
> > > It feels a bit stupid to duplicate it there but I guess we'll
> > > just have to live with that if there's no place in any acpi related
> > > headers for cleanup.h.
> >
> > If there is a cleanup.h "free" that can only be used with objects
> > returned by acpi_evaluate_dsm_typed(), I'll be fine with that.
>
> So you'd be fine with something like this:
>
>       union acpi_object *out_obj __free(some_other_name_than_ACPI_FREE) =
=3D ...
>
> ?

Basically, yes.

> > Or if everyone agrees that doing
> >
> >     union acpi_object *out_obj __free(ACPI_FREE) =3D NULL;
> >
> > is not confusing and fine, I may just say "Hey, I don't care that much"=
.
>
> I personally don't hang myself into "free" or "constructor" terminology
> but look it more pragmatically, if ACPI_FREE() should be called before
> the object goes out of scope, __free() is a tool for that.

It is also good to consider the example given in cleanup.h though, in
which there is the

            struct object *obj __free(remove_free) =3D NULL;

pattern leading to a real bug due to a cleanup ordering issue.

I would prefer to avoid encouraging people to create code patterns
that are potentially problematic.  The "free" or "constructor"
terminology mentioned above boils down to avoiding those code patterns
which also matters in practice.

> Have Rust people tried to wrap this interface already (there seems to
> acpi.rs but it seems very limited in scope)? I'd expect them to be just a=
s
> interested in knowing what to do when something is at the end of its
> lifetime.

No, they haven't, AFAICS.  At least I'm not aware of any attempts to do so.
