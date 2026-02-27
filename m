Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA4B453493
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224763; cv=none; b=t8Yoz7lBgFTUODiUsjxnFPuGL9j0c2AKeYHGKuja5lJguINjtUMAoEreEQDoFj2Jyy02SBbR2GzpW4gMV6CNzi6+cpfp3lk6nY+cq8pEBTrgOYCjERfOi/vHCPaLp2lq+RJOXax0qrSfo9JOoFUCNaBC9p6Dagj8H60IBM9DA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224763; c=relaxed/simple;
	bh=6AdUKpKiYsXqGo/mY/vHMu0nT7ukrT9GDbr4FQ+OAjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRoarocFBI20NEFJe6uQk/5eKt1ESsjGeQySA5DZ1Jc2U/VdOJ7TR93bWbzuuAdVzqXtO/fpEaKvL/rz3t4ujuFGHXIjdufX4l76UEplvFvqtNkcedSicmvbs7Q4THYJARjw46xutpafXkj+LI2OuhP6TgIohfLzkIJ2cwCek6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfvaVjWp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfvaVjWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16726C19423
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 20:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772224763;
	bh=6AdUKpKiYsXqGo/mY/vHMu0nT7ukrT9GDbr4FQ+OAjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RfvaVjWpotzQzpzzCr2JRnxWlVfxZ9puwjFwX978E6NtLMCBJIZJ0+afoIeu8YYnF
	 BljF5wCwaPrglmYNfC4mZuFG9vqHapkYQ93DLT99dTMrKohJ8mJ4KfH6XDz3MzhwTO
	 EwHZgIK20a1NH9z4GMRQPuMCjZqwmz0KvAWZ/10iQbIade4R77ZBfYNPtFFBdVCpnY
	 d5EytFKWH8yDlPTudCrulurfUE5AaX+zgL78Nav28ZI+1lLR8R8EXIvz3EdxKe+jbs
	 oFl3PepgwjAvrwemV8QYcvWj0cBvZTCaesogYXPcVjkNkJkKLtEA8ULbbSh4tCQuTQ
	 UVLYoZ3/4xjtg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4be94eeacso2146007a34.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 12:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDX0Z9ibSu7z0KYZiceh7Xn3CfelcXbGZ05JgR3IUWR57B1o1z6e6JJgQ9PBgLfc3Db7N4+w80sZlz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/wI9XNEkn6S3jo+Svn0U2EAMS+02z9+o/O1ppGQK6e9vtdQm
	eHR2PJyrghERHCSRO6SR8fa3YzPklffdhhvJ7clzwjyfEXhfp7YBG8HYZ5/dNIMXVl8QJNaakqw
	N7kgzOe1NpGyobPhnkm01SuilNCBHmPw=
X-Received: by 2002:a05:6830:63ce:b0:7cf:d119:8d93 with SMTP id
 46e09a7af769-7d591a0bc67mr2451415a34.0.1772224762229; Fri, 27 Feb 2026
 12:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204212931.3860-1-W_Armin@gmx.de> <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
 <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com>
 <6825e6b2-802b-4cd2-b2c5-b4eab67b00e4@gmx.de> <CAJZ5v0h7Nc2gUr_WaJSL4vEekhfL_4aojDWdkidnS=3T-=uxRg@mail.gmail.com>
 <c663548b-29ee-4d23-a6b7-9a88eab5470e@gmx.de> <e7ba6414-a1f3-4e49-a3af-3a8592a46a99@gmx.de>
In-Reply-To: <e7ba6414-a1f3-4e49-a3af-3a8592a46a99@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Feb 2026 21:39:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jwE_CYDAxT3OYx4+i4nk1v2TTuyFHbzCKXVD0j5mBuiw@mail.gmail.com>
X-Gm-Features: AaiRm51iwGFCTt8H0lLQ9HamBk_cna2fmE4ZFfBfpfyTpN2nlmUixgNGMkDOXKk
Message-ID: <CAJZ5v0jwE_CYDAxT3OYx4+i4nk1v2TTuyFHbzCKXVD0j5mBuiw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI error
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 8:55=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 27.02.26 um 20:50 schrieb Armin Wolf:
>
> > Am 26.02.26 um 19:46 schrieb Rafael J. Wysocki:
> >
> >> On Thu, Feb 26, 2026 at 7:35=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wr=
ote:
> >>> Am 25.02.26 um 22:28 schrieb Rafael J. Wysocki:
> >>>
> >>>> On Wed, Feb 25, 2026 at 12:06=E2=80=AFAM Armin Wolf <W_Armin@gmx.de>=
 wrote:
> >>>>> Am 04.02.26 um 22:29 schrieb Armin Wolf:
> >>>>>
> >>>>>> The ACPI spec states that the operating system should respond
> >>>>>> to a fatal ACPI error by "performing a controlled OS shutdown in
> >>>>>> a timely fashion". Comply with the ACPI specification by powering
> >>>>>> off the system when ACPICA signals a fatal ACPI error. Users can
> >>>>>> still disable this behavior by using the acpi.poweroff_on_fatal
> >>>>>> kernel option to work around firmware bugs.
> >>>>> Any updates on this?
> >>>> I was about to apply it, but then I thought that I was not sure abou=
t
> >>>> the Kconfig option.
> >>>>
> >>>>    I don't see much value in it TBH.  If you agree, I'll just apply
> >>>> the
> >>>> patch without that part.
> >>>>
> >>>> Thanks!
> >>> You can drop the Kconfig option if you want.
> >> OK, applied as 7.1 material.
> >>
> >> Please double check
> >> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/co=
mmit/?h=3Dbleeding-edge&id=3D6f09a7009a1d7a132ddce3a8dd0c46aac66ad8e2
> >>
> >
> > Looks good to me, except that the include of kconfig.h should be
> > dropped now.
> >
> > Thanks,
> > Armin Wolf
> >
> I also just noticed that we still need to include panic.h for add_taint()=
.

It complied regardless, likely because kernel.h was included, but yes.

> Should i send a new revision?

No need, I've just updated it by hand and pushed it out.
