Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263409;
	b=GzSr9kTqgzxWojsPUER/brIHXngr+/YMkYwutD1HrPNaUcxM2gCqzUsp3hPE/vtEZ2YJ
	 FyDwUQoiF3gF1wPFWo2FQ2NelOS9JnxA+yK2Uqe/WuqxlJOH3T9lLJ0AD/Rl8sQvSbeYj
	 aI2+SVNwwOomRZoioZqxuaCG8gie77/od8EsU+nWAj18G5YkuBVwI4rk2O/gueE3AdBtU
	 ot2pXGXKQckR0ku85USmgplt8CCgqHgT/tS9dLqKZnXSlI0myrenjGJNGXVrcNVjBjaZS
	 oInco9S29ZNOQQyJS2tUKsn9MzLkcTE69kKhDFFR2MdTsfH3ySDitgQYIW1K0AgpR+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
	b=y+Eg/weg3p8rzjBZpZ1A+2MMnNsQuJ0JR5sbIpnvyQvnOm2Y2NoXZu/K1QQecXseauLx
	 V36KQJqLKYiQBFoaktp2OkLUq6ZkK+tCt9KvUaet4d8nptvmijXfby7iJoC+SLkZtgYGy
	 H1TEijIvRULN9XjQKENuwUobldAbF19ps9ZzZNiZMven7P+0U7wx9gLz1nUuZRvD5bRoB
	 CoWcPzZGhFl9LrkaglQzuTcBDETU4a2mrW8kkuwU5RKO7g+DZJzIWphS+jzgysvJw20ht
	 VS805gmYeh3Q8+TGfCaArWua/6Aadexv0wG/myS0mTY9wCQnhPdFkdXnNhe1gbceZxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C13606A326
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C13606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535f598d126so39631cf.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
        d=google.com; s=arc-20260327;
        b=dejvHaWlN/iGjl+MODn05MfwsxlaNsIaMJGqtyFF97xfwpjDe+H1fb7me2i24766Xl
         UkkLJDEi6Y9zf8G8mSVVXWc2f8rVzfUIHKjS2JxAwVmN/6F04fv8oSEqntLHKr01Zooh
         tK26v3V9ywVMwelz5dGgTL7OLu5LMntKmumKI9kZecBNCqywXB76RUrB4PeQ7c5F5ABV
         RfpocC9dgEdRVVJrJkhpdoX/0pcBCO/sQDgPkZsqLSPkrlnQZeddynlL0TkBVfDcSJ/L
         EWD7Xo02nx4WJQDhPOi5FYEJ9n9ZiZTRbN6zrNnjhKU9hkT74NaT+QSPd6IsCjbVDcBS
         QxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        fh=9O6IrTp0LJAHgdhKYenEy7t/8smrgsO2kLa4ftBp/Mk=;
        b=TYqpeDpdwzu3O3uvNysRo7CpjYb2Fg/eclDwsVUB201SrSck9rM29RPY/E+uWf9cd2
         A7P3H6x5/hW6osgWxtLOXUr/GrZDcBpF7aBtMZGuIzds6cpxGha+fQIbpIP/0hYXStFb
         oDGUnMxanGDqSrgy21Pf2cVWLx2QhQFjt8A7Uze8aIM3dvPSsNc5gHaXZHzgLL0zBmZG
         ZdwfssStyvMP3EDrcBcA1zjqOej0DE/RKMuAHs8J2OdmYT9e3q8MjJCC8sCCmyf0yyIr
         dilMYQeuzInysAJzqo66Y0c6MBu5UB4qMexrdp1ol6VlFRkTOPXH297iffE6stSnyJ8x
         FscQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263408; x=1794868208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=bc6ecKnXzqp5zahKN5US+W/GLFNu9bOCxLTorv75CdL/TyOgB/Qh6QFUi86M3M/XI3
         3gbxOXuAYS2+xcjqU4SLj5C27dCKM/SCCgBGdSbxDV00eICb4MzgEjo9vjECQ1QTCTmr
         MgCtojiqIWlVyB6AunwAs2qSQJP0tUdJsdT71C1y4WilJg+rQa++O5B+9FpAikzFpyGD
         TU94u5aUZCMHCz2bEPFushfsTW1bpin21NCA0WBKSF7omxyVw4eI3lnqeaGfI4JhzN5X
         ZQZwi7mBvwRBGIVH1EKWZ2xsmVHzuYxoBrVKANockiyw6pDDJKKlw7J5nTOQpM4hDjUm
         KR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263408; x=1794868208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=Ja/UvqJqu1HuQg1AuKaYc0omgrLh+G6sdJegaNfD8Zsn5O9Pr94bmSWAPbevhMeuZ2
         eQUSTyDfJJsqNItxGiiETgC5RBEuhxrdy1Dd5PzynGRl90ad8oTASzMLIJi1IDyZw122
         bsFrG/aL7Bjs7iG0amjoQqkQBik2gQHX84toYmLJKo9zs5M0W9jI9TFmtSFtoBZHZN77
         fb9Fe5Q9sXuq5lzfJLoKhxDKE3F1CpjFUkejxPo+BlnFeVxes3W25yPcvqzo63IWtSQO
         Y/dz+wJl4SmIDd6Qt2BhpERuhBUofMeWNGz5z1xrO0prxf5DJKTHgaxEP/wijUhrQ7e1
         uG7A==
X-Forwarded-Encrypted: i=1; AL+hErEYZ1Gh88U6j1JwbQr5UaksUArYUt1F3G+BXZrwnD31LOxziqBDqkzAp0oYOnwi/46soU6EFfKIhQKr@vger.kernel.org
X-Gm-Message-State: APuU4Z8eo2UX6nk2xh7mcwB4gwX5qYCXRbRWLuSPNn46YobxRlBgfA2N
	04rRLF26Rd1O589gjnRB/1rPvnV0WznQI1Hba/QwgBTRNtOlbkhFtebt/irPPGG1nKPumoVrl6j
	M67MH91sv1N/J7nz8/gy4zvSeGuJ6sKimLxOPDxFw
X-Gm-Gg: AYBFou2fAV2rSbWuaFZh2NG81mRPWH0gdP6+j3Rx80zbmmXTLHXFBLUPjyEy4dX3uwI
	q0L/y+2+HeHey8AvatQDoTp8zl4duCydatsyxRyHhsktsK50Q6NZY6MVVDaaMAT1RMyrP4NFzaG
	sZYWQkecfr8TvtXLBpt6W10a3KryqclAKnmULoX1GksZk8N9Ao5Q3O6PyOUcg862WfP+BD1hgy0
	kFywi0XlQAnshmMvk/yCtAJk/EpsXlJ2CZnrNANRvK052n7m1GwdU9N0t3zzL7e18BNOhHmqOAE
	0Ur+rzdRxe5C4gxiW8qNaumhPETYTMYMXazHRc8pb1H0YD1dFaRLY9YC8J8p6zqq6ZwarSl3Ejn
	ZZBS8hrGGzZik01QcI2CvNhWRvC7bSIZ9qWyRPSib2Y6Ud3YXEXBu4EmVJdXM6d3FH8M=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stefano Stabellini <sstabellini@kernel.org>, 
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

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen
