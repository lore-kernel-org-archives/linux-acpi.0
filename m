Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96F41CB5E
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792540; cv=pass; b=Ubfq/Z+rj7inkspc3p8s1wRWj7ibSEa03sLFtDGGVtDZR3zhGYEo4sp7os/qtEKKHycf7ztICy6Abc1yWZLH3T66RlmDyA5olFWrAC8So4oJZ7pwIPukBT3TYm4n2NWwkVOESHgwpINC/ZhgD4i0YEiT6/GA4fkKd8wLTLhq0Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792540; c=relaxed/simple;
	bh=9s3mrYJ7+5SgZM2v5YsLEH8BsKpU23j+dxsH+EwUIBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/bVhus70cNUniyrmX5+P8f2Fn3rzQ5aZDu+dfqcL69ElstvantH/21ByVWOaVKgKwhGIL5UqWNM8AHwa04dZRvCi91Bs1z8XXB1c8oGNDzYqKwrT/hLbB4RnDxZkqidCv3gma/vsMO+SYoegMI+lSoufGA6WE/mpEcdDYowqGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbp0jgyg; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbp0jgyg"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a9991e5e84so2038861fa.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 01:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791792537; cv=none;
        d=google.com; s=arc-20260327;
        b=cHMTVkMuR5wOa1B0MA0Ni/0tN6Z9gs4NY+8wqqDLzFCnkLNiva3RGTLjA7hfmADmbY
         81NRw+e4qHor2GtZNxx9zt2ib6F41BdGEk8cMdvPOoh4H6eyyTAgVLWwO0YgPO0fqv3V
         VJXOzY4eT698TvPbQkbkTc758QABl2Is6SC3sFKaRvPh88km3pGkMsHor4vzy/pumD+S
         4T4NUkaimuMgMTHEZJw1Wsvid0lrXT3nHq6WbBtlxFQwRzhOWKCiL1bP5H4wFy2XFJka
         opVehNIm9gaOgVbNnVVp3fLxy0kJFsyhV36jmIgRkl/ClziXZAcndPhZru/mcI65QHOQ
         q1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/Bid3bokAT8GtDHUcm91fXQib8AjiPPpst1kvF9OlyE=;
        fh=YwWSvBNTG6V4DFZ6/vvhNx3IUdymgsZY1DiQubh7Lv4=;
        b=SGtmNTeV/XNEMhPPALjyp2tfZyM9EubRHxc4iYnh/7NGCA6VRfJq1D8dXWtYr5Zx0G
         mG6hf5jjJCPV8wvo654k1XWCou/vxaDdyWfIriHopIS9VqPXSsZYGNQAg5Ty4rIxzB8D
         q5QAy5K4d3YjiXSg2+QljeV1au3jzit42B7jzmI8daLUeBR873KVT2XfQEOCqkKkdtNC
         U9sFdRGYNPkO36MaU94DNCeaQU9FIMF1o8l7lUSqqb4Oybp3l0jtRENon+SdS8DcNFHa
         GyNFd2JlpA0xWX9kTiK+Yh/kJMTZRkJ9+YLPUOfOnULZjnpg6IttP4GnQ0F2MMlIKd6r
         cpdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792537; x=1792397337; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Bid3bokAT8GtDHUcm91fXQib8AjiPPpst1kvF9OlyE=;
        b=cbp0jgyg/Eti/YMH0nvU0ckfTxbzFBKYSKz9i7k4qjRTyiIut8QNojj2wiYeW0MAAh
         AQIj4mNWZjimwfAvKB9aSa4ipT2eXOnjWVZXdmre8r32ktR3lnNBcZL1rbzPhWEdslvW
         byxAYmo4PXgrYWFGLCzBOd/Fpg50oyuqLSTUKckJSUmCTc3VuyM8fs8q2k+pNrDV59M1
         ErawgYWwNw8uAEyrvCpi0CKO1RWmaMH89vLBy87HqLxuIqg187oyg0qlxN52nUsj9Eov
         KLpaHQ4CzSJg2epdwVi3fx6dpUANIKw/eVOYcBFqVTfK0BD2BEc9c2v+oAnDsObiOUK1
         axrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792537; x=1792397337;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/Bid3bokAT8GtDHUcm91fXQib8AjiPPpst1kvF9OlyE=;
        b=xIzc/Ec7F6htvIhF4PuRT1PhV/SvoEng1hsB2/mNfkMXTkfbuZS8Uod9y/xFcxh93U
         fNg4q/Cd4PZ24360Vk4pmbeAA0q9Nr4q33yQocMGUoGl4NOaxtJUZyH3UhEodc9QdT56
         H4SSnWDiGOrxmsclbAw52DWWdSKCsj+rWkvGKSW9k7ZIiPPuDucZNHwN0lAI5Ai09SnI
         W//kqdHDOugRLvgO+PaMWLNetKFShw77DCtfpkiAZN1B67dGQXZwnoZFBEU+E/jIlLrh
         eolFJZHKZ2tPyYuPXaNaCULOgpaIDWORe7kzFeyjFp1uPxf5EUPRtlcDeGArzLskPNgM
         /m6Q==
