Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6638422F
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739493; cv=none; b=BDNIkxVylWWwq+IhemUS2lOClULCqIo5Ylg6uQb0PxQyVo/vFdGm/OWGR+knhjgy9CXzoVJGjJmIuwZZZ6nCSTVsd0kc7L2rVQXP+u877rj/KFY+duvhB7q2YH0YZ2FUfcE0inuJJzn31WLyH4KOUTzh3FT4J5jr+0aIAuQAGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739493; c=relaxed/simple;
	bh=sqL24K0KfJdbx0vHEs3vDO0I9peitKLJ5huBhDqLg/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=So3Iec1ypFNFGv/dFUSUavv8eJQMC4im4d3cEIHyO0PpBUaRZ2Nybmu3m199A+UqsmdVvsvCmD6i4Tp/vkdOjr5bvhnM7PNA2SWSaYupBih3cndewcv2wL+KHIWzxQ8x6fTjjoDerZSW2DTR5GB7fV0EkqnWC/ujUpWCtj3fY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEYJ0QiP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEYJ0QiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142581F00ACA
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 10:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787739492;
	bh=mDV5gdsC6yguzGKpIGUB6MMAjCOyqIfbyxfQVnSthAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WEYJ0QiPsNz/hfSPDfjvjPu8n3hqjXwZNZvTlaejmuycz+nSglf5e425z6K8VtWCA
	 8e6IlIR4tv4OdCBmVs1wtRiGE1c268+VscF/ztbKnZawYk8E8RX2Zn8BZV5lx0pIpx
	 qB7mhhpgEBgQFNs8SaouLWV1Uo4loeSEKxBKDGUBUQHLVKPQLVdwqsjnwZHgvlgsov
	 IIjlNvBrI3XA5c13p43a+if6kDPffd1PeYjkxe/rjRU6mF9Z8Om74N5NwbZzU9X5W/
	 D0j2jTYXElRy+eXLnzSnfU3FlsgCxOt45gqzsaVw5oucoSCvUO/6cUCbfQea7d8y6+
	 0TP6AIixhaM0g==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso4025551fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 03:18:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqGxtsCFp6gqH5PSVlGRsjtkw/sKbcfc+grHSCIIkubNYaW2m9BbvS8rPfYo067etVrTJMEkDbIAhlp@vger.kernel.org
X-Gm-Message-State: AFuF++mIk+gT0spWflyeZNZJ1LBuskXxOiEMGInY1DidQIHlKUwMzQFd
	bve7zsIXBvHeuB1M+VBmhPmfvsqXRiFj5w+oX0Ro5WdGioO4BluyBRInUvUBboXR5LDRxSH5CIv
	zGJl6KqED5y2IZAgfetspmucYi2o+6tk=
X-Received: by 2002:a2e:b8cd:0:b0:3a1:8dd6:aada with SMTP id
 38308e7fff4ca-3a1fbb66ed5mr9694031fa.4.1787739490431; Wed, 26 Aug 2026
 03:18:10 -0700 (PDT)
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
 <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com>
 <ao3uh2xos_1uwAgJ@kekkonen.localdomain> <762e0630-1b04-6a82-69b6-ca5148e74cff@linux.intel.com>
In-Reply-To: <762e0630-1b04-6a82-69b6-ca5148e74cff@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 26 Aug 2026 12:17:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+82WhVmdK=MT8oyuZ=d=Lb7adwEepmTx4JKebh-bqRg@mail.gmail.com>
X-Gm-Features: AcwNN1XVhFh3nFaaB5EpSZughSsqDc3uvAx5MZLQaiHg6Md-aDFOcSXi5vYryYg
Message-ID: <CAJZ5v0g+82WhVmdK=MT8oyuZ=d=Lb7adwEepmTx4JKebh-bqRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI objects
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Daniel Scally <dan.scally@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:04=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 25 Aug 2026, Sakari Ailus wrote:
>
> > Hi Rafael, Ilpo,
> >
> > On Tue, Aug 25, 2026 at 03:08:07PM +0200, Rafael J. Wysocki (Intel) wro=
te:
> > > > If there is a cleanup.h "free" that can only be used with objects
> > > > returned by acpi_evaluate_dsm_typed(), I'll be fine with that.
> > > >
> > > > Or if everyone agrees that doing
> > > >
> > > >     union acpi_object *out_obj __free(ACPI_FREE) =3D NULL;
> > > >
> > > > is not confusing and fine, I may just say "Hey, I don't care that m=
uch".
> > >
> > > And particularly there is this paragraph in a comment in cleanup.h:
> > >
> > >  * Given that the "__free(...) =3D NULL" pattern for variables define=
d at
> > >  * the top of the function poses this potential interdependency probl=
em
> > >  * the recommendation is to always define and assign variables in one
> > >  * statement and not group variable definitions at the top of the
> > >  * function when __free() is used.
> > >
> > > regarding a broken code example, so I would think that this is not a
> > > made-up concern.
> >
> > That's indeed a valid concern, still quite unlikely in practice but
> > probably hard to find when it happens, so avoiding that is definitely
> > preferred. That being said, the biggest trap in cleanup.h is probably i=
n
> > scoped_guard(), and doing __free() =3D NULL somewhere doesn't matter mu=
ch in
> > the end.
>
> __free() =3D NULL is not that hard to catch during review (or even in
> code already in-tree), have done that dozens of times myself by now.
> Checkpatch, too, should be able to catch that easily, if it doesn't
> already.
>
> None of those cases I've commented on had a bug, so it was just for
> teaching submitters & readers of that code the correct __free() pattern.
> I think the concern is largely overblown given how rare actual bugs are
> even if the wrong pattern is used. Put that to contrast to memleaks found
> on our rollback paths, __free() looks a clear win despite very rare to
> occur caveats.
>
> Given what I've seen, I'd say on dangerous level __free() =3D NULL is
> somewhere around using MAGIC_SIZE_DEFINE instead sizeof(*obj) when doing
> mem allocs. It usually isn't buggy even if we don't want to teach people
> to use it.
>
> Besides, it was actually Rafael himself who brought the unsafe pattern
> into this discussion (I immediately noticed the problem but since it was
> not an actual patch, I didn't raise a concern). Sakari's patch did use th=
e
> correct pattern (and if it wouldn't have done so, there would have been a
> review comment from me ;-)). In my reply to Rafael, I intentionally left
> the right side open with "=3D ..." to not place that NULL there.
>
> > In this case I'll just call ACPI_FREE() sooner.
>
> That works too in this case, yes.

So overall, something like this can be defined

static inline void free_acpi_object(union acpi_object *obj)
{
        ACPI_FREE(obj);
}

DEFINE_FREE(acpi_object_free, union acpi_object *, free_acpi_object(_T))

and used along with acpi_evaluate_dsm*().

Moreover, a wrapper around acpi_evaluate_object() returning a pointer
to union acpi_object on success and NULL on failure can be defined and
used along with the above.

IMV that would be way cleaner than wrapping a raw cleanup macro around
ACPI_FREE().

I generally think that there needs to be a wrapper layer around the
ACPICA API, so drivers don't need to call functions returning
acpi_status directly, for instance.

Someday we'll get there.
