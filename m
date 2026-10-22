Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694791;
	b=rhjRbCRErZug4jbLFciYn7hlCQuuQd+0h84zjvV1I+Hpnuv2n9HgSoTJve/LWLDAA89d
	 3wwqL6CrgxsM0050qbEwnVCo8ySUWNinvhlJDseF5W9IQaKsSZt6u0AHFpZyACw3MMJMB
	 YvwwV+FQcPX9VwgAh+Kyr5j8SQ9uJJNXaTA+Qqv48jtj3AcKsc+uI81YBPIExo+51/Ve0
	 wqEnl7QWCYdTI+I7m1v+VSrqPNZRQEbtyg5tje1+rgdG4s96DOVMNH4uLPHMRRKjMrag+
	 AO2nYpKOJyL9cfYCCaYvLADscbixl3REGuTp6F0YtF6n1yb1yAs/U/snJjRUOQQrk7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694791;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GF88O9P5M6CE3jxSeAPzPZTVPbIUcNEdcAmUJ5UkidY=;
	b=y6oHeyBJ5IgJNZe/6IwaxU7ZVAzi//kZXGnPYRcwV7AG/coNoyokaslw2BUsaK6aLKmA
	 5EaqYph+8cZ3TZnFoI1ISxGAdl5KuokC84rv8SGBmfMBcAv0GfQKd6Lmcdsc+GZ65hw+U
	 s8/njMpTKRfpEuudOtvpDKYnQnZCnC7UoNpNTyYwiQsdbUXKfeUm/88fMsYPycfFujiOx
	 dyAu3SeM3XDk1IDsG9L+f+/DCWQJJShUfc3wytKOB9FV4MXyMeFJ282wtMP2LyeZ5BbL4
	 Wkp6KIMd34elLY8oHqIrn78JwheOsR3ay7jYRFo3zEnUI5r7UtmRmE4xKSPdcf8qa9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBVjRIlz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AF606A31B
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBVjRIlz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8A41F031E2
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694790;
	bh=GF88O9P5M6CE3jxSeAPzPZTVPbIUcNEdcAmUJ5UkidY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gBVjRIlz1a1Pa+sUEfCPBjwms5GxRC047MyA2ToTxLJg6esyG83Ea2AkbIuwtXUKc
	 bB/IHycsqrnY1SCxdrrBSE3L49BKaJ5k+gTZW2WpcqB2o6IXm6x1yjUVQ12MxwvB2M
	 sdA/Th+xYFEgpZd98v1XOnjGbMWy9lXTofhApGs+Pc6t1Lumcv98v37J76c/GfJ5cn
	 6E4g2ywkBxga14JQMXJJCShOPRyz8CQMimA8wGno6XltyKvtTANnajpzbum5bJ0tgA
	 I6Z7gX8JNRTV1G8WScjLTqZlzWZ2P1D1hhE220M4frUA3td60HTLMTF6S/LemAe6F0
	 v9W+1vOMiE+2g==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab27b4924aso16524521fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 11:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByWugGOFGY3/IxV/qcp34lWALYMZnNQvCfIb0CeKCVm+N+ZzoJjWjkQ88cwI3k2zo42ZT128VH6DYsf@vger.kernel.org
X-Gm-Message-State: AFq9FYJdTvGmFx1150aesvmB2jglmQYF3skMg0uUHxKvBAw7UE/EUnhF
	QJCod8Keaz/Da+mneiTTerXRM1pCdId4X1p/riqoLMsSsApOGb7lye1Kd8dWzjfqv8hx/b+/3wZ
	A9tFwe5e35oJhzcrw2QtM1FvPij4busM=
X-Received: by 2002:a05:6512:39d1:b0:5be:590e:ea86 with SMTP id
 2adb3069b0e04-5bfa1cf13e4mr2704376e87.41.1792694788688; Thu, 22 Oct 2026
 11:46:28 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013193900.1258808-1-jamien@nvidia.com>
In-Reply-To: <20261013193900.1258808-1-jamien@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 20:44:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jzfS3npCjmmGg+GQkoHMz1Fvp5aiZzRroVTVYLwzv9GQ@mail.gmail.com>
X-Gm-Features: AclHuK-7_LmOsA3cxfxBK1gEpqDKJON_N1oV80uzP5wNz2fGx98s01m9Jcd-gQ0
Message-ID: <CAJZ5v0jzfS3npCjmmGg+GQkoHMz1Fvp5aiZzRroVTVYLwzv9GQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: Finish sysfs init when creating a table file fails
To: Jamie Nguyen <jamien@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Punit Agrawal <punitagrawal@gmail.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:39=E2=80=AFPM Jamie Nguyen <jamien@nvidia.com> wr=
ote:
>
> If creating the file for a table fails, acpi_tables_sysfs_init()
> returns without sending the uevents for the tables directories, and
> acpi_sysfs_init() returns before creating the hotplug and pm_profile
> files.
>
> Stop creating table files at that point, but finish the rest of the
> initialization. Skipping only the failed table would give its file
> name to the next table with the same signature, so reading that file
> would return the failed table.
>
> Assisted-by: LLM
> Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
> ---
> This was noted in the review of the BDAT v1 patch:
> https://lore.kernel.org/r/CAJZ5v0hM+6RvyXwG89Jyyu48jxSejNwsDt-H=3D2Y2dkt-=
-af2QA@mail.gmail.com.
> Handling it as a standalone patch here.
>
> Tested on an arm64 server with test-only changes that make creating
> one table's file fail at boot (FPDT, or the second SSDT). Without this
> patch, pm_profile and hotplug are missing. With it, they are created,
> and every table file created before the failure matches a normal boot.
>
>  drivers/acpi/sysfs.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index dd4a99f09efea65..7dfbb19238ad906 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -510,7 +510,6 @@ static int acpi_tables_sysfs_init(void)
>         struct acpi_table_header *table_header =3D NULL;
>         int table_index;
>         acpi_status status;
> -       int ret;
>
>         tables_kobj =3D kobject_create_and_add("tables", acpi_kobj);
>         if (!tables_kobj)
> @@ -535,13 +534,11 @@ static int acpi_tables_sysfs_init(void)
>
>                 table_attr =3D kzalloc_obj(*table_attr);
>                 if (!table_attr)
> -                       return -ENOMEM;
> +                       break;
>
> -               ret =3D acpi_table_attr_init(tables_kobj,
> -                                          table_attr, table_header);
> -               if (ret) {
> +               if (acpi_table_attr_init(tables_kobj, table_attr, table_h=
eader)) {
>                         kfree(table_attr);
> -                       return ret;
> +                       break;
>                 }
>                 list_add_tail(&table_attr->node, &acpi_table_attr_list);
>                 acpi_table_data_init(table_header, table_attr);
> --

Sashiko has some feedback on this:

https://sashiko.dev/#/patchset/20261013193900.1258808-1-jamien%40nvidia.com

but that's about a pre-existing issue AFAICS, so applied as 7.4-rc material=
.

Thanks!
