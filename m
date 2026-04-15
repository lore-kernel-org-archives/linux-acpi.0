Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49DE3ED5CD
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276019; cv=pass; b=NE+cP0uc0FLOnm24nSC0XMxyiNKxK1h4fpRbocG/w2KGQ0Mzi5pK/S005ASP58M9t/71+JaTy7FayzDJMjDdJRtCGUfhmJ7L+h3JfHdx50rSn2Q/zd8GIAjc849X5f+C0n0DzyPww3ZsQtK8CR/W0i1drG8n6zNNYBo2fbDpB5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276019; c=relaxed/simple;
	bh=qPQhQp9VdovCFB/WM7hSOT0rza7x2YKPTKKh6DdT8ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMCAacC0vGRsVdcuT5HcX/YmNnZE2NBcBQ3zRCnBCT5+clpqdhSPL3JdtHLBJEDUoAu6qXC3zBKIlOPdkNuQWkH2RAvVc9ZfZs7cSU+pKUy2iBDq3EDNkpnjqpjTTZ4+pP28dWVRO4pmjaVp6sYaYEI1qjmDRiWYT6h8PlfJ2Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7ce+bMH; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7ce+bMH"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887ec3d8e7so34865e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 11:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776276016; cv=none;
        d=google.com; s=arc-20240605;
        b=e0LT9k9Tu49cLyo1i3e7rE5e+qh5hgXKhA2UzOOTXDCn+mZM6dpWEf6jFfCe2xTlbz
         bzisRbfrxPEnzqwv9CuOJFgagufol1ydg+feCdwTU/50xpjg8ToPz1jAlvbaj3rnokA6
         0xJdrD5yWiot5p1M0KCHth39MyTp7RTA88x8mYmy6lsPtzCFMD6qII69D4rv5p8Z6BoX
         ajZ7UcmJirgEzmI+9XiRgX+hr8WKrlQ4hCn4rVxnkEG569gz2QfBJwY2DiG5nFlveuIH
         AdH/IrXhB3hDGNlev1oprqn14Nhmim5P+547ypqThJJ+JvaQvfe2fJExusoHDIseFzch
         xFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7k+/a5yHkocf0kBDbxZdsG9VDQvYFZJUscJs/+UC0is=;
        fh=d8ImhQqAnmBp4RnCT1HnXt+0xyAkXTzm3cXpIkfA2Lg=;
        b=RNJOZhj0PRtGvs2XACCRLTVBl8fa8nS3t/KfD1hvh6A2fDrBQBd1Rpe65tGmigEwH1
         QMIzmQSuFAjOrbSoxzWUiiyXaYlJiVEl+xSn4qotPCuHsxMs2UPI8ktDIxQ/sQhsJvXJ
         x7dz3ZSQJRqPDlKXAyJH/DXdLz8nM8Bc9n096A38YyXXN2uQ49MA1zMTjQtifsygtYj0
         cZMHgpC/pSk+4XGGY6vMwVio0PcPadwE3feeg4AtxooA4pQUpj/SVJ9NqWK0pGbWIMOl
         aeSJGu5lvvnwZWQQLNsRInXgrAPyN7keyRJ4h6oF0Q3tWulGKNprjhg83/9qqh3t/e0r
         Qvog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776276016; x=1776880816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k+/a5yHkocf0kBDbxZdsG9VDQvYFZJUscJs/+UC0is=;
        b=n7ce+bMHwN6A8wrl/7HoCPPnw+rcuwpP9phHtbcrxMzHZK5OpksL76fozQe0HkAKa3
         LA6iapBoUCAjeLmbYpUZfflLKVFdfPiEkzXMVy9MG5Vou8lv5pDRtMdMpQbvT4ayMBQv
         8vnq/eFxM4EetGsj+G0Gn12vhlLQpIw8+KqHMlfBQmLegfgQvvt4hF6lhxF1QRB2D4Qj
         Hw2jQH6lKyZDXP60ADsm8TvXQHApInB1XfXckfH9vZq/wFZNHsVfnW1mDk+twxkkrCu5
         TSBda4xRGnR+isObUVvndSjnTD8+ji7KaIV3ntBTKGpcAx0frzSbjhKo+bMtEpPrCn37
         VC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776276016; x=1776880816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7k+/a5yHkocf0kBDbxZdsG9VDQvYFZJUscJs/+UC0is=;
        b=jx8QmFmS8ujG1DmkvfbtB0pIHHEQyjMlcFP5anO0gQCgumizx0ER8pFrB2TD0zFg/7
         mDgi6FOhpRKu55L/QYwo6m3lcwwbh4O52el7i3q/s3bfojnQS28gqh/jHH7KQ2Bq0JHC
         e2OivDNZ7BRslUP9noDz2DFVbogIeqMO+K5iOFIf+DVuOQ+w82OF3A9+bBmlZ8FsQa5E
         fFOG7Hl7+1gR+/T/TlF4YKdV46OEsPYqOhhv97Qu2PjbGLKt2BnyqzD0g2aSK+BR8bq/
         ezjiIT+HXsGX88NS4ccIeUZSxnToPuqamC2oWDt3CRt8sGVEWf3O/xXinfZyC3MGeDht
         pSUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AaPS0Osz2nAkxdLzQF9jw4qnhbczHkB0kDdUCSIfz9ohhZzemLjN0UR5FHh80o2NNZZoyGWjeAohU@vger.kernel.org
