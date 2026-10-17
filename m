Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186843AE713
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264584; cv=pass; b=ReUoF4HW9xqUWYPT237q7aCoN6gUA9pvd43i692UkcjJrKUGGmwqkaBOP8Cd++OPkOuiHbZiOxwfafVKD/txLtikjNV7lomlrUzJUfWpl2NbDUcCV1hTx0gUs3lK2k89+K1niXDF/ZDapWryCrhR2lOB4vZy4IXp0JOkLXCy1tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264584; c=relaxed/simple;
	bh=Z4OyXcJagBnFQn/ViOZVUwTX8x9tggUpZX39gqflrPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghkOwsPbU4MoygOnEuSFb62tk0RAxhjWttATQh5Sufpp9SRhND/IBtz98E1ScbxDFcoeGtnB2ieCoollkEtOfPUktsFASiiG5Xs6VHFFjaPZbXKfMtFMzRUncNJMtvlio9dhdjsojngMjQWn2ELWiU0VTQEWslO7R6aWJvHS2qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABzC3x+e; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABzC3x+e"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6dd7070699eso571027eaf.3
        for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 12:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792264582; cv=none;
        d=google.com; s=arc-20260327;
        b=S5yf5iER50sHP4bDXYgLu0GonmHA8VV+Wv2ItXa30JO+4Fesas9GH6zLosJOYIUrAV
         gc1CV8ZHpJZDRdJIzJuaOLnnm+7qcWBd1FghrISTVtEK11YEWWT6uCcc38oY+TYCwV8B
         S3RPoxWdLRJkHQCoLz6mliJCRCAuVNMMsb4tA0J4Qow8Hv74pjoDogTwRTlDEGKxExc3
         K9g8ce+tJ8TN3tQKEXumVT3PBMunm3uzeMspsenbjOYjUmglJs778r4902VzDhiFlysb
         chK+QBanJq3Mn/AVPcEyuw3MxMUqJFVs103/Rn26mnD98AxQJiBkoR58ogqH9f59U/+h
         UJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3kpX1qw8aI9g0XRNJfIyX0LLMiylk567EvCY0vBBCeU=;
        fh=vVnUwq/ARgJ6xPXpIBsLrwoB0kohVi355hyZ2armnSE=;
        b=BqUW66vyiXVXyHBjuoS0J5lUX9BaT4exdWp3ehlWKVpTGUzlO4Gie5zCohYiSJG8q1
         TpoFc7uInLiCqceLHR9bOhGeNMMMPLgDPbzfmS7QzqoRL7XODMCw33qw9698PheD0oBB
         Hv2cB4SZb4ca5EAC+M8i8jiqn7jsHHAGpxW8kWOVeub01nqdIaWA3DM3LHk8DOAcitwD
         NDbUlBwD0xZklhRZhSMojI5CLfqzowdHebXOzHJDLyBnlLF47GFSV49gBOQfMR+8JXkM
         tPov0tFW3433CWIUr8aRL+ApJXSMIOXhBzxjn6/AFtbGNVGRxF4aidqb0tG9vM9ntoga
         Pwjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792264582; x=1792869382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3kpX1qw8aI9g0XRNJfIyX0LLMiylk567EvCY0vBBCeU=;
        b=ABzC3x+eqbR9370JWhcy+T35IkvABJwTI4joPbmTSu7XFYvG5o/9IkZlIZwYpDD9Ei
         U1/HbNyEDc1xvAbClcNOLOU/m0sTG01fPTXr+Bo+az0/sWMECqQvYcINioieCFNpZM1E
         2P1TppDcHBLVUdPfOweBsEf6mW/hwx44wXFZxy9lFMvxAvKTkQkXeww057yXhK2ETdd+
         X/GCmboLnIaA/YXk/9kY9b/WvLyphOOkKrOSry/MtWCxDojcJ+5NxYDcb4QZRpBUofxt
         IklrOF/FWd71zmPkP79swdjfepFXjAlsOKExtFYs2/f/1GuWf2wguRJXuJS2jUVMUSNv
         /cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792264582; x=1792869382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3kpX1qw8aI9g0XRNJfIyX0LLMiylk567EvCY0vBBCeU=;
        b=q9X654EnX4Y7v9BIMjtZElqc4E28bYMd9V1RZEc0j9Nv+kuHbKBKyAcgzhQKOx/NSM
         +ZLYVNWDKRVaXyRpyzkDbr6CsVeCIbeiuXGLyXpNoTS5c9Xvl4H0lomRv+CQ1da5C4Tv
         O7gPgx0ZXRlFX7+VDvwAis8ps+fY96zQFdZABIeN4nC7O2kaEtLqKbf5ZE3hKS0PZrev
         eIN7h5yBDop+soCJsEspAhfLuGQ56VjA0FADiL1NkoXGNlmZXS1+d1dvhVuSE8oI33ox
         BQzx9z60aZWhOCsHA0IboW12cIohl3aKmjoyPlpSFo3BRMdjvVcNZI8mYB8+W0wgqF3C
         nAyQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0com4ZlGMB7xw2N5w3M6wvzl47YE5MNyNrKr+JFEmgkfL/t6kBLN5gVqfqrf5VeXHF6K/GeYA4w8/@vger.kernel.org
