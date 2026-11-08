Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794134038;
	b=t2teHftSnV9E5FR6gnkRyAlB8ymLksGUaQHWdKhq9KrqERlIQqcDOVyzkx0jOr1KmmLe
	 L//8WoMyVtNWZ1tMOXShbpSNNlHrFDISSV8SUH52LkXKfKVXjYBb/FGwqB9TBSGQ4stdI
	 2nNISVnhU2Ksuw/WjHdwSpAF23sA20mZ9Xnn27Lf8GTTg67Ia2npdfWigPWXKFnhmdhkd
	 VWeBIpqS3yBSPJYiWGKWHuZMWELEgup8P55GwaD1MFEQoLuYVtZNC3QD7RP+EaDb4+NP3
	 xJh8+s4mPs+EuRT7jrTka2mDYb61VGSkYEJFjCiIR2IbKaWkw8UkuiB18aBys/PsWaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=glvGrWRT1QN/fE8UGYdsbVnUnNT1CZIwbxztIXMB48g=;
	b=LWCPtmW6XcoEms87Iseb2gxwicupaMQzV4p9OrX3L/6wlBMWQ0BVbUzhPqpbnfKawXFa
	 v4xraQVZm60GpjQSM2vsnxUpBaIgjUVdE3iISOufO8Wx8GMWyRYjx+h5YdhwniSRzszlP
	 4U0TrBGjoZestd0Tw2l8oPqfJqgtIu0js678gRyTi+jBK4Zl/1a75sQcJBA90dGiChqfh
	 nDpnS/8CO45hBBj+vchbuoaHesvLPbv0AGZwtN6rDOMRHmPjmpDc/vIW4Vs+UtQ+5xn+X
	 sDo4oxx+WXo1CLR0BXYHFdU9X4gaJM1oiiLBZpwv0tSnh+TjHs1IfAyrVZZQf5HqIwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZyBVlwC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F1606A320
	for <linux-acpi@vger.kernel.org>; Sun,  8 Nov 2026 10:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A20F1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZyBVlwC
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab1a37faaeso40481fa.0
        for <linux-acpi@vger.kernel.org>; Sun, 08 Nov 2026 02:33:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794134036; cv=none;
        d=google.com; s=arc-20260327;
        b=seGBqrMzCsaUFi4TdLk6yKFgEjQ0Z5EeDBfVnFj7gS2wGcAl1zVrVI3hl0Zpl28LTF
         qbXNEwRiMsZQSY9FIhBmVAS6UKABuBgCnm3lLAETDhk78wOfkceJXF34URPnjSvezHl4
         fwzyPhaFPa41gFDiFwcy5P+w5a6Zedo/4wq1I1Y3QCuFyJxyH1YSbEeaYsLPTJedRevE
         81aYndj483D+NG0kmSDKyZKztdbP108nMk6ox2WKdMlgrfrPqIHRbKBWmUC9/ncfH1fh
         OMAOx5m4gVfTImzQ55wxuV4rzkcnrXaWf0utNp6Mn4oHv9luDM7C/3hjUq8pXaF5itmE
         Ly2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=glvGrWRT1QN/fE8UGYdsbVnUnNT1CZIwbxztIXMB48g=;
        fh=A6CFz9IyAtCVIKPZECvkbHst8RcD/236Bbh1ehZNaL4=;
        b=BufC2EhkWa0vyuaNowK5qWYd6rF7V3hGH0j43cRMk3JDUCwM8mFnmI3yo/Ehw0YAn2
         Z/9o567q0kUfOf1EwzdJyY5+iEs82uhBblK/kutDTIEHGExaiOfkA8wQdfH2tian9kGN
         lOSSlGBoEtmgMKVxpQHs34GRpFnVBFPGnjwYOiMTCuPXBv55DDAAD1pRnOzKpZjIPpzS
         y+aS6PS2jOFHP+4KjFPQKWMyFlAAQRIHUUweWVzTCCC+aFWteCN/fEI+YzixoheME0oh
         RE55M+XDHlcQAPCRwPTt881+cQKr5BgBbisAX1awVC5TQB3jfFeBUKPqjR7tf5bNCWIh
         6okg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794134036; x=1794738836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=glvGrWRT1QN/fE8UGYdsbVnUnNT1CZIwbxztIXMB48g=;
        b=aZyBVlwCf3HtdIM+1sV0UWQdH2oSFkOc7HO3xGCc2YUHvHTXKYT7khh2XIxyNQ+mtv
         ASKuqDjU8ERXQwDKG9KaoDqfPNad9Ukvu/lAl6xSetw/JW7T2bE0av8FKX0Rsdq8Bkhk
         qFIx5stGz4MeP50q2tDAwKTLMmrax8Dp/bj9D9D0sIWULCizXkZP4q9MriCyyWoI0TFv
         SbG2YCAzt5VAVm9BKTHlVK9CTS9aYYhZgtNifmVAFMTo6qxN1QmDa6v1YVinqxIeXQXA
         N1/Wqf9Rc7JpqFLKV2qx6vi+v7qRbszs4wLnkL9fYoVjOX3qdUPV0ltxmtL9qIjtaNT+
         2T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794134036; x=1794738836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=glvGrWRT1QN/fE8UGYdsbVnUnNT1CZIwbxztIXMB48g=;
        b=Be4drrrjvqv23J6d0/nl4kpERpyhz325XN2DkIFpspId/nnj8lZ3pxscfZ1893ztXE
         JUd93ol5xxFsmwijWaaZTl9XtmERfm4AnY4q1uid57+gw9uUwt3VKYm6WI7vN5g3bFtD
         FpAaa+H4fBFmjk/ycgB3g3sTafzLQ7iY3G19gIHC3P25AFhnaUh9puQ8Ro/J7OPPIGup
         Y6SovIn9tMU6/Woa47YtjVfS+36XWfFzjj0njQbTBRrtTT3n43+VceTKLivevMh8EwPT
         kszmWy1L27wDZHmiGEvBIbRjb0pNQtf9VyhN/7kUbaNiWxXGzaT6ko6cR+nQJ34+kCQQ
         UkhQ==
