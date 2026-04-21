Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A731E84F
	for <linux-acpi@vger.kernel.org>; Tue, 21 Apr 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793339; cv=pass; b=bC+xZT6hrKeRY5qwncpokqDhFgwqu/ReC0anZGA7B0PbsFLMIVQHohdkpzp3Ta+yUivSE4vjbd1fy8qYBfCUsTt/okXI4fH/O7V/lQij9bTmEQjJ5j6W78X328M0gqcVfxEjUCa35jA80dGiP6NyG1jo0aSoyFud3aY1Nv1Bafg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793339; c=relaxed/simple;
	bh=Of0/EaLDkC3KJoWqOLa6xLXmX35rzEt5z2ujgm6WNGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rj5wv53e+Q6NsxUUsMs9wMwAxw072lYhMdMoAHRsU4rAxl7f19SxTVs73okE63ZYEHKILSDVaUUmrbPIfCgnTTT76a3+vhvaA5+swJ7KMBask895VfG5zTBzfMJqDreRqNB0wJbv1bUmDc9IMrbg/6RsJKNCdlaDZk9IQ4SokA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4OKLDaN; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4OKLDaN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so362795e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Apr 2026 10:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776793335; cv=none;
        d=google.com; s=arc-20240605;
        b=THL4QPcpzhv+jcJwoVmizqoIbKwCfcsUM9w47Gz6tDRESEFAl5AbxkImgrN0YkcxN7
         vsj2rDRrPkaPSBe89LAR9tvzLV+CXtM3l+3wQ6EH9KwS+VcPtOcTv+Lfk1HA4zQrmS7P
         RfsiZOubhfYe0rVENOBtE2tUnBMF7EwLntClvQNT4bvpaJe8FYvYuefIkkKYutEH2hf7
         0yJvMTgQJ4Tgz748yvbHqDPiu2SNWct+XgSBLtsKiMO16yloWHwhFpuCBwMDzbTgzTg2
         KUja6zFmVOi0Tub8zQ8bfYi1YI/2kuhQuLvPixioAVS516rAGfLN00sp3VetPS5VMQau
         EU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVLuZOfQ/wAnql5Ulk19piwsQQJoEI+P/OLaiUP9iIs=;
        fh=DQrKCxshY85Fh8Xb/LshmfriWio8cS0gJdN5My6eB/8=;
        b=YRdSIK2AqQK+mDLx3/0litAnlwEh6V/sGX8kPkgrBNztadFdnJfuFm9pQteavUo0c/
         HqVlx+uCjX5z85GhL2p8lMQgOBXiLH2Gsxmo2gnGnEMNtIOEJTeEgzHgbBJ9FV9SIXFk
         YYMsMuj86yRD6oKDxItMZj/WiQJO9KSdTGPW4T9PDdDOYu320LqL+EuaIQ7VWi4npUv2
         JXe4FAHaq1jK+1KRtToamYDty+u8OAk/De/09/U5ZxahZKsaH6Cjp2YosVSvOCCZVYIi
         hc6eSKYfJ43C2gI4IjAShK7VenVL18zu+nhbrOPoafhPNWMMFog5w4rfkZzDGocWhu6N
         NwIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776793335; x=1777398135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVLuZOfQ/wAnql5Ulk19piwsQQJoEI+P/OLaiUP9iIs=;
        b=d4OKLDaNi8NM8/VVnfWZ8QCJjStHzFIa5Un9yAKD1U5I1i+m1Cqu1rcqhGIujXIaNT
         icivJe2L1+/PVCaER2FVaaHMmp2b47fDp2cEHlc4c0Kda16ynD6Etq7Re8eyFbXu05hS
         9Cbr9LjCTTeI+PGMYwVZDUb1hBL+tk/S8H3+bp8oKy+bxjCCIPBf+6aMKG+iifNxB4s6
         uu9qpIsC1C2OXVRzu+EpbgsmkUeqt0eoJOY2fG8xTqOUrqLH57ADEB8hMchASuqWliF8
         BopM/dY4OikF1m2bRO6CPxeB2caTohNgI6IXj+KrwvR+BNLjBPva+gXDWME3n8P3nY26
         aHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793335; x=1777398135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVLuZOfQ/wAnql5Ulk19piwsQQJoEI+P/OLaiUP9iIs=;
        b=jyk7tlO5SDyz5fxfZHJHLR+huMT8z4qZ+PGajFcCD1fLPeGyPDI31jeh3KMDAs2W55
         SwlsPuyHMUDjG25p0I1Wga5+bqLcE+0OrSdMglOJqrTxDQlRZ3Dkwp5Py19WF461TUmH
         lsECUocR/3Ej3GzfunGwlw674c2f/qQVRZCHyDsI/zwg3AnpWgx4D8LClTsFxMznPIUZ
         /nlEHkTVamV7JcJGw5PD6Tpn1UoEC0JoV/PUQDja2NXi+9k8EFsmm8Van1hJXCHbZGY/
         4TOXsiutROnDES0LCp6UcLtequXfCpeqtce8J8L1JD1VH727rhsvMmTazlttgOZF4DYC
         VLBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Xf88g1WSoP6U+n2i3ZNDSY2iRkAOU5AprXFdJEaalZaEtrth2Zh6nq4vGZN1NKbYqHe8/wSGzSy0V@vger.kernel.org
