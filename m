Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670DC3A9D8D
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957024; cv=pass; b=KR7L7x0Vks725CfLLwkena6pV4b6/akJWtVfmmtNF9Q9a6QqihqHo2tAgL+gCHb9DKhyn1mTWr6AdZIE4VTpxEkzHIkOn7328LlFjltF7RTTzA7CbeLw6csRUN0FOrN82PsX6o8IDCNz9PWS1E8/Tr0gp5KbcIlh6O+obkSswAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957024; c=relaxed/simple;
	bh=DGHs5SQQXiotArDuQZ0B9Dgbv8T3sLVqVQ1dRhCjkp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUJRrifMCucSbqnBi9zBYB3iUnM8yrnLHDOlYT/umanMNh2mhNtBu7bYCoeLBIPpnf+Gj4S/0+l/ixrbLvQjynam0SoJj7ZmXObKNyfgZ06muMh3GfMhTVCNiscnDtxxvq/aa5Txl+FLhxxf0bpYoBaKaQtEV3IUmv+zRR3gSj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqN/alX9; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqN/alX9"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836cbcd0a48so24715357b3.1
        for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 15:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787957021; cv=none;
        d=google.com; s=arc-20260327;
        b=sPsikychakmTAicAHb45bWd6zLO5sttSU7VPxyOTz/NTJ/HMsgLr9e6XKyo4gxvSTj
         yRwl22DcfGw7EBFGpe29VdnGonYb+M/OxuKFJDbnYmc0zfx6h9/RfjwP+7emoUS4s3X1
         XlLNHJWyXExZVCpGAMtTmo7OunYBu+hcy4OxoIH8xGU4SL+D1X01Rgau2xcNFmS3Pl7v
         htzorgkIw/V3zQcQzQX51Rr+uX2r0erVJyEbrLt6zjCHBFzguVICy4S+FapQksuexE7X
         E9dk7qOy3+m2WLgTmCC7JWEA0SijiivbMmN21dybOo6KXTYYiGMPPfHgDUKLD7hjH9Mx
         wxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E2b2r/YcBr12q+KrOQE2EJ7xuTvSb8Ce2sgX6K3dty0=;
        fh=v+NhKgEKCIeH4mkgQSFnExO0L/v5sWlUvz0TA5nhycg=;
        b=m24ePIponar8TAZY6L5PQp3cMlyKqQwvY5E5p0RnEhyv7TzmGF0WNT+QsmeoPMG3wX
         Cgur6inegRXU/lLyR05sOJBcg0Tp4Kqv5VjyfzG7/yKso+swSRx55D0CSNftqb5o54RR
         G7cS6OjINpo8wtIC21+z1k6swQdtSoAEikMQpxhYHgZ76oVJN0Jy6LMc7Q+s/caJv0yM
         YU9rXu0rdU/Wm7z2U44VcQebIUebqzRxSpxGrIm3Svcou3kPW22irmoTcbLI34l5+Yk4
         cYI0OA3G4YM7BAu3X1EuhWtRby3543h2xIIxv47rwM6I6euyUtvpLbyJIGRyDoyzN6e9
         r3vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787957021; x=1788561821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E2b2r/YcBr12q+KrOQE2EJ7xuTvSb8Ce2sgX6K3dty0=;
        b=lqN/alX9OpBf+DPeZHsWQLM5kFGFKYUMX5/eq/j42Y0DqCV9giWgPwNmFyQD4CLx79
         77k1zvC3Q97ld53Ni7hvA9hB+RWAFdoRdS6dz9AQS5kLeULXasYtBl5Ol5NeJ8cGBRKg
         8MAbYMMN4ESqnoev2Mje6DuTE8AI2J5XfaenSx/c+nSobw+8GwqyOMJRBi7vslWIAkiR
         v5d4H1KpGa03MFv9bpTfV9e5/frM1n5c8oJPrwlpl2FalSVG0qKkJIpqbxMGrIMhCesn
         BB3p7QFfocYlcDWWN8AJd+W0Gqpf+5Eg0Aee3GrOc9R5im9GMYWatY+RUjOCer7noiaI
         oORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787957021; x=1788561821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2b2r/YcBr12q+KrOQE2EJ7xuTvSb8Ce2sgX6K3dty0=;
        b=CwfBpsSauJBDYEptv2OkENy9d4fGr38KFMYg1qDMgO+bwEm4UIm0IXfzsME0WD/DeY
         yaB4R3W9+Rp3afsvMfXjQbn2gU40ZtpoJI9+0PkycLO+94utCXzyrnefWRgvtYq1XwUe
         TwPoV0TRtIt6Fvo2dqtQjX3ahsHHM9WVxtpcQflQdFBdQJ0nBnJLXwbHvHr4dPvvTR8h
         44ubBNw5NuvZrgViNbnORrp2za0285EQLakr7O0k1YDLo9AZPFpxDRVPZGO6XlMu/one
         tIFac2DHgFLhtA8lYe+r7ZzExmCdeOV3CaeALhiaMFJBFAFiEiRhYXGD7fzswrN36Cih
         0I5A==
