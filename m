Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7B427A10
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661558; cv=none; b=uZyNH5hRbNqKqRUdxbEejuBxRSMAu15rmPDp8ikAN9qGxU7gplWVUDtV2PNKOs/fRWboXhzrd+NrufJGnLb+j3+DtOpZLo1eNV/9gO2W6/BSOOA/7W5Z6oWcBD4jECI28rwv3YR91mKmSGbBptw6KO99Konz56d/M6+Ps7JNQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661558; c=relaxed/simple;
	bh=LfuLGMStzF1m2LVS6CuY3v+eMV9BmENzXspMTBzBiig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2sYPfvwHYyAdILnbG1HMhd6cnLniRMRbJRt2oeMekAcDwRdck/Cq105J318ADxge62WtYJmrzkSk0E3aA0ZZMGc+PY8IjhhjXHV8EFJWjfpeTIfxodtRgFhitkdXoORIyfG2IOhjvZMK8EQgDIDqlgGty1e2Ax7/QFFeZttFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlF85q/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlF85q/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30B01F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661556;
	bh=W/BKvjdp/4/Dp9hX0nDJhIq57/XuC5OzN1k+wU0jfbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hlF85q/xyaDlGk0BQd6FB/wDWUpU23W4ob5nVcVEvPc0eEiccu/77qxm/3sQbcqnq
	 s4vDSMYoXqFHf3DaKlg483v1S2LChQ6O9StJVmRwAT6/yKVZBYuTmBw06eBAEp45HV
	 I/Y9rE3vahFR4LaR+jW+52p1G2NK7957t9zehesYHFYzRNXbVeK2ZZBo9gkfe0H+ug
	 AoGheTG3hm4LDAGVZhz4zY+upNxN0d2U8xT5Ij/1M5VQrzODrsSNPAb6VR/ryKDSQr
	 zG6YlRkwYg7cUuLwWrX3rMHlzLsYg5ObJ5iBT/W+jz9W+6u9dKMr/Y//vgPjMdtl7x
	 A9MK3y8dUFbUg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b2aab18795so41240e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:19:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywxeu5v7dIVvr1mZ+U3exTI3lG8xW7DSqK6MVCcPJe88VA10Ci2
	f2yVs86gDIJoFtaovDzPERzOzq+uqckefpU3XWPHOw5uS9WSuR8gJldCEIJbbBLrTUBzgnZaGfN
	vWPoYB5RkrgPvx0ZX9Xe0lAyC9TCer68=
X-Received: by 2002:a05:6512:2312:b0:5b2:a344:2a8c with SMTP id
 2adb3069b0e04-5b2a3442cb1mr1510978e87.30.1784661555295; Tue, 21 Jul 2026
 12:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717065129.72924-1-trenn@suse.de>
In-Reply-To: <20260717065129.72924-1-trenn@suse.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 21:19:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iqW3q0QOzsW6O3H1+ysOv5uKDGwMejJ4JCvi0RQb+how@mail.gmail.com>
X-Gm-Features: AUfX_mxiLE3UCEZ4VPW_tAoS7lEW8rKtaLrwtIC-LY_tuyHa_Nt1Tiqr8M1sBBg
Message-ID: <CAJZ5v0iqW3q0QOzsW6O3H1+ysOv5uKDGwMejJ4JCvi0RQb+how@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix sysfs duplicate filename if multiple BERT tables exist
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 8:51=E2=80=AFAM Thomas Renninger <trenn@suse.de> wr=
ote:
>
> Previously sent to linux-pm:
> V2: Do not use acpi_get_table, but pass both,
>     struct acpi_table_header *th, struct acpi_table_attr *table_attr
>     as function parameters.
>
> Cmp with:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1270211
>
> dmesg | grep BERT
> ACPI: BERT 0x00000000DD695238 000030 (v01 AMD    AMD BERT 00000000      0=
0000000)
> ACPI: BERT 0x00000000DD6955C8 000030 (v01 AMI    AMI.BERT 00000000 AMI. 0=
0000000)
> ACPI: Reserving BERT table memory at [mem 0xdd695238-0xdd695267]
> ACPI: Reserving BERT table memory at [mem 0xdd6955c8-0xdd6955f7]
> sysfs: cannot create duplicate filename '/firmware/acpi/tables/data/BERT'
>
>
> Thomas Renninger (2):
>   ACPI: Use correct region struct for BERT region size check
>   ACPI: Properly map BERT and CCEL acpi tables to their data tables
>
>  drivers/acpi/sysfs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> --

Applied (with some modifications in subjects/changelogs) as 7.3
material, thanks!
