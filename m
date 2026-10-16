Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A45349CA
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171582; cv=none; b=oE/cuqfisMEw3Z2gFCGsMlC8/m44pTOTpmZzzw76Xi098D3HFz8W+xFaA78X9M/LeivdUYV+yOl5U8ply00Ae3Xi4ZHf7UAVRA2yVfycPO9KpdalgWbTsaOOJ2icdXU16mmfjyJ9aL42MjunNk9GJTbO9v8ghYkqupmnkU0ImGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171582; c=relaxed/simple;
	bh=M4ytFOlsuAxsi/XkpYodCf/7zbjSI9R56ThsIDKe7B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiQN1wxkokD7KRXXf0IyWeDihy+fUJdNYimb7efpztt8PPQO3/HV6K07Qqn/EyUdQrP+mX7BUHLmh2sH1nvjkeDazrIjV89q78yn+/N4dxYGjb/LS3StGTyfhx+cP85F/T6HGJ3FYx4Kqe3s8VCqS+W3ZszjwXdokyg+wiAYqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT9r1tyk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT9r1tyk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e812e2b31bso359125ad.3
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171580; x=1792776380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M0sMKvoCBddf3NULdihue/8J2Gg5vlScxeExo0WVuVY=;
        b=YT9r1tykwfy+qmrBSU91HMTTkCjnU8RjsmfQNLfQ3XzLTlze4lqW156PQbDydcvjJb
         jfAQZ8gjslI2PqFe2tGlwkqANkTSz04sCQ8k7n+Sb1FuYK3FQ/RliVmeitvEC0ouOt8q
         dmkKyx+3sd6wDB4jIBlv0FVF9plW7wk2iM3xrAgZ4o4uueqPkY1LotcrxSY+Mw/xV4X0
         z0xChxpPXmheaZAGkyDGNjkpwFZ97mahfyfLyb2oLaomBe8dD3JRmmwHmftvZI6ITzeX
         BD+IxG8LrqWR9y6HRedL8VtKBynpKXhTz1dIHJbBbnbDA8lrac6jxn0sUbp6LAbc7F/w
         uRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171580; x=1792776380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M0sMKvoCBddf3NULdihue/8J2Gg5vlScxeExo0WVuVY=;
        b=OYjmLygihOCHGuk1UM87gtyQtFctLs3yZIePhVxRwrskrnoeTkgTdahaeBU1lCNT4N
         QAUUZE4SCyEA/jyPI4sMA22+4jbZb2cbFtGSPlWAXRAZly7tTdSlmymS/deG3zrRZ2hU
         JSRKOKnISn85ubwobWlSlURJMcvBVxtOtJpwQ2JMo15UL1o4j4xan35qQFwEeT9ubRr+
         m5a0loNS67u6ifekMqwDm01zSwTzKyxXiPMAd/JL4m5O3vs3REyrcvHHUGM7sTTHA0SM
         wFVyqC/oShOAc+zHDCEvq2qMCynWCl2iZHoWSbDpCSrMMzec8NVs5VPNn+C7J0aYLHfl
         VMEg==
X-Forwarded-Encrypted: i=1; AKwUvBwcUBeQwoAJSoq2QQnS7UZ+QdLECrqKTFQ0kE/th3mkxnoFbHzU7CwZpJ+ELJ77WzT8Q+LFrtBCvRF+@vger.kernel.org
X-Gm-Message-State: AFq9FYLQyRLgwyRgYZ5qAZ2h5ai3Z5hcVXiQhYe6/8bKGIX3ftgw3R3f
	ytc0o7Il6QDYgHOKeBWilWiwSSLMxNcC1HvaR8cHM+X+b+/ily6Nf8hS
X-Gm-Gg: AYBFou1hHBy/K/zcSjqbH5t4cI6z7UQcsU3GnUSMXw9vgEbmqy/NQr6MlcWi7JfUD2l
	Q56I4Aaqk28eAOU4yPxJr+Vvhhek0mxGzsdkbvox7tnJ1Vm8Zfjatp7yrOguK4VpNJSRnCbQ713
	KJxMQcx1r6CftMSUQ+1+Hl8KX9mXaEa6D7kBfkFacIMAB00MxIMWMvBht83osSYftXK5G1rtKxt
	jpq7mdEGLsLO68egPoedNY4Yac4Rc0fn4rBuI9ANcSMhfsDfW4g42SnCacqwf6EWGgh27JosIso
	BMbbmYWIG2CLdF3Yvl4DErovCOBEqewl8s7dymrHb+GHYE5o68hQiI+RfrbOM9qvWtxYUXX+BEB
	3JieIHTojh0j6QV/q3Sd/5cm2mJCZbQICFmqacKMA/9Sdhf2EwpeU25jwniEUDseJWFOl/kq+US
	aBKgABoU9dkJc9xwAUCgHlLNC88KrAohJsbet1aEF/gjpn0BkoCmaqFQMC915eQhrbF4eTs8Mw2
	O5eHPIduU9MOHdyxmSpu0xsSWovsZmnUtCT2EPu2i9INw/YyU8MlNslljVPgMeBVHKX
