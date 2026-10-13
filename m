Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7153B95E0
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880804; cv=none; b=c8bwT2r7mpFLzhoBgRCCIFy/bdCz4BUBEsYoHF0xtSkEmvQx4ehvoDEeBBI9XJDgKWIP15se5tMR5QRKi8dTy2z55PADTihud87iakZNhW8JTew8D1xjGFw/+we1PIJW5OYrQ/6rKMSsaj4zca3BEdGC7hHam+gKX40/Ddw6k8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880804; c=relaxed/simple;
	bh=zYodpRJl2sTx4KeDMYM4tddxsAs05qKU0E+V6KZSlRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooKpIPj32iQwyxhfzXthI7wCN7jU4u7LzjswBGzOK3eVMDAE+oRDmVYeq2p0U2ldOcEA5aY4HDsHEbOCKYe4d9hkQWR5KO8Nlv444zMGvDYBsaU3CPkgYAO1/I/lsuWvN3J3QXsLO2vAK2NqmQSlxMyh1kSXwg0MKyuaR7XM1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdZedCPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdZedCPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DF31F008A4
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791880802;
	bh=zYodpRJl2sTx4KeDMYM4tddxsAs05qKU0E+V6KZSlRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BdZedCPeO9CwxRpDFBDz0VYWDfdqBszx8mATvuUddMSxUC8P5SrgsNWNfs/NL/Q/O
	 4IdihQ+BPI1U9ApanBGuC58E8E0GpuWfGTlRXVhINRKt3vam9f9hf1JGy1sdRCYwtU
	 3uu3d0w0vLAk46rlX9NjZJNgsSWhzinzit3+wi0Fzud2N7iwCTeur3ew6NZ4uqoepZ
	 WxfSiqvYkPWfBmoBzyxfnM11tf931JjZzrN0nlRO6XP81RubAIujY+MVgWU80bLpE5
	 Lmm3yKl+feMBzVeBScHr+bKjF2fPWYZuft1o4z5ErZ/xvpWNYXl1RHD5OMwcyNKDDs
	 Zck+arstH/VHA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so4024305a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 01:40:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwei8mi5zFTFYKIwGN74PPLdwmvbYp61WHAewX9qHCzzViM1OW47+F7h68VzNGJWO/748MIuJqJS5Vp@vger.kernel.org
X-Gm-Message-State: AFq9FYJWoZWPxIRAevRrR6P+VpSmVEfKTktyzbphvA2cx9scOZeJse0Z
	ZotOYTok6ythRPfkDz++77UriK5RWdc32AdW7tDjuyYExyBOvMvx9GMx+Sxm+zpMhizqDNeM3R5
	sXhB3NP8OMJNT2SzfyxoB7vK41wrB0rE=
X-Received: by 2002:a05:6402:21cb:b0:6b1:c355:c7b3 with SMTP id
 4fb4d7f45d1cf-6b1c355cdf1mr3702607a12.25.1791880800689; Tue, 13 Oct 2026
 01:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
 <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com> <CAJZ5v0gpFDaS8sLdDBbS4tU-F7fKPKOkXtb7nqjfNhagEB_Cgw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gpFDaS8sLdDBbS4tU-F7fKPKOkXtb7nqjfNhagEB_Cgw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 13 Oct 2026 16:39:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4hdq_2rGAw9LtCcxLUnQuKBgYTJeMXkAfjCuM+yck9HQ@mail.gmail.com>
X-Gm-Features: AclHuK9oQiH82PB9ry9ALpvacw_4qobdW-etWeXxZBWjotSguWim_HyWbwXpPU8
Message-ID: <CAAhV-H4hdq_2rGAw9LtCcxLUnQuKBgYTJeMXkAfjCuM+yck9HQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Bibo Mao <maobibo@loongson.cn>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:49=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Mon, Oct 12, 2026 at 9:21=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> =
wrote:
> > >
> > > This change is already merged in acpica tree.
> > >
> > > slightly ping.
> > I will merge the last three patches once the acpica changes are synced
> > to git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git.
>
> I've applied the $subject patch as 7.4 material.
>
> When it propagates to linux-next, I can expose it on an immutable
> branch if that helps, in which case please let me know.
If that commit is contained by the tag such as 'acpi-7.4-rc1', then it
is enough for me. The loongarch pull request is usually after the acpi
pull request.

Huacai

>
> Thanks!