X-Gm-Message-State: AOJu0YxWD/fnFaqb+OyZ5di2thbSj89YVXVXMVXwZJdXstE211NCRCdX
	qFoQ+xxRyPdEYYry3uFRRiC8zOXPxgR1M6qpgGH5rinQIA3yewbDeEJwZObFiLWjfMaxF+Na740
	9SZmhcr5jGVN0mXkCa3rce2gGUMJLDSQ7AG3Ffk5G
X-Gm-Gg: AeBDiesQI5bafA/n8OhviQEeqr2e73ms9eQXEh37ugdLLBji7mK/kqhOCuzBd691zZ7
	7YSFebgohlTz5v8wKwz8sPRxmNXgckfDepWaBSkbRHgaKdBi5p6R0ibxA9L1KGBYTMUcefjN3fF
	uHRbKnQuFZxXgqVg9OZLS3hQ+DyuSqYurRJu3vm4LmSLW/blG10Az1XeZogkSohtFWn/bqZMkbJ
	Mtd78YaN0X+Dz/EhFaJrR/cFqaJbOp4JtBVxu4Z4ejls1dKiGStc9EuEzRaRMxh3ttEVXec6sGU
	SCykrSpkhzp8DVyfz0BT0hdRchIFW2jkoO5uVPsRlZ2/rHuiiAgMLR90k6s=
X-Received: by 2002:a05:600c:1992:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-4890090506fmr4929315e9.0.1776793334852; Tue, 21 Apr 2026
 10:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421150216.11666-1-tony.luck@intel.com> <20260421150216.11666-3-tony.luck@intel.com>
In-Reply-To: <20260421150216.11666-3-tony.luck@intel.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 21 Apr 2026 10:42:03 -0700
X-Gm-Features: AQROBzBZMQqdOr7KbeHRPze1igkhothHr2ycHmyOAVwdZrAjsgR6OGfZhruDgUM
Message-ID: <CACw3F50yER64HyCiPW_oRH_WaZgT1knvi0_qk_mdr1Y-vxmGEg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ACPI: APEI: EINJ: Fix EINJV2 memory error injection
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Herman Li <herman.li@intel.com>, 
	"Lai, Yi1" <yi1.lai@intel.com>, Zaid Alali <zaidal@os.amperecomputing.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 8:02=E2=80=AFAM Tony Luck <tony.luck@intel.com> wro=
