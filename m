Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204055;
	b=XWjqOw/N4W5WD5U7Z0F6xlop8+4voa/bEcMqV49ZgYRSG7I2ip6XFLdMz0PJWhFJ9AkA
	 Cp0CrObovSi1vRXfrrkSroJW5WvnLD052mKkbVyACBCxADhtV3KEc6fHKXTXWDdPy7lKa
	 eK2RA526MFWjV8UyW3RsMeSH+io84yfUy6pnVRYUNaXSnuOOjhoo8iHuM2TB9td6FXBVC
	 qpneaMK4yXb2AUqauVR85DSjl84ktMzNd+SvEu+/Dy8Ye1r08osrq4cKzDHw2QR8FvOzG
	 Qjru2tGBICz6DrFaC2hGCon+q+UqIT/utc/l7ToNl1EVG5rS8ldP2wF1B7hkEU88hpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204055;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=WOVU8i6VSaQSMlgwSIaOiPPhD4QfVwgPNsYdPg6cYCU=;
	b=GWAOh7CHUh2okJcNN3Rh4voXi7XlkRemcPZmfxDQcWV8nNfAw7y/uhjR4frwebBzUZvE
	 hgKGBLIKSb5PnVnt3aX8bDwBYyWlfccOw8Rrx6Dbo7MCLAKHfbtL6TM07dblxXp6KZo0t
	 3jfRTM7E0czsl0pkM3H4vHkD/k9fHL646OZDbQ8cbKSW03krwAHmFXWGswaHiNNkhe6xs
	 f5jHS+NiexxdR0ZvNj0QYTjFOKqc6QbcjjrbWmYPdhUASgmVhi4jYHpNlk/tvqrULflvl
	 9a6jM85SQABP4kiXiNVpowYRhCqA1q9Y91NLVrAQtkanJlKM4Tbh3KaXP9yQsB7Y63g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnWD0tqP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC387606A31A
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnWD0tqP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832EC1F01825;
	Wed, 28 Oct 2026 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204054;
	bh=WOVU8i6VSaQSMlgwSIaOiPPhD4QfVwgPNsYdPg6cYCU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=RnWD0tqP0Rx76Hd3Lt0R6BXS06e06K3a9AfaAYA1Mrj1Ce6ttkV/Z6/VIpHdWFOVb
	 RE8ZRHhoI5GT8bvE3ZyuCDItxrEK8ooi3qnmQr1p0SnR2SzhMIbr7TqTxrQX8QITti
	 /HQCuwxfiHOcWdksoGPI6nMLVsRh8Y8LXkoF9qHAsiiS+GPQq/XlrT7qQ7dwT8mg7T
	 dHLgDs3KQ/Z+Rl7TB0oJskZRQhuplP1y5xZr+xh4X6POxL/m7b74SS3dp4jUGeliau
	 GAaS2yxJH96rpsz+nVuQZJsWqWDie9HI0z50pjAPgiiMTBDRoFeE5zRy4yAcutqM4F
	 mXB/xaDD8rOAg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id CF775198005A;
	Wed, 28 Oct 2026 12:14:11 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Wed, 28 Oct 2026 12:14:11 -0400
X-ME-Sender: <xms:UR_iar2J6I9p2Ig3QvaWcsNcwnVB6gNqitW2_cUp8h0_YIuJJ5uGzg>
    <xme:UR_iak5Hje25aokA0qrV-XYpWJxNpK4-Ac47sZYXltw9zii6TjerO6O8V0yQqN69q
    7LR-g9-4646Y7Fz2Rx0dNoyz82HeQfkzb5F2IajuUF1BNH-uHnqIWO_>
