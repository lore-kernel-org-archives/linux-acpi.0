Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824216;
	b=ksxowdhpBzOyoavcYufPwebKdeT3cd79FnGtJgHjzb8M1+yKF+T8URmD5/XwCHhKDUs9
	 3JL68xYG0E+7XGXndcUsEz3uiZvdBZBniLNE7CVc7F1y6tuo2FL4s3HSbgwr6FFZp96dI
	 nHp+9Q1ShQNp168MiRYu41saeYcIz8GJZQw7eXGYdSFgTF+2Xe0Z16+rz/fy6iePwXL04
	 u/1FPUo1agTjMGSGCUYBpSknBxU2VTmjG4YXssvgvX/1f0soIQw1CST+OL54elO7e8EIJ
	 jDoDveZfviCkGC7KuLnrvDlYHqxRq7yTKgK1kFMAs8GTxA0R9qCOkErvjtzO0siuMEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824216;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MUqmEjQiDyXh4Fy1G1n8A/EyQ/xm3gIfckBPjkYh8nI=;
	b=EpCGiLcuGBMX1bWAYd9jub1JJU4ce8PXbvHx7tqZD2BhXaOMHRS2tkqFJcY9QviCa48j
	 wl0SaN21IXkWsyA011o5x3+A4Fj60Bbxx7Bt84L4+2ZqXv4ACaDtmzlh2OUdfiqfs/f9m
	 FhyG+OavzwDwAlJeMRQo60aA9TNyxlIlTjAGfDQT88LWT7YJHqVxFJ6UB+KSNy1tbeq/f
	 cO88KFBWQKAzDdJxy9hSHX+izJ483SNIdLiJe1NED4WJ5IMji2k/1sXUlNx09jW1gKK0X
	 VcGYf/Y/v9+mMidtrCnK3obwfX9uRjmbjX5NMlx0xwzz4lCCe4nkJyqWn3V/hBZC9KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pm1x6lUH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5516070313
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pm1x6lUH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3556C1F00A1E
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824215;
	bh=MUqmEjQiDyXh4Fy1G1n8A/EyQ/xm3gIfckBPjkYh8nI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Pm1x6lUHePQLpQa12onR5NIh/2+wiooaqTTt9oK77hAQOqbhN2YkQbC1Z4Vpi6ihA
	 BFQBmbXlx2u28Vvi+04sXCIkvOOtlu55jw4GfxjHH7bPGnZdR3p6sio2PPhwVX63KB
	 e/y7IsICJdnHRXYHUuMqG1n2OBfT1pFB7b2VYYkyX1NPNi9A7/x6PVij5Q3Ung04HW
	 A3Vf5TEWxMpXhzWuuen4/fnnBXpNQ/jk/IV9NUG9/S/UGGtBPm39fflpuJ1iiMxtB2
	 9vIQ3bPbSNtc0aQQoqzT7GJmcBhOQTzoeTe7clz1mNvwrl7EX/gb9924C1Y3h8aVyu
	 d1Fo7s7KakEDA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ba328513b9so951333e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 12:30:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxOEt9/55SUpiADFc0kqphs+0WA3GyH6jUTy0awMV2ieXOLBnrHZ3Z9sSqEFFvD3VetH494PAFoqyjQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+JQHgXVDJfdtI4wyJB9HiuYHR8Wgh5+drjxTaNhJ9vmNpsIUxt
	QSKyyPVjJ3+/11SfDxcWOIfniEZ3ptlI3RCrLbvb//OjAqRpxewKo1tOueY7sZ8FX7DMPBYA5XU
	pl4rpJpzVQnCccbY6zO6nIx4YscpSfxI=
X-Received: by 2002:a05:6512:3a89:b0:5bf:a036:3e4b with SMTP id
 2adb3069b0e04-5bfd954b85emr5964083e87.7.1793824213504; Wed, 04 Nov 2026
 12:30:13 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-ghes-hwerr-sev-v1-1-145ceb996c77@debian.org> <9a375554-57ee-4cf4-8d84-60511c96d8ea@linux.alibaba.com>
In-Reply-To: <9a375554-57ee-4cf4-8d84-60511c96d8ea@linux.alibaba.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 21:30:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iXwVS8r67NV3KjcZtpHONYTQCF79TnXsNL-N4uiaaGGA@mail.gmail.com>
X-Gm-Features: AclHuK-7kjHHiBpwTEf80kUIfdqsskeRw3vF-XeO5xJVCOs50HtHMmyFSu4uzU4
Message-ID: <CAJZ5v0iXwVS8r67NV3KjcZtpHONYTQCF79TnXsNL-N4uiaaGGA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Fix severity check in ghes_log_hwerr()
To: Shuai Xue <xueshuai@linux.alibaba.com>, Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 2:16=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.co=
m> wrote:
>
>
>
> On 10/30/26 8:18 PM, Breno Leitao wrote:
> > ghes_log_hwerr() is meant to count recoverable GHES errors in
> > hwerror_data[], but it skips them and counts informational records
> > instead. As a result, recoverable CPU, memory, CXL and vendor-specific
> > errors reported through GHES never show up in a vmcore.
> >
> > ghes_do_proc() passes ghes_log_hwerr() the record severity after
> > ghes_severity() has converted it to a GHES_SEV_* value.
> > ghes_log_hwerr() compares it against CPER_SEV_RECOVERABLE, which is 0
> > in the CPER enum and matches GHES_SEV_NO, so only informational records
> > pass and GHES_SEV_RECOVERABLE ones return early.
> >
> > Compare against GHES_SEV_RECOVERABLE instead.
> >
> > Recoverable PCIe errors that ghes_handle_aer() hands to AER are also
> > counted by pci_dev_aer_stats_incr(), so with the check fixed they are
> > counted twice under HWERR_RECOV_PCI. That is not addressed here.
> >
> > Fixes: 3fa805c37dd4 ("vmcoreinfo: track and log recoverable hardware er=
rors")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   drivers/acpi/apei/ghes.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 663dc2e601cf72..5d888c82efeaa3 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -899,7 +899,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
> >
> >   static void ghes_log_hwerr(int sev, guid_t *sec_type)
> >   {
> > -     if (sev !=3D CPER_SEV_RECOVERABLE)
> > +     if (sev !=3D GHES_SEV_RECOVERABLE)
> >               return;
> >
> >       if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||
> >
> > ---
> > base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
> > base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git master
> > change-id: 20261030-ghes-hwerr-sev-e440624108b6
> >
> > Best regards,
> > --
> > Breno Leitao <leitao@debian.org>
>
>
> LGTM.
>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Applied as 7.4-rc material, thanks!
