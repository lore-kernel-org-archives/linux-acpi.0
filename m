Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C2383984
	for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066605; cv=none; b=kLB3CQEkvrlaoebwVIMtwctz7ZG8mkMwMHyxbxhqcg5jQP0GjFLuiDVJdzZuYuc2aIx7jtLZBT9TsHUnEvN6XeFyRsKPFOCp5kxlyvwqsBhoBYLYkQiN0Vtedd8+AHzTkvbzbfF6e4Fl3O9VjvkanZuMMcIaiP02dVNb+4Rg3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066605; c=relaxed/simple;
	bh=apV4MFXuinpqWoqNOaKgBV+93M9TMWWLYxR7HwQlPLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucpzL/aGOWvXZamtB1CZof5sZVb4kmQDzjMqp/vlrms1yjWc2MBkbzf2Qc4yBq+YZBVVD4dFqrDJFr0gUPtQtLeb5YiSjJYEZtKTELxsL/SDoaHaJm6mBXjHS0sdiRfoJScvlIOPC1efBzJQB20kr4sEgsuCpUelQxiOwKO5MCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDZmR15B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDZmR15B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F8A1F00A3A
	for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066604;
	bh=VM/O2tFnOA/m3uwjcQ3FYby8zOl177tbOL49//JHdQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aDZmR15BTG+nXw8vzhad1VfOBmPdvLxmFNu5Nz3c5bwgrcicgetuC3qCcwkfmH0BN
	 7D6Ha4bu5Wd3go/ClBmui8zcxOl/ESw1BvB/T1Mb1f8hAMKJhN/4QWPgwbDxfnoSYO
	 gyZ6KX4bBze1Tzvf3SgU/waLI5OmMzGxqhHtVF484lMa2T1DYOeBGGeIxiVdvNzQY8
	 NssnyyqeME75QImfjdkxNb8iprvCK9ECFTszleTUBgKTrT8ZTG66+WwBdtWI90GOjf
	 y/T6PWRS2Bqq8eBznoDHIg5okZ/bY3qffFernrDrNpRho23EFPCTnzDKiQ628MG2la
	 V41JtggIXePbg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39dbe684115so9805431fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 08:23:24 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyh8uV+TR0cAa+2YUwRbe6d6qQrt6FxpjJIQz7Yeenx2FVRfBZs
	C09pXY2gwFF9RrSKxEPV2LR2oFw4Z/uQnRSsuAJksgYWahm9dD+/VMDdK9oyU9niCJP7PNFG/CY
	my+L9kqk5T+phErN0KPbimoX+ejCa89w=
X-Received: by 2002:a2e:a552:0:b0:39b:11f9:6132 with SMTP id
 38308e7fff4ca-3a17686cff9mr17509831fa.1.1787066602757; Tue, 18 Aug 2026
 08:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69a1eaf0-4a58-47d5-ad94-2af958f84841@gmail.com> <5d99ccb3-691e-4b89-b58b-017a7318aef0@gmail.com>
In-Reply-To: <5d99ccb3-691e-4b89-b58b-017a7318aef0@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 18 Aug 2026 17:22:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMjbTGd5mDuPwypJ06E_F_QZweHH_QHj_Kryh9ZWtRQg@mail.gmail.com>
X-Gm-Features: AcwNN1VrOFEiUsaLMpH2gy89EfCfen9UrKzcqZj6i8q0_7xrsCpiNAzfrc8zlsA
Message-ID: <CAJZ5v0iMjbTGd5mDuPwypJ06E_F_QZweHH_QHj_Kryh9ZWtRQg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Regression=3A_Backlight_control_broken_on_HP_Omen_?=
	=?UTF-8?Q?15=E2=80=91ax246nf_with_kernel_7=2E0=2E0=E2=80=9128=E2=80=91generic?=
