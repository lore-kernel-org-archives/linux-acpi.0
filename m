Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45717413230
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493809; cv=none; b=bovbIAPQXhrJIfzBkujtBhyaAaeQUgyeMkD0Tc/1d41Fx10JsQr1g2CkJtJQpS+NTBunt0Gus0L65a7CvYsS/oPJBUUHsbq5pD9hhFA6Exm1JKRq0o2zC6vlmYVLh8/fGJtJ2TiIMUeNspbRRJKCKgt5eMTsINlrcnhZ9mcKw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493809; c=relaxed/simple;
	bh=P1qW5K/WAYkwpB10JO5S2xO79+RVM1UFXE31AzRJsn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuQeRn5/KyAYiwskV5kIVB3+4h/DtiMjI4CfLvFR9CuxTsvUWhALmvaLuUVeUAXVpn81kqEcWeuK7Lyko11LOJIZ8GfhknpNNRK7MUqkx8Nube9yA47TQswEg1cCWpuZ9eyCMYGBazicBIAc/1osqH2qbWJpxnhBPWNxUCxL0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8k9nENy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8k9nENy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672A51F00A3A
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 10:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785493792;
	bh=P1qW5K/WAYkwpB10JO5S2xO79+RVM1UFXE31AzRJsn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X8k9nENySskp3+wVQpabnQWHVySisRYtW+24wx2uEBmmbRcaUatkU6BMjHGHlgfGw
	 sEGUcz+vo+FllMt5HChcngx2+4aUnZGBcPa8OdCuiEKdQvTHFxHuVIt4QAg53MNFFd
	 v5HcpfdYW2zUQWCAZRnrkTlekkCfgVXUYfy84WYad7Fii7OtDILvU+xA8KC9Q3xU77
	 8GKPSXBFooA+ObcEF3KP0cdH3MEwF8B3MJQct590JkAiQ7iB5VWDFZJ8lNom7c3RH6
	 Td7Rhn32DAOvUKwEpFPoKLChsixy+CfAUXeN1aLvP7rByHombrjzPbjyGhuFSHtKKb
	 MsFplDNnRv9xw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b00d083818so1674680e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 03:29:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqC+CcUCS47TzdhXg2+oRnfRNuFl/y2TCgLYCIzVyRV7cvDTsN0DTo3WTnVxSXAWbRWmvFLuxuIrP5V@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKqC2BoKZP7dBovR2pOtjzeoe/11eRxsBtfAEUPhamR9fEGHM
	l9SQroseZSgK8wK1H29gpF7OfdM7MJD74FqhbRaQsXm7gEPUFMsn+5AltYiDzVwc42UAo0FNQMy
	vpAC71eq56cpogyJvzGW+7ECtVP0qxy8=
X-Received: by 2002:a05:6512:33cd:b0:5b2:b02c:e8ce with SMTP id
 2adb3069b0e04-5b2e23497afmr335013e87.30.1785493790890; Fri, 31 Jul 2026
 03:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
 <daf0bb9b-246d-437d-87ca-16706113b201@gmail.com> <CAJZ5v0jByxtQ2tmNm_ZyyBnDMBNjuqQwD_367NRyGNzF7wQtRw@mail.gmail.com>
 <7792f017-42b0-4a09-9941-5259138e21b1@gmail.com>
In-Reply-To: <7792f017-42b0-4a09-9941-5259138e21b1@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 31 Jul 2026 12:29:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jCFFNuG7WtCE2CG+hP=YNsYMdXH_945QgkgAUcr4Lryg@mail.gmail.com>
X-Gm-Features: AUfX_mxMWrJYWEGNu9VTGHJWBkWM0z9KgAfZy1cyJAWdfLd-3fe4Aw39Q6semGo
Message-ID: <CAJZ5v0jCFFNuG7WtCE2CG+hP=YNsYMdXH_945QgkgAUcr4Lryg@mail.gmail.com>
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: Julian Silver <mendaxca@gmail.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 6:40=E2=80=AFAM Julian Silver <mendaxca@gmail.com> =
wrote:
>
> On 2026-07-31 00:16:27, Rafael J. Wysocki (Intel) wrote:
> > Can you please check if the attached patch (on top of the current
> > mainline) helps?
>
> I tested v7.2-rc5 with or without your patch. Both of them have the -110 =
error.
> Note I add "#include <linux/pm_qos.h>" as the patch does not compile.

All right, so it is not sufficient to avoid deep idle states for the
duration of the EHCI probe.

Please send the output of

grep -r . /sys/devices/system/cpu/cpu*/cpuidle/state*/

from the affected system.
