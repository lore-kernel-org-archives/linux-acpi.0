Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3F1DED42
	for <linux-acpi@vger.kernel.org>; Thu,  2 Jul 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997294; cv=none; b=glIw4MIK1kxsnmb1o7k4fEMCz5zGbwTlI9Gue6CiI3TbrE2hvX89hY35eO0uneLRRUXuXYZ8/mkR39316rl4PEKONmjM05jQdjlHg762Rppp+lN1y3RkWN4Et/30D4ApURSgKImj1ajLggDlN8Xh1ERY4FwK8wVdlDCvg81e6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997294; c=relaxed/simple;
	bh=fBavffYPsr07girFYLYTKFB2pkyqvPE7LwpU3JxxEGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mv8neIjascudhwg8N412nMFx1ppG+4GAWfs0MBk4BGNW+2nYvL5dmOZdATPxlO81pOESPOmcSLoRCKnEGAVCkZJyhUqdNE1NSQcE7H65e/TPbuNECx75YVYpV8O2qC4z6UiztTUDjchGD5wMgTcXYvpGYmtcCI4Gq5aoqvAxk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbcnVwtj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbcnVwtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3423C1F00ACF
	for <linux-acpi@vger.kernel.org>; Thu,  2 Jul 2026 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997293;
	bh=NJgbIXZ3VpQAEIiycSutVcOhsZeQIS/TD9wj0KScBzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gbcnVwtjVe6iEzMwEU980PXG2ymJuMD9otIVeMnmk/FyvrGxy54d9r0OL6Z+V5VT4
	 g1iApjkJrOOnFgH0KvOK9xXQpZWALRLPDnh48aLzNSyWkuLl0c8wHfRczW/aPaMhjO
	 X7P4o0/QbE14PBLgTMAbQzQbKyfZYx7D/HcHeKPEQbPEz2a4XXuvVllVt8qlqLdaaO
	 hskfBKRysc6YRB3eNBH+QC0C0vLqeFzsBPBkovBjsLPei9eWFkfm6Py+KYUNKwEjIn
	 dP5toKw0YhqNBSmt4IgrI1maUfv9l54IV9TmHTz2wIeyt+LplhvgCEpl3cJMpAUcOQ
	 20KyXVOeo6tSw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39957d210f4so17216441fa.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2026 06:01:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RomoKgTqIe73U0Td+MmoZ7AQf7H7zB+rjSsg/6m8R8YoXIseIDbm4ExB+1O2D2H/wlVQPSGbeFZlbua@vger.kernel.org
X-Gm-Message-State: AOJu0YxnndJU4Yf6oFSBUi3dzADbJjqdZ3hptKoSjdgSWsVTy07D1JPZ
	qFJPnaSC5iihqdxioSiMZB+a6HvRhNKHOOpI0mq5vbQPUPDcmEYAo0flL0zZoqhJa/W81HyvfRy
	ZzQSfC12UGrP4mfQTJlM+4f31M6z/53E=
X-Received: by 2002:a05:6512:10c8:b0:5ae:b8f2:a63d with SMTP id
 2adb3069b0e04-5aec68b9dbemr1645102e87.65.1782997291626; Thu, 02 Jul 2026
 06:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527082707.2013499-1-hejunhao3@h-partners.com> <6ebea989-81c7-6237-1a31-8d6975796680@h-partners.com>
In-Reply-To: <6ebea989-81c7-6237-1a31-8d6975796680@h-partners.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 2 Jul 2026 15:01:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPUi8ZoqVZ_hNk=R6mtB6xqRvYb4_EVwr77ApfHBR9ng@mail.gmail.com>
X-Gm-Features: AVVi8CciIHZN9eidKgvBSyBcB7Vf9Vbo8s5r03M1pkruVy1XTlbnUAyoBFnSJK8
Message-ID: <CAJZ5v0gPUi8ZoqVZ_hNk=R6mtB6xqRvYb4_EVwr77ApfHBR9ng@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: Handle repeated SEA error storms
To: hejunhao <hejunhao3@h-partners.com>
Cc: rafael@kernel.org, tony.luck@intel.com, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, jarkko@kernel.org, 
	yazen.ghannam@amd.com, jane.chu@oracle.com, lenb@kernel.org, 
	linmiaohe@huawei.com, bp@alien8.de, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, tanxiaofei@huawei.com, liuyonglong@huawei.com, 
	mawupeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 2:50=E2=80=AFPM hejunhao <hejunhao3@h-partners.com> =
wrote:
>
> Gentle ping for this one, and it's ready.

