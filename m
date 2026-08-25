Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591FB484236
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668998; cv=none; b=BHjwTL8VgEBNzLTF06dlubJp0F4/vntcEnl1fB7RTt4i7c3frVz6fAqc7GZdx5Mg052f4PAii59tmuP1ACNLdaktZijb8yiytvcVWA/L20or3giwam3YHtuuczMuPXoTQxGf/ASJ0X3wx8dwmxHM/j2NmI2iCcizMckahvY8qQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668998; c=relaxed/simple;
	bh=wch87i9yJYzX6N4Tw9uzlMwiZrqht4WcrmhzTQ4ye38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvK5J0f1//rTV6kBa/ye7XJ7Lu36xbsD9nnWMVf3BvWh2jWF2ZmydWsjAdi3DqmZaTaUL7olPYGl9pKFnUEPs+97EMlvj7YZrpqwMUTwgmKCXcmDa/psiTO5f+ek496E4Bhn56JFaDwbkbOkZ8+zF49XdepXerzm1v3xCQ1ErHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBVp3+rh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBVp3+rh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122BB1F00ADB
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787668996;
	bh=wFVBzOqPc8UOPhde8GY7epvGk77JTDfDkKrM8bjfz9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dBVp3+rhMhgESq5Bk68zaGBVsPUVuGiSYAZXJ1JjYilUYEoou8PKBwgPk759hpJMd
	 nK8udHHCOWHU7vRyesvhWnyXUg70xdeEiEYnRgR6Z1hhXyhw7tQxgnYyQqjEZXOvyC
	 qEQOKVb8iTrT63/GBFNj16jtNBeyeRo4aYjxKkjfl+EQ57NwqJ3IrivBEXSYU52+t5
	 h3j3BFUbt3QdnH8orji+ByALcgpt6XGHb/g+FS6DLxDiHT85iOzM+kdmMHKQBVC98h
	 umJUaETul4dY3tBEHo89k62YjT15weBS/CLFdqJxTE7lng5vQwCypZl0DpLEoDPB5f
	 ay8cLHwl+3xsg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b49fee1ce9so421995e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 07:43:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqWJta3QWhw5sjMHYgE7jHidv8t6gKMYZ3BwjZrWe86LsvZ9JlIcuVBBjyQwjzfoAhsjI+rWwoPZHlz@vger.kernel.org
X-Gm-Message-State: AFuF++kpF9CLDd+EZum3/jIsgGOyozLm5JGZ1CfG6jtNcP7yFjRzeeYI
	Ci3yP1GbW/vwJkr5OjBqBSdbO+avv1xBBcOTMYdnRZpBR6+AojqbJKVC3a8tZ39ApIoRGWO7c48
	9bVFHsPFnJNi4W6xXsoM4OY+BxfD1K44=
X-Received: by 2002:a05:651c:b29:b0:39b:2757:c1d3 with SMTP id
 38308e7fff4ca-3a1aec08881mr83137611fa.9.1787668994165; Tue, 25 Aug 2026
 07:43:14 -0700 (PDT)
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
 <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com> <831afa75-ab9f-b54e-a5a5-6b46f4fe26cc@linux.intel.com>
