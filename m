Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794164978;
	b=iK4anJ9nCHCL8b9rez8W+Y1AxWoWHGntBd9AExvpUwBgnI/b+z4yrEkioSUtwe/xfPh4
	 R/RvcDwYuqHiMfZLgjturaVzp5P14+iyvulrpudPpn2wAZiy1iUVd/ZFCYkpcD8JyZwff
	 tA33tS2/MnuLlF6/samwpVm8yZMaOrCsOZEx4IskBLJ6z2siqnqjDMfUbV6mpQwnk9ZLJ
	 tpiYrAiFOVXk8UKfzCp7FdE8u2jx8FMCHXZ/JROLqUsVo3fQsTLoEpXnDmMIDUlZNoV3W
	 XG60m2fmXvh7rSZw6PegEXsnYS1WSbISVFrpjzcsCCKpuZWbGkSYs4PFTF6rqZfk8hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nVPhrKJfbSmpnE1ryW+os71+IdLIXTokbMOzIHpkGpM=;
	b=J/JcooLr5Polh1LyCqJ3fOlq8G4I3kTD7xfKpGz1IJ6RLS93XGsWch3Rae6h+UxkUrFB
	 jbzz8PLy8eGNwNItQWoS0KUUfxVAbhuoFrZ6FwG9RcTV0Z8TJG0Wb9yIZt3tcfB1Nvs3R
	 NXG4RISU2h+hAnvdf+CCwPeudJk0KrV6SIyQu7NqCUI5SWemzXsLhOVSkZKcOZSSB2MNG
	 DUu9X6sM2iwxEWCjbSeWtxYoblr8ysHGu8WiEsBF3NjRcOxdW4g0daGJFt8hLu4Roxs/s
	 OodQdbJ9zZIxuIoF5oRjNZLBzeDFgAGM24GqFwB27eYI389Yp/xFqm15ZEiZgX4c+Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyqhPkoJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF652606A320
	for <linux-acpi@vger.kernel.org>; Sun,  8 Nov 2026 19:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF652606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nyqhPkoJ
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c14c0503dfso17457e87.3
        for <linux-acpi@vger.kernel.org>; Sun, 08 Nov 2026 11:09:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794164976; cv=none;
        d=google.com; s=arc-20260327;
        b=M2WZ3MpCowRd5uw+IbkuOVVJ/E+azhilRwK5iOz39G2fD3LU0rDRvouh2ECJb3/+/F
         VhhF0Mn1VxtJR2oc1MlMQLdoacAiX3MyFNEEXS6J0YZtZlNZ2la08tdTsJ71dnORgo2X
         FKIiiXlOTjBoWJK1f53PbKkL02Z/JGJnlX0wZV5YCb1Bi5lFpFZvktXUUzdNWthd8vsq
         YfTFq4KsjESZE5hiT9872JVAuBhWkUs4S17LN24oAZ+hUTPHRJzlnQDG2ekvlEA1YdEa
         hBhbB7vVyZoW/p3QpKLWlXuEwBKvPNwPnyn6/rEi4PVnR9hgLGbcErXubqdaTocBGb/G
         wYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nVPhrKJfbSmpnE1ryW+os71+IdLIXTokbMOzIHpkGpM=;
        fh=bVV1wmDTd7trLs3LyQC0XRIPsoqcKiKvnqtviJ2Jwdw=;
        b=JtZQo49ul+yCjJJHv3IfPhDIOD+m2SpV6U81rWhV8e9d0TdHv066NSsybhy6NCf9jL
         2TOQxdKw3LY7jfKICnN6qsD+EZTrl7v6H/8cwza8kRp4fCR0j4rgDASWKXpBgBeMLHVn
         zVE3h1SuFkZD1XbtHUcTqN/3Gm2DKCkfE0x+hbVnpmC3FfQYc2WusMYE8tH14FIHg6bB
         nPO1c1fGgtEMS39POO2krtj+wt+XLiJ6vJCPkGkgmOFiPCQUca/hHtPvZl2e1cqW1TQC
         SDrxc+vPTDf26IMHpM6ysAFLU00vEsporuOnOjwOjirvpN3yinwS8k1zx8fzdgIPFHSr
         75Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164976; x=1794769776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nVPhrKJfbSmpnE1ryW+os71+IdLIXTokbMOzIHpkGpM=;
        b=nyqhPkoJf4ud3o1TNoUahdgrSk8UAzNFro6L20LwdXi6pzsG1JFYz7/hq+yiq56Sos
         hIdYfIn7fBJakdI4m+bmVlv2y9vUaw91XeEMXFwCN8sKIUaSHTq9ec2wFyGVfwnFT0r/
         jRS0GMBjeJWcVqAl4vWKAMXmmzuHhp3dGlsb3RyGYTUlN1GB39Wqp+pH/S7ri2ksB40S
         mOul80aft9gc0KlaHVkXRUMipjiiw3PzmpaLddu4ZdbKPo+vFwtprGd+EM4UB48OkEK0
         tJEN+w2HClt45BB1n+TDYkVMWWZuZu74L/iNF9FE01IrMjVd6fGC/0U2X2oatkpDZsoj
         oCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164976; x=1794769776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVPhrKJfbSmpnE1ryW+os71+IdLIXTokbMOzIHpkGpM=;
        b=lFMGpuyxfhuOTJP5bFMgHqqMIcr3Cn6a8FY481PDBxb2UmK2J1iaDn7YlZ/10KNuf8
         ILzoLxiqZjiDJnd8HC/DD6UPWuH/hAIpatA2oNAvElvwMTz1wYpytimweZIkMkTvmoIg
         L44ie+axgNkmTlJT9GYY4p+vFHvKdjcbIfOduGJ/EuIvZwzZhKTi5J7JoVsIIrORCdR3
         niRp33uONcKr2hUfXvAW4DFodXKAB0100fWrzHYp9Vt0g0TztckuZgvPQzwmnEN6Fsoy
         puQUQNjVIkjYVVS+AuNKLRXgy1VF4MTm4eFsCuD/nz2cdhSEEmYNOmPRf69utRK8hjTl
         mZ1Q==