So it requires at least one ACK from a person listed as APEI reviewers
in MAINTAINERS.

> On 2026/5/27 16:27, Junhao He wrote:
> > When hardware memory corruption occurs and a user process accesses the
> > corrupted page, the CPU triggers a Synchronous External Abort (SEA).
> > The kernel invokes do_sea() to handle the exception, which calls
> > memory_failure() to handle the faulty page.
> >
> > Scenario 1: Memory Error Interrupt First, then SEA
> > The page is already poisoned by the memory error interrupt path. The
> > subsequent SEA handler sends a SIGBUS to the task, which accesses the
> > poisoned page. This flow is correct.
> >
> > Scenario 2: SEA first, then memory error interrupt (problematic scenari=
o)
> > If a user task directly accesses corrupted memory through a PFNMAP-styl=
e
> > mapping (e.g., devmem), the page may still be in the free-buddy state w=
hen
> > SEA is handled. In this case, memory_failure() will poison the page wit=
hout
> > invoking kill_accessing_process(), and then takes the free-buddy recove=
ry
> > path.
> >
> > After the CPU returns to the task context, the task re-enters the SEA
> > handler due to the same access. However, ghes_estatus_cached() suppress=
es
> > all subsequent entries during the 10-second window, preventing
> > ghes_do_proc() from being called. This suppression blocks the
> > MF_ACTION_REQUIRED-based SIGBUS delivery, causing the kernel to fail to
> > kill the task immediately. Consequently, the process keeps re-entering
> > the SEA handler, leading to an SEA storm. Later, the memory error
> > interrupt path also cannot kill the task, leaving the system stuck in
> > this repeated loop.
> >
> > The following error logs are explained using the devmem process:
> >   NOTICE:  SEA Handle
> >   [Hardware Error]: Hardware error from APEI Generic Hardware Error Sou=
rce: 9
> >   [Hardware Error]: event severity: recoverable
> >   [Hardware Error]:   section_type: ARM processor error
> >   [Hardware Error]:    physical fault address: 0x0000001000093c00
> >   [T54990] Memory failure: 0x1000093: recovery action for free buddy pa=
ge: Recovered
> >   [ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory
> >            (page:0x1000093 offset:0xc00 grain:1 - APEI location: ...)
> >   NOTICE:  SEA Handle
> >   NOTICE:  SEA Handle
> >   ...
> >   ...        ---> SEA storm
> >   ...
> >   NOTICE:  SEA Handle
> >   [ T9955] Memory failure: 0x1000093: already hardware poisoned
> >   ghes_print_estatus: 1 callbacks suppressed
> >   [Hardware Error]: Hardware error from APEI Generic Hardware Error Sou=
rce: 9
> >   [Hardware Error]: event severity: recoverable
> >   [Hardware Error]:   section_type: ARM processor error
> >   [Hardware Error]:    physical fault address: 0x0000001000093c00
> >   [T54990] Memory failure: 0x1000093: already hardware poisoned
> >   [T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware me=
mory corruption
> >
> > To resolve this, return an error when encountering the same SEA again.
> > The subsequent SEA handler invocation uses arm64_notify_die() to send a
> > SIGBUS signal to the task, which terminates the process and prevents it
> > from re-entering the handler loop.
> >
> > Signed-off-by: Junhao He <hejunhao3@h-partners.com>
> > ---
> >  drivers/acpi/apei/ghes.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > Changes in V2:
> > 1. update the commit message per suggestion from Xueshuai
> > 2. Add a check to only return failure on the ghes_notify_sea() path,
> >    avoiding impact on other NMI-type GHES handlers.
> > Link to V1 - https://lore.kernel.org/all/20251030071321.2763224-1-hejun=
hao3@h-partners.com/
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 3236a3ce79d6..787664740150 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1383,8 +1383,16 @@ static int ghes_in_nmi_queue_one_entry(struct gh=
es *ghes,
> >       ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
> >
> >       /* This error has been reported before, don't process it again. *=
/
> > -     if (ghes_estatus_cached(estatus))
> > +     if (ghes_estatus_cached(estatus)) {
> > +             /*
> > +              * Return failure on duplicate SEA entries so that the
> > +              * subsequent SEA handler invocation sends a SIGBUS signa=
l to
> > +              * the task to prevent it from re-entering the handler lo=
op.
> > +              */
> > +             if (is_hest_sync_notify(ghes))
> > +                     rc =3D -ECANCELED;
> >               goto no_work;
> > +     }
> >
> >       llist_add(&estatus_node->llnode, &ghes_estatus_llist);
> >
>
