Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0044BE426
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577882; cv=none; b=r1aO9s2JGmjak2lNnS6wivhuBnhjNCB+TsP6CsFfKTxnh3S3t4se5R2jiX4rKOLENwW7scPqFm7imXzhobI3BvjCaYyp1QigJrh5lLyL2DpwMzOcCdIak7vPgganfFgwovqG1chbDKzLK4xz9KfX20SekEpIEAhbYK0cP0j1Jfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577882; c=relaxed/simple;
	bh=4hFWEbuE2AQefLY6oY+WaF7GgZdEWO7hngxQP6KlUbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vByyf826PTApr/tKPHaOh2VAySEJj1+yyoKqYeHzISg3ZY6x4X2s28IIFKNOgatKW4YBgdPw1dTbe0KJxo+dNhCuYk/r1OAnEyE6etEsYjAKxPAapKbXxTXCqlB3dOJdBrwF8gPsp2WQoFTgLjCJr5CXZYVf0TVw1EQXppX0nxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvdLKoJB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvdLKoJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0AC1F000FF
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577872;
	bh=6oh4T09/HYEEtcXV5J/6yzIjl1npmjYVcmea9tYWGw0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UvdLKoJB4yfty1FlARVhD45Nepm9YPjE7vETaQDuZkuhXxhDDe7BxceaVzRHemZfS
	 HEOqgFGt63EKT/60P8fZsJCHWhBArjSJWKnkYjICVm7gyfF0Ba61mT3gK8WxOFLwaE
	 BFTmUlAb4mJ0W+ZrkSH9ImvGM5m3EciRssLe3LqhuW10QX7KfT357SGSyzCek14egF
	 B+1ZGSpXyzB0nH7u+U+zys7Mlx8WrhAI66mB3svI7bOqRZ/t8YSkWVgWUz3fRy2IUn
	 +C+X24Cyfdwv+tiKMktLPiun0pYegdlERXyjIhCHqQHUZLjZipklVpAlZnf0XLWewu
	 ZpT5cCQ8vyRTg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a3156692c6so8937491fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 09:57:51 -0700 (PDT)
X-Gm-Message-State: AFuF++m2AQW+Pv6rM1zX81MrWIH/kxrLpozl0QIP5o/PiqKY6H7+trJ3
	1ozHKXMqQYceo5hlYPBNkfMVNolbhmteTR+HPaVMQTDvh4DnGIEg441qgoOUmrGKZK6CqOHzDxG
	vwjOyu9nMMvB5rM3AD2sLlerv2hFeNHc=
X-Received: by 2002:a2e:be13:0:b0:3a1:8558:56a2 with SMTP id
 38308e7fff4ca-3a5dc9a7905mr6715151fa.6.1789577870440; Wed, 16 Sep 2026
 09:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF9RqJ4ip_egVwRKnwn3=X-Qxuwz0u_9pNrgfujBw8RSf2DTPQ@mail.gmail.com>
In-Reply-To: <CAF9RqJ4ip_egVwRKnwn3=X-Qxuwz0u_9pNrgfujBw8RSf2DTPQ@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 16 Sep 2026 18:56:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g2pvj96FR_=iiBSNFXCfRS3mYuwtUMTMiYrqFGA+w=EQ@mail.gmail.com>
X-Gm-Features: AcwNN1UIW8KWHz3IjtnVoRiBxRSxZcw4XxnQHoEMkViaQUw5MapFVuRCduRaLE4
Message-ID: <CAJZ5v0g2pvj96FR_=iiBSNFXCfRS3mYuwtUMTMiYrqFGA+w=EQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: use strscpy() instead of strcpy()
To: Ruslan Vagner <rusya92266@gmail.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:56=E2=80=AFPM Ruslan Vagner <rusya92266@gmail.com=
> wrote:
>
> strcpy() is deprecated in the kernel. Use strscpy() with the
> compile-time known size of the trace_method_name buffer. The existing
> length check already rejects overlong input, so behavior is unchanged.
>
> Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
> ---
>  drivers/acpi/sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index dd4a99f09efe..a99373547126 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kstrtox.h>
>  #include <linux/moduleparam.h>
> +#include <linux/string.h>
>
>  #include "internal.h"
>
> @@ -181,10 +182,10 @@ static int param_set_trace_method_name(const char *=
val,
>
>         /* This is a hack.  We can't kmalloc in early boot. */
>         if (is_abs_path)
> -               strcpy(trace_method_name, val);
> +               strscpy(trace_method_name, val, sizeof(trace_method_name)=
);
>         else {
>                 trace_method_name[0] =3D '\\';
> -               strcpy(trace_method_name+1, val);
> +               strscpy(trace_method_name + 1, val, sizeof(trace_method_n=
ame) - 1);
>         }
>
>         /* Restore the original tracer state */
> --

Applied as 7.4 material, thanks!