X-Forwarded-Encrypted: i=1; AL+hErHVGhTXajKVcl956WEQk8p8ezip3EsMDp80DbOcj4rEFnjDEiQhRy6sCp+sLgj0h5c6O1BnYPXGZ/yt@vger.kernel.org
X-Gm-Message-State: APuU4Z+wk61xK3RTRTjQxEO5BCsAdJjgPeze/A+lGegS/bJvA0VeeKoh
	Vl1/TF93GRav9HQZJ2uvTVm8RNsD7BjFkvI8V/2ZQMRx1l5MADYTiEo7ldwjtdEq9Efj4lIGbKi
	EomAWPD7YvqJYEBIkeBxEf66h68eNY2o=
X-Gm-Gg: AYBFou1/DfhjyLG17htJd8PGeqx3xPLcWTrzhNS5OndBAzzdbYbWBJJ9F0QEZKxoWgu
	qt1iBzUOOY1dp4AWkgEjQgJEGaBgu4gLIEBvbIXEAgjh8XC261GYYTxWRjAOheQta8PyvK/UPCa
	LZI8MDiKgOF49on4NmLokPSGsx9ffe7rN3ePyJjUdhXoSBNUL2KvByN/hUEq/BIn6tAMCN3krSo
	KjEffC/Jnpzr9hOCdn7AWEyotOB5PomuQ/PempUJUxdK7gvddUMlK7tJUumGdMmg4cOQgaxYxeF
	FuSO/RYZ4M2puj3CM4w8xwgP60DhIvVohJynRMdfcbbsgYzsswhHokn9Gg+mgFCpPtNp3J0hvS+
	9neb8j/U94IdAO8R9zbzqABepMo9vp3XJeqpRfzp0xSmvtz8BOe15JXT3k4jKQtaFwZCwiA==
X-Received: by 2002:a2e:7a04:0:b0:3ac:ddd5:55ee with SMTP id
 38308e7fff4ca-3adfa3a50cbmr2094571fa.2.1794134035626; Sun, 08 Nov 2026
 02:33:55 -0800 (PST)
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
 <atJc2J2hYrdI_Eun@archlinux>
