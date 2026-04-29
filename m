Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE73EFD06
	for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468473; cv=pass; b=jIhPEAtOoEF9qN3pdddyeYsGWG9h7NX+idHPO3kVXl6MAiKXCxCExnvtQI9wgFcVe8hoRo9hyKK8ylDkc0IWt2h+XfvYXKyT21z+I6GNxscEzki/4+Urp/NldHvB5t2oDdQZmSEm7mlzn46zqiK7sBxslRN+/4KnRpWtw4LD3fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468473; c=relaxed/simple;
	bh=Ux2r9QnDlH5d/NiXKpkjv121CLS12vhgo4R+YpSnuAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjVbauWwgnwAGvUSmsDe6lHS3iZ18W+WD7xVgm2NELGVlV5HU6nqMFNFBR972f3ZP3vH0plNUyMg0vMR472mgMrlkl5z7M/bH/TS+vGgwblCCeoovcyNEEDmnFHwV7PAp69mXkqXKZizP/rS66Xce0KTaaPFIWwjISPQyv7eLe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnGW5oHq; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnGW5oHq"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65075c2ba66so10513560d50.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 06:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777468471; cv=none;
        d=google.com; s=arc-20240605;
        b=HmiqkMRaqC0rl8QPKM1+imstIi7zVbSavt/UcxD8Ise9zJEBTpyd3urqERS+iLGQmg
         Bmp9mxsf43pAJGFIRv4KhjA0jfUTap0Mt144sc2v4FFUCAK0eFoYdOG0Gxy8zUmvc3pz
         iyEZ84/TaT4P2S5raZUjtPzBvbyMtVt8Oft80weHAl4qFnyIxUJCd3yJWkkTWYFy5GLC
         5BejEAhRHQDh9SF95Rpxs69j3UwLxwTFvQdiymZgCqI5BOH3Kl6vsKCrPys/PEVEqy5V
         pHzuJkDHltBjmLCKUpWwbpW0/D2aWOX1bLXn83O4R+ZesRweXdKDY6NESUx5KXl79asz
         YW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nJPGoDB18jxxWOq+lTIa2rT6oabQIaw1yzHWrhodPo8=;
        fh=FAflpxCZmi4ETATdI50PZPD37raqYSQjtCDwETJ3dwE=;
        b=U0Q7mVHuhNCUVYyE6Se3rTIb4DpoeHRiLXCqANDIYDSRHNsKltuMZ6bCzGI+oGpxW5
         9vZ74uT87igaKTZCwUdcFM/3Xd2Xh/TJyXoUMSGaIB9MQYP8Q3GeF00UtPFXe7nOg9lH
         w/NwmItkLj4OOUkr0vXXeiqtHZ6GFFeFcl3vjP1g6gWGAkyWldRHyxoMB64+rlmADVbC
         6KpBPUBzMKYH3iyUoQKBJD5S0nsxRcwPz+3A2NNsNemnaD73Knivc4GEkCPDaOKiiUTq
         REAGnJET0JR2kqXIXrK9hhJLMW2OxC0u7kWvqyfYH9WCJOm9f6yiUs7PoYixQOOSNSHG
         Udlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468471; x=1778073271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJPGoDB18jxxWOq+lTIa2rT6oabQIaw1yzHWrhodPo8=;
        b=WnGW5oHq6YMK60dVAT8PS8AQOru57Y1rcDQiWKEMPoF9SWnX09vES+ZUqUYPGbUeyv
         qa/MsyskVRR34NX9rJXWIdSBstnAjibID6ZsAlztSGfjtXscGBNpTrhO+fgRT8uHD8tM
         2G/kBRGuqqNc1YN2mpRxTHjB48x/OQ3JYO0fkUKIoAJ6n21uiyRMD3nKvgrkvBoUwd1t
         Jxm8wN/9+VX3DAU3hNNIIoGWuqZjvrqVugCbEg6Y1WE0sSQ5sFQq0u3vpbp2aVzWh4WF
         xUWBMKc3UeaXs7jGK4TFOwHW+3JzkzTDkiyyLlFC6wR+AA5a+UILagtmwvjqT+hl2gLn
         HeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468471; x=1778073271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nJPGoDB18jxxWOq+lTIa2rT6oabQIaw1yzHWrhodPo8=;
        b=iAVcr4gFeZmuG2zLqdOrV8JllCf7CgcTWT97SxJyDLJIO4LV2TiwWaMFtEkbWcm55W
         cMKfIIhzBtJ5rFLJZ+IOTFeHpjty847s6GJ0c+mVeiVjmVO6nimhQpPVGXmETT6PCyHQ
         h8HXNqYhbnGD4PJd6Wy6KIJdp7WlrPzkoKk3wnpQMxnq4YmF1VHpWMVmx3CEVhQ48/Ta
         3ocnJ93ypz39NAfDLp7F/wZp6G/wucGHNJp0gveS/4Tygge4PsSeMnvItPjyU46unrRM
         eMMnUzz4cUnf+Vnrzmtl8Cx4xcUOdu6AwwweQXR+baB614jm4rrh1FXsNM7OSjEOYLqO
         /DiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tz+g3WdCXRI1tmJw0MoulYGE0DKRKUWgDJZqpEJJqNpzA+4pgXyWCJzpCzhmiObpyxJWrKAdbv+vq@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxuzK8JVRRo81v47iSE9cg648IQzHzRy/5yyDPMnEko5i8zWN
	XvHggRLGik7JRYijLcsuEJQpffdHDLxQJreaKAAY4s+tRWR+jmAzviZzEoY/jfYaW//02Wz724u
	EyrMSXIZML+Bp1pjL1auuQ8RcL2EdbPo=
