Received: from mail-yx2-f36.google.com (mail-yx2-f36.google.com [74.125.224.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADB4A8432
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267421; cv=none; b=FqRfwauUQGkD4VSYXJVqusj8NVTXxVtXaDzkHzZjllXBNd3l5aAtm/8ksUESbS1MPpPGJop1ysOKj/tecvt8Jjck7uD2+ouqCCXJHSSM/tQcpKdZCc6jONCvrYPC2RumDaGOO/bXxb0k702gc89OP2tTmVW0R00ahnYohvOJPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267421; c=relaxed/simple;
	bh=JBDGzc60077SgcewoR3vKPZnAOMKOUz6ytxF3+0PB5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvTPZiFFjas6aiuVZ/4jAPz1OMtBV4QnZNQrB7cZeUPRzcW26uFO0s+V1//KLSD+taY5hFhr1kXCwp6v2r8YO34uQibwGdZV2XYOsbHO7N9dF26qTNzP6tZkNtaDrU4xQPPmhTSQcuWdhClNngVX4B3lWahaciJOg314ngL1Ojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnhMYw4L; arc=none smtp.client-ip=74.125.224.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnhMYw4L"
Received: by mail-yx2-f36.google.com with SMTP id 956f58d0204a3-66e4aaf2ecfso110304d50.1
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267417; x=1790872217; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Rnw2ZxPq8QQGfsa2N17k5WV6br+EhptPqyuYf7fWpE=;
        b=cnhMYw4LuxuOBbWH3PfSlx1kWrZeqhtB48vtrBha8irDkCv5oAswgyKQdAzK9mJcx+
         qKNzfpMP95ZBttd0RPmwka6/ibThNCNNa9MWKtiLPimiU19k7Ef0lLKTf0+uOxgYZHdr
         R2YwoBCO8MXEQ8XZVsAUs9rdN2HgL2KIYOoTcLkvAKrQJzIukBJ8mCVP5/VHr6dgOReZ
         nAR8gFT0LCYt+VrwVgO2BZh5Kq03My1l50UxawyBjAM30tbWqVq8SfVjBXgjdKcVD/Dk
         s6WJWb3aFi58vEusg2tG9GJmsUKvw1mD7rP4qrv5bDJVHnnY4cwFEpoIb2sACub7qpXF
         Ezmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267417; x=1790872217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Rnw2ZxPq8QQGfsa2N17k5WV6br+EhptPqyuYf7fWpE=;
        b=2VwxBjJa8taE7CtyT/TvGkOdFAxEjdlV3uXBLh6NF4DCDREJwtIiKP5mtpkTzdOFoj
         tvA83HJgk1kHX5xgRTZnNhFNcT1G+5keVpnz5DUjWyFo0bMmRLrci6z+zjxOiYmgQ4vD
         xI0szgWKvS9etmvZz3v/GJE6RtlCZhS4Bh28k3JsDXd6n60KjC8Zt/9EJNMkjOaYcN4n
         EszAtRP+qgCM3+KafNRSXAaSsFIU3aIvptjaKwccD9xwjEqLl4+/Q16uz6b404aQ+3qJ
         Jq/omfgjXm7zhW9/WZh6WwoOZODqcLcE1k5E3mAdrRKucVEfPi1aNVjsfvH3JzuOPrmI
         TCcg==
X-Forwarded-Encrypted: i=1; AKwUvBxJUIhRMyjkI18jXQ1iX27SNco7RTSeBYTlJtq7ytI+YRjDcOLpysq2EMsY/PTZIL1EhU3eKnkbF8MF@vger.kernel.org
X-Gm-Message-State: AFuF++n4lzcQH7N/46LHZleysArKVYqhzwBlgOQWCjKkFfCuo3K3fpw0
	vDkOtMHyJ8pQU3OYzxmS06zxr2d9/pMdbYhpdAHhgxDzLnSxKMzAjon9
X-Gm-Gg: AYBFou02lDDr3dWzMP9ny+vQ1gKKLGqNFypwXCCNp4aHccEuzL1TVKVS3LDm9hdlwxu
	2qpXTzkOh8iiNOHAZz4w4hHJ/DMgbvMM+v93/2mT6/gcU61Nsx0uv2CPWIFPzVsZ0gnZ+I/9JVu
	7OYrSgeM9nuiqJUQA2UNE++zWVsO4zTwss7J6mfiyFMegFlrehBbxpiyEXtdEtgWdvlI5Q4Ai73
	mkN19akXJiFwAf1xWdvyK+knL3w8+csXSmtb1NP6wKvq1lLtwU1LJses7zmItqfUVXqgu8GXmc5
	3qiTQDeRq505+krkDSWyfBCtbujYKMYK5zO0V6XGQiSAc07MuSGRjWrQzkTe7rrnWXVEkOqSZgs
	EE+KZV9zlcvCBTbJvHHCQeToL46ESEitqY7/tRaIZfIHxUW5LxnxsodF5N0FLaQaRkyduBYQSD2
	/wD9ztXx1TpNDQZORCUGRrVQHcYyTr8NIghGWbrHurBmgZ2BDxzTLtkGZbjnt3aE0Re8KLtRJ2X
	B2i
X-Received: by 2002:a05:690e:12ca:b0:672:a450:6932 with SMTP id 956f58d0204a3-672ed36dbecmr2089408d50.70.1790267416650;
        Thu, 24 Sep 2026 09:30:16 -0700 (PDT)
Received: from deathstar ([2600:1700:22f5:9081:10c5:856:4833:d269])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672d81ce7dcsm2254959d50.18.2026.09.24.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:30:16 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:30:13 -0700
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Saket Dumbre <saket.dumbre@intel.com>, Len Brown <lenb@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Bob Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com, kernel-team@meta.com
Subject: Re: [PATCH] ACPICA: Fix memory leak at acpi_ds_create_field()
Message-ID: <arVPNWY3HziZkU1p@mail.gmail.com>
References: <20260813-acpica-pcc-field-leak-v1-1-3d6c5f0eb557@debian.org>
 <CAJZ5v0isQYRN9aZCmWty-kZpjHvZWyJT2AnRXs9RDszy7b5TkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0isQYRN9aZCmWty-kZpjHvZWyJT2AnRXs9RDszy7b5TkA@mail.gmail.com>

On Thu, Aug 13, 2026 at 03:39:37PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Thu, Aug 13, 2026 at 3:35 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > acpi_ds_create_field() allocates internal_pcc_buffer for operation
> > regions in the PCC address space.
> >
> > The function runs once per field, so a second field on the
> > same region overwrites the pointer and orphans the previous buffer.
> >
> > The matching ACPI_FREE() in acpi_ut_delete_internal_obj() only ever sees
> > the last one.
> >
> > An arm64 platform whose SSDT declares regions with multiple fields each
> > leaks two buffers at boot, as detected by kmemleak:
> >
> >   unreferenced object 0xffff000051e65400 (size 192):
> >     comm "swapper/0", pid 1, jiffies 4294668436
> >     backtrace (crc 0):
> >       __kmalloc_noprof
> >       acpi_ds_create_field
> >       acpi_ds_load2_end_op
> >       acpi_ds_exec_end_op
> >       acpi_ps_parse_loop
> >       acpi_ps_parse_aml
> >       acpi_ns_load_table
> >       acpi_load_tables
> >       acpi_init
> >
> > Do not allocate a region if it was previously allocated before,
> > preserving the current design, but, not leaking memory.
> >
> > Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> As per Documentation/driver-api/acpi/linuxized-acpica.rst, please
> submit a pull request with this change to the upstream ACPICA project
> on GitHub.  The Linux patch will become applicable when there is a
> corresponding commit upstream.
> 

Hi Rafael,

This change has been submitted, approved, and merged in GitHub:
https://github.com/open-acpica/acpica/commit/c71849d476bb5f97ca1867849e893368e12a69e6

Can you please review here as well? Thank you.

Regards,
Matthew

> > ---
> >  drivers/acpi/acpica/dsfield.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
> > index d7d56cc600d31..f7e503bf57c87 100644
> > --- a/drivers/acpi/acpica/dsfield.c
> > +++ b/drivers/acpi/acpica/dsfield.c
> > @@ -522,7 +522,8 @@ acpi_ds_create_field(union acpi_parse_object *op,
> >         }
> >
> >         if (info.region_node->object->region.space_id ==
> > -           ACPI_ADR_SPACE_PLATFORM_COMM) {
> > +           ACPI_ADR_SPACE_PLATFORM_COMM &&
> > +           !region_node->object->field.internal_pcc_buffer) {
> >                 region_node->object->field.internal_pcc_buffer =
> >                     ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
> >                                          length);
> >
> > ---
> > base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
> > change-id: 20260813-acpica-pcc-field-leak-8f676f55179b
> >
> > Best regards,
> > --
> > Breno Leitao <leitao@debian.org>
> >
