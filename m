Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FC3BED79
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jul 2026 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454122; cv=pass; b=GQHj50sMicS+9ZJUg5Hi253JfPt/gi/S1lcNuQdWYhUBeg8nACnPehvCQDQABoPPdYi6K2CI1w+rzE1gZdEj2KaQ3jvd8QDI3HJgzmOjgWeQuQ3Ch8GF1dIW8jS4wa68pKbcQzv5oX19KncHu8KhSIuZdcUW5Fh+dAtc4XpIix4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454122; c=relaxed/simple;
	bh=28T9LC8qC3w3ciXN6Fz4Z4g2iDK73+BSqIPdga2DGts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc0beW2h0Dgv+bFyQWlDUGzokrb0XKiMthtW68b/abz8Ogb5y2OGDLeLXOmS/wJNr9W3eltLnoyTyY/E2lftZvuun8iHF2WrHdcT15GJR9JTf++X3vWEKd2SRluTjmG91Qa7SgJu0bXOXtN83/92f3eV/nxvCFbVEx/zWw1aGoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0YErfQB; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0YErfQB"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-448b0ff4a57so2860455fac.2
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2026 12:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783454119; cv=none;
        d=google.com; s=arc-20260327;
        b=dGr7TIW9+6yxWpHw6Qaex/mPUHZSDoqivOWObJOSsS4XytwdZjZj+dFEOmUSKKMaMQ
         1uOZ677hx2eyH+yDdXWDZk+D25UtXmlRn/NJTRdTgdHLWxYTZ1C+mqKotO35NsPwtJ+j
         nzIV/OKOEm2lBg7r7Tq3Yigq/ZYHZdZSdJ0dp6bzhL/wl/u+dFeRIYfmX3eJNAkZ+Snr
         QSuveRHDEVxFR+mpQ/5rfEbHbcG5cbjP8tBtRoDUKhLcs0mvJSoa/C0uQY5ThEXFW46J
         dohDZmp4UEPJcdHJQUH90apuVIwkt+c+oDwxtDR49BTtDIInXPdxLEAct3Hp3ucklP+C
         7mOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/UUjuXqKnuK61a7cFsjW9ZWqBCGpYoIH9JYtW2nvWM0=;
        fh=wsduLFtwCxbQwsxiTeqjhBuykkymGLyYkfcxdUgj8lk=;
        b=OhbAiMx4DYLbY4IZVgT3Aax4z+Lt9H0bG0LjeGdJmqW10pIzzBm3P9Hcg8UhnFx1pd
         pWS8toyZiRjZk6BLEW1Uj+ElafpWW8kr6CQHiWOxp1TBZCSnKJxsDWIO4gUo3+fp6KTs
         jry8OHpXgn89iQx16Nnft2QYwYnWYxXbK+ga3e5BM3srAqbqSFU8HSMERtuHtiB6u9+M
         k9d402FCpF7PdXQBPr51xalpWMC5k+156VfARc3EJnd0xGvfdXznn5C7o054noD6Ng1t
         YBDnezSpYtaljD58jodnRN50SXEZnsjT6oEGmQ7DxZzbPZoz/oVDa5FSsKeaybOOVdP5
         tHVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783454119; x=1784058919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/UUjuXqKnuK61a7cFsjW9ZWqBCGpYoIH9JYtW2nvWM0=;
        b=o0YErfQB34QdQFrY2zNUh9GRTkZk5Ho9wisT8d0y1U3jl0oiNblo0Wss7R8tCrVJ6O
         nuHPQZlE0fRis73ENKQGHNmi53NEqWtMclDjadTtx5Nq3b0uu59iXj8oxhOaWZseEBSY
         IF/K5+qX5A+ZPuo8KiMgCytd0MRiRvWIMIC5Bu/yXrWM3K+S88n1xv+IbJFbpGXHoAzO
         s9bwEwGl6rBOHDVYZb+jLbnhV2b7AE7rry/g/tvuSy6makW7VOB2jD7s8uy+kRoLFCC1
         +3Ba9mxh5RMG+0jNjANa/L+gGkB6spNkDbjOcVUHcY46bZ9Szvd108aRShmCSy+1hsLM
         Hk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783454119; x=1784058919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/UUjuXqKnuK61a7cFsjW9ZWqBCGpYoIH9JYtW2nvWM0=;
        b=kT+QMEF2A02nfB1EkPoz7sNaGmoIXO8DHfa0gTjfL+AMwyWpJ3Yx1pO/j+4nY+sAso
         Netwq53Gn5EGY+q601uJHkYHImGhlNripKqjLD3PTIOsFlxSVN6OI9M1ZukHlB+NFQ6c
         C3xTijeQOjm0jUfdu9blCz3tOFyhI2dLLxB6J6+sLShikdtD+1wSkTixUYwBbLm5ra61
         GHfUj/sTR9jOlsdtkEOXyPMqwN+MwZyArr0fFf3Q8BlhQ7YCU7EC5Qnz1E84fQbSNe4l
         SRpMgBRhiav8rpnhRjqRxHO7TOFnlhKhRDquOJ+gbxjIIgjcbjeN6qWbEplW6JmV02eP
         jAPw==