In-Reply-To: <atJc2J2hYrdI_Eun@archlinux>
From: Lorenzo Collevecchio <lorenzocollevecchio17@gmail.com>
Date: Sun, 8 Nov 2026 11:33:44 +0100
X-Gm-Features: AclHuK8RS4vQ3n6u4Bm4vCHvO6Hnt7D0ObPsJjucxe4puVLCmB39UPpPrbPa-oI
Message-ID: <CAPvUaSqAnLYVuzcq6Zq=hRp6JBoo8upjrsy=LSxnLdXuTyHDaw@mail.gmail.com>
Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP OmniBook
 5 16-ag1xxx (board 8DF4)
To: Krishna Chomal <krishna.chomal108@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, W_Armin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Re: HP OmniBook 5 16-ag1xxx: hp_bioscfg output and fan
results on all OSes

Hi Krishna,

A quick update on the OmniBook 5 16-ag1xxx (board 8DF4, BIOS F.12), in
case it helps with the HP side.

1. hp_bioscfg: the driver loads and registers hp-bioscfg, but the
attributes directory contains only Sure_Start and pending_reboot.
dmesg shows: hp_bioscfg: Returned error 0x3, "Invalid command
value/Feature not supported". There is no fan or thermal attribute, so
I can't read or change "Fan Always On" from Linux.

2. Fan behaviour: it isn't specific to the kernel or the OS. With Fan
Always On disabled, the fan stays off under load on Windows 11, Linux
Mint, Arch, CachyOS LTS and CachyOS 7.3.1-1. A full-load stress-ng run
(all 12 threads, platform_profile=3Dperformance) reached 92 =C2=B0C in abou=
t
35 seconds with no fan. A 2-thread run reached 83 =C2=B0C with no fan.

3. Timeline: BIOS F.12 has been installed since the end of July, and
the fan behaved normally until October. HP PC Hardware Diagnostics
UEFI still passes both the fan speed and thermal tests. A hard EC
reset and BIOS defaults changed nothing.

I've also reported this to HP and asked for a warranty repair. I'm
happy to test any further patches or run any commands on this machine.

Thanks for your work on the hp-wmi fix.

Lorenzo

Il giorno ven 16 ott 2026 alle ore 19:26 Krishna Chomal
<krishna.chomal108@gmail.com> ha scritto:
>
> On Fri, Oct 16, 2026 at 09:06:03AM +0200, Lorenzo Collevecchio wrote:
> >Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP
> >OmniBook 5 16-ag1xxx (board 8DF4)
> >
> >Hi Krishna,
> >
> >Thanks a lot for digging into the ACPI code, the explanation makes
> >everything fit: the missing GMCF call for HPWMI_GM, Local2 being left
> >as an Integer, and the -22 coming from that.
> >
> >I also tried your suggestion about the platform profile. With
> >HPWMI_READ/WRITE the errors should not appear:
> >
> >  Before: dmesg | grep -c WHCM  ->  3 (the three boot-time errors)
> >  cat /sys/firmware/acpi/platform_profile  ->  quiet
> >  After:  dmesg | grep -c WHCM  ->  3 (no new errors)
> >
> >On the fan: thanks for confirming that acpi_fan reads the EC value
> >correctly. Together with hearing the fan on Mint and on CachyOS at
> >idle, that makes me fairly comfortable that the 0 RPM readings are the
> >fan really being off.
> >
> >Your plan to query the fan count and hide pwm1_enable and
> >fan{1,2}_input when it fails sounds good to me. I am happy to test it
> >on 8DF4 whenever you have a patch, and I can rebase it onto a stable
> >kernel tree on my side if that is easier for you.
> >
> >I also tried 7.2.10-1-cachyos: dmesg and the hp-wmi hwmon folder are
> >identical to 7.2.9 (three WHCM errors, then the -22 message, and
> >pwm1_enable still present).
> >
> >Thanks again for the time you spent on this.
>
> Thanks, I will share the final proposed patch on your Bugzilla report
> (222138), and leave this thread for others to pick up the WQBC/WQBE
> errors.
>
> >Best regards,
> >Lorenzo
> >
> [...]