X-ME-Proxy-Cause: dmFkZTGYb6kzeLfSbFhlwQe1a1zYe5/Mo+zrZNnKMGIQueQ1a7i4SRFPcAejSS2+Khllz0
    xAoR1Qnia36Ov+e5UBqH1FPnGs6xHJZU+D7viG3zqmLxO8RwmIEGn7x/YYIGUdcoRE+v5i
    3ZMJ41Y5OzQvRG5OMzvUv/h/TzDy4NKA6qOHtcUgsKK3ZR1rGlHfwRgO41EFTCw2xV6YFr
    Dr0bypCtmpxUh+GMuNfthe+Des+PnVRHA4M8Lb3Wt7cw7aqGewD/Xz8mKSZHqQ9od1k1B4
    yWGNOEeXLCcPAry7eMZmOyc2w4L8uH3eCvJ60b9Xbw7dix6QwzYHEqYBXa+DylEJzINeJb
    dKxN2RLCm0WOzERroc3Y4XVCb1L212yfgSGn+psQOXSLLNNe2yGg1d+zkQraPWCx10Clw9
    x/JdizrcTU2WGLgHCz15EB+M0bEBCkymtTSIGTvLne6uke7bOuYmtUO7Sok8Ct7rNVRaUP
    HQvoayfFWbXln8ISiGT6hF0PcR6w9RKgMOx/IWm6AxtgefLR5+lHzdZNbfaMp4V6S9wip+
    P8HSnqgk36yfhs7rVDrW0ufNSYyoFX8Zm4WF2ZLQgt3UKmssMTDgKOXymaCTWiDsri2JdQ
    NPJYITZq3XGM6OkXqDTKTmTfQ52MfTJQtGxW6AbohZ7aODkxXrO9Gb3M3Nnw
X-ME-Proxy: <xmx:Ux_iajBl35FxRc0NNVREa6rg_J7fcmXCV_oIJfizRMSzrhabBpF2Yw>
    <xmx:Ux_iagyDvoCEhlOZaVtMGScMw6hYf4cav2BpGxM7NHpsjWoX69_4Ag>
    <xmx:Ux_iapfbamI2AGk2KXXMbpUqzl2T4NkhabAS6cL9hCwU_WJeeK63hg>
    <xmx:Ux_ialuxZ2mATC45EJrRC_J5F2S63LgXVqIW5m-hYtGIaCroSeDhog>
    <xmx:Ux_iauCEgBI4aSOf_0NbqTfMiLFmK3Q__6DogFQRjbtyA4koUygkc-iH>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CD7ADF80090; Wed, 28 Oct 2026 12:14:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 17:13:49 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>
Cc: "Srinivas Kandagatla" <srini@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Dmitry Baryshkov" <lumag@kernel.org>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 "Abel Vesa" <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, "Linux ACPI" <linux-acpi@vger.kernel.org>
Message-Id: <4b41b061-1c0a-4c00-8263-2e14076c0864@app.fastmail.com>
In-Reply-To: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
Subject: Re: [RFC 00/12] RFC: Devicetree-ACPI hybrid mode
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Hans,

On Tue, 23 Jun 2026, at 16:52, Hans de Goede wrote:
> Hi All,
>
> Currently as soon as the kernel boots with a populated DT provided then
> the arch/arm64 code sets acpi_disabled=1 and the complete ACPI subsystem
> gets disabled. On WoA Snapdragon laptops where the factory Windows OS
> actually boots using these tables this is not necessarily desirable.
>
> It might still be interesting to at least parse the ACPI tables and make
> the ACPI fwnodes available for device-drivers to use. I call this DT-ACPI
> hybrid mode.
>
> This mainly is an experiment for now and possibly a method for accelerating
> the ongoing effort to run Linux on currently available Snapdragon laptops.
>
> On current laptops Linux cannot boot using ACPI due to some information
> missing from the ACPI tables. People are working on changing this so that
> for future WoA Snapdragon laptops Linux can boot using ACPI only without
> requiring Devicetree.
>

I was present at your LPC presentation.

I agree that exposing the firmware tables even when booting via DT
is reasonable - it is conceptually similar to SMBIOS tables, which
the arm64 kernel mostly ignores too (as opposed to x86, which relies
on it heavily for quirks from very early in the boot)

The examples you provided are straight-forward enough: I2C devices with
_STA methods that reflect whether the peripheral in question is present,
and all actual I2C transaction handling taken care of by the native I2C
host driver, which is exposed as an OpRegion.

I suspect, though, that things get hairy really quickly when things like
DMA, interrupts (both wired and MSI) and SMMUs enter the picture, and so
the extent to which ACPI device descriptions can be used on a DT boot is
rather limited.

Do you see any use for this hybrid mode beyond I2C input devices etc?

-- 
Ard.