X-Forwarded-Encrypted: i=1; AFNElJ9l40w0FgUqEGXdv05+xtRSCM1bn1AqQOcYcIrHAxu/7QIXo+REsuyOrMMlWX1gSv2FQ9LKFwcbXWTO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tXlOQCNrWqawBmXs4zXqyq6NQmRY+gva8p5Glby1PPgEQgYA
	erWa/7R/XYTpQx3E/VCyAOR9asXKtl5aL3ENhCCWdLE7Mc9B9GEV/dyDzs4VCpE8xSRNVQoWiL+
	bGddkWIt6NhYesSWqLAKEdM+bfuqsjlU=
X-Gm-Gg: AfdE7cm/HHsVCMtSYJbWbuYLDWfUbWZdBNP7hCpFHfhCLwJdGrKEYPEaduL7VJTO+L9
	FNRoHQpqVRLkyGQHEitZRB/UuXxQyk8ytFzSG8bOlgEyrs24j67lUsy9C6T1CSSuFBjpzhe+F7c
	14sS3EFHRnC/iTHqO3EZGbkxQN7MDab2H+Bw7QhUi/agq8tQbL7bUI4UYm3a8ZrB2v1IngLCdb+
	hrZ2aQI0UCdZJCNKOQYYHv2qBv3Mt/FBeF8JKvsPRPhGHdDY6oY4/+aMXqlA+QLNby0ley5Nbr1
	EoKYh3U=
X-Received: by 2002:a05:6871:2eaa:b0:439:c66d:2e5f with SMTP id
 586e51a60fabf-451062d14b9mr4294017fac.24.1783454119271; Tue, 07 Jul 2026
 12:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706000338.362421-1-shijujose2008@gmail.com>
 <20260706000338.362421-2-shijujose2008@gmail.com> <akx2wqr3ULcmpCmc@hu-ashoraj-lv.qualcomm.com>