X-Forwarded-Encrypted: i=1; AL+hErEEaPffWnOkbxoKxNiewT52u3sncYKa0sIoL5Slg+2sgfz0WXYoBF9n8dTuI4+i0eD50KjNZv1ILVf7@vger.kernel.org
X-Gm-Message-State: APuU4Z8UVcmU70EjtpNL6BiIDQ1/9Jh7by+caX0BWwFFZpai625kCyPs
	AhknUhIXqZMevSR95DXBtOeZHmp/aAcQscVO4HdIXBRXRuu805Yv23yKwim+GDgNThAJ2rzK/xG
	xASI8+rUGjGtpHc/VDw6C+EjE8HEvNRA=
X-Gm-Gg: AYBFou2ZYlqaegXfAowrAQ+QeJSiwmkk8rWLFnvCZHJNNaroFrtXyt+6s5Hv5dAf7Xf
	Qd23JRPaV2kuN+3Q3y3/elrlx3IgIBvOu5M2neEjDmCiHoIVeTqAOiReqpScucPKt7lhFxfiQU2
	dyMd44OOnUzb2UBduZV3Si5V+wDRX6MkgGzxcuUYX8+SEpLbaq5Zwl2YdnWpNvaoEzpmYsUtK+c
	vgsQEidCw1OFRmkcrgh9QDFcW4TjkOl8uBsbPiJ0UeTke+SOYjoLIxV+8Iub43gnYTl/e/9tkH0
	YUFUbtuNVFCp51MBLgIYHi/3I04jrRPh9S0EcB5xhvLrEwmbVvPs7afwNyHESW4gcHW4kvH2uc/
	WXzfHTREgG103MfLP3GHTY11d71f70OwHhLD14JIOmMakI0C1BbzvawQrnE9OVR/G99h/2wFyVf
	V5JhrY9WJPFYEBtkQ=
X-Received: by 2002:a05:6512:6516:b0:5bf:a66f:e5e with SMTP id
 2adb3069b0e04-5c14bf215b5mr451239e87.0.1794164975540; Sun, 08 Nov 2026
 11:09:35 -0800 (PST)
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
In-Reply-To: <CAPvUaSqAnLYVuzcq6Zq=hRp6JBoo8upjrsy=LSxnLdXuTyHDaw@mail.gmail.com>
From: Lorenzo Collevecchio <lorenzocollevecchio17@gmail.com>
Date: Sun, 8 Nov 2026 20:09:23 +0100
X-Gm-Features: AclHuK_FNAfGTAsVxz4a8U8h_DJnTbqCdNj-mRMbyDEevkGVnR6kp2dma-lgvo0
Message-ID: <CAPvUaSpk3wKyedtwcJpKFeQ_DGRJNa2-wXwVGSzX_bCadWozsQ@mail.gmail.com>
Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP OmniBook
 5 16-ag1xxx (board 8DF4)
To: Krishna Chomal <krishna.chomal108@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, W_Armin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Re: HP OmniBook 5 16-ag1xxx: fan stays off, thermal tables
invalid, results after BIOS reinstall

Hi Krishna,

A follow-up on the OmniBook 5 16-ag1xxx (board 8DF4), with some new
data after reinstalling the BIOS.

1. Reflash result: I reinstalled the same BIOS with HP's official
installer (DMI reports Insyde F.12, bios_date 04/10/2026, i.e. 10
April 2026), then did a hard EC reset. With Fan Always On disabled, a
stress-ng run on CachyOS reached 85 =C2=B0C with the fan completely stopped
(acpi_fan: 0 RPM), and I stopped it there. So the firmware reinstall
did not change the behaviour.

2. Thermal data from the firmware: on every boot dmesg shows
   ACPI: thermal: [Firmware Bug]: Invalid critical threshold (-274000)
   ACPI: thermal: [Firmware Bug]: No valid trip points!
The only trip point Linux exposes is thermal_zone0 trip_point_0 (type
hot, 103000). There are no active trip points. Both lines are present
in every boot I have stored (4 to 8 Nov), before and after the
reflash.

