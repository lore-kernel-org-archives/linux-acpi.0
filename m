Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515EC269CE6;
	Wed, 11 Mar 2026 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232801; cv=none; b=CfZNppHo6R9EiAysDbrGEyoRqGmfv83OKX76sp0A/VHJiRj/ju5CPX+xUnTuik9j7RBRdqZA5ERjsW+Cs2lTe0fqNY6N+376kqC/IQOoW4bFitq5cJZUXU/DESZXkQn+PDe7YZwbe1kIgrFd8XjEn74ioJIkiGzdzl+hpFrcCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232801; c=relaxed/simple;
	bh=CXmlH99kGw85pQrLoBsTcEEnfwm4/fSlpbsS8YLfIp0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/AW9+tlLRq9goRZ4jl/qOSAN3ONZXbiEde0vfdojxHH3Ip+HmLJEDTdAbj/ao/vrvTjNZrJbAYL+CPdjxh9g0g1wxC0VBe90TTdYIp2j92HX0eCpuw0ODbC7hNi0Ho5/LIyStFx+pCVRPuwQZO9ri6Sjc3hajbslse7IHAW+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fW9Kg5zfszJ46jW;
	Wed, 11 Mar 2026 20:39:03 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 06FEF40587;
	Wed, 11 Mar 2026 20:39:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 12:39:49 +0000
Date: Wed, 11 Mar 2026 12:39:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<Dmitry.Lamerov@arm.com>, <catalin.marinas@arm.com>, <bp@alien8.de>,
	<robh@kernel.org>, <rafael@kernel.org>, <will@kernel.org>,
	<conor@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <krzk+dt@kernel.org>, <Michael.Zhao2@arm.com>,
	<tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 01/11] ACPI: APEI: GHES: share macros via a private
 header
Message-ID: <20260311123947.00000be3@huawei.com>
In-Reply-To: <d0911510-9f87-49ed-b896-fa00e5d2a98b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
	<20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-1-347fa2d7351b@arm.com>
	<20260224152230.00000531@huawei.com>
	<d0911510-9f87-49ed-b896-fa00e5d2a98b@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Mar 2026 11:39:38 +0000
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> On 24/02/2026 15:22, Jonathan Cameron wrote:
> > On Fri, 20 Feb 2026 13:42:19 +0000
> > Ahmed Tiba <ahmed.tiba@arm.com> wrote:
> >  =20
> >> Carve the CPER helper macros out of ghes.c and place them in a private
> >> header so they can be shared with upcoming helper files. This is a
> >> mechanical include change with no functional differences.
> >>
> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com> =20
> > +CC Mauro as he's been doing a lot of work on error injection recently =
so
> > can probably review the use of the various structures much more easily
> > than I can!
> >=20
> > My main comment is on the naming of the new header.
> >=20
> > Jonathan =20
>=20
> The content is intentionally GHES=E2=80=91specific CPER handling,
> not generic UEFI CPER. It's the GHES view of CPER parsing/handling
> and is used by the shared GHES/DT path, so keeping it in ghes_cper.h=20
> documents that boundary better than moving it to ghes.h (which also=20
> contains non=E2=80=91CPER GHES logic). The helpers moved there are the on=
es=20
> needed by the shared CPER handling path.

Ok. So the intended meaning here is GHES and CPER, not stuff specific
to the CPER aspects of GHES.  Maybe, though I'm not sure why you
don't just name ghes.h in that case as GHES always incorporates CPER.
I guess because that file already exists and covers some ACPI specific parts
and HEST bits that aren't of use to you.

Ah well, one for the ACPI maintainers to perhaps suggest what makes
most sense to them.
>=20
> >> ---
> >>   drivers/acpi/apei/ghes.c | 60 +-----------------------------
> >>   include/acpi/ghes_cper.h | 95 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> >>   2 files changed, 96 insertions(+), 59 deletions(-)
> >>
> >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> >> index f96aede5d9a3..07b70bcb8342 100644
> >> --- a/drivers/acpi/apei/ghes.c
> >> +++ b/drivers/acpi/apei/ghes.c =20
> >  =20
> >>  =20
> >>   static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_EST=
ATUS_CACHES_SIZE];
> >> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> >> new file mode 100644
> >> index 000000000000..2597fbadc4f3
> >> --- /dev/null
> >> +++ b/include/acpi/ghes_cper.h
> >> @@ -0,0 +1,95 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * APEI Generic Hardware Error Source: CPER Helper =20
> >=20
> > There is other stuff in her usch as the GHES acks etc
> > in ghes_clear_estatus(). So I think this intro text
> > needs a bit more thought.  The boundary is already rather
> > blurred though as for example cper_estatus_len() is only
> > tangentially connected to cper.
> >  =20
> >> + *
> >> + * Copyright (C) 2026 ARM Ltd. =20
> >=20
> > Doesn't make sense to ad this copyright in this patch as so far
> > it's cut and paste of code from a file that you didn't write (at least
> > not in 2026!)
> >=20
> > Might make sense after a few patches, in which case add the copyright
> > when it does. =20
>=20
> The file is new and maintained by Arm as part of this refactor,
> so I kept the header consistent with other newly introduced files.

It's code moved from elsewhere, so you need to at least also list
the copyright of the original file alongside the new Arm one.
Just moving it and dropping that copyright is inconsistent with
the license.


>=20
> >> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
> >> + * Based on ACPI APEI GHES driver.
> >> + *
> >> + */
> >> +
> >> +#ifndef ACPI_APEI_GHES_CPER_H
> >> +#define ACPI_APEI_GHES_CPER_H

