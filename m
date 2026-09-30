Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDCC4E36D0
	for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797137; cv=none; b=muFLF8H8dXGxgNUmCodJ3Iocb4cY/ni8nRVG6p/m077skGuPjjWZi+vx9xLJ6G6mJzulXzV7iaIBc1wQxkJC4UBh64DdE/9LqYR8oqxwxinV/C5qgft1ovo6gaC/TzDkeMqC2Scad+84jt6Hg8pvFiY6/VsRqpP/jCJ6oN3ZevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797137; c=relaxed/simple;
	bh=qEppF1wtROGh18AU5y2B8FBqsoM94EvZAzeKfrkk3jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5kTbWFlmhNm2pN95nVlHcSl7jqvxWnL6Z+TNUH3eqDdD0xwweWcc+5YyIGgRKkDcdkMjaL6ndtAZBUq03nX6jnAV/mn9S48tR2C04Seq+VRbq4tlswDrRI1oxwLoweh0vDYDhuHND7Te6FeiTyNT7z2s6gOBxky2SKl77sMiV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1U/ywZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1U/ywZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F11F0089B
	for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797136;
	bh=8Je3TKW6mDtA9RrqaQMnwSzR2irBizMaSxHCErbT//E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y1U/ywZYNESF14kINBto93A6xhIrIlefFqRf60ijCCOKbtHUYtqU/FoLosB0jH7tt
	 iMgdzykjIuIKZtAvJZ9Fmg694tDb+uAVSHK3Bwv96eI9Wg7CzSubcojQJjzixQrAWF
	 xIgGJk3ldbhauFtrGSQ43tr6W8PE6Dii8bHRotx2jUGpOm0GC2gc9MEzvKXbpPflpy
	 KjrVnVXTrzoRqtwRY2WcGYLlRIy1yTpjslZqR7j5GQB4Cm/U2JAwn0luyAV3Vw0TCf
	 hbLrgX1JmwJ+UvCSOQ1LFnC4Zr+CZauI1RuKc1Nz1xyzVjf8uqLLoorbC4jDoByIvS
	 ITFN614cis8ag==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so5298808e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 12:38:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzfWx9p6Hi/24jX3R09HR+X52pV/A4KhMK0uCrsgc62SOYn+ZoGf0H5dJVOGpLeYra7C5MhWNuNthHs@vger.kernel.org
X-Gm-Message-State: AFq9FYJg+Q+f5QR4aokr+OLTuu1JNbQ7DypYc0f8++MP7qqjDNhzKDB4
	Eh0nZORZT6nqu8BDJeI02KC7VaGQSS3IFSAoUP6DeVnhb3KMAYAfJtbae0XcrB7o8jrmdAKEULF
	37cEfvTUjbgf8ngRhWIPx39ae4PVJqn8=
X-Received: by 2002:ac2:4c29:0:b0:5b8:bc5e:b576 with SMTP id
 2adb3069b0e04-5ba40612544mr668515e87.46.1790797134250; Wed, 30 Sep 2026
 12:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924160052.2858456-1-superm1@kernel.org> <20260924160052.2858456-2-superm1@kernel.org>
 <213bc2ba-2ee4-4a89-9054-3bd953546789@arm.com> <c20aa0b6-30a7-4c88-80e0-21bd5e97c0c8@kernel.org>
In-Reply-To: <c20aa0b6-30a7-4c88-80e0-21bd5e97c0c8@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 30 Sep 2026 21:37:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYf1dXVX4LFeWnnsatA8b0LahRfJUe8hH7-978z+nKxg@mail.gmail.com>
X-Gm-Features: AclHuK_IQd7EoyZptxoCUg3bgzT-8ulRUStswYqJCMm1GsL6MIhRdqnNJYlVic4
Message-ID: <CAJZ5v0iYf1dXVX4LFeWnnsatA8b0LahRfJUe8hH7-978z+nKxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: CPPC: Refactor boost ratio handling
To: Mario Limonciello <superm1@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, =?UTF-8?Q?Rafael_J_=2E_Wysocki_=E2=8F=8E?= <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 4:54=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 9/25/26 04:40, Christian Loehle wrote:
> > On 9/24/26 17:00, Mario Limonciello (AMD) wrote:
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_pe=
rf()
> >> to better reflect that it returns the effective highest performance va=
lue
> >> for a CPU, accounting for preferred cores and heterogeneous topologies=
.
> >>
> >> Add a new helper amd_get_boost_ratio() for doing both for boost
> >> ratio calculations and update callers to use it.
> >>
> >> This refactoring is needed because on some AMD systems (Zen6+),
> >> the boost ratio should be calculated from frequency values rather than
> >> performance values.
> >
> > I think I see why you chose to implement it this way (the x86 APERF / M=
PERF)
> > issue, but I'd still prefer it to be spelled out here why this is neces=
sary.
> >
>
> Do you mean in the commit message, like spin the patch?  Or just in this
> thread?
>
> Not all cores will operate at the same frequency and fixed scaling
> values from CPPC perf don't apply anymore.

Well, CPPC is per-CPU at least in principle, so the above doesn't
explain much TBH.

It kind of follows from the cover letter that there's something
missing in CPPC, so this is a stop-gap thing, but it would be good to
put the information from the cover letter to the changelog of this
patch.
