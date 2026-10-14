Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0993D7D9F
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996102; cv=pass; b=D5wWBSn8G6+0MsO5k+7BpkyuVHrewCb2uRYRUwk/WHJbKVrD65wrYTXIrdDROAAK6SgRYxIkQBs4Q/5KOkayAY2x9wDrgJZZrnvJvrXfWgS1iG9IUvayGArWCR9nw4TWiv9hdsJ6XmULcNnl99lTMdMJ8HlueIHkfeDatPwimsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996102; c=relaxed/simple;
	bh=3mwSDPTFjJGkaatL1Lo6Mh8o6JdUk3CgZRH07sGguXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Av+NPMRDoIQwd4ENzDxLbq1XYwpMcgGAOcDvCW3aCrv5mXH7AaK0J6J+SEepvWWHFj/Jl4Hi4R8s6kvIObzjIGLm3pyu/UIbRalc5X5+O4QQbdiOAVI7SqqOfH2xRfBu8JucIFpTqOEID+U7t3eU+5/reekoq7mFZ1wh1n0vBJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwJ71fpf; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwJ71fpf"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533202fe429so1289061cf.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 09:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996100; cv=none;
        d=google.com; s=arc-20260327;
        b=sWvZoEN8QBVEa6fFvjxhdcxrvX2LhJif/ch5rxJ8CNSXqLTB7OtT8CB5UUArv1mwvi
         hMb537QXELcGfe96l+LhF6Z+HI4ggZaFsNtEMngo+nhvPJEAl3pkh3p8VQO7Bf4KM9VS
         norIqel1Wvgk6rMBRnnXjbEPeVANt6RXhnUif9cLxy2esr8FBL4ChvdKT/PndBFjhLJF
         Cdkw8OjAkqPyq8G0h+Z3mrq0FLU4Zfi5JNa7XmEAUaXreMPJ/IydYB9qubrVXqVt2BR4
         7+zMShaMPg4HxT78K3Jd26yg/OtL/evwSKG6Y0Cwkt+pnYJv7SKVgEB0n5ewq589PE8p
         ntdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        fh=eyYkxOEt8IGexR1HKucxTDpSEpv2OlSvUljD0YNBBzc=;
        b=JlAqRyNin3Sque5liuxiogyNUD7JzBJ5H3+Tp1DVxbDZDPTEv4b5iucuuDhvtmd8Uc
         cPTSdWDhpQX4YqOztC27FfIwcgDBdxnfvYO+QYjMjZdnO4yDWMM030CWwI2fVMXEbtMb
         ItMJdU+gShhMab4z+53qkgBlAATg09hyGRNySAgGKCf5wFxKwyHp95xVVM3m1wssqSyl
         s8cXPsp/zwgZ72toIUL8aG6owwIi27u70q3D0+sDWdrK/Kocz8c55gewkMVTY+zu+zxl
         754aC7CzT0KESBfPdEBthyl/bkFvlAbib5PbnOSKKNbGrqEXwYI8+XmG1hkTGOI5LQ2q
         /e3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996100; x=1792600900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=CwJ71fpf5+y9d7FQ5OPj4VQUkMx2Y/zScgcoVC0/m0gnttZZ9zBV8PLxtewfJ7QlOt
         HdHW+QAJO8C7LzxX1RK1fDcK3aE6a8ij8n/ALNgPB+b8ixDq3LloP/oXBEekqZcRjsme
         z2xA1D6muW/HSIYtm+iOl3j/uL6rYVbik2sHrK8yCS8DEISS21ww6jYWHuc5//ZMKDtl
         D6uqMZxBfmoHSlQ3Jm44uS/8JfohOg/NIsx95xWOopwyvLPy88h06ZpGFP5UoquuC3g8
         JGeeaYZgrJzcLd6TMzRpF94huSlRi5W/P+XLETSE3Y5rvBDUvb1hLPqRHcbHcqe+49F7
         z6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996100; x=1792600900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=rll4j8nJdR2an7JD5LTLtWlY/SvjJygkrXKF7YIADaybeLRwIQdHGKdL1p5LfmB0fs
         Ave2/98r2wwfsL0iEyiLU+/AuNcu536vdlEXsBWwfC+PzIk2iUH9phQJybL5grjh988D
         mBwLDJuOK7Td6C5eVMdhZyf86Amc1ZEBMunvqq8n55Sl98sexOguxjqul0TDQ5FkqWlG
         uTtE8aJU65nRbbE1pDcIZQAhzJ8CULnXkVeJhA/iyTwqLFD49hSQQRIG9QFT71GP9YSx
         +3hmMJ5MyXzCJvfHeucu4CENQY0AseoRoB3YJqUiAM6nIZ2xWAg9+hrcrBs1dF3Fe961
         Cgxw==
