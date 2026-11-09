Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794235966;
	b=pFjoj12MgONB7n5GENRG5jfpNgJCLFAWXcPd4wc76BZk0XOlTHev5215fq7mc08pHTKL
	 AxEfpdaNjLBFumBRac7DDRXCHFgYerTIzTE/TuVr5JjUN2sJzsiZFdhHuMobVWjnI+1Eo
	 RTp7UfhpO/v3uhqlEyLi3Ig17vTYWurYEnFrjhQRfl+AgdZWYUXCQ8xtOCbBuQ6zO9MZF
	 AgO1ycRbqlmFhebIT88Coa7679St7jemnJPQII+nVshskAOCciE95ZczKIPMBtbsXMb0D
	 MltJ/TqlCj2gXGRRhxztlXKSciQilYg+Z2G/btuphD6pbQBjlXdMLZC1zmc5etaqCUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ITI1Hu+sB84O3i5CuT1vzHZvkT3z53SspgQZfJcrRIo=;
	b=XOn4vK2fW1JdmNLmxpPGcj1vMM2/TJkwjVhuRX4ZLe9tkAzdwnfUyA8Nm8yROIMXNgzB
	 dAfNk0e2vcYl7euKoywpYhLgYuGv/gPYq9yZjFQREc6eEPph8AM9d5du8VBjYAoMqgfko
	 E9BsH1SnRentdP6Ra0uE89CcFY64NekFVYOSHXziFxhjrsm2wMzptt5s9CcO1H2SU7SHr
	 ByPHtQTrg+biZxTLDkw9GzgziNaxvsLv/DGKqlFplQtvNfNQLSsbVMxOLhMIhYrDX3AD/
	 t7+u5Wz6n/yRGRWCqEnNcDz/Mr6okuvNrkm8rQkWP9AAKzuL2wU+hleWfx5cPLD9JYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qUJhtjWh;
	arc=fail smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9326606A321
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 14:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9326606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qUJhtjWh
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c14c0503dfso91622e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 06:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794235964; cv=none;
        d=google.com; s=arc-20260327;
        b=LMotkSQndAReqPKbjY6e3VZPjd8cjvnrk0SnWoPU1gof8ZbJ6bW2cxBWft2je1pgDY
         ZQ4GkpqyARGc4szsoi0fLfRF7rvE3N/PSrKF8BvmMTDxXMNtOnDDvOfihmoZX0k0osK+
         OPbGE9dikKQUXaWU/ZJfv1+/zGiINWZ6a35FPadVzHlMFhJoek4X/w91NHdkunM3fThx
         UCb2oLza0CwdTl6oJ1u8bxEKLOy9DRtAvxh1JFxtF2wkv4VuTArm1c9WvjzTnrtNxaE5
         WetnFTHSvFxPpdXEbdD9ogALBe84dSLl2DTIPtV/r94j6vfY4RtZuYAaYoDOvC6L425k
         THYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITI1Hu+sB84O3i5CuT1vzHZvkT3z53SspgQZfJcrRIo=;
        fh=p95OzZGsZBcaKGnvbSuC/hPpgVt+zqX1vvFzP+74/lQ=;
        b=pNydOE1+xP4EsSpn6gjqpvZEfCbA6BNPGrh+Hk0Mhc1sUvs/haiZSo/KCMD1vbTC9X
         UAFbWM/nnaw3385UxD4VIy3QxCBybkwUWe1BJYzpaDwAqu2Hj3ixn8lvCfd93ieWkVSs
         Dh/DeCVVxpb9PvvXFW8DeNzihHO0tk9NYSROaDrPeYt4yvz//p7kRcmtghe/hH7MyuAP
         aSQOco6fckXUiYQ2rA0ev+BMagIwUwnjp0ATG2v7nLED9l7VkZAHJaMppUdPvAeFZofm
         pnpIXyJ1pO77810wpHQEPErRPgypw39P9I5fr58X637tClJ0Dv7NUsuNERaEM/MhHQf9
         TMLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794235964; x=1794840764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITI1Hu+sB84O3i5CuT1vzHZvkT3z53SspgQZfJcrRIo=;
        b=qUJhtjWhIhdzF7W5AovdtbZkCdE9BAe1MVigA3VBPmxBPDKpi3deDeHMhAHDkDR6e+
         E0paQjhaVaGlVPWYMmSdeo+v4wJHkWJfHfriqBsiEWwPdR5DJozRtVoFllXoeg5e1Xgp
         zfq8bgQtmkTdkPNQeQs4ILXyP8/1Dq7lU08j7EjamquaWAkFY7fSVgW66EMseMmU6k/n
         s8Xo8YyrvCBk4zCWF2sD+3jsoUePmO059Z18g/otKtaj+sPitCmYd15wAZmGdfY8eLV4
         cGRuMKwRHbC+1fJ+KXMPxsr6cn1g/c69FJF8/nR4Q4bDgaAcPVraQ6J2xzPGlT0gDAvm
         O9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235964; x=1794840764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITI1Hu+sB84O3i5CuT1vzHZvkT3z53SspgQZfJcrRIo=;
        b=R6dG8AdK4i5rGfCCispDZYfedNOm72J6eYTL8PyUBbf2P0N8p5pASq/HgJNBOf0dzt
         0z+xPNIc0bYcmFL4vwuSgdcuIYF88B3+ZZSXg0CfN+ACoRGC6WaYyzQtncMdEyQ9SSCj
         qUTPVT7KOMIBU4mMbmVrDalMWuI+xq8OZFVXR0goXGbNlDsNPRaOX/Q47tUEuf6OFnTb
         qNNp3mGWPj0Jzu68Ro862AwhEudYCG/avVrY3+/B75QCHCJqgfx+gtn4XCxjjB9FHbGW
         8Nz8tIp9Yr3fjNmjIhXa2ophtsZ8FZtrhCxeRAlZv9pPt1Rih5uXgAkViIlrm37yi6Kk
         5tGQ==