X-Gm-Gg: AeBDievh3ceaqZYCD+3P3a1tYteDxNB2vSb2UyS26Nj0QACi55weP4BqtV4TF3uqNtW
	FjFMqwGC+hRfjwtXnXapMfFcZxF4lOV3b3tSdc3g6+nTpqzDUDawHMYGUi4c4EcCcZdMt59E4Bh
	+JfGrdWVqsw9+3EA1RHd9bMw4B+Fz9Bc9eY+BG3PSxQyBE5SFK1yvxCSv28H4HXSxQWkSj3wZ3Z
	tV5dEfx+bSqXywGm15Pye8TcSyQpjaYTcpXbqYnNaCB/4tOMTH17jt7tEtlxVRh5hnN86q9uuqu
	e88j706j/bStGuEpoGdkGYkfmKc0bL/xerjZFbrwaEQnd/ioxkI=
X-Received: by 2002:a05:690e:b4f:b0:651:cfec:fcf3 with SMTP id
 956f58d0204a3-65beeed4ef3mr6702815d50.64.1777468471453; Wed, 29 Apr 2026
 06:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429012432.120830-1-m32285159@gmail.com> <afHVeVavSJ2NZ480@ashevche-desk.local>
In-Reply-To: <afHVeVavSJ2NZ480@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 29 Apr 2026 08:14:20 -0500
X-Gm-Features: AVHnY4J-70M_rffw_QcGwS-Ky0kCnkglKCpXmElJ4mmy1DTYIMD25D_8-FsqH40
Message-ID: <CAKqfh0HWpH_cgwqVw8YAg7BTDMZwhWVpLkh8RCwypcz_P1Bn9Q@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, andy@kernel.org, westeri@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 4:55=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Apr 28, 2026 at 08:24:32PM -0500, Maxwell Doose wrote:
>
> ...
>
> >  v4:
> >  - Added else keyword to if statement in
> >    intel_soc_pmic_exec_mipi_pmic_seq_element() per Andy's request.
>
> Nope, sorry if I was not clear. The idea is to drop 'else'.
> Also make the patch less invasive.
>

Ah, I see. Just a misunderstanding, I'll make sure to fix that once I'm hom=
e.

> ...
>
> > -                            __func__, i2c_address, reg_address, value,=
 mask);
>
> > +                             __func__, i2c_address, reg_address, value=
, mask);
>
> Still a stray change.

Yea, I'm not sure what's going on with this one. I think in my editor
it looked like there was some misalignment from before but I'll see
about dropping that.

> ...
>
> It should be
>
>         int ret; // also left untouched, drop that from commit message as=
 well
>
>         if (d->exec_mipi_pmic_seq_element) {
>                 // the below if-else-if just should be left untouched.
>                 if (i2c_address =3D=3D d->pmic_i2c_address) {
>                         ...
>                 } else {
>                         ...
>                 }
>
>                 return ret;
>         }
>
>         if (d->pmic_i2c_address) {
>         }
>
>         ...warnings...
>         return -EOPNOTSUPP;
>

Alright, thanks for clarifying this. I'll make sure this gets in for the v4=
.

best regards,
maxwell

> We may get a second patch for deeper refactoring later on.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