3. A new intermittent error: ACPI BIOS Error (bug): Could not resolve
symbol [^^^^NPCF.DTGP], AE_NOT_FOUND, followed by Aborting method
\_SB.PCI0.LPC0.EC0._Q37 (AE_NOT_FOUND). It appears in only 2 of my 14
stored boots, one before the reflash and one after, so it is not
caused by the reflash and not present on every boot. It seems to
depend on an EC event.

4. Fan state: with the fan stopped at idle (0 RPM),
/sys/class/thermal/cooling_device0 (type Fan) reads cur_state=3D1,
max_state=3D1. dmesg also says "acpi-fan PNP0C0B:00: Using Microsoft fan
extensions". I don't know whether cur_state is meaningful on this
firmware.

5. Still the same as before: the WHCM/WMAA AE_AML_OPERAND_TYPE errors,
hp-wmi "Failed to apply initial fan settings: -22", and WQBC/WQBE
"CreateField of length zero". hp_bioscfg exposes only Sure_Start
(error 0x3, feature not supported).

I'm not claiming the thermal-table or _Q37 errors cause the fan
problem; they are just firmware bugs that are present alongside it.
The fan stays off under load on Windows 11 as well, and HP's UEFI fan
speed and thermal tests still pass, so I have asked HP for a warranty
repair.

I'm glad to run any commands, collect more logs or test patches if
that would help. I can send the full dmesg and the journal output.

Thanks again,
Lorenzo

Il giorno dom 8 nov 2026 alle ore 11:33 Lorenzo Collevecchio
<lorenzocollevecchio17@gmail.com> ha scritto:
>
> Subject: Re: HP OmniBook 5 16-ag1xxx: hp_bioscfg output and fan
> results on all OSes
>
> Hi Krishna,
>
> A quick update on the OmniBook 5 16-ag1xxx (board 8DF4, BIOS F.12), in
> case it helps with the HP side.
>
> 1. hp_bioscfg: the driver loads and registers hp-bioscfg, but the
> attributes directory contains only Sure_Start and pending_reboot.
> dmesg shows: hp_bioscfg: Returned error 0x3, "Invalid command
> value/Feature not supported". There is no fan or thermal attribute, so
> I can't read or change "Fan Always On" from Linux.
>
> 2. Fan behaviour: it isn't specific to the kernel or the OS. With Fan
> Always On disabled, the fan stays off under load on Windows 11, Linux
> Mint, Arch, CachyOS LTS and CachyOS 7.3.1-1. A full-load stress-ng run
> (all 12 threads, platform_profile=3Dperformance) reached 92 =C2=B0C in ab=
out
> 35 seconds with no fan. A 2-thread run reached 83 =C2=B0C with no fan.
>
> 3. Timeline: BIOS F.12 has been installed since the end of July, and
> the fan behaved normally until October. HP PC Hardware Diagnostics
> UEFI still passes both the fan speed and thermal tests. A hard EC
> reset and BIOS defaults changed nothing.
>
> I've also reported this to HP and asked for a warranty repair. I'm
> happy to test any further patches or run any commands on this machine.
>
> Thanks for your work on the hp-wmi fix.
>
> Lorenzo
>
> Il giorno ven 16 ott 2026 alle ore 19:26 Krishna Chomal
> <krishna.chomal108@gmail.com> ha scritto:
> >
> > On Fri, Oct 16, 2026 at 09:06:03AM +0200, Lorenzo Collevecchio wrote:
> > >Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP
> > >OmniBook 5 16-ag1xxx (board 8DF4)
> > >
> > >Hi Krishna,
> > >
> > >Thanks a lot for digging into the ACPI code, the explanation makes
> > >everything fit: the missing GMCF call for HPWMI_GM, Local2 being left
> > >as an Integer, and the -22 coming from that.
> > >
> > >I also tried your suggestion about the platform profile. With
> > >HPWMI_READ/WRITE the errors should not appear:
> > >
> > >  Before: dmesg | grep -c WHCM  ->  3 (the three boot-time errors)
> > >  cat /sys/firmware/acpi/platform_profile  ->  quiet
> > >  After:  dmesg | grep -c WHCM  ->  3 (no new errors)
> > >
> > >On the fan: thanks for confirming that acpi_fan reads the EC value
> > >correctly. Together with hearing the fan on Mint and on CachyOS at
> > >idle, that makes me fairly comfortable that the 0 RPM readings are the
> > >fan really being off.
> > >
> > >Your plan to query the fan count and hide pwm1_enable and
> > >fan{1,2}_input when it fails sounds good to me. I am happy to test it
> > >on 8DF4 whenever you have a patch, and I can rebase it onto a stable
> > >kernel tree on my side if that is easier for you.
> > >
> > >I also tried 7.2.10-1-cachyos: dmesg and the hp-wmi hwmon folder are
> > >identical to 7.2.9 (three WHCM errors, then the -22 message, and
> > >pwm1_enable still present).
> > >
> > >Thanks again for the time you spent on this.
> >
> > Thanks, I will share the final proposed patch on your Bugzilla report
> > (222138), and leave this thread for others to pick up the WQBC/WQBE
> > errors.
> >
> > >Best regards,
> > >Lorenzo
> > >
> > [...]