X-Gm-Message-State: AFuF++m8gy24cST/311XFfrZxuyQD9Zypk9tU0sw6wtsCnGKui9kdH6Y
	fvTIT/9Wz+DMsNGiRrcGP4m/5NjMS1qjSQ9xYnaFxmDEDXTVbY8LxxNgpsHQU9JxsSqhmJBoKXV
	AOZcT/vlqFZ6JsT71urtHJwjhYcvhKrU=
X-Gm-Gg: AYBFou2QTkVFBWLkxXhzLuiA3GX53Y9HDmqI+14vi3YuE84RaOHssed7wtUfhcOnZaY
	ARlBEVHs5q2AHxCJMPJVnr0dPYR/m8Z3Jt6RkCkfxv2kXbnQ4YioFfHSQkts9zDNit9Vbb5tcSm
	O99WDhKumAJrUToogiejjDJ82UYHZameiIxmguWyyehTHuoEyS7SuU9IJgSI9XYlrTZL2z0oZj0
	iuX/VYfOivEnWVRHs/rqZYbYAtqeYeeq5eMregLTJ1IevJNL19hJ5WtrJpUOr/ffzZz+e4s/gxo
	7dQLjgXo94PiNLxXiJ3yZElo/aPOF2Vjbr1q9832PfEqSOwas+fgniSeLpuIuqYj7Qafyqtaccq
	r
X-Received: by 2002:a53:a690:0:b0:668:1c55:4283 with SMTP id
 956f58d0204a3-66e4c76d946mr2712395d50.49.1787957021314; Fri, 28 Aug 2026
 15:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955564.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12955564.O9o76ZdvQC@rafael.j.wysocki>
From: Julien <julien82453@gmail.com>
Date: Sat, 29 Aug 2026 00:43:30 +0200
X-Gm-Features: AcwNN1XYBX11rSIqXNiWyf1cOFtlIqqPNasGuWLMN_MrER9LH0cNWCpmTMsLH7s
Message-ID: <CAJOGg3x4nMtSJeiLa2nsBFFuG4GRyvj7MbErcdOgxyuXCkr_og@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Do not combine resources that overlap completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Commit f234fdaae1ca ("ACPI: scan: Avoid registering platform devices
> with resource overlaps") attempted to avoid platform device registration
> errors due to overlaps of resources of the same type returned by the
> same _CRS object in the ACPI tables.  It did that by combining two or
> more overlapping resources into one, but it went too far and also
> caused resources that overlap completely to be combined which broke
> the arm-cmn driver that expects two MMIO resources to be present for
> each device it binds to and it expects those two resources to overlap
> completely.
>
> Address this issue by adding checks for completely overlapping
> resources to acpi_platform_adjust_resources() and add a comment
> explaining what is done there.
>
> Fixes: f234fdaae1ca ("ACPI: scan: Avoid registering platform devices with=
 resource overlaps")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/linux-acpi/20260819003752.GA3063251@ax162=
/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2:
>    * It is better to check for complete overlaps both ways as suggested
>      by Sashiko.
>
> @Julien: I would appreciate testing this on the machine that needed
> commit f234fdaae1ca.
>
> ---
>  drivers/acpi/acpi_platform.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -85,7 +85,13 @@ static unsigned int acpi_platform_adjust
>         for (i =3D 0; i < count; ) {
>                 struct resource *res =3D &resources[i];
>
> -               if (resource_type(new_res) !=3D resource_type(res) ||
> +               /*
> +                * Look for overlaps of resources of the same type that w=
ould
> +                * cause resource insertion to fail down the road.
> +                */
> +               if (__resource_contains_unbound(res, new_res) ||
> +                   __resource_contains_unbound(new_res, res) ||
> +                   resource_type(new_res) !=3D resource_type(res) ||
>                     !resource_union(new_res, res, new_res)) {
>                         i++;
>                         continue;
>
>
>

I have tested this on commit 1b78070aaef6. It seems the patch is
already included in it.

TPM device still works. Here are the logs.
acpi MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded due to overlap
tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

If in the future if I need to make tests again, should I do them on
the Linus Torvalds' branch?