To: harryblanc <garett26@gmail.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:03=E2=80=AFPM harryblanc <garett26@gmail.com> wro=
te:
>
> *Subject:* Re: Regression: Backlight control broken on HP Omen
> 15=E2=80=91ax246nf with kernel 7.0.x
>
> Hello Rafael, Thorsten,
>
> Here are the outputs you requested, from both the working kernel
> (6.17.0=E2=80=9142) and the failing one (7.0.0=E2=80=9129).
>
> For context:
>
>   *
>
>     Secure Boot is *disabled* on this machine.
>
>   *
>
>     GPU setup is *Optimus with NVIDIA GTX 1050 =E2=80=9Con=E2=80=91demand=
=E2=80=9D mode* (Intel
>     iGPU is primary).
>
>   *
>
>     These changes do not affect the issue: the backlight regression
>     remains exactly the same on kernel 7.0.29.
>
>   *
>
>     Kernel 6.17.0=E2=80=9142 (backlight working normally)
>
>   *
>
>     $ ls -l /sys/bus/acpi/drivers/video/
>     total 0
>     --w------- 1 root root 4096 ao=C3=BBt 18 14:50 bind
>     lrwxrwxrwx 1 root root    0 ao=C3=BBt 18 14:50 LNXVIDEO:00 ->
>     ../../../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/LNXV=
IDEO:00
>     lrwxrwxrwx 1 root root    0 ao=C3=BBt 18 14:50 LNXVIDEO:01 ->
>     ../../../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01
>     lrwxrwxrwx 1 root root    0 ao=C3=BBt 18 14:43 module ->
>     ../../../../module/video
>     --w------- 1 root root 4096 ao=C3=BBt 18 14:50 uevent
>     --w------- 1 root root 4096 ao=C3=BBt 18 14:50 unbind
>
>   *
>
>     The ACPI video driver attaches normally, and backlight control works
>     as expected.
>
>   *
>
>     Kernel 7.0.0=E2=80=9129 (backlight stuck at maximum)
>
>   *
>
>     $ ls -l /sys/bus/auxiliary/devices/*/
>
>     /sys/bus/auxiliary/devices/acpi.video_bus.0/:
>     driver -> ../../../../bus/auxiliary/drivers/video
>     firmware_node ->
>     ../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/LNXVIDEO:00
>     input/
>     power/
>     subsystem -> ../../../../bus/auxiliary
>     uevent
>
>     /sys/bus/auxiliary/devices/acpi.video_bus.1/:
>     driver -> ../../../bus/auxiliary/drivers/video
>     firmware_node -> ../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01
>     input/
>     power/
>     subsystem -> ../../../bus/auxiliary
>     uevent
>
>   *
>
>     On kernel 7.0.x, the ACPI video devices are no longer bound under
>     |/sys/bus/acpi/drivers/video/|. Instead, they appear under the
>     *auxiliary bus* (|acpi.video_bus.*|). As a result:
>
>   *
>
>     |acpi_video0| disappears

Well, this is not supposed to happen regardless.

The (auxiliary) video driver binds to both devices and it uses the
same platform firmware interfaces as before.

It should register the backlight interface for one of them, but that
doesn't happen for some reason, probably related to the ACPI error
messages you see when running 7.0.x.

>
>   *
>
>     only |intel_backlight| remains
>
>   *
>
>     brightness keys move the slider, but the actual backlight does not
>     change
>
>   *
>
>     ACPI errors appear in dmesg (CreateField length zero,
>     AE_AML_BUFFER_LIMIT, WMID failures)
>
> This matches the regression I initially reported.
>
> If you need additional logs (ACPI, i915, auxiliary bus traces), I can
> provide them.

Please boot the working 6.17.0=E2=80=9142 kernel again, do

$ ls -l /sys/class/backlight

while running it and send the output of that command.

Also please send boot logs (the output of dmesg after a fresh boot)
from both the working (6.17.0=E2=80=9142) and failing (7.0.0=E2=80=9129) ke=
rnels.

Thanks!