X-Forwarded-Encrypted: i=1; AL+hErHzOFzQ37+0iwZb4cy6SWumpsg4ASWfNxn13SzVXPG8SL3EDayqD/oiuiMQ84ta90gDNzm8dXPf37cL@vger.kernel.org
X-Gm-Message-State: APuU4Z9RPdmPy3bVqcpC15rvjEIcq8PqRhkFvltbLmkwJsmAxccotAEd
	DGMcsHXS+fJLg1kT2Uk2ie1rj+Lk3RiM95LmtfVc7IDSfPoBRkURYqgAo3S+2oIR7QNeRnnDRMF
	m7EYr8svbhw9hS/3vm22HF/s2mBS36gI=
X-Gm-Gg: AYBFou08iM/owuAzZeIiSWJy+cAuLMlCPeDq7rJyFZiaWIxKoy1uHXui5ezV+UYdhK7
	xQthZ7L/1c7X3CtIhIVuoxyVbVeVoGdeKIRTYrEluXEKwBOozKLZ905fD7YdBIEBcJEqzeaKzlJ
	5txsAqqfC0PAnlqMtGUOPVXiPzq+zs6Z5i4FJ3n901IXkdFOdKY8MZ1Fr0bLWCqZm6gS6TLRSiS
	/P/ycQlsNQ/i5znJ3iitoVrw1a6PdWeBndnH5gzecPjLzq9f0b4wE0opGz2E3/KiRDHxn88PuNU
	wDyp4PiQi+A8L+BgOu/3TrO7Sfdi9ywlYd2cb8NKdv3CKxdSmaS4iKXTuEg7vh9A4Hx0tYuLdr/
	EG3eOQu/MSw6L89LPcCHsp6Z8oRIjWHC5F6Pkmp5T3CSRl8nXCi8tca9nkeviYxmVcpC9hA==
