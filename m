Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067159;
	b=4OIEwpjpIgAAe21OW9HlP1Ak9J5bTnjdu5OQLXmLtvyK3keeQ/52wpWPd9MNc6jn7D5o
	 xnjXmziSq7bSkeS1q2qEj0jROXZ2OPkmQWw5MipwAsRmCbe+WgVzE7pzOaIwIEdlDdxyk
	 GvNIBqgfFg/FieLPUzqNyYsGAo9/54rIIFvzQkbG7fJyXt1ElwrnTcAuHWPzTtIztngGO
	 PfAT+a5rRy966q7WRMKlKOrkEIQp+9DExjVpUFnlZoiwAeu3VflE0++ZDMApvHOHjJHsw
	 UQM+o70BvHN6LngdjHbT0KQHeuixRq56gRjBypHwLJERRvtU6KTKfusNVLSWrhs3Dow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
	b=K3+hZBwgFOfAund8n03ovKFhOeMo1w3z7Zq7ZXHh3QjvnDIUHVGXnyX9QtYmpsm7U3av
	 BuTnmX6XhPDwT4D0z5svgMLFid/vfxT8YeVSgHn7YuX24wSpxYH4UcZTuhelYI5suhqWV
	 +cjhFqmviR25lVDDCAPo6c2DuX3tUYm4VzvmW1Nm40LXcmt6fWAT0eaxOkSM7oCTWoX9s
	 ZjnLpoSS8FLLztI0XCpBfJbTMBLjusE4dDUq2Dw/84Mt5FjzY4sosQe4+3ShHC0HeSJCf
	 oRThIszD5maL8BI/xfwBqlS+8+w+rYxiScCG3QUuYDdzCODWhV6u0NwPl7CUdktmhfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3D606A337
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 05:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B3D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55be673e029so117381cf.1
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 21:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
        d=google.com; s=arc-20260327;
        b=am+pH1H61KeXuHnNFfOfJ+tPiU6O27bGX9zntVd9FZjRjxKRTNoFaiT69Cxfjmc17B
         cLcO0Eq8wWUWxyY7XePUftzSH7FtdZq6G4sa273D46aZLj8g8k3GbXaErglpljVNEx8X
         5QT3NJLPoY7qfcccQogoLWk/cXO1D/SQzjEY4KGfUTHZUQiLJ3PJ/d1IktGtUr+NreXV
         ZSiulIgfiGhq4kkvSV69j1GO+QB6iYullZNbhcioWetQNPZbuuRmmNOg6V/gpICQg0tm
         ZUH19vxaJI/gTyUs+ox4eJjzGANFk9vRquvodJt9GhVVt28s5V49XX3Uk+5MYBm40/RC
         jrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        fh=60pWq/o5z+ZACtfOXYkgVcID+xC3dXeBolzcKTG1hGA=;
        b=ZWQ2tjVhYaAJ+Zwz/xu1NqkhxxmQubX9P0GffJHUCaXtYuFOxDqDiKGtUYlz419IhJ
         ZO+ytrM5VWvk+azVUT+pjS9yfb0UgGtdSCwJ2oxao03BfZRZlpzvntjMl7B+Ico5yxbw
         A7Bon5DOMx/Yfsw8rbFaUW+nNEf8Skc+Sn55p+zgHzCL9jFfLg/oaboeNAJhTX2AVaSX
         lvWfvarXf4UVc9RFYAgUO+LQtEUcBSugfWlhoPRx0emU97yPhx2g7+14l1j3gUfxgw4z
         WCtz+ZsoftwP2pb6sUbRNIxPgjiWF315lZh9GhnuwR+JJwrgpv4uvoTcU1sCASs/GQfU
         060A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795067158; x=1795671958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=G9sTcZLhDZovHsgCx5Yv7CDMxJM8G5FDawL5JBd36y8NAy88YZsvFaSPGxL2OJDQWl
         D8l1zhaslplXpC+LH5CUyVM6fiya54hKkm3044CoRWwH6cYkMSxwEs9IE4R9vJJik3G9
         PaGymfho5RIhVhS+d5TUg18WON8Y60WBZxMM5gYyXKhy/KCwkwn+iT9No3gldijeO5tx
         xp5Gg8oePFUL/bdSJWKKtm4OA3cKKfEuUGn9FzCr/u57K1nN+6BjTy/XuUfYpf49AuBU
         GF3mrNTIV4ZWpGu4KegbuhUlLkOSriAaKH7KHmdnomUVdJlrrfe8QiZH1hsMd7fqVOCf
         HQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067158; x=1795671958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=PYcd9FJGaVyUZ52z+oV7CvvyjPUBLKCIig7zsRGol7JiQIVDefw5CsMPIX+v3dHl8i
         i0Gh5bpIk+vcAN9TEKA4URAmVq/H2gMuVGOEgv0+OAQLYyUxWclmT+FHsbr3ntHEl8oF
         9X6hB2jc6XHmWD3D/hKPz7Z8nwiASqgx/gLyrlg9FSoLC5tDbC/9x7JDeAnKHzCL9ave
         Zy9r/AsSjdHDVQRBeYK5WbwU5yYVnm92JhjZpC0hK9OlgQf9SwZrfOamr7zoqlwU0Lqk
         DdEDdy9v4faHUv8Y3DcH0M0Z/ah/wBxK4E04w735zAFATIPJyMoq1OCMz1xoo8j2aoh9
         V3Vw==
X-Forwarded-Encrypted: i=1; AL+hErHjdtVsfJCqRPulEBSDZFfqUI5f0q5G4Lexw3au61Gro8Cvmed0P2DF4pwbLZw8HN7hlipr8EW+mZNw@vger.kernel.org
X-Gm-Message-State: APuU4Z/LjPulfor+mAe+V1nm4d7C5o/IK8r3e/xX7zOnUYQgdv7k1EUG
	ofXCVGAfivGZcwBsPDEVy/i9IWag013lZsJw7+Uwc4CGSyV2IQMWGDXoyL0mxY6jwYJIAPGEJJ3
	9lVLBAMRExmtWd8RAF11XBcsvHxe0zYz9Ys1LjXc1
X-Gm-Gg: AYBFou0gRaPhPQGbkk3ME6Z8QxJFM62GBdK9eSOM9Cfsq6EilR1KlUn7shBhjmdv1vQ
	szkSdISKBovqNbjNrCdjATk09Jebm0geLwx5oLqa7XanbMPjI4j2mUagTIHulFYPJ5fIQ6+Iv01
	z1X0AjVl8lwxxCm/o+CjS80wBeM0jQgHs4vhCDz5aRb+yvVBtdTVJT/HhxYWyuYrfD42cfI1gKw
	zyzBr9UK7i7yfg3JQ5MXbWI2s5ikvjH+1Ofuh92PSa3ZNLOBSPIyW9r2i0vvkOMCgtKiWhB5GFz
	ybGtSNcZXI6G9n2z72nfsN5r8pE9Y1pXM53gT9+R9GNBzK4gzk0/bQG85Pi5hbvMpiEy/gyQJm2
	N7ZW2D1uhk4lrYfpjc0pJhV1HI842YtHPG95k
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>
