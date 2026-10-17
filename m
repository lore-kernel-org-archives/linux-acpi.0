Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6441925BC;
	Sat, 17 Oct 2026 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210980; cv=none; b=Bxt0XP3Cd986/nAOw+sqx26ERPmgIZgUu3vMyxLYY5DjFPTJgo6VSO+PWSwEei9O7UN4KBNXHsQES75AbfTOpGjLmKQe0udLafnlA3f+YMCYZjQmMzrKxSHS5U+9saQcTEQWKHBxXvB63XKMax0e6pblDuq7Ds1KuWXizt86W4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210980; c=relaxed/simple;
	bh=R+SpqW4MZ48QJKzzDNXKrEGl63U9IRkjWNCl0O/GHmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5k/uu/Z6itUnYFZoLvWRWSJQFcma77wZ62F3vPVB8CzhSUSpnGOe1nHb9tY4f/uhI8/a2Hc2qNR9/tYKW+tgV9pHVWrsou6+Ix3hIAx+Px/7eaTMu7YdLydZKSue1gndBdusGcpEUtV0phDw19zBwg44kxhWTssM7s5lFmnJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GqdIvXw8 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GqdIvXw8"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5F26540E03BE;
	Sat, 17 Oct 2026 04:22:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TUYCDTo08E0I; Sat, 17 Oct 2026 04:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1792210965; bh=kDZQQH7hqxy27MFGHbhtcoKGmXL6dyq5YBHj2HXhVsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqdIvXw8GTcynBcaSSC/jLrsVdzfNLOypcTTmoIwMf4sELi6zAZUEq4RUL7XO9Bdi
	 INSw2oxapHOv8JbF1PLl5soo1PDG3N/iOeI9YwzyLwCxNz49ofvnllEmK0CH5A0Omf
	 qhLRS+KI1XsQSIFc0G3UpzgQ8PghjJYGVchptViY07Zmc5UwyuvTkTAoZ5vxZBaGcf
	 5mSDWvNBC6EfMgkQYfASvtkS20GTucP7ZD8b7Xguil5cuovBsJcioh8LnvPN61e8Eh
	 VxMHFHEMn9Xe4IrDDSJECr0x474sJskG8+ZvZY+o9Q9EQjzn/iYPX6aEv14opfDXUr
	 9W9MUV5vjCbCFhVApkXOYaI5EhZjmNMeP++uiI/BbAJ3GvG5oVIoGcvMRr2T8bWHFx
	 QGEq9SbkwSRMkBQWykPO+OXotKuPWoo4pFHQRv6L/sf3kjsEtJTP0pQpSRIhdTGpxW
	 hacx1YYlDs4iVyTz5UXdxbZu/pZxrJj+ED6rhLq5cbAcNOBNhO9yuwviFagaMyVFbR
	 7SqDUlNhzLELw24/JqoPGRxXkDhAg3D4TeLaj/zOQrZKKFng+ChN8Z8pPy5v/Vsho6
	 ixdTKO+Zns8y1Rg3Ae24/T6z0Mk0b4/ODtaBCYZHWhfGf0LpaHYp5AligPDxps8vTB
	 1gv5ItyVg++gFtiJQrOP8WBY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4471840E01B4;
	Sat, 17 Oct 2026 04:22:08 +0000 (UTC)
Date: Fri, 16 Oct 2026 21:22:04 -0700
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shijujose2008@gmail.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	Yazen.Ghannam@amd.com, mchehab@kernel.org,
	ashok.raj@oss.qualcomm.com, jic23@kernel.org, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v23 0/2] ACPI: Add support for ACPI RAS2 feature table
Message-ID: <20261017042204.GAatL37AhysV7BZBod@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260807055952.GIanV0WDlB9-eP9VdV@fat_crate.local>
 <CAG4KcRJcpLREkbmOEEw7nGD+_PNOd+fWHkODqfWo1M8hmxA_Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG4KcRJcpLREkbmOEEw7nGD+_PNOd+fWHkODqfWo1M8hmxA_Bg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 09, 2026 at 05:21:35PM +0100, Shiju Jose wrote:
> > +static int ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx=
 *ras2_ctx)
> > +{
> [ ... ]
> > + if  (ioread32(&ps_sm->params.flags) & RAS2_PS_FLAG_SCRUB_RUNNING) {
> > + ras2_ctx->od_scrub =3D true;
> > + ras2_ctx->base =3D ioread64(&ps_sm->params.actl_addr_range[0]);
> > + ras2_ctx->size =3D ioread64(&ps_sm->params.actl_addr_range[1]);
> > + } else {
> > + ras2_ctx->od_scrub =3D false;
> > + }
> > +
> > + return 0;
> > +}
> Does this logic misidentify a pre-existing background scrub as a demand
> scrub?
> If the platform firmware has background scrubbing enabled prior to driv=
er
> initialization,

First of all, when and how can that even happen?

How can it happen that the platform has enabled background scrubbing befo=
re
the driver loads?

And if that behind the driver enabling is legitimate, the driver should l=
oad
and ask the hw what scrubbing is currently enabled and mirror that in its
internal structures tracking those settings, right?

I haven't looked in detail yet so perhaps you're doing it already. I need=
 to
clean up that code first, though, because it is very hard to read.

> ioread32() will read RAS2_PS_FLAG_SCRUB_RUNNING. Because
> the driver's internal bg_scrub state is initialized to false, this assu=
mes
> the active scrub is a demand scrub and sets od_scrub =3D true.
> Would this prevent the user from controlling hardware memory scrubbing =
via
> sysfs, since writing to enable_background might return -EBUSY and
> writing to enable_demand might return -EOPNOTSUPP?
>=20
> Shiju:  This is not a valid comment.
> Please find a description from the spec.ACPI spec 6.5 RAS2
> Table 5.87: Parameter Block Structure for PATROL_SCRUB:
> Flags (OUTPUT) : The platform returns this value in response to
> GET_PATROL_PARAMETERS:
> Bit [0]: Will be set if memory scrubber is already running for address
> range specified in =E2=80=9CActual Address

Which memory scrubber? The background one?

> Range=E2=80=9D.Bits [31:1]: Reserved, must be zero.
>=20
>  ioread32(&ps_sm->params.flags) & RAS2_PS_FLAG_SCRUB_RUNNING
>  ACPI spec 6.5 RAS2 Table 5.87: Parameter Block Structure for PATROL_SC=
RUB
>   Field: Flags (OUTPUT): bit[0] - returns status for demand scrub only,

You lost me here. Where is that stated in that table 5.87?

Confused just like the AI :)

The rest later.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