X-Gm-Message-State: AFq9FYJnLtmJ6eCw1FFEun6hhYagIxdKv+EeKah9IOUCdIoem3910J5j
	M1w2WVv7Us0aNkYsF/Iw3MB9Ej4VXnpjY1DjENkbuR21HiYFKb4mciX2TiOX9JMjb7jAX886F48
	o1/2NBXI7KL/XUN9n5rcLU8ua6TJQdMA=
X-Gm-Gg: AYBFou1cKUFl9WQZ3YkI4mNte9m11cpdjt0d4/MomVocLuJKPzOsgi9cOVsLE+ciJKn
	YMevRd8pW0mVE40llT4CQ2cWy1g/nEelPxlomtKFa9pfZ2ynM/1M0Wwc1ROR84eaer33CipEJVm
	h6gQb9PIxhpJUZVpT7DdTVg0BmBzWUQa0uEeSEZT3GCCYiyo91mW2LQ9G9xm1K/Apk/BQ4aIwnh
	sDRR7idaDFStn9iaZqu74xAUT8c2Yti00vj+tsQj2JSgv6LScuXTkbuIhjurQLtFrAQk8IM8iTo
	3A/PoUiNjdmX4oIiZ5sKEV1FsuFGjRQGEsupv8E+vIzTEWqpGPsVLDo=
X-Received: by 2002:a05:6820:208d:b0:702:96cf:69ae with SMTP id
 006d021491bc7-70357f996a6mr2222268eaf.73.1792264581908; Sat, 17 Oct 2026
 12:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260807055952.GIanV0WDlB9-eP9VdV@fat_crate.local> <CAG4KcRJcpLREkbmOEEw7nGD+_PNOd+fWHkODqfWo1M8hmxA_Bg@mail.gmail.com>
 <20261017042204.GAatL37AhysV7BZBod@fat_crate.local>
In-Reply-To: <20261017042204.GAatL37AhysV7BZBod@fat_crate.local>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Sat, 17 Oct 2026 20:16:09 +0100
X-Gm-Features: AclHuK9ltyMIoKi-tNdGjK3uKrWCnIWl5RP71EvNz5XG4osLNZC_K9K1LqvUxuM
Message-ID: <CAG4KcR+9mHBBOpAw=_kN5Smd+KNCA=5-Fd5nkFgVRi5XC7Yf-A@mail.gmail.com>
Subject: Re: [PATCH v23 0/2] ACPI: Add support for ACPI RAS2 feature table
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com, 
	mchehab@kernel.org, ashok.raj@oss.qualcomm.com, jic23@kernel.org, 
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

