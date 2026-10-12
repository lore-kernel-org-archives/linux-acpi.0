Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B83A839B
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789671; cv=none; b=BCWkZ31uufF+4pqHap1dbv2Lbn/4jaXvjsf1jrnH5gsFHQbEPvBcakxQ5taafY7rUC0uNZxROCYpaF/ElhuGpXMvV7jOL246KMqlQYN6h0W/RawvyORdd4ZkUrf73j7qOyvzpC4PVB9MqTOnT9BDH3324sKfej7j+ydLE1GyxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789671; c=relaxed/simple;
	bh=GlPJFBH/QQaGpWj2HTUaP+XhfB/ILKkWcWTtXLgnGnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1sU4yZatwFm/Oqfq1Rfyjuf1903d+aBlmK6R7pnuysuztvd/DL9VnHnc6tf6H0b6Q4NIQ//7NjQ0CyWmy4blRJgs3l15dj0Tvgybp+oinJ0C4M6WweC4LJK3zZWBBESTbOHlSUdQ4ZfcCts25pca0vfM1XXa9iig9WCjQzT3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5cPIcd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5cPIcd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C621F0089E
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 07:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791789669;
	bh=E1EzNNVWzoVsaQJ5ysflzUxIgWV051RNj1SflKkQXWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I5cPIcd/1R6JVkxSZhtYPyRF5PVkCY7kac+RYLcylwiw5g87HDsd7xhp1Z9sPBV0B
	 G/SCHA+iqR6fdffK3KAlG8v3rnJZ8xTQGLf+XXAF0IYjSCEc7WU3L500czspn+PLH+
	 cohqb6OL3M3dD7nR+PQ81NCzj636CQyKeJ+q9cDMRgf3WOeuDPMdZ1n/qCTNXMRHv9
	 LIjPA4BfDSKxZ+dNYetnvYtNc92ukj3LtZ/Djd107KBh2fDEuD6q0M+zZOays2qTVM
	 ovb7bqgqIvPE+v/gam84FO8rs2U2xQ2THImE48LZZOooEeqX2N1NkuuqVF0vXbMJtf
	 U8zrZ4+KoudUA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c20ce3c118aso111767366b.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 00:21:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwyNNRkYykzsTQumf66xp/OOv4Bhh/h4SumlbZuTflkqDNnftUMLSdE+GNJcaWXq/fglHtJH+lWhdqk@vger.kernel.org
X-Gm-Message-State: AFq9FYKbx7rggamUo+1wJweDctNvZPUyak5FPFIxSXBzY1Yag/W6Jnoo
	hbFo0vp8FcZJgSvImorIZ1UOsFVdqAwfUpdYsU9GTUiK+DCzZWH14JM4f6En1hbOTG6xLmnX1qQ
	86KS0QYUHvxW8+ZP1VungaqWSE1vCKzs=
X-Received: by 2002:a17:907:c8c4:b0:c2d:c0ce:8465 with SMTP id
 a640c23a62f3a-c31a6999fe9mr871638766b.0.1791789667484; Mon, 12 Oct 2026
 00:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
In-Reply-To: <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 12 Oct 2026 15:20:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com>
X-Gm-Features: AclHuK8x62gs_C5UF1Qg2VLiQQD2G3P5vBVPyCdu0AvLT7ob8451ejbWRTFvLCM
Message-ID: <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Bibo Mao <maobibo@loongson.cn>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> This change is already merged in acpica tree.
>
> slightly ping.
I will merge the last three patches once the acpica changes are synced
to git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git.

Huacai

>
> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>  > According to the IOVT specification, define macros for each bit of the
>  > Flags field in the IOVT IOMMU structure.
>  >
>  > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>  > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>  > ---
>  >  include/acpi/actbl2.h | 7 +++++++
>  >  1 file changed, 7 insertions(+)
>  >
>  > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>  > index baef525367b5..76e4a5bc79b4 100644
>  > --- a/include/acpi/actbl2.h
>  > +++ b/include/acpi/actbl2.h
>  > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>  >       u32 device_entry_offset;
>  >  };
>  >
>  > +/* Masks for Flags field above */
>  > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>  > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>  > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>  > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>  > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>  > +
>  >  struct acpi_iovt_device_entry {
>  >       u8 type;
>  >       u8 length;
>  > --
>  > 2.39.3
>  >
>