X-Gm-Message-State: AOJu0YwV28hLuqDarN5G7vSmbAGarUJVM+UU7KrPAQUqP8mCEOjv7KJM
	JZ0LFMyV1+xJ9XsP+Ete306SzOMwvHK2jNhwqlGorxAUKwDVgBBE3S5LlXeNRKqnewxNOiGJXxs
	g8aH8HUYG0ACpgOrGBDjDuU9YXdD3bC3z5s6rSDIVKaZEnZMXQrvoer6neYw=
X-Gm-Gg: AeBDiet5N9KGkARANf5T51dzKZ9pnj6h9BMJUMSO2x5AcGGPTp34oda8ciecLvIwuU1
	Voda7oMxIb1milgVD2Xy9SQ2dBoC2dJT+w9NfRp1DkEIuvttpdkXPUzAat1F+ECpmiK8NvuAIMj
	ITXV4t8SAQ6w+NssiYk8CtrWEjbYWCqLz/g45qHC1knanNzfCSNXBSR9ASbFpMRLnPM0pwXyQyy
	WM/djNRwUdTcnSTaf4n5J6h/NBSd4lggQcG2Mf4r9hF9+GMGzZ1+0UPXMZTWlRf5JuuBe1Pttq8
	vCmLBoKuArtxwCRUhsVsP771Z9qwxGmol4jQG+I55jlsF5Us1Q/oeO9JNU/3c206iG/2
X-Received: by 2002:a05:600c:35cd:b0:477:86fd:fb1b with SMTP id
 5b1f17b1804b1-488f4b0baaamr15375e9.11.1776276015887; Wed, 15 Apr 2026
 11:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415173735.24437-1-tony.luck@intel.com>
In-Reply-To: <20260415173735.24437-1-tony.luck@intel.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 15 Apr 2026 11:00:04 -0700
X-Gm-Features: AQROBzB_XFGZq9Z8O_w4jVm1Y0Hi5-1B2wXoFxak3HfWQOe7OzTU8T44AQs-lJo
Message-ID: <CACw3F522f6p-x6MEU8t7CEoU1P=PtU8dKy7opKjH8sOecdF1kg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: Fix EINJv2 memory injection
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Herman Li <herman.li@intel.com>, 
	Zaid Alali <zaidal@os.amperecomputing.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 10:37=E2=80=AFAM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> EINJ trigger actions for memory error injection often include access to
> the target injection address. This address does not need to special
> mapping.
>
> The code to drop the target address from the resource list only checked
> for V1 injection signature.
>
> Add a test for the EINJ V2 memory injection signature.
>
> Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
> Reported-by: Herman Li <herman.li@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>
> V2: Add "Fixes:" tag
>
>  drivers/acpi/apei/einj-core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index a9248af078f6..ba0ce71b7adb 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -401,6 +401,17 @@ static struct acpi_generic_address *einj_get_trigger=
_parameter_region(
>
>         return NULL;
>  }
> +
> +static bool is_memory_injection(u32 type, u64 param2)
> +{
> +       if (is_v2)
> +               return type & BIT(1);

Hi Tony, just a nit: for readability would it better to introduce a
macro for BIT(1)? like ACPI65_EINJV2_ERROR_TYPE_MEMORY

> +       else if (param_extension || acpi5)
> +               return (type & MEM_ERROR_MASK) && param2;
> +
> +       return false;
> +}
> +
>  /* Execute instructions in trigger error action table */
>  static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>                                 u64 param1, u64 param2)
> @@ -480,7 +491,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u3=
2 type,
>          * This will cause resource conflict with regular memory.  So
>          * remove it from trigger table resources.
>          */
> -       if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && para=
m2) {
> +       if (is_memory_injection(type, param2)) {
>                 struct apei_resources addr_resources;
>
>                 apei_resources_init(&addr_resources);
> --
> 2.53.0
>

Anyway, the patch looks good to me.

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>