On Sat, Oct 17, 2026 at 5:22=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Sun, Aug 09, 2026 at 05:21:35PM +0100, Shiju Jose wrote:
> > > +static int ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx=
 *ras2_ctx)
> > > +{
> > [ ... ]
> > > + if  (ioread32(&ps_sm->params.flags) & RAS2_PS_FLAG_SCRUB_RUNNING) {
> > > + ras2_ctx->od_scrub =3D true;
> > > + ras2_ctx->base =3D ioread64(&ps_sm->params.actl_addr_range[0]);
> > > + ras2_ctx->size =3D ioread64(&ps_sm->params.actl_addr_range[1]);
> > > + } else {
> > > + ras2_ctx->od_scrub =3D false;
> > > + }
> > > +
> > > + return 0;
> > > +}
> > Does this logic misidentify a pre-existing background scrub as a demand
> > scrub?
> > If the platform firmware has background scrubbing enabled prior to driv=
er
> > initialization,
>
> First of all, when and how can that even happen?
>
> How can it happen that the platform has enabled background scrubbing befo=
re
> the driver loads?
Firmware can start the background scrubbing before the driver loads.

>
> And if that behind the driver enabling is legitimate, the driver should l=
oad
> and ask the hw what scrubbing is currently enabled and mirror that in its
> internal structures tracking those settings, right?
Yes .This is done in the ras2_mem_drv_probe() by calling
ret =3D ras2_update_patrol_scrub_params_cache(ras2_ctx);

>
> I haven't looked in detail yet so perhaps you're doing it already. I need=
 to
> clean up that code first, though, because it is very hard to read.
>
> > ioread32() will read RAS2_PS_FLAG_SCRUB_RUNNING. Because
> > the driver's internal bg_scrub state is initialized to false, this assu=
mes
> > the active scrub is a demand scrub and sets od_scrub =3D true.
> > Would this prevent the user from controlling hardware memory scrubbing =
via
> > sysfs, since writing to enable_background might return -EBUSY and
> > writing to enable_demand might return -EOPNOTSUPP?
> >
> > Shiju:  This is not a valid comment.
> > Please find a description from the spec.ACPI spec 6.5 RAS2
> > Table 5.87: Parameter Block Structure for PATROL_SCRUB:
> > Flags (OUTPUT) : The platform returns this value in response to
> > GET_PATROL_PARAMETERS:
> > Bit [0]: Will be set if memory scrubber is already running for address
> > range specified in =E2=80=9CActual Address
>
> Which memory scrubber? The background one?
Hi Boris,

demand scrubbing. Please see the reply below for more details.

>
> > Range=E2=80=9D.Bits [31:1]: Reserved, must be zero.
> >
> >  ioread32(&ps_sm->params.flags) & RAS2_PS_FLAG_SCRUB_RUNNING
> >  ACPI spec 6.5 RAS2 Table 5.87: Parameter Block Structure for PATROL_SC=
RUB
> >   Field: Flags (OUTPUT): bit[0] - returns status for demand scrub only,
>
> You lost me here. Where is that stated in that table 5.87?
>
> Confused just like the AI :)
Please see three fields in the ACPI spec 6.5 RAS2 "Table 5.87:
Parameter Block Structure for PATROL_SCRUB"

"Requested Range(INPUT)"  & "Actual Address Range (OUT-PUT)"  -
(Description) "If OSPM requests default scrubbing through Bit 0 of
the Configure patrol scrubbing (background scrubbing) field, then
"this field must be ignored" by the platform".

Note: This states that both "address range" fields are valid for
demand scrubbing only.

Flags (OUTPUT) - (Description)The platform returns this value in
response to GET_PATROL_PARAMETERS:
Bit [0]: Will be set if memory scrubber is already running for address
range specified in =E2=80=9CActual Address
Range=E2=80=9D.
Note:  This states that  Bit [0]: of the "Flags" field is valid for
demand scrubbing only.

Thanks,
Shiju
>
> The rest later.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