X-Received: by 2002:a05:6512:6516:b0:5bf:a66f:e5e with SMTP id
 2adb3069b0e04-5c14bf215b5mr1121239e87.0.1794235963672; Mon, 09 Nov 2026
 06:52:43 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPvUaSo1D+1Tvk3-4TMiXw-ScBtY8Mu0FzO7R_EG6zrjYfjYqg@mail.gmail.com>
 <asxTYBiGy6lf6-Ki@archlinux> <CAPvUaSo-ubCOCYYPadY1C23y1Fd_AAhQLuVKWRa6F1XVh6mk_Q@mail.gmail.com>
 <asz7WqGzukhkYHGD@archlinux> <CAPvUaSrbWrBuvAi3R02xC8w8M5Yh97pVd3-+FBXLp3mPgG5cUQ@mail.gmail.com>
 <as0bOFOoaaw-smyB@archlinux> <CAPvUaSoBgAG=MX93vMhfEiEk5bYXGydFsGn8CpoCu_QVQRPTCQ@mail.gmail.com>
 <CAPvUaSpPVYc-5M72G0Hf9JPsbdAp2-4f-p5OetYbMKdLqm0PXQ@mail.gmail.com>
 <atEh9Gon95EFIq76@archlinux> <CAPvUaSpq2d5hkxTaqAL6rBoeHct68Y37C4nSpV+goGZ-QwrCsw@mail.gmail.com>
 <atJc2J2hYrdI_Eun@archlinux> <CAPvUaSqAnLYVuzcq6Zq=hRp6JBoo8upjrsy=LSxnLdXuTyHDaw@mail.gmail.com>
 <CAPvUaSpk3wKyedtwcJpKFeQ_DGRJNa2-wXwVGSzX_bCadWozsQ@mail.gmail.com>
In-Reply-To: <CAPvUaSpk3wKyedtwcJpKFeQ_DGRJNa2-wXwVGSzX_bCadWozsQ@mail.gmail.com>
From: Lorenzo Collevecchio <lorenzocollevecchio17@gmail.com>
Date: Mon, 9 Nov 2026 15:52:31 +0100
X-Gm-Features: AclHuK-yHGm_OgM6tGld76Sat-ACVbH1JP4rJO3Tsa8gtHhtCjb26go9NshVU-g
Message-ID: <CAPvUaSpaKUk2Tp2N-0RaaMYUGoYYkTeVJ0As6YxFPRsd_MmXqg@mail.gmail.com>
Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP OmniBook
 5 16-ag1xxx (board 8DF4)
To: Krishna Chomal <krishna.chomal108@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, W_Armin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Re: HP OmniBook 5 16-ag1xxx: platform_profile reads "custom"
at boot, fan state carries over from BIOS

Hi Krishna,

Some additional findings on the OmniBook 5 16-ag1xxx (board 8DF4, BIOS
F.12), on top of my previous message.

1. Fan carries over from the BIOS into the OS. With Fan Always On
disabled, if I enter the BIOS setup first (where the fan spins), the
fan keeps spinning after boot until I write platform_profile. On
CachyOS acpi_fan reported about 4000 RPM at idle; on Linux Mint
(kernel 6.14.0-37-generic) it was 4100 RPM by my observation (sensors
did not show a fan1 line there). As soon as I write any profile (for
example echo balanced), the fan drops to 0 RPM at idle and stays
there. I did not check the RPM for each individual profile.

2. platform_profile reads "custom" at boot. On Mint, before I wrote
anything, cat /sys/firmware/acpi/platform_profile returned "custom",
which is not one of quiet, balanced or performance. After the first
write it reported the profile I had set. On CachyOS the profile reads
quiet when I look after booting; I have not yet checked whether a
service such as power-profiles-daemon sets it at boot, so I can=E2=80=99t s=
ay
whether the firmware reported custom there as well.

3. This may relate to the hp-wmi message at boot: "hp-wmi hp-wmi:
Failed to apply initial fan settings: -22". I can't prove the
connection, but the initial fan setup failing and the platform profile
starting in an undefined state seem consistent.

