Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35D4457CD;
	Tue, 25 Aug 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665076; cv=none; b=PUGx8MJrwjcjR6hdi2HMyp8xMv/2HNducz+FheMwOlqPHmHznpehysvvfMvtFuFBHRmINSUvsVV4dLEOBSSc0eat1Hye0dvcD0sFdugwR6Z4942zXualoq6mpx8UtTssMX24lElCQHLaO4QM5XrZArJmgvOUUxAC0mesjg/Grl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665076; c=relaxed/simple;
	bh=hI0XRbcM7oEmfwkhQe1CyI3KPZ/oa0Cz7NmKm+iRMgs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tewWEYAIpUruO/zHu086khpXeUM2f8nMpjVmcntJkuE63WJJuUU+WNj9YNKV5nFikDO6i4VkVt+AveyEJXvT5rJB3Q0UOIPHa9Me0CTJ8kbJkaYrKEv/15Ghn8L3AcyfEQLoZdKPwlIUkB1b0hvdQqpUXkt3zZgInNc8sdwye8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8bxF0/l; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8bxF0/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787665074; x=1819201074;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hI0XRbcM7oEmfwkhQe1CyI3KPZ/oa0Cz7NmKm+iRMgs=;
  b=l8bxF0/lY/WWo7/cG+8tmTBBhXa1PmOuZ1CWbhAu95i7BnTw9DXTI2gQ
   8IiBzP1f3E+CvDSixW5wxzZpg54j9dc/8Mpc5svyIpPfSzS9eVyhC6k8n
   4DouvBX0xcYudvja6UXf39bqziCuGYzFol4+WhWWvFeyS/DyP30WRAoQf
   PJ4r8UXWPxSQvGaIssZ4LNr6sVIewzvbrBrwWrZCRe47iD/P0xfMrJMml
   cNtp0pGJ52yn7CPCn4gLNCBqlr+UQwP/p+LnN4lAcLnSIv+SqE0SBsBKl
   jw5F/paUZdXPAfT6mGwi98Ccx75pcJSyahUxUI1/5vPRjkCG8HcIzSv7C
   g==;
X-CSE-ConnectionGUID: RpR4N9SNSOeq+ZGotz4LDw==
X-CSE-MsgGUID: AUc01B28RO2G0vGBRQ/XSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91997012"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="91997012"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 06:37:53 -0700
X-CSE-ConnectionGUID: mx6mv9qGSqi+OvrMCEiuUA==
X-CSE-MsgGUID: FZS7ZTcES26/vBUkvWSb9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="271090268"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 06:37:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 25 Aug 2026 16:37:46 +0300 (EEST)
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
    linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
    Daniel Scally <dan.scally@ideasonboard.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI
 objects
In-Reply-To: <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com>
Message-ID: <3aad6baa-6b19-b441-d294-5a656ef190a5@linux.intel.com>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com> <20260824211338.3583976-4-sakari.ailus@linux.intel.com> <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com> <ao2FmNRFjSJVxhrL@kekkonen.localdomain>
 <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com> <134e9566-7913-86d7-1e8b-b2ca9ebec55c@linux.intel.com> <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-636865285-1787665066=:1165"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-636865285-1787665066=:1165
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:

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
>=20
> Sorry for the confusion.
>=20
> I just don't want people to do things like this:
>=20
>     struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER };
>     union acpi_object *out_obj __free(ACPI_FREE);
>     acpi_status status;
>=20
>     status =3D acpi_evaluate_object(handle, METHOD_NAME, NULL, &output);
>     if (ACPI_FAILURE(status))
>         return AN_ERROR;
>=20
>    out_obj =3D output.pointer;
>=20
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
>=20
> Well, fair enough, but as I said elsewhere, the code flow
> simplification can also be achieved in a different way.
>=20
> > It feels a bit stupid to duplicate it there but I guess we'll
> > just have to live with that if there's no place in any acpi related
> > headers for cleanup.h.
>=20
> If there is a cleanup.h "free" that can only be used with objects
> returned by acpi_evaluate_dsm_typed(), I'll be fine with that.

So you'd be fine with something like this:

      union acpi_object *out_obj __free(some_other_name_than_ACPI_FREE) =3D=
 ...

?

> Or if everyone agrees that doing
>=20
>     union acpi_object *out_obj __free(ACPI_FREE) =3D NULL;
>
> is not confusing and fine, I may just say "Hey, I don't care that much".

I personally don't hang myself into "free" or "constructor" terminology=20
but look it more pragmatically, if ACPI_FREE() should be called before=20
the object goes out of scope, __free() is a tool for that.

Have Rust people tried to wrap this interface already (there seems to=20
acpi.rs but it seems very limited in scope)? I'd expect them to be just as=
=20
interested in knowing what to do when something is at the end of its
lifetime.

--=20
 i.

--8323328-636865285-1787665066=:1165--