X-Forwarded-Encrypted: i=1; AKwUvByo0oA6Ype2eEYpsUQpnTKBZdaI3zk0NpTWq2dPzIfvZpG31R0T6aBJbpr/DgNjroRkvnTpMrban288@vger.kernel.org
X-Gm-Message-State: AFq9FYI07MOSnWzqIpyF6ebOAP26XJgOH+UnRoP25IPMbftGRqmK0p8/
	z2bMQuKs8Zsh094YfvFJEXDmyxhZ6NiFrT0F1LF1D/3q+gRzXhmmNVQ6OqIhxB5W/XUez2cKTo3
	PXLDfG6KsrV2iMQxtge/8PUSY5G2miRs=
X-Gm-Gg: AYBFou2SWYWQrtdj+D83WihdQgTycbDw2qc+NTg5W+pMC7jvTfBtlj9ssddmbq2I7Km
	7KEGZbghMoxaMsPvK+E/1E2kHEwCmM+Lpy8p11TGtJMNQZjSuLMIeV+bXfqu5lo9/4qNjDfrwH1
	BziMvH6oRC8CxRdIoAVsN9uHBMYMmOQFB/uZqY1vU5eFu5oVP6eC7wFuEToAscClXWfEXmCC8N7
	IcpIVTQHBD9kKrqGFPkq9zuh5VZgkirn6WCePhY4odFLrnSP+GWsKmTVIFp+qnf421t+i8UgZvk
	SUxFXR59miOerz9XYg7SuVVLvxW1gD1eXtGxccv0l92M6AOOPbzDgJAG2ktT3+YwVDLf8ChbIal
	uiiWPBGkw6pIW
X-Received: by 2002:a05:651c:3605:b0:3a5:cee6:9439 with SMTP id
 38308e7fff4ca-3a9c4850930mr20579991fa.0.1791792535033; Mon, 12 Oct 2026
 01:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPvUaSo1D+1Tvk3-4TMiXw-ScBtY8Mu0FzO7R_EG6zrjYfjYqg@mail.gmail.com>
 <asxTYBiGy6lf6-Ki@archlinux>
In-Reply-To: <asxTYBiGy6lf6-Ki@archlinux>
From: Lorenzo Collevecchio <lorenzocollevecchio17@gmail.com>
Date: Mon, 12 Oct 2026 10:08:43 +0200
X-Gm-Features: AclHuK9QIm_cyAxCJbd_dL0bCv_1RDgkPqpwV7qsRDi6PUx5VbyZNkuR62_tvDc
Message-ID: <CAPvUaSo-ubCOCYYPadY1C23y1Fd_AAhQLuVKWRa6F1XVh6mk_Q@mail.gmail.com>
Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP OmniBook
 5 16-ag1xxx (board 8DF4)
To: Krishna Chomal <krishna.chomal108@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, W_Armin@gmx.de
Content-Type: multipart/mixed; boundary="0000000000008ff39a065da0354e"

--0000000000008ff39a065da0354e
Content-Type: text/plain; charset="UTF-8"

Hi Armin, Krishna,

Thanks for the quick replies.

acpidump:
https://gist.github.com/CollevecchioLorenzo/aef5917d9775629d48618bd42cb5f5e2