4. Thermal zone 1. thermal_zone1 (TSZ2) reads exactly 20.0 =C2=B0C on every
boot I have stored (17 Oct to 9 Nov), even when TSZ0 was 54 to 62 =C2=B0C
at boot. During a single-core load that took the CPU and temp1 from 27
to 49 =C2=B0C, zone 1 stayed at 20000. My journal only goes back to 17
October, so I can't tell whether it was ever different. It may be a
placeholder value rather than a real sensor.

Separately, the symptom I originally reported is still there: with Fan
Always On disabled the fan does not start automatically under load (92
=C2=B0C on CachyOS before the BIOS reinstall, 85 =C2=B0C after reinstalling=
 F.12
and a hard EC reset). I'm not claiming these findings explain it. They
look like two separate symptoms of the firmware's fan handling: the
fan does not stop on its own after the BIOS handoff, and it does not
start on its own under load.

Happy to run any further commands or test patches. I can send full
dmesg and journal output.

Thanks,
Lorenzo


Il giorno dom 8 nov 2026 alle ore 20:09 Lorenzo Collevecchio
<lorenzocollevecchio17@gmail.com> ha scritto:
>
> Subject: Re: HP OmniBook 5 16-ag1xxx: fan stays off, thermal tables
> invalid, results after BIOS reinstall
>
> Hi Krishna,
>
> A follow-up on the OmniBook 5 16-ag1xxx (board 8DF4), with some new
> data after reinstalling the BIOS.
>
> 1. Reflash result: I reinstalled the same BIOS with HP's official
> installer (DMI reports Insyde F.12, bios_date 04/10/2026, i.e. 10
> April 2026), then did a hard EC reset. With Fan Always On disabled, a
> stress-ng run on CachyOS reached 85 =C2=B0C with the fan completely stopp=
ed
> (acpi_fan: 0 RPM), and I stopped it there. So the firmware reinstall
> did not change the behaviour.
>
> 2. Thermal data from the firmware: on every boot dmesg shows
>    ACPI: thermal: [Firmware Bug]: Invalid critical threshold (-274000)
>    ACPI: thermal: [Firmware Bug]: No valid trip points!
> The only trip point Linux exposes is thermal_zone0 trip_point_0 (type
> hot, 103000). There are no active trip points. Both lines are present
> in every boot I have stored (4 to 8 Nov), before and after the
> reflash.
>
> 3. A new intermittent error: ACPI BIOS Error (bug): Could not resolve
> symbol [^^^^NPCF.DTGP], AE_NOT_FOUND, followed by Aborting method
> \_SB.PCI0.LPC0.EC0._Q37 (AE_NOT_FOUND). It appears in only 2 of my 14
> stored boots, one before the reflash and one after, so it is not
> caused by the reflash and not present on every boot. It seems to
> depend on an EC event.
>
> 4. Fan state: with the fan stopped at idle (0 RPM),
> /sys/class/thermal/cooling_device0 (type Fan) reads cur_state=3D1,
> max_state=3D1. dmesg also says "acpi-fan PNP0C0B:00: Using Microsoft fan
> extensions". I don't know whether cur_state is meaningful on this
> firmware.
>
> 5. Still the same as before: the WHCM/WMAA AE_AML_OPERAND_TYPE errors,
> hp-wmi "Failed to apply initial fan settings: -22", and WQBC/WQBE
> "CreateField of length zero". hp_bioscfg exposes only Sure_Start
> (error 0x3, feature not supported).
>
> I'm not claiming the thermal-table or _Q37 errors cause the fan
> problem; they are just firmware bugs that are present alongside it.
> The fan stays off under load on Windows 11 as well, and HP's UEFI fan
> speed and thermal tests still pass, so I have asked HP for a warranty
> repair.
>
> I'm glad to run any commands, collect more logs or test patches if
> that would help. I can send the full dmesg and the journal output.
>
> Thanks again,
> Lorenzo
>
> Il giorno dom 8 nov 2026 alle ore 11:33 Lorenzo Collevecchio
> <lorenzocollevecchio17@gmail.com> ha scritto:
> >
> > Subject: Re: HP OmniBook 5 16-ag1xxx: hp_bioscfg output and fan
> > results on all OSes
> >
> > Hi Krishna,
> >
> > A quick update on the OmniBook 5 16-ag1xxx (board 8DF4, BIOS F.12), in
> > case it helps with the HP side.
> >
> > 1. hp_bioscfg: the driver loads and registers hp-bioscfg, but the
> > attributes directory contains only Sure_Start and pending_reboot.
> > dmesg shows: hp_bioscfg: Returned error 0x3, "Invalid command
> > value/Feature not supported". There is no fan or thermal attribute, so
> > I can't read or change "Fan Always On" from Linux.
> >
> > 2. Fan behaviour: it isn't specific to the kernel or the OS. With Fan
> > Always On disabled, the fan stays off under load on Windows 11, Linux
> > Mint, Arch, CachyOS LTS and CachyOS 7.3.1-1. A full-load stress-ng run
> > (all 12 threads, platform_profile=3Dperformance) reached 92 =C2=B0C in =
about
> > 35 seconds with no fan. A 2-thread run reached 83 =C2=B0C with no fan.
> >
> > 3. Timeline: BIOS F.12 has been installed since the end of July, and
> > the fan behaved normally until October. HP PC Hardware Diagnostics
> > UEFI still passes both the fan speed and thermal tests. A hard EC
> > reset and BIOS defaults changed nothing.
> >
> > I've also reported this to HP and asked for a warranty repair. I'm
> > happy to test any further patches or run any commands on this machine.
> >
> > Thanks for your work on the hp-wmi fix.
> >
> > Lorenzo
> >
> > Il giorno ven 16 ott 2026 alle ore 19:26 Krishna Chomal
> > <krishna.chomal108@gmail.com> ha scritto:
> > >
> > > On Fri, Oct 16, 2026 at 09:06:03AM +0200, Lorenzo Collevecchio wrote:
> > > >Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP
> > > >OmniBook 5 16-ag1xxx (board 8DF4)
> > > >
> > > >Hi Krishna,
> > > >
> > > >Thanks a lot for digging into the ACPI code, the explanation makes
> > > >everything fit: the missing GMCF call for HPWMI_GM, Local2 being lef=
t
> > > >as an Integer, and the -22 coming from that.
> > > >
> > > >I also tried your suggestion about the platform profile. With
> > > >HPWMI_READ/WRITE the errors should not appear:
> > > >
> > > >  Before: dmesg | grep -c WHCM  ->  3 (the three boot-time errors)
> > > >  cat /sys/firmware/acpi/platform_profile  ->  quiet
> > > >  After:  dmesg | grep -c WHCM  ->  3 (no new errors)
> > > >
> > > >On the fan: thanks for confirming that acpi_fan reads the EC value
> > > >correctly. Together with hearing the fan on Mint and on CachyOS at
> > > >idle, that makes me fairly comfortable that the 0 RPM readings are t=
he
> > > >fan really being off.
> > > >
> > > >Your plan to query the fan count and hide pwm1_enable and
> > > >fan{1,2}_input when it fails sounds good to me. I am happy to test i=
t
> > > >on 8DF4 whenever you have a patch, and I can rebase it onto a stable
> > > >kernel tree on my side if that is easier for you.
> > > >
> > > >I also tried 7.2.10-1-cachyos: dmesg and the hp-wmi hwmon folder are
> > > >identical to 7.2.9 (three WHCM errors, then the -22 message, and
> > > >pwm1_enable still present).
> > > >
> > > >Thanks again for the time you spent on this.
> > >
> > > Thanks, I will share the final proposed patch on your Bugzilla report
> > > (222138), and leave this thread for others to pick up the WQBC/WQBE
> > > errors.
> > >
> > > >Best regards,
> > > >Lorenzo
> > > >
> > > [...]
