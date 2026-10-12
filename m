Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64436397E86
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831606; cv=none; b=R1CM+lWHl2MzKo6V92zSLohc8wrDxLbxxSldxyQKqNz1kUuYsn8BuN3LxWmXCuyvfgXmiHKzG2vn32P2ubB9eKVMJ1hGhWeV5oFS218f0ECih3y/gi5LoMKkzDLQW8i93N9qAQhwpe4MAXml5zgjozToy/UH/NqwchR0zshA7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831606; c=relaxed/simple;
	bh=V7icQUpG/n/mpwO4qJo7e1Xfq12TP/Jwl+BE5t7RigQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6dnF9xVE2poP3+Oxu+3grHR7CRJdeep4HT4d1cwSgAGCbXS1ziOtUajiVeujejAbXoCypsXO70IjE5p2/d/zt3vVdvbOmGMbItSJpiz3+RepB0uQ2W/NoXp60MV1/kaDjbsazTjJOCcZayJLPCmnYHgakkogxtr5PIJizWaI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWslXAwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWslXAwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4FA1F008A2
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831605;
	bh=V7icQUpG/n/mpwO4qJo7e1Xfq12TP/Jwl+BE5t7RigQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XWslXAwQWcIy7VrQzStgtQcmKIJMHy0hRLRg2xe76g8DKiEHTxaRy2P9yJilCGPep
	 Ss0OO/aKr8yqnCmYKUw5RfuaZFl1tN4y1B4KQgoDeulEfQz775W2OQSQIQcLhevNBY
	 pp5EZaeU7gcfHbI91JjpZww8dtwVXVBX8IBbMlk6/zgLMnlldtk5anu8/As218vwQA
	 DMJXQZjhTyrsCBSs2FdsIDHlcN+lZuTmTtv5JVbnpQewId0psnektdda14wyYUfi/f
	 3IlxYG8SulfmTysqXYTbwisYSZeMvLwPb8dMOb7zzY5g7vtnv0g20kTfiVQT3yPG0h
	 QFeXtWdElie6A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba3adf78f5so1841840e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 12:00:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwURfJO7eufyBOuDZhQL2eaiRf9n8yr5Ar9U5Dse9v3KhwLksvJJYx7sdWy4NsYCG4ybRLdgGA/Z00x@vger.kernel.org
X-Gm-Message-State: AFq9FYKcWwZxSTBgSl3mMkB2Hx0dsJCValaUVTyq/0QM+wlt6PZEXyRw
	N8LRoL5OpNKeqKHw4v6WPJ5LC0d6+U7ECEWgRxlNvLogmyxLrOwVnqbk5pRABV4t54W0i6TTrN2
	17/8CSSnL3/QSteB/UcMpVvEBSy005lg=
X-Received: by 2002:a05:6512:3b8a:b0:5ba:43ff:3bc9 with SMTP id
 2adb3069b0e04-5bcde35f412mr3811716e87.3.1791831603447; Mon, 12 Oct 2026
 12:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009232955.866131-1-jamien@nvidia.com> <CAJZ5v0ghc7Ks=nMNwtvm9727NbUQb0XDEu4GrXiEcaDELgRk+A@mail.gmail.com>
 <20261012185148.3192127-1-jamien@nvidia.com>
In-Reply-To: <20261012185148.3192127-1-jamien@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:57:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hM+6RvyXwG89Jyyu48jxSejNwsDt-H=2Y2dkt--af2QA@mail.gmail.com>
X-Gm-Features: AclHuK843aRLZ4O8zip1aKZmSlwaUYbNOm49ZFUEBf9wNbZDuigfK4o4zsi_hQw
Message-ID: <CAJZ5v0hM+6RvyXwG89Jyyu48jxSejNwsDt-H=2Y2dkt--af2QA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: Expose BDAT data region
To: Jamie Nguyen <jamien@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:52=E2=80=AFPM Jamie Nguyen <jamien@nvidia.com> wr=
ote:
>
> On Mon, Oct 12, 2026 at 11:15 AM Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > Please see the Sashiko feedback on this patch:
> >
> > https://sashiko.dev/#/patchset/20261009232955.866131-1-jamien%40nvidia.=
com
> >
> > and let me know what you think about it.
>
> I agree with the Sashiko findings, and it looks like BERT and CCEL have
> the same problem, going back to commit 7dae6326ed76 ("ACPI / sysfs:
> Extend ACPI sysfs to provide access to boot error region").
>
> I'll send a v2 with a preparatory patch that moves sysfs_create_bin_file(=
)
> and the kfree() on failure into acpi_table_data_init(), so it is fixed fo=
r
> all three tables, with the BDAT patch on top.
>
> The other concern in the report, the direct returns in the
> acpi_tables_sysfs_init() loop, was there before this patch, so I'd rather
> handle it separately if that's okay.

Sure, thanks!