te:
>
> Error types in EINJV2 use different bit positions for each flavor of
> injection from legacy EINJ.
>
> Two issues:
>
> 1) The address sanity checks in einj_error_inject() were skipped for EINJ=
V2
>    injections. Noted by sashiko[1]
> 2) __einj_error_trigger() failed to drop the entry of the target
>    physical address from the list of resources that need to be
>    requested.
>
> Add a helper function that checks if an injection is to memory and use it
> to solve each of these issues.
>
> Note that the old test in __einj_error_trigger() checked that param2 was
> not zero. This isn't needed because the sanity checks in einj_error_injec=
t()
> reject memory injections with param2 =3D=3D 0.
>
> Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
> #Reported-by: sashiko <sashiko@sashiko.dev>
> Reported-by: Herman Li <herman.li@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Tested-by: "Lai, Yi1" <yi1.lai@intel.com>
> Link: https://sashiko.dev/#/patchset/20260415163620.12957-1-tony.luck%40i=
ntel.com # [1]
> ---
>  drivers/acpi/apei/einj-core.c | 45 +++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index a9248af078f6..1f3fa2278584 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -401,8 +401,18 @@ static struct acpi_generic_address *einj_get_trigger=
_parameter_region(
>
>         return NULL;
>  }
> +
> +static bool is_memory_injection(u32 type, u32 flags)
> +{
> +       if (flags & SETWA_FLAGS_EINJV2)
> +               return !!(type & ACPI_EINJV2_MEMORY);
> +       if (type & ACPI5_VENDOR_BIT)
> +               return !!(vendor_flags & SETWA_FLAGS_MEM);
> +       return !!(type & MEM_ERROR_MASK) || !!(flags & SETWA_FLAGS_MEM);
> +}
> +
>  /* Execute instructions in trigger error action table */
> -static int __einj_error_trigger(u64 trigger_paddr, u32 type,
> +static int __einj_error_trigger(u64 trigger_paddr, u32 type, u32 flags,
>                                 u64 param1, u64 param2)
>  {
>         struct acpi_einj_trigger trigger_tab;
> @@ -480,7 +490,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>          * This will cause resource conflict with regular memory.  So
>          * remove it from trigger table resources.
>          */
> -       if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && para=
m2) {
> +       if ((param_extension || acpi5) && is_memory_injection(type, flags=
)) {
>                 struct apei_resources addr_resources;
>
>                 apei_resources_init(&addr_resources);
> @@ -660,7 +670,7 @@ static int __einj_error_inject(u32 type, u32 flags, u=
64 param1, u64 param2,
>                 return rc;
>         trigger_paddr =3D apei_exec_ctx_get_output(&ctx);
>         if (notrigger =3D=3D 0) {
> -               rc =3D __einj_error_trigger(trigger_paddr, type, param1, =
param2);
> +               rc =3D __einj_error_trigger(trigger_paddr, type, flags, p=
aram1, param2);
>                 if (rc)
>                         return rc;
>         }
> @@ -718,35 +728,30 @@ int einj_error_inject(u32 type, u32 flags, u64 para=
m1, u64 param2, u64 param3,
>                       SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
>                 return -EINVAL;
>
> +       /*
> +        * Injections targeting a CXL 1.0/1.1 port have to be injected
> +        * via the einj_cxl_rch_error_inject() path as that does the prop=
er
> +        * validation of the given RCRB base (MMIO) address.
> +        */
> +       if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM))
> +               return -EINVAL;
> +
>         /* check if type is a valid EINJv2 error type */
>         if (is_v2) {
>                 if (!(type & available_error_type_v2))
>                         return -EINVAL;
>         }
> -       /*
> -        * We need extra sanity checks for memory errors.
> -        * Other types leap directly to injection.
> -        */
>
>         /* ensure param1/param2 existed */
>         if (!(param_extension || acpi5))
>                 goto inject;
>
> -       /* ensure injection is memory related */
> -       if (type & ACPI5_VENDOR_BIT) {
> -               if (vendor_flags !=3D SETWA_FLAGS_MEM)
> -                       goto inject;
> -       } else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)=
) {
> -               goto inject;
> -       }
> -
>         /*
> -        * Injections targeting a CXL 1.0/1.1 port have to be injected
> -        * via the einj_cxl_rch_error_inject() path as that does the prop=
er
> -        * validation of the given RCRB base (MMIO) address.
> +        * We need extra sanity checks for memory errors.
> +        * Other types leap directly to injection.
>          */
> -       if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM))
> -               return -EINVAL;
> +       if (!is_memory_injection(type, flags))
> +               goto inject;
>
>         /*
>          * Disallow crazy address masks that give BIOS leeway to pick
> --
> 2.53.0
>

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>
