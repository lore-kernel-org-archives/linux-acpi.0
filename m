Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF8288C2D
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663023; cv=none; b=FcDSGvlPcz/OQwnilMyV6FxMmTVjlCmEtR6Bu6xecmlIuLLAvNI7ncZz9vi3hwPzXIXFjUH7yVHO3OeZ34YPAOatxyVxkYJtfLcFB5FoEYnswcHiLQWJWs8H8LD+oA1EY386QkE2BzmDIo9k3Bsw5s0YkJcVh3O0cHd7O1uqrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663023; c=relaxed/simple;
	bh=TJRPa/Ggm+9586MtcXYNB6Ia4GfcxoAbD85BT7yGGDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIjUkOcXLw/V9nwY2gzrCp8mB5mqI22Qf4hsk0r0g7V9LPiGckTVqNtEEF6TfyGxJKNF9S/O1ESJz9pLwv9M34KQy0+yMC7WyewamvaG3CQfqlfm5eAjyBN6eJxtle5uop56ox4hx6ml3QZAzWqJTeZIRZ/5MYF15nQ60MP6lIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAtmRxF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAtmRxF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303601F00ADE
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663022;
	bh=47kNsLtyuC0VFyVb940jGDwOo50IwCDnjYsdmnapaCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eAtmRxF2oHGPjhO5X8Cyof/gAdkICeTezCQ8vksSQalU2Vz4KPvsTYDCNo9Fch11N
	 JULXeVXrM8ubtUZFCuDyU2+05DzpXLtHLQ701V3NF2hPNeXsEMR/s+8jGWRiOdyyoz
	 KHHec1ST2cjAnK6eHtOvUz657Hn8b3UjmUpfUqCzgTXtsQ6Lu9Nix+aV8LFE0WqEuV
	 sfBvMZxNACi4fpNq9sJRFCIWaqNX4wvrj1avUJo18PdJfxKVZjJxodOBgTDv2BBokX
	 RsLPFCV6W8rJ9qWgO+3mFScWSl0/RiQcKijLf7tlvjwXgQP+XXoSVf/e5NiEWYxChy
	 S5J/RvRhMWndA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2a3166398so4636979e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 06:03:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrtpbd/H6NgkVOXihv0LenN80O+g9Azeo95jZ77NeycCW4NSyrEE0GIRJznYk6AgGqgaRwH9S1ioLyp@vger.kernel.org
X-Gm-Message-State: AFuF++kMi1jDYwqj4IzeAPvkwJXqtlcuDLvaP+QDX9HURsNddOA3QCvk
	8zWfqAj11TSJHwazxw3nCxmhZEjUaAFed8PcMy+gJcKt/2J6GrfPDpuF6eJq29aIgCQf0u1plQ0
	pR4XrgdFmYc9mvk+ddJkOyIRMgRlkUEk=
X-Received: by 2002:a05:651c:a20c:10b0:3a1:5172:c287 with SMTP id
 38308e7fff4ca-3a1ef503acfmr11052391fa.5.1787663020392; Tue, 25 Aug 2026
 06:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
 <20260824211338.3583976-4-sakari.ailus@linux.intel.com> <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com>
 <ao2FmNRFjSJVxhrL@kekkonen.localdomain> <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com>
 <134e9566-7913-86d7-1e8b-b2ca9ebec55c@linux.intel.com>
In-Reply-To: <134e9566-7913-86d7-1e8b-b2ca9ebec55c@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 15:02:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com>
X-Gm-Features: AcwNN1WdQqupHXC25x9xbMGTjPjMFPh7UT1_cOYp2FXWcp3ifII4mjtsGuoQDHQ
Message-ID: <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI objects
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:32=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:
>
> > On Tue, Aug 25, 2026 at 2:07=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Tue, Aug 25, 2026 at 01:51:18PM +0200, Rafael J. Wysocki (Intel) w=
rote:
> > > > On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Use DEFINE_FREE() to allow ACPI objects to be released automatica=
lly.
> > > >
> > > > But at least some of them are allocated by ACPICA functions like
> > > > acpi_evaluate_object() and so they have no proper constructors.
> > >
> > > You could still assign the return buffer to a local variable. It's no=
t
> > > ideal API-wise though.
> >
> > Exactly.
> >
> > > I'm not quite sure what was the point you wanted to make but I reckon=
 this
> > > wasn't an ack. :-)
> >
> > Using the _FREE with variables that are not initialized through a
> > constructor is questionable, so this is generally not particularly
> > clean.
>
> The driver does call ACPI_FREE() for that pointer so clearly it's already
> using something ending with "_FREE" already. So unless Rafael is
> suggesting ACPI_FREE() should be renamed, I'm a bit lost what that
> even means on concrete terms.

Sorry for the confusion.

I just don't want people to do things like this:

    struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER };
    union acpi_object *out_obj __free(ACPI_FREE);
    acpi_status status;

    status =3D acpi_evaluate_object(handle, METHOD_NAME, NULL, &output);
    if (ACPI_FAILURE(status))
        return AN_ERROR;

   out_obj =3D output.pointer;

> > There is no cleanup.h in ACPICA that is a more traditional C code
> > base, so mixing up ACPICA code, which ACPI_FREE() is strictly
> > speaking, with cleanup.h stuff is not particularly straightforward
> > IMV.  I'd rather not do it.
>
> Perhaps add the DEFINE_FREE() into int3472 driver then, it seems to be
> what intel/pmc is already doing (I don't seem to anymore recall why it wa=
s
> added there). Using cleanup.h for that variable it clearly simplifies the
> code flow.

Well, fair enough, but as I said elsewhere, the code flow
simplification can also be achieved in a different way.

> It feels a bit stupid to duplicate it there but I guess we'll
> just have to live with that if there's no place in any acpi related
> headers for cleanup.h.

If there is a cleanup.h "free" that can only be used with objects
returned by acpi_evaluate_dsm_typed(), I'll be fine with that.

Or if everyone agrees that doing

    union acpi_object *out_obj __free(ACPI_FREE) =3D NULL;

is not confusing and fine, I may just say "Hey, I don't care that much".