X-Forwarded-Encrypted: i=1; AKwUvBwsvwWjWBUt821IdYLGZ58t2iGzaMdv5DUIlWcnivHOApD3m9Tk/D2btKa51GRvc1TVkMfplIvwwuYt@vger.kernel.org
X-Gm-Message-State: AFq9FYI8rMac2+gOvTiqN06+2SOKAt+0U+AzL96KLFSVp7boEOikgOqR
	C75Dw9aI8tegkq360VGozourJrkJnHGblpQ3pbBILKUbQTLNPyD0Oi1s9Txm2xsnHvBZbUggg+F
	ilkHBqqX/1eRBNiMLkqakT+3jiKLMoYJ6j5syyAgt
X-Gm-Gg: AYBFou0WNuqHjwgVVrpgh0OQIG2+x9s1oy9TBDsNcKiHZdDanmwrrNAfpUx3/roHVL8
	9M22yC+9By9TjONHjQruRtpAnqBhNmeVDbEZydmFbKd8wNU7Dzuh+uXYYxbeX//JX79EQHSPvoh
	48pTLB9MfxRJwPCahf45PAXYFV+X+MkNfGm4IVX4Dwwqqee7MAohtiHrbp+G4olxGJmT1iVIvln
	pf5CyoElZBTI++M9oqQhr3yzLyWpxOWyDE0Lp2BgjIWaPTluk/x8CQFFIiZnzkN0LAhO705D34T
	G44VWHKDzw/wJVHRbbCbOckMD125f8mtmKFzr5KUyDp16/jaBoFws0BCHI5ckmBHaEBaesMaLap
	ZisOC2y0egA==
X-Received: by 2002:a05:622a:1108:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5360573c96fmr14813151cf.5.1791996097367; Wed, 14 Oct 2026
 09:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Oct 2026 09:41:25 -0700
X-Gm-Features: AclHuK8_g-YOJgMR77fEpf5RTsveF4u_ERdXz6lvoN6wh_uF7KP8ZsaUSV1ti8A
Message-ID: <CAP-5=fVLWh4uay2HGy6DOpZmtTr5WAd-TehAkN+P-pQgq_BZhg@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 07:36:41AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> > > Clang supports the 'require_explicit_initialization' attribute on str=
uct
> > > fields to enforce that the field is explicitly initialized when an
> > > aggregate object is constructed, emitting -Wuninitialized-explicit-in=
it
> > > (enabled by default) if the field is omitted.
> > >
> > > Following discussion at the Linux Plumbers Conference [1], this serie=
s
> > > introduces __require_explicit_initialization in
> > > include/linux/compiler_attributes.h and applies it to
> > > struct kobj_type::release.
> >
> > Cool, sorry I missed that talk.
>
> Yeah, I'm really liking these compile-time checks. :)
>
> >
> > > As Documentation/core-api/kobject.rst notes:
> > >   "One important point cannot be overstated: every kobject must have =
a
> > >   release() method, and the kobject must persist (in a consistent sta=
te)
> > >   until that method is called. If these constraints are not met, the =
code
> > >   is flawed."
> > >
> > > Annotating struct kobj_type::release caught 30 struct kobj_type
> > > definitions across the tree that omitted .release:
> > > - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
> > >   allocated kobjects, ksets, or enclosing structures were either leak=
ed on
> > >   kobject_put() or freed prematurely before kobject release (risking =
a
> > >   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=3Dy).
> > > - Patch 11 annotates struct kobj_type::release with
> > >   __require_explicit_initialization and explicitly sets .release =3D =
NULL
> > >   (with explanatory comments) on the remaining legacy struct kobj_typ=
e
> > >   definitions whose kobjects are static, per-CPU, or embedded in devm=
- or
> > >   parent-managed structures.
> >
> > Sounds great, but let's fix up the users before adding the attribute.
> > Looks like some of these need another version so it might take a bit of
> > time to get them all merged.
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

I'm happy with that. I'm working to address/incorporate the other
feedback for a v2 of this series, but I can drop individual patches
that have already been merged. Thanks, everyone, for the positive
reception in getting this landed, I plan to follow up with patch
series for the other uses I found.

Thanks!
Ian

> --
> Kees Cook
