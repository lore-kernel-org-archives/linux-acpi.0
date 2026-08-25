Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809538F938
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660354; cv=none; b=MJvCoFY6d5ilJs5kYcWNvInanvkqOiD5WBu8sGKvT0xGIPbKR3CoGvc+HCNv3zYBCQJTqWnC34QvJwB/haoSlINMfKg3ldYknDHlZvkldNLauMk9p57HrqYBEWh0gOXu+nBsu7o+/Af5U+bBH+TJ4Mj0JKEAtVfJ5IbGmqoJs5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660354; c=relaxed/simple;
	bh=0UgWnf10QgL+IwsLVVeQQPm78lDk3BGYoexA9nJVtco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni5YlrZvEgHkVbgRcVHNSUUN9gGUxLssaXuS+AjksLjFrIdhwMPpzKh+gouktwwjVWCF9bP7oBAmB5UE5JOYzVVFuHJEIxcs2AF5TmL/LyWMqdseQCZRF1ieI20LjxJY/oxB/w+GIKhbaih+qgoc1Urf1wgXSbx2L785mBrzrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVt7op0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVt7op0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6898A1F00AC4
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787660349;
	bh=/Ub3Hg2VlUI9r1R58NjfZNRJNEx1WUBh1o/FodIcrlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mVt7op0Z7yo7+CRpBbPEK4QuFlT1Bsee0fAvIfpJ9W6Rr21KeniFEYJaC4Cuxt7iu
	 4nfMAz67MtgfdOspsYoC/FxMNaDck7NQoTv+N7LwMLOGk/e0L+R8WFVJWReO9oBE24
	 ADkUIQLrZ+qMVMPPtAfhEBmcK6lwMeOW5Dk5D5QcHjCfF9VL/vwpW1CcRpnPhjQd+K
	 neBehOtgau8y8YKBNAyQoEVXmY/SM5wpN88O4UH2+3Zouznnhc4/xu7/iM7vFmA7X3
	 OzdksqFScMESV4OXQlV/0bcGCnySlPgBsepp8Fbxl7pr02fFBRNjCpBHZ//BJkh+X4
	 xX5nByEzYXhgA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c953950dfso35094981fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 05:19:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqSFvdVCjUWH3GWF/ESRHhzc+WXAAIhfCTBO4pQ3HQP5xk+txpIDDY7KX3t+54R+3in6ztgvMfibuyf@vger.kernel.org
X-Gm-Message-State: AFuF++lplvYgt/bg0MrIQDxNdmOf+WKsEJQX6gdoboOoFghVTjII6K1t
	+t00XfPpgSvh1aWRymjrRg/AF82Ulv2vjSC5CLlD4i5+5d+d2oFJRo6qBF4QQk5VB/sP6NqZ6m3
	rcoXiR6y/Jv2t4QBV2n6ShRSdXxfsAbk=
X-Received: by 2002:a2e:b889:0:b0:3a1:5cd1:9f90 with SMTP id
 38308e7fff4ca-3a1aeb5d50dmr79046731fa.3.1787660347742; Tue, 25 Aug 2026
 05:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
 <20260824211338.3583976-4-sakari.ailus@linux.intel.com> <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com>
 <ao2FmNRFjSJVxhrL@kekkonen.localdomain>
In-Reply-To: <ao2FmNRFjSJVxhrL@kekkonen.localdomain>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 14:18:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com>
X-Gm-Features: AcwNN1VHed9q1EQBzb9P_9pLlZhzeBRSuyvZ604o0hXk3nKE99z3QpwxcPgcG_Y
Message-ID: <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI objects
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-media@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:07=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Tue, Aug 25, 2026 at 01:51:18PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Use DEFINE_FREE() to allow ACPI objects to be released automatically.
> >
> > But at least some of them are allocated by ACPICA functions like
> > acpi_evaluate_object() and so they have no proper constructors.
>
> You could still assign the return buffer to a local variable. It's not
> ideal API-wise though.

Exactly.

> I'm not quite sure what was the point you wanted to make but I reckon thi=
s
> wasn't an ack. :-)

Using the _FREE with variables that are not initialized through a
constructor is questionable, so this is generally not particularly
clean.

There is no cleanup.h in ACPICA that is a more traditional C code
base, so mixing up ACPICA code, which ACPI_FREE() is strictly
speaking, with cleanup.h stuff is not particularly straightforward
IMV.  I'd rather not do it.