In-Reply-To: <831afa75-ab9f-b54e-a5a5-6b46f4fe26cc@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 16:42:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYNQgrKfH0Jpv1g1Ja3d=vA8+TWpWKaipivjd0iN-gUQ@mail.gmail.com>
X-Gm-Features: AcwNN1WzxmKSLqDHEdyKyFwsm9FCSoLC9qlNcs_i000cZYtvQgZf5gLQKfFi4kg
Message-ID: <CAJZ5v0iYNQgrKfH0Jpv1g1Ja3d=vA8+TWpWKaipivjd0iN-gUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI objects
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Daniel Scally <dan.scally@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:51=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:
>
> > On Tue, Aug 25, 2026 at 3:02=E2=80=AFPM Rafael J. Wysocki (Intel)
> > <rafael@kernel.org> wrote:
> > >
> > > On Tue, Aug 25, 2026 at 2:32=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:
> > > >
> > > > > On Tue, Aug 25, 2026 at 2:07=E2=80=AFPM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > >
> > > > > > Hi Rafael,
> > > > > >
> > > > > > On Tue, Aug 25, 2026 at 01:51:18PM +0200, Rafael J. Wysocki (In=
tel) wrote:
> > > > > > > On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
> > > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > Use DEFINE_FREE() to allow ACPI objects to be released auto=
matically.
> > > > > > >
> > > > > > > But at least some of them are allocated by ACPICA functions l=
ike
> > > > > > > acpi_evaluate_object() and so they have no proper constructor=
s.
> > > > > >
> > > > > > You could still assign the return buffer to a local variable. I=
t's not
> > > > > > ideal API-wise though.
> > > > >
> > > > > Exactly.
> > > > >
> > > > > > I'm not quite sure what was the point you wanted to make but I =
reckon this
> > > > > > wasn't an ack. :-)
> > > > >
> > > > > Using the _FREE with variables that are not initialized through a
> > > > > constructor is questionable, so this is generally not particularl=
y
> > > > > clean.
> > > >
> > > > The driver does call ACPI_FREE() for that pointer so clearly it's a=
lready
> > > > using something ending with "_FREE" already. So unless Rafael is
> > > > suggesting ACPI_FREE() should be renamed, I'm a bit lost what that
> > > > even means on concrete terms.
> > >
> > > Sorry for the confusion.
> > >
> > > I just don't want people to do things like this:
> > >
> > >     struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER };
> > >     union acpi_object *out_obj __free(ACPI_FREE);
> > >     acpi_status status;
> > >
> > >     status =3D acpi_evaluate_object(handle, METHOD_NAME, NULL, &outpu=
t);
> > >     if (ACPI_FAILURE(status))
> > >         return AN_ERROR;
> > >
> > >    out_obj =3D output.pointer;
> > >
> > > > > There is no cleanup.h in ACPICA that is a more traditional C code
> > > > > base, so mixing up ACPICA code, which ACPI_FREE() is strictly
> > > > > speaking, with cleanup.h stuff is not particularly straightforwar=
d
> > > > > IMV.  I'd rather not do it.
> > > >
> > > > Perhaps add the DEFINE_FREE() into int3472 driver then, it seems to=
 be
> > > > what intel/pmc is already doing (I don't seem to anymore recall why=
 it was
> > > > added there). Using cleanup.h for that variable it clearly simplifi=
es the
> > > > code flow.
> > >
> > > Well, fair enough, but as I said elsewhere, the code flow
> > > simplification can also be achieved in a different way.
> > >
> > > > It feels a bit stupid to duplicate it there but I guess we'll
> > > > just have to live with that if there's no place in any acpi related
> > > > headers for cleanup.h.
> > >
> > > If there is a cleanup.h "free" that can only be used with objects
> > > returned by acpi_evaluate_dsm_typed(), I'll be fine with that.
> > >
> > > Or if everyone agrees that doing
> > >
> > >     union acpi_object *out_obj __free(ACPI_FREE) =3D NULL;
> > >
> > > is not confusing and fine, I may just say "Hey, I don't care that muc=
h".
> >
> > And particularly there is this paragraph in a comment in cleanup.h:
> >
> >  * Given that the "__free(...) =3D NULL" pattern for variables defined =
at
> >  * the top of the function poses this potential interdependency problem
> >  * the recommendation is to always define and assign variables in one
> >  * statement and not group variable definitions at the top of the
> >  * function when __free() is used.
> >
> > regarding a broken code example, so I would think that this is not a
> > made-up concern.
>
> That comment relates to how defining the variables at the start of
> functions may result in wrong/unexpected cleanup order. More imporantly,
> the comment is not an argument for not using __free() but an instruction
> on what is the correct pattern to use it so those ordering issues do not
> occur.
>
> The cleanups will execute in reverse order the variables where defined so
> a variable defined at start may be cleaned up only after releasing a lock
> that was taken mid-function (which often is safe but one can easily
> envision cases where the lock should be still held when the cleanup runs)=
.

I agree with all of the above.

Though I think that cleanup ordering issues are easier to overlook
when the "__free(...) =3D NULL" pattern is used, which is why I wouldn't
like to encourage using it.
