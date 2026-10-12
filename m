Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BA49365C
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816557; cv=none; b=tYIaTDFxt8TMQJE4BEPXiRYNoRPfZYZOB3k7mvjry5PG3j0/CcOQXRFn6SZEjXUAgme76bdacJ4yCd5s4BEgqd4rO4Of78roHI5Uv6TvoxSWXfI9M51ix9qVb4p+k0slPO75xzfd1RJy5w4+d//3nvgDeWiksgfKp+n+kKvYcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816557; c=relaxed/simple;
	bh=HSaqZ/vs2+B1i4yUCchBv9N9j074kQN43Wfdo51BDR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdCSqHsMl4HFQMdt4MEpdcCOeLpfWw7xbxlzm2AnBDl+O5QFp5+XFlmxERj/uJJDHtXEwBLxGGHXQaAwws2nQCVMKlfwTrVltbsAeR+q+ooVZALem1enIzlALOHJctecTNJdvZlTbEHd2Q3t1ABM2Jxj/CKIRUmEIwH42ZpIiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPZPQl7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPZPQl7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2481F0089E
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816555;
	bh=HSaqZ/vs2+B1i4yUCchBv9N9j074kQN43Wfdo51BDR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZPZPQl7NvfqRwodKtoxsYDEEQHsp56Kws6ml4P1Q8+nS/hrE9HZZ7AqHg/e+WXsG9
	 DKRVTolyVopvHMErEpbl0xCbJfKSCn6JvNdWNVpTg03Pa47q9Esd9p1HLO5V0s/C4L
	 POvps5/JJ/y7jrxQFag3HBQ4wVR2M5lu6Jz8B1wz3MZXIuhwoqWXMHKeh6toUFQdS/
	 ViBh9KRG9cWJrYDAhVqJN/kBCgj52oCGSnly9JhtKx0DBPHHrhN+Wc+zIj654HPZ2S
	 8ITdrEc1tfslVRPgdbMKY+ZMFCEVx+RAXNzCMUJxJImuNSrgnb1hbcom3+KaK2ZXC+
	 tYpqgZsAg/KIQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcb1f1358aso1265162e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 07:49:15 -0700 (PDT)
X-Gm-Message-State: AFq9FYIYLdBmjU19KDcDct/2i7KVT8gitz76dg0Zk557T+XHnWq6AlkO
	UhREi4ntTTwxeX9uNJ82pcIO34kdTX5REbG9CJ1WecZ/1fuTfo0mKWEWfCxYgQNJtEsp5ryg0YB
	IiIrpYAcCX2dL+gElAxyYtnjHGw/yjrk=
X-Received: by 2002:a05:6512:1302:b0:5b9:8480:88b0 with SMTP id
 2adb3069b0e04-5bcde6cd81emr3590336e87.46.1791816554296; Mon, 12 Oct 2026
 07:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
 <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com>
In-Reply-To: <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 16:47:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gpFDaS8sLdDBbS4tU-F7fKPKOkXtb7nqjfNhagEB_Cgw@mail.gmail.com>
X-Gm-Features: AclHuK_yh6nJbDMby3wJpiRQ5ov-r1gjRQklEy0qVxrWW-6ieFaflZzFuZVP5uI
Message-ID: <CAJZ5v0gpFDaS8sLdDBbS4tU-F7fKPKOkXtb7nqjfNhagEB_Cgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, lixianglai@loongson.cn, 
	loongarch@lists.linux.dev, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 9:21=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wr=
ote:
> >
> > This change is already merged in acpica tree.
> >
> > slightly ping.
> I will merge the last three patches once the acpica changes are synced
> to git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git.

I've applied the $subject patch as 7.4 material.

When it propagates to linux-next, I can expose it on an immutable
branch if that helps, in which case please let me know.

Thanks!
