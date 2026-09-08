Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8C538D7C
	for <linux-acpi@vger.kernel.org>; Tue,  8 Sep 2026 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869304; cv=none; b=o+Ro0HQr4oFGhm9qNMUri5ZZb2NNVDRiklWxz1Kni4bF+ZOiaJsaTA/ceSl4WA/XH9FAsq5ocvgkRkcj9papWhq/qebHU0wuthGoVdjfpoerIYsYNJon5pARALHvCwSpIImgtrMLrSY8/BGlvUoZ1k5TGLWIY9KPQHFclNntgLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869304; c=relaxed/simple;
	bh=JHMWfsW5CyNQs5sLAnfEG7ermVzW+vcIzePTWPMKrvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GY2To8iaqtIsQl4R8mLX5wOh87avPZz3fg+kmwEhJf/y6vekRqHKDM/HzIjgbUpjRbtl8SGyaBnulFHUU90y582sH2x+E4MKIFGwJd6iy1wVL4ZAEBwdkXkE0NseuKED9F0/ZGqooSvlKB6JKEJyTOTXcPGZBr55BWDh9VF8neg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfY94E6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfY94E6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83AE1F00A3A
	for <linux-acpi@vger.kernel.org>; Tue,  8 Sep 2026 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788869291;
	bh=e1BflZLG/y41ig4kA0DqIwNP4dQBVnCs0NJUnHjdC2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WfY94E6hZptpfHeIcig8Cl9DDaeMftQRo5GISPOT1MzoYNk4nv1/Fkv2bjdsfcNAA
	 ENFYR8DIuJUV/EYAdMMcB5g8PUP2nmTxJrMogLgM1XbATM3ZTRtbCibR9lLDllOR/i
	 ndymrHKR+p1JrhfW5YTHT7HIUENRpEoJUQsMWXtmu6cWn5UEhp89qWZ1geqAwxiTgf
	 nxemDOB2mm08RgDO2RCtg8qowe4hKQTgQUvHtxgZv2ECt8Jt/PZXmvsvaEKxaiyE0Q
	 DRhed6AkUn1qEcDtda/I9LsVHVlfb+25zWP40rc4fuga1AsZXdPtskxnuzcf3LQjMg
	 qv/YgQLJeprNQ==
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso1808091e0c.2
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2026 05:08:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzvpaPuNOzA+t3wSYxbB8DucXp+Xm3OXDXB8eM1JYRaI0uLCz4a4AjrQuIM4Wclm3z+SazZtw04FBxu@vger.kernel.org
X-Gm-Message-State: AFuF++nodKqJXYpoLxQYFgDUrW3QMImu/eiT1CD8vCVARFrvvI2Kgv49
	u5ng8GokkwksdLV7a4eanPSYCSrwCeBjPMZTPoDE/uxUHmY5OmSn/8eToO7V/BMcpBgIJHPn++p
	fKoAYi7sf6Y7YZuAZffN4zBW/rdKt3rA=
X-Received: by 2002:a05:6122:32cc:b0:5bd:aba5:3830 with SMTP id
 71dfb90a1353d-5c7ed0c4c20mr15328463e0c.0.1788869291010; Tue, 08 Sep 2026
 05:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908043124.53175-1-mario.limonciello@amd.com>
In-Reply-To: <20260908043124.53175-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 8 Sep 2026 14:07:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMjdmjEoHFB8W3Do_qqLqfuJJYA-R_rGG3qhZBEekuiQ@mail.gmail.com>
X-Gm-Features: AcwNN1WaDQywLkU6MV1NZpHwLD3dHl8GMTPwTm6V5Fc_2wQqMaGrHpaJvnSmK3I
Message-ID: <CAJZ5v0iMjdmjEoHFB8W3Do_qqLqfuJJYA-R_rGG3qhZBEekuiQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: utils: Ignore leading root scope prefix in
 string _UID match
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, 
	Len Brown <lenb@kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <linux-acpi@vger.kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <acpica-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:32=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Firmware may express an ACPI namespace path used as a _UID with or
> without the leading root scope character ('\'). For example, an AMD
> IVRS IVHD ACPI HID device entry may carry a character UID of
> "\_SB.MHSP" while the corresponding device's _UID evaluates to
> "_SB.MHSP" (or vice versa).  This semantic difference is due to how
> Windows PnP enumerates and uses devices.
>
> acpi_str_uid_match() compared the two strings verbatim, so such
> entries failed to match on the UID even though they refer to the same
> object. In the AMD IOMMU case (get_acpihid_device_id()) this caused
> the exact HID+UID match to be missed and the code to fall through to
> the HID-only path, spuriously raising a FW_BUG.
>
> Skip a single leading '\' on either string before comparing so that
> paths that differ only by the root scope prefix are treated as a
> match. The integer _UID path is unaffected.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Add kdoc
>  * Make sure the string is at least two characters long to normalize
> ---
>  include/acpi/acpi_bus.h | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index a10a591c18b23..cfc3c8a21cb8e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -826,11 +826,29 @@ static inline bool acpi_dev_hid_match(struct acpi_d=
evice *adev, const char *hid2
>         return hid1 && hid2 && !strcmp(hid1, hid2);
>  }
>
> +/**
> + * acpi_str_uid_match - Compare ACPI string _UID values
> + * @adev: ACPI device providing the primary _UID
> + * @uid2: Secondary _UID string to check against
> + *
> + * Returns true when both _UID strings match after optionally removing a
> + * leading root scope character ('\') when the string contains additiona=
l
> + * characters. Returns false if either _UID is missing or differs after =
the
> + * normalization.
> + */

I'd rather update the existing kerneldoc comments of
acpi_dev_uid_match() than add a new one here.

You can say something like this in there:

"If both the UID in @adev and @uid2 are strings, they are compared
after optionally skipping a leading backslash ('\') when the given
string contains additional characters."

>  static inline bool acpi_str_uid_match(struct acpi_device *adev, const ch=
ar *uid2)
>  {
>         const char *uid1 =3D acpi_device_uid(adev);
>
> -       return uid1 && uid2 && !strcmp(uid1, uid2);
> +       if (!uid1 || !uid2)
> +               return false;
> +
> +       if (*uid1 =3D=3D '\\' && uid1[1])
> +               uid1++;
> +       if (*uid2 =3D=3D '\\' && uid2[1])
> +               uid2++;
> +
> +       return !strcmp(uid1, uid2);
>  }
>
>  static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2=
)
> --
> 2.43.0
>