I booted 7.2.9-2-cachyos with modprobe.blacklist=hp_bioscfg
(confirmed in /proc/cmdline; hp_bioscfg is not loaded). Counts of
each message in dmesg, before and after:

  WHCM AE_AML_OPERAND_TYPE:                 3 before, 3 after
  "Failed to apply initial fan settings: -22": 1 before, 1 after
  WQBC / WQBE AE_AML_OPERAND_VALUE:         1/1 before, 0/0 after

So the WQBC/WQBE errors come from hp_bioscfg, as you suspected. The
WHCM errors and the -22 are not caused by it: they still occur with
hp_bioscfg blacklisted, right before "hp_wmi: Registered as platform
profile handler".

Windows, as you asked (Krishna):
- The Windows power mode setting exists, but that is standard
  Windows, i didn't check for HP specific.
- Omen Gaming Hub offers a performance mode
  option on this laptop.
- The BIOS has a "Fan Always On" setting. I had it turned off

Happy to test any patch or run further commands.

Thanks,
Lorenzo




Il giorno lun 12 ott 2026 alle ore 06:03 Krishna Chomal
<krishna.chomal108@gmail.com> ha scritto:
>
> +Armin Wolf
>
> On Sun, Oct 11, 2026 at 06:03:25PM +0200, Lorenzo Collevecchio wrote:
> >Hello,
> >
> >I am seeing hp-wmi fan interface failures on an HP OmniBook 5
> >16-ag1xxx. This is not a gaming model.
>
> Hi Lorenzo,
>
> Thanks for reporting.
>
> >Hardware:
> >  product_name: HP OmniBook 5 Laptop 16-ag1xxx (16-AG1002SL)
> >  board_name:   8DF4
> >  BIOS:         F.12, 04/10/2026 (no newer firmware listed on LVFS for
> >this machine)
> >  Kernel:       7.2.9-2-cachyos (also tested 6.18.55-2-cachyos-lts;
> >ACPICA 20250807 vs 20260408)
> >
> >Symptoms:
> >1. At boot, \_SB.WMID.WHCM (called via WMAA) fails three times with
> >   "AE_AML_OPERAND_TYPE: Needed [Buffer/String/Package], found
> >[Integer]" while resolving operands for [Index].
>
> This is likely due to hp-bioscfg instead of hp-wmi.
>
> >2. Immediately afterwards: "hp-wmi hp-wmi: Failed to apply initial fan
> >settings: -22".
>
> Ah yes! This is because we are currently enabling fan control for ALL
> devices. If you share your acpidump, I can check if we should use the
> HPWMI_FAN_COUNT_GET_QUERY to decide whether to allow pwm1_enable or not.
>
> >3. Later: "Attempt to CreateField of length zero" in \_SB.WMID.WQBC
> >and WQBE (AE_AML_OPERAND_VALUE).
>
> This is also likely due to hp-bioscfg. Try booting with kernel cmdline
> parameter "modprobe.blacklist=hp_bioscfg" and see if these disappear.
> That will help us narrow down the scope. But in any case, I think Armin
> Wolf will have to help here since I am not familiar with bioscfg anyway.
>
> >4. hp_wmi still registers as a platform profile handler (quiet
> >balanced performance).
>
> This is because 8DF4 is not present in any whitelists, so it takes a
> fallback path and uses legacy WMI queries. Honestly, I am not sure if
> platform profile should be registered for OmniBook devices. Could you
> let me know if Omen Gaming Hub on Windows allows you to switch
> performance modes or there is no option for this?
>
> >5. /sys/devices/platform/hp-wmi/hwmon/*/ contains only pwm1_enable
> >(rw); there is no pwm1 and no fan1_input.
>
> Intended.
>
> * pwm1_enable - As said, this is because we are currently (incorrectly)
>                  enabling fan control for all devices.
> * pwm1 - Absent because manual fan control must be unavailable on this
>           board.
> * fan1_input - Absent because get fan speed query must be failing.
>
> >6. On the LTS kernel the same WHCM error repeats about every 2.2 s
> >while something polls the hp hwmon device (277 times between 551 s and
> >1165 s uptime).
> >7. ACPI thermal: "Invalid critical threshold (-274000)" and "No valid
> >trip points!" for thermal zone TSZ0.
> >
> >Fan behaviour:
> >- acpi_fan (acpi-fan PNP0C0B, "Using Microsoft fan extensions")
> >exposes fan1_input. It sometimes shows about 2400 RPM and sometimes 0
> >RPM.
> >- The fan works normally under Windows on the same machine.
> >- I once saw the CPU around 95 C with the fan apparently stopped on
> >Linux; I have not been able to reproduce it yet and am collecting a
> >temperature/RPM log.
> >
> >I suspect the WMI query path the driver uses for fan settings is not
> >implemented by this firmware, so hp-wmi should probably not attempt it
> >on board 8DF4. I would be glad to test patches or provide acpidump
> >output, WMI GUID listings or any other data.
>
> acpidump would be helpful.
>
> Thanks,
> Krishna
>
> >Thanks,
> >Lorenzo

--0000000000008ff39a065da0354e
Content-Type: text/plain; charset="US-ASCII"; name="blacklist-boot.txt"
Content-Disposition: attachment; filename="blacklist-boot.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mv4xj8h90>
X-Attachment-Id: f_mv4xj8h90

WyAgICAwLjAwMDAwMF0gQ29tbWFuZCBsaW5lOiBCT09UX0lNQUdFPS9ib290L3ZtbGludXotbGlu
dXgtY2FjaHlvcyByb290PVVVSUQ9MWZjYWU4YzgtYzI0Yy00OTMwLWI2ZTAtMzYzMmI5ZTY2YTE1
IHJ3IG5vd2F0Y2hkb2cgbnZtZV9sb2FkPVlFUyBzcGxhc2ggbG9nbGV2ZWw9MyB1c2Itc3RvcmFn
ZS5xdWlya3M9b2JkYTo5MjEwOnUgbW9kcHJvYmUuYmxhY2tsaXN0PWhwX2Jpb3NjZmcKWyAgICAw
LjAxNDg1NV0gS2VybmVsIGNvbW1hbmQgbGluZTogQk9PVF9JTUFHRT0vYm9vdC92bWxpbnV6LWxp
bnV4LWNhY2h5b3Mgcm9vdD1VVUlEPTFmY2FlOGM4LWMyNGMtNDkzMC1iNmUwLTM2MzJiOWU2NmEx
NSBydyBub3dhdGNoZG9nIG52bWVfbG9hZD1ZRVMgc3BsYXNoIGxvZ2xldmVsPTMgdXNiLXN0b3Jh
Z2UucXVpcmtzPW9iZGE6OTIxMDp1IG1vZHByb2JlLmJsYWNrbGlzdD1ocF9iaW9zY2ZnClsgICAg
Ni4xMzkwODZdIGlucHV0OiBIUCBXTUkgaG90a2V5cyBhcyAvZGV2aWNlcy92aXJ0dWFsL2lucHV0
L2lucHV0MjMKWyAgICA2LjU0NTcxMF0gQUNQSSBFcnJvcjogQWJvcnRpbmcgbWV0aG9kIFxfU0Iu
V01JRC5XSENNIGR1ZSB0byBwcmV2aW91cyBlcnJvciAoQUVfQU1MX09QRVJBTkRfVFlQRSkgKDIw
MjYwNDA4L3BzcGFyc2UtNTQ1KQpbICAgIDYuNzQ5ODI0XSBBQ1BJIEVycm9yOiBBYm9ydGluZyBt
ZXRob2QgXF9TQi5XTUlELldIQ00gZHVlIHRvIHByZXZpb3VzIGVycm9yIChBRV9BTUxfT1BFUkFO
RF9UWVBFKSAoMjAyNjA0MDgvcHNwYXJzZS01NDUpClsgICAgNi45NTM1MjRdIEFDUEkgRXJyb3I6
IEFib3J0aW5nIG1ldGhvZCBcX1NCLldNSUQuV0hDTSBkdWUgdG8gcHJldmlvdXMgZXJyb3IgKEFF
X0FNTF9PUEVSQU5EX1RZUEUpICgyMDI2MDQwOC9wc3BhcnNlLTU0NSkKWyAgICA2Ljk1MzU0OF0g
aHAtd21pIGhwLXdtaTogRmFpbGVkIHRvIGFwcGx5IGluaXRpYWwgZmFuIHNldHRpbmdzOiAtMjIK
WyAgICA3LjM1OTcxOV0gaHBfd21pOiBSZWdpc3RlcmVkIGFzIHBsYXRmb3JtIHByb2ZpbGUgaGFu
ZGxlcgo=
--0000000000008ff39a065da0354e--
