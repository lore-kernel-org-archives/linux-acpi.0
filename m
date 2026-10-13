Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892364F55DD
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892979; cv=none; b=SWEjdDilT1uEF96rg9dERKTYOX9BbfL6sLy+1BKirJOeYWWek5OHsDJ4bag4TbqVUPtBFOPrSh7VLzsxU06SvZ1ip08BUg+d8SSkTyO8ctYXOSErph8fb/YbHTP0VSGEJOX1pNnZgnEOqBwCWLPimE619JWFt66SkIRvz9ERqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892979; c=relaxed/simple;
	bh=Qgghz2ce1N3txSgutvJhs+kzyjPhbpQpd6HbrGdufeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKtpJZ2m1pI8D/wYQ10wnq7TAiQvoPztJJQYZyfDf10yA9TXRWH4hsE1f4S/4ubg4wLxMej/SxDaDSY+UEYSSnDvQ5Z1OOReHx/ksDhqmMOABq3WdZIzbknN//0eK5RZbob+QY3YD5jOoVrYmQLxKDyHmi3hw4LHROjJR34aaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCTioVJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCTioVJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D42E1F0089B
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791892978;
	bh=Qgghz2ce1N3txSgutvJhs+kzyjPhbpQpd6HbrGdufeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YCTioVJtDV2w3Suz0JAJGqrcEzN8jzMNW426WKyoLv9DevlcWEZMEWUMjvcUZurpP
	 593ciP6gzchSW/cwrM6h2bAtPqlQL6a62+e1AMmptLTnm6RzATjhBBS4KIEm35Z4cp
	 9Q5X0c4H2/ie95U5WuUGCON1WX5vCaERZNGFZfheDdOQobD0oKXCljUd6ybYhTbS1t
	 t13dkr306au5+jy+/koQVyiDfMhEoRYkHYWmxW1jjMoxsKe/uwJgNcfaYaAH8gwcAM
	 ZOia/UhQYCOQUQrpJJ6NNQnx7f6cLOOmXJjDSf0Kbb+NjGpd7OXvh/onaLuoqZ9gaL
	 JPXIAE/ogNQdA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bcbb82dbadso2106163e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 05:02:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFFB9krlC9mzdykcUMe4NiqNmAhZdhmGHqTDq/LUJSUrGQ7W7CEHxdjMC0c0/4SZB4gZM1zqYbsduM@vger.kernel.org
X-Gm-Message-State: AFq9FYJrMSJVbmk3OyiaLTc5f+kikho4/dG8u3pXFd+xyUA1ImFblY8Q
	cL4y+//L5Yz9FbJXkqq/+SW7EVhMYXvLF5ewsmy0cvdVwPWuXgsFCv0yEyXKIGtsqyNQbzRSvPk
	Mo4HRNXA5fpNXJA0EjIX7psq+QAX4e64=
X-Received: by 2002:a05:6512:61b1:b0:5bc:b778:70ac with SMTP id
 2adb3069b0e04-5bcde6cb069mr4504958e87.27.1791892976820; Tue, 13 Oct 2026
 05:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
 <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com>
 <CAJZ5v0gpFDaS8sLdDBbS4tU-F7fKPKOkXtb7nqjfNhagEB_Cgw@mail.gmail.com> <CAAhV-H4hdq_2rGAw9LtCcxLUnQuKBgYTJeMXkAfjCuM+yck9HQ@mail.gmail.com>
In-Reply-To: <CAAhV-H4hdq_2rGAw9LtCcxLUnQuKBgYTJeMXkAfjCuM+yck9HQ@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 14:00:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLNNWa+5FVr6qq3wweasish5PazhmJ79opiKKsSFqtqQ@mail.gmail.com>
X-Gm-Features: AclHuK_VlXt4n0aWWke0Z8h9vKGfPNjerwul9StuMA3SRlvJ9c4BQDZac7-YVlA
Message-ID: <CAJZ5v0hLNNWa+5FVr6qq3wweasish5PazhmJ79opiKKsSFqtqQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Huacai Chen <chenhuacai@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Bibo Mao <maobibo@loongson.cn>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 10:40=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> On Mon, Oct 12, 2026 at 10:49=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Mon, Oct 12, 2026 at 9:21=E2=80=AFAM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.cn=
> wrote:
> > > >
> > > > This change is already merged in acpica tree.
> > > >
> > > > slightly ping.
> > > I will merge the last three patches once the acpica changes are synce=
d
> > > to git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git.
> >
> > I've applied the $subject patch as 7.4 material.
> >
> > When it propagates to linux-next, I can expose it on an immutable
> > branch if that helps, in which case please let me know.
> If that commit is contained by the tag such as 'acpi-7.4-rc1', then it
> is enough for me. The loongarch pull request is usually after the acpi
> pull request.

OK