In-Reply-To: <akx2wqr3ULcmpCmc@hu-ashoraj-lv.qualcomm.com>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Tue, 7 Jul 2026 20:55:06 +0100
X-Gm-Features: AVVi8CdNXthfgZirwipMRC0g06u6afOreJEJzYGgCdk14S6ETxObFJktMa8ee-M
Message-ID: <CAG4KcR+TPE9a7Fr1FWwoRa9tcb+u4qfp=UiuYvb=kNXKRWPP7w@mail.gmail.com>
Subject: Re: [PATCH v21 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature table
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: rafael@kernel.org, bp@alien8.de, akpm@linux-foundation.org, 
	rppt@kernel.org, dferguson@amperecomputing.com, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	tony.luck@intel.com, lenb@kernel.org, leo.duran@amd.com, 
	Yazen.Ghannam@amd.com, mchehab@kernel.org, jic23@kernel.org, 
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ashok,

Thanks for looking into this and good catch.
I will incorporate this change in the next version.

Thanks,
Shiju


On Tue, Jul 7, 2026 at 4:47=E2=80=AFAM Ashok Raj <ashok.raj@oss.qualcomm.co=
m> wrote:
>
> Hi Shiju
>
> Thanks!
>
> On Mon, Jul 06, 2026 at 01:03:37AM +0100, shijujose2008@gmail.com wrote:
> > From: Shiju Jose <shijujose2008@gmail.com>
> >
>
> [snip]
>
> > +static int register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc=
_id)
> > +{
> > +     struct pcc_mbox_chan *pcc_chan;
> > +     struct ras2_sspcc *sspcc;
> > +
> > +     if (pcc_id < 0)
> > +             return -EINVAL;
> > +
> > +     sspcc =3D ras2_sspcc_get(pcc_id);
> > +     if (sspcc) {
> > +             ras2_ctx->sspcc         =3D sspcc;
> > +             ras2_ctx->comm_addr     =3D sspcc->comm_addr;
> > +             ras2_ctx->dev           =3D
> > +                     sspcc->pcc_chan->mchan->mbox->dev;
> > +             ras2_ctx->pcc_lock      =3D &sspcc->pcc_lock;
> > +             return 0;
> > +     }
> > +
> > +     sspcc =3D kzalloc(sizeof(*sspcc), GFP_KERNEL);
> > +     if (!sspcc)
> > +             return -ENOMEM;
> > +
> > +     pcc_chan =3D pcc_mbox_request_channel(&sspcc->mbox_client, pcc_id=
);
> > +     if (IS_ERR(pcc_chan)) {
> > +             kfree(sspcc);
> > +             return PTR_ERR(pcc_chan);
> > +     }
> > +
> > +     if (!pcc_chan->shmem) {
> > +             pcc_mbox_free_channel(pcc_chan);
> > +             kfree(sspcc);
> > +             return -EINVAL;
> > +     }
> > +
> > +     sspcc->pcc_id           =3D pcc_id;
> > +     sspcc->pcc_chan         =3D pcc_chan;
> > +     sspcc->comm_addr        =3D pcc_chan->shmem;
> > +     if (pcc_chan->latency)
> > +             sspcc->deadline_us =3D PCC_NUM_RETRIES * pcc_chan->latenc=
y;
> > +     else
> > +             sspcc->deadline_us =3D PCC_NUM_RETRIES * PCC_CHNL_DEFAULT=
_LATENCY;
> > +     sspcc->pcc_mrtt         =3D pcc_chan->min_turnaround_time;
> > +     sspcc->pcc_mpar         =3D pcc_chan->max_access_rate;
> > +     sspcc->mbox_client.knows_txdone =3D true;
> > +
>
>   Probably a minor nit ..
>
>   sspcc is published on the global ras2_sspcc list (with a live kref)
>   via list_add() before sspcc->pcc_lock is initialized a few lines
>   later via mutex_init().
>
>   Once list_add() runs, ras2_sspcc_get() can find this sspcc and hand
>   out a pointer to it (kref_get_unless_zero() succeeds since kref_init()
>   already ran). A caller doing so before mutex_init() executes would
>   end up with ras2_ctx->pcc_lock pointing at an uninitialized mutex.
>
>   Currently harmless because the only caller, parse_ras2_table(), walks
>   PCC descriptors strictly sequentially, so no second register_pcc_channe=
l()
>   call for the same pcc_id can land inside the window. But it's relying o=
n
>   that being true rather than the code enforcing it.
>
>   Should we initialize the mutex before publishing the object, e.g.:
>
>         mutex_init(&sspcc->pcc_lock);
>
> > +     kref_init(&sspcc->kref);
> > +
> > +     mutex_lock(&ras2_pcc_list_lock);
> > +     list_add(&sspcc->elem, &ras2_sspcc);
> > +     mutex_unlock(&ras2_pcc_list_lock);
> > +
> > +     ras2_ctx->sspcc         =3D sspcc;
> > +     ras2_ctx->comm_addr     =3D sspcc->comm_addr;
> > +     ras2_ctx->dev           =3D pcc_chan->mchan->mbox->dev;
> > +
>
> > +     mutex_init(&sspcc->pcc_lock); <---------------------
>
> > +     ras2_ctx->pcc_lock      =3D &sspcc->pcc_lock;
> > +
> > +     return 0;
> > +}
>
> Otherwise
>
> Reviewed-by: Ashok Raj <ashok.raj@oss.qualcomm.com>
>
> Cheers,
> Ashok
