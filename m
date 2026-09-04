Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5F4A1E19
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528450; cv=none; b=YeXkFrCvZ+WdTgVRd9cm+tlWJ8WHpr7fwcI1VVqWCoYYTYLqwSKusiYrrab4f3NztB7mWL5gNvmhaXOQ1HvdPu6u9XDTO18RG51kdvTJ+6xN6ykv/uIzWu2vPZBp+R45ZGuu6cxv0KJcQz3hZUnHwCTfBKj4GkMG2Wb1w2rbwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528450; c=relaxed/simple;
	bh=6o3FN68txfSUOLS6C9YkD4JwzK2reI8HHvuHdgydk98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQwzKGG0IUSiUcTeVZTw4jjc9fCKq5VG2PqMMx+1zUfzfZI02QrcWv6z9X5eJEcZ0QOXiGCr5yArrscBDOlfuKUNjz81ZdQfxfmg/UF7PkyG3dtk/9TB5tbKCzFaGKAtjDEc/4mCggAGanVQHZm1JYxAGAZB+EQs601FO7YoZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnUbh245; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnUbh245"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB21F00A3E
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788528448;
	bh=yLr5JER9L2GG4LQNJ6EPE1CFk2v2zU96DBox5ONJHmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BnUbh245UT2qnT2kYz9oPXxdypfw/ueXE0/573Now74NoqjoL4c6A02+Tq1XX3aqo
	 oTcylc1gPAmf9yMmOP1Q/QeCiEu2xFGnp7bAynhyr43+qqGPyjEBmpdNb7rsG+cy5G
	 paFq5KvZZAih66pjxOshYtcKD/5kmbSvbP/kzfq1n38fLepSYpNff9f/2awp2+Ukic
	 tnFYmRyMgMmcT+mHw9h6lYB6QngyV8t5/YcL7i0DqDZtP7pTfEg1cTAgJ496AK5czs
	 KwZ1Hr7gzhni1+fWcFBJurdXPYgsbQDkRkEtq1kIkyCAviwAALQt9WaDOJxt+IhhD2
	 OJgb/lBRv5i6w==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a309f92daaso9634611fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 06:27:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwTrk69FIvJX/8C7jmECHj5cHTuME+0jwvKGXbRQJlVZ+qpP+GZ14+qmJ9TiQtQU2vyOwgZC8HjGe0w@vger.kernel.org
X-Gm-Message-State: AFuF++kli8MOm90iQgJr4aO/0hzf70VZATX9be7enUZBrB8zOGtag5gJ
	SsyZRLhvjCck6OjAsg8fPpFak0zbZBQsOb4/9HO3mR3rz3DR8oEM7gAXRh9/VrnaecavFFUZUZz
	edQdJzrNWR4kXHEqKTeXIoNFhHysKTF4=
X-Received: by 2002:a05:651c:15c1:20b0:3a3:476:2e37 with SMTP id
 38308e7fff4ca-3a371b2d735mr5188101fa.6.1788528447121; Fri, 04 Sep 2026
 06:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831180214.2231161-1-mario.limonciello@amd.com>
In-Reply-To: <20260831180214.2231161-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 15:26:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgn+_L_yvEg0yo0vPk9_brbxsywyu_77tEyww4nV+eUg@mail.gmail.com>
X-Gm-Features: AcwNN1UTAxjAba3vdZOPJ_75Q5wKhnCiwoSBVjcu6FvA299Kmrch79HVAOs_dvo
Message-ID: <CAJZ5v0hgn+_L_yvEg0yo0vPk9_brbxsywyu_77tEyww4nV+eUg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: utils: Ignore leading root scope prefix in string
 _UID match
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: rafael@kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:02=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Firmware may express an ACPI namespace path used as a _UID with or
> without the leading root scope character ('\'). For example, an AMD
> IVRS IVHD ACPI HID device entry may carry a character UID of
> "\_SB.MHSP" while the corresponding device's _UID evaluates to
> "_SB.MHSP" (or vice versa).  This semantic difference is due to how
> Windows PnP enumerates and uses devices.

Can you please elaborate a bit more?

I would expect _UID to return the string without the leading
backslash, so where does the other one come from, exactly?

> acpi_str_uid_match() compared the two strings verbatim, so such
> entries failed to match on the UID even though they refer to the same
> object. In the AMD IOMMU case (get_acpihid_device_id()) this caused
> the exact HID+UID match to be missed and the code to fall through to
> the HID-only path, spuriously raising a FW_BUG.
>
> Skip a single leading '\' on either string before comparing so that
> paths that differ only by the root scope prefix are treated as a
> match. The integer _UID path is unaffected.

But this sort of assumes that the string returned by _UID will always
be a namespace path, but is that the case really?

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  include/acpi/acpi_bus.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1a45e0d521d8e..e0bec35953ef1 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -835,7 +835,15 @@ static inline bool acpi_str_uid_match(struct acpi_de=
vice *adev, const char *uid2
>  {
>         const char *uid1 =3D acpi_device_uid(adev);
>
> -       return uid1 && uid2 && !strcmp(uid1, uid2);
> +       if (!uid1 || !uid2)
> +               return false;
> +
> +       if (*uid1 =3D=3D '\\')
> +               uid1++;
> +       if (*uid2 =3D=3D '\\')
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
