Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2943F08A
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667996; cv=none; b=KHxRsRj4x6pBHSzCSg+P1Bmp2yXyFqk92iSkAfn+cvWiAPQL/xzdyV6vr5R8TUMGRYVxQAS7Daid/1O5SzxwfmeBr1CU6MqKejolVLpKx0EIP4y59OuqDJFBrJu0XVa0OkMaoqtaStf2PQIwFroEXYeBaGbWXiBn46voKvQXz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667996; c=relaxed/simple;
	bh=WrKWF0zpBFmx9TGe6pRnrsasHgTmHn/qSADU66B648s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3Prq9Lewz881Ty0gfkwwBkzoIAJZad3x3++eY8mpK8VyBPzJLtGI/8f697gGWCs1oz+c1hOyYopzelBNXKwo/3xr0amy4ERld2S/GFamVw+Je/JuJYMoBNWcuAmB5n4O0+499Z5UdGopiHLoEslBkhb7FhNXYIps7npDpQ0VU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEQsac6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEQsac6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBD51F00A3A
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667994;
	bh=lrzQfNCmnVmNZzMq6NNyeALqwDSMHKUO3YbQ6Oaj5r0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IEQsac6zfeyz2pIdb0YlrY1/JLAU4NlKyOXNjjUY/hRvI5ERAHnpPbFcaVqYSTg37
	 GfRdOe023nSCNaHVLbF1XRmcWO7vRv+rQ5LEhBlq376jww4TgeerFeN2Ky3HOOASiV
	 Xbr4/7pgRvTI7DrivtlMmFbLgrgWx1m1frd7sXdRHi00WcavY1S+ZkP+o49beF+aJa
	 rRT7mUY4LArWtS9ipUGCXoMmzmhwMX+rKYMMOHe/5loFF1K87bSfldGC7PGNqau63j
	 bgcE8Z+yHDcjCXJk47QpaKvj2zVo0rFlVcHVZq2nvElqbUldWlw0paNfEa2mRhvLsv
	 S3USWZG4kK8uw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39b51882d71so68635531fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 14:06:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqX0SXE+fg4UYK3a2sXaidBCCDGejxfZo29Sb698/NT7UMApR0zkpS4kWy6UjofrJZg0vHXNc7mU8yQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxqqU8LmjOZmVopPVMHfGw4f+3Pt0kIXgI5AQ8lExZUvyxSihCZ
	EaEmhCrs3UuCcIvym5A4bAYRd++/ocrIA40vOZJ6MekZ5jJzoXK4FZ8IOAlILVu1zElxld1khus
	wNqKbXTGU+oJyacp0PqjEWwRVANYBmK4=
X-Received: by 2002:a05:6512:638c:10b0:5ae:a9ec:9fc4 with SMTP id
 2adb3069b0e04-5b28f9bd9efmr2954503e87.63.1784667992917; Tue, 21 Jul 2026
 14:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720032341.3087008-1-rdunlap@infradead.org>
In-Reply-To: <20260720032341.3087008-1-rdunlap@infradead.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 23:06:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsYiZU3X+6f-dygjO8tsqEMfkmWZRU6Er3NP0wjj5Twg@mail.gmail.com>
X-Gm-Features: AUfX_mzc5jptaTrl8NNlQdrdgTjMDCvWgczmK070d0QWuCdidxIc2JHiM8FRbZk
Message-ID: <CAJZ5v0hsYiZU3X+6f-dygjO8tsqEMfkmWZRU6Er3NP0wjj5Twg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: fan: Use correct function parameter name in kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 5:23=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix kernel-doc warnings by using the correct function parameter name:
>
> Warning: ./drivers/acpi/fan.h:83 function parameter 'speed' not described=
 in 'acpi_fan_speed_valid'
> Warning: ./drivers/acpi/fan.h:83 Excess function parameter 'speeed' descr=
iption in 'acpi_fan_speed_valid'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
>
>  drivers/acpi/fan.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20260717.orig/drivers/acpi/fan.h
> +++ linux-next-20260717/drivers/acpi/fan.h
> @@ -69,7 +69,7 @@ struct acpi_fan {
>
>  /**
>   * acpi_fan_speed_valid - Check if fan speed value is valid
> - * @speeed: Speed value returned by the ACPI firmware
> + * @speed: Speed value returned by the ACPI firmware
>   *
>   * Check if the fan speed value returned by the ACPI firmware is valid. =
This function is
>   * necessary as ACPI firmware implementations can return 0xFFFFFFFF to s=
ignal that the

Applied as 7.3 material along with the other 2 patches in the series, thank=
s!