X-Received: by 2002:a17:903:2f86:b0:2e9:460e:ca49 with SMTP id d9443c01a7336-2e9a68da459mr5690005ad.18.1792171580463;
        Fri, 16 Oct 2026 10:26:20 -0700 (PDT)
Received: from archlinux ([2405:201:1b:20ef:268a:fa82:9f05:61a5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d5558sm13901345ad.7.2026.10.16.10.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:26:20 -0700 (PDT)
Date: Fri, 16 Oct 2026 22:56:14 +0530
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: Lorenzo Collevecchio <lorenzocollevecchio17@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, W_Armin@gmx.de
Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP OmniBook
 5 16-ag1xxx (board 8DF4)
Message-ID: <atJc2J2hYrdI_Eun@archlinux>
References: <CAPvUaSo1D+1Tvk3-4TMiXw-ScBtY8Mu0FzO7R_EG6zrjYfjYqg@mail.gmail.com>
 <asxTYBiGy6lf6-Ki@archlinux>
 <CAPvUaSo-ubCOCYYPadY1C23y1Fd_AAhQLuVKWRa6F1XVh6mk_Q@mail.gmail.com>
 <asz7WqGzukhkYHGD@archlinux>
 <CAPvUaSrbWrBuvAi3R02xC8w8M5Yh97pVd3-+FBXLp3mPgG5cUQ@mail.gmail.com>
 <as0bOFOoaaw-smyB@archlinux>
 <CAPvUaSoBgAG=MX93vMhfEiEk5bYXGydFsGn8CpoCu_QVQRPTCQ@mail.gmail.com>
 <CAPvUaSpPVYc-5M72G0Hf9JPsbdAp2-4f-p5OetYbMKdLqm0PXQ@mail.gmail.com>
 <atEh9Gon95EFIq76@archlinux>
 <CAPvUaSpq2d5hkxTaqAL6rBoeHct68Y37C4nSpV+goGZ-QwrCsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPvUaSpq2d5hkxTaqAL6rBoeHct68Y37C4nSpV+goGZ-QwrCsw@mail.gmail.com>

On Fri, Oct 16, 2026 at 09:06:03AM +0200, Lorenzo Collevecchio wrote:
>Subject: Re: hp-wmi: WHCM AE_AML_OPERAND_TYPE and fan init -22 on HP
>OmniBook 5 16-ag1xxx (board 8DF4)
>
>Hi Krishna,
>
>Thanks a lot for digging into the ACPI code, the explanation makes
>everything fit: the missing GMCF call for HPWMI_GM, Local2 being left
>as an Integer, and the -22 coming from that.
>
>I also tried your suggestion about the platform profile. With
>HPWMI_READ/WRITE the errors should not appear:
>
>  Before: dmesg | grep -c WHCM  ->  3 (the three boot-time errors)
>  cat /sys/firmware/acpi/platform_profile  ->  quiet
>  After:  dmesg | grep -c WHCM  ->  3 (no new errors)
>
>On the fan: thanks for confirming that acpi_fan reads the EC value
>correctly. Together with hearing the fan on Mint and on CachyOS at
>idle, that makes me fairly comfortable that the 0 RPM readings are the
>fan really being off.
>
>Your plan to query the fan count and hide pwm1_enable and
>fan{1,2}_input when it fails sounds good to me. I am happy to test it
>on 8DF4 whenever you have a patch, and I can rebase it onto a stable
>kernel tree on my side if that is easier for you.
>
>I also tried 7.2.10-1-cachyos: dmesg and the hp-wmi hwmon folder are
>identical to 7.2.9 (three WHCM errors, then the -22 message, and
>pwm1_enable still present).
>
>Thanks again for the time you spent on this.

Thanks, I will share the final proposed patch on your Bugzilla report
(222138), and leave this thread for others to pick up the WQBC/WQBE
errors.

>Best regards,
>Lorenzo
>
[...]
