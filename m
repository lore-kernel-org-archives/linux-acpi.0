Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935545A287;
	Tue, 25 Aug 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665879; cv=none; b=VOJDyIMOpqTdJlZrvGYlB2ZmzzOJJGzRqGykFN7TbfmSsNY8O2igS+LP2pVpvx12gyf6wzUxi4pWC2lx8y68zTFrCbKkTsQYjDiR2ZftQ7yyF4FnftVXgn7NXucq7IPVZSIS6G07JEvxW0lKJgjiQIf3CzQl1m9d5br5Lby3qRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665879; c=relaxed/simple;
	bh=tJND6aND2PywHJERPckQQl5cRba0RNyWcv7GeD802pM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oanWF5pTm+uUl4SKwq1pD80ztb0CUoFIhx6JyG7eXgnjC//LauArwPK4eAn8jQhbHbpIQSqLEQ/WoscBNHj4rb6g2cm6echkTe4NfcUk1++mvHpHn50yrHfmxy/KbARFk5EcBd0zMZDCsT8yLMEI6fm4lvXTRB1tVa247FWyfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/QQ4hzj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/QQ4hzj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787665877; x=1819201877;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tJND6aND2PywHJERPckQQl5cRba0RNyWcv7GeD802pM=;
  b=O/QQ4hzjS+3dOKZCSORo8SjX662og8VSVHFJhk2HCSoTc5RLdrbcUsGb
   QXsv1wKeqlnPPAVor9Oqm2LOVDLNkcpaR6os+AJ+QGngVm/qi+j19nAEe
   HwqeouZMV3PeVRNcCetH0IQu9T8QqLdynkxF3wuU9WPyWEIcqOnhAfdt2
   VDxsF/PHoAIFQntI6jLNScdjBKmMHnxmWXWiOu6OK38aCp3PtBcjqVRQL
   Q8hcw/bH5fYZb3jjD5fbGCdG1qbLbiwJBW9ibfY5cQQmAxtZRyx6T0ElO
   zlEr2yQ0z3NNdXPVpVZxN4HRDXJVe0PiTec8mxipAmC+yBoZ7D0ENZh2A
   Q==;
X-CSE-ConnectionGUID: bFKdu2qbSS6Df6L3Yba2cg==
X-CSE-MsgGUID: IEeUizN2Q72AqGnNmPk8Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88187312"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88187312"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 06:51:16 -0700
X-CSE-ConnectionGUID: j/Lmqp7hTqGhtLaJQwVWtA==
X-CSE-MsgGUID: Ls8fAcFGSdaQz/8xY15nYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="271495174"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 06:51:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 25 Aug 2026 16:51:10 +0300 (EEST)
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
    linux-acpi@vger.kernel.org, Daniel Scally <dan.scally@ideasonboard.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI
 objects
In-Reply-To: <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com>
Message-ID: <831afa75-ab9f-b54e-a5a5-6b46f4fe26cc@linux.intel.com>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com> <20260824211338.3583976-4-sakari.ailus@linux.intel.com> <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com> <ao2FmNRFjSJVxhrL@kekkonen.localdomain>
 <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com> <134e9566-7913-86d7-1e8b-b2ca9ebec55c@linux.intel.com> <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com>
 <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-58132523-1787665870=:1165"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-58132523-1787665870=:1165
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:

> On Tue, Aug 25, 2026 at 3:02=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
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
> >
> > Or if everyone agrees that doing
> >
> >     union acpi_object *out_obj __free(ACPI_FREE) =3D NULL;
> >
> > is not confusing and fine, I may just say "Hey, I don't care that much"=
=2E
>=20
> And particularly there is this paragraph in a comment in cleanup.h:
>=20
>  * Given that the "__free(...) =3D NULL" pattern for variables defined at
>  * the top of the function poses this potential interdependency problem
>  * the recommendation is to always define and assign variables in one
>  * statement and not group variable definitions at the top of the
>  * function when __free() is used.
>=20
> regarding a broken code example, so I would think that this is not a
> made-up concern.

That comment relates to how defining the variables at the start of=20
functions may result in wrong/unexpected cleanup order. More imporantly,=20
the comment is not an argument for not using __free() but an instruction=20
on what is the correct pattern to use it so those ordering issues do not=20
occur.

The cleanups will execute in reverse order the variables where defined so=
=20
a variable defined at start may be cleaned up only after releasing a lock=
=20
that was taken mid-function (which often is safe but one can easily=20
envision cases where the lock should be still held when the cleanup runs).

--=20
 i.

--8323328-58132523-1787665870=:1165--
