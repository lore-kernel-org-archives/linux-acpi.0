Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A43932F9
	for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458401; cv=none; b=PRORnpFAY1xQnkPB348z1iOvJyTNd5verUd8VBTZs1cT3BdCNVKDzRBLpkVzjRRGCRajmEsQ3YJqBavh0MitRwWa1nlPeQZpgFiP88LXr+Ta5dXn/65SSPCMWZFwj2R38YcmxrNUuyM9WXLWSecCJMvEHkhpgyyRWqRmMpUhFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458401; c=relaxed/simple;
	bh=IjyKE0XeSsR8wzLQnuETqkvshRjub0mrOrczEl0ADl0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:
	 References:Subject; b=MWxLEDvUk3xfEQCrtkUYPJQcfyZdkrpKc2mI69cwEOqEv87uYK+xvVACtnHrNEW2YhpFpBW6Os/BeMXQ56vRQdeeQlz6S1A9S6deJOA4HuXvbPX6eGtXpgR1eJltTyKoxNahOALgbzYji+KgEvL+UPwJTavIvRjUNUVkMeAyrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKXRE4pi; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKXRE4pi"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49551652105so357755e9.1
        for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784458398; x=1785063198; darn=vger.kernel.org;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjyKE0XeSsR8wzLQnuETqkvshRjub0mrOrczEl0ADl0=;
        b=UKXRE4pi8Ow+RgEfs2oQBpExwnIc5uZKK1Eqc9Xvn+CT3bzrvXtoiiBAJPmLeL8Xs2
         Fg6nUf2oNMAuKNdxt8a+kQv/tpEj9yGl+pUf8lbgiZ3pNyCYUfDZXk8OQfgn9qNFGDa5
         PIeO1NYb7AqdtJZkGrfNbHxJz2osaKalHDeG82ixUcckj4nFUpDqNoIB/4mzKHXZG1jm
         SAg/6IQ7Sfg31In86omqVkeLr1yh0erPbnQW/52G6af5c7UH8tDccgXf4+LJcjb+vvp7
         T/5wtY0CrTYTBHXgNELDI1pGHwdDf28bF6mVugX6E9iI/vbbSamlVh9KLFwCk/BYhLcc
         2wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458398; x=1785063198;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjyKE0XeSsR8wzLQnuETqkvshRjub0mrOrczEl0ADl0=;
        b=TbxswUKxDdrfm3DwRzqooWtyJBRX5rc6XTZD0eOZE/Ym/gx0tfDCIkhYy4O96gaWqA
         ZAULQH0lpTPCnDoOxqyP3FnOaLAFVB57RsDN1maVc+T1istLW8ZIk1T5OEDZE1tabx5O
         E8yUTBrh4AisVH8ITPK5mIKtmO5my3w1BaJjHeZm3J7txkcv1jpa/S2pCTICC2R1lOfE
         E1JFQe70kSrv3etELM1dVcvedHgrMGJNilc6/FtMwl2XX2rY8DjfjSi2pC/f39Tbl2P/
         P6+E+UVc4/SLONj5zxu3DyVZmKPA/JUhnufJYO2AFrG0fLMY2ylG03Ps9a+ZkA/a8Sv1
         x9nQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlZMj8wR7x/S3RXMO0m3A8eNpv5AldV2VHbZPSYgmN12RN19xVycl6UT0tesGVj50T53/28TtoQ/CJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxCoobiADmlfD6rO/vGhL+m8mEFeOup9gwIOKPyvq2x1BjAzz
	Wunc07zIsIc4uNRx8/PzgT9bnHTghTwsUbYVYI/vWut8w8J/UAl/LtR3
X-Gm-Gg: AfdE7cklyaWfE0heC6+lTYCw7cMo7PrUin4/d+3PNgxB7vP7lVgKfMBxKNeHattXs8C
	aIMUtmoRqO6sNa+aIXW7nQ5cM6qJF4TqMmoOjqoiLABnM6yYDTyVHkn4gCZovziGIWiaqcGR7Ug
	rwZQsiVl9mftRZinHsOjwuasdwoEsa9yInQAiM1hgb780PY+I+i5UHrN51PaLOWsqjVikjjtjAZ
	M9yVcSbmjNDBCF2ZC+6AoZqoc+0ZhV41nt2O7ctiwZLDWsFaYPkP9sGkJsUGmf0LNLJU/r+RqON
	wOevi1Ajc1UlH/IRkh+iwDJ6L22jP/73roWT451LfZtJbi2+PTxa8OZTUoVynmFBIBRDlrJUrOj
	RzQtJIKKT91zptj9ja/V8RhROHkN1pw2qFT5Q8dtpAL9uennEfFUm2maLmzSKWG5muidj/0kdJ2
	SABUQfJl6nVC2SKg==
X-Received: by 2002:a05:600c:3b9f:b0:495:59af:7a5e with SMTP id 5b1f17b1804b1-49559af7b6cmr14802985e9.5.1784458397580;
        Sun, 19 Jul 2026 03:53:17 -0700 (PDT)
Received: from [127.0.1.1] ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm141919705e9.1.2026.07.19.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:16 -0700 (PDT)
Message-ID: <6a5cac9c.b39440a8.65068.29e6@mx.google.com>
Date: Sun, 19 Jul 2026 03:53:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: =?utf-8?q?Metehan_G=C3=BCnen?= <metehangnen@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-gpio@vger.kernel.org
In-Reply-To: <2026071832-nutmeg-prototype-7f53@gregkh>
References: <2026071832-nutmeg-prototype-7f53@gregkh>
Subject: =?utf-8?q?Re=3A_=5BPATCH_2/4=5D_drivers/misc=3A_add_Goodix_GXFP5130_eSPI_fin?=
 =?utf-8?q?gerprint_sensor_driver?=

T24gU2F0LCBKdWwgMTgsIDIwMjYgYXQgMTE6MTI6MjhBTSArMDIwMCwgR3JlZyBLSCB3cm90ZToK
PiBUaGlzIGlzIG5vdCBob3cgeW91IHVzZSBkZWJ1Z2ZzLgo+Cj4gQWxzbywgdGhpcyBpbXBsZW1l
bnRzIGEgY3VzdG9tIHRyYWNlIGZ1bmN0aW9uLCBhZ2FpbiwgdXNlIHRoZSBidWlsdC1pbgo+IGtl
cm5lbCBmdW5jdGlvbnMgZm9yIHRoaXMuCgpVbmRlcnN0b29kIG9uIGJvdGggY291bnRzLiBUaGUg
SVNfRVJSX09SX05VTEwoKSBndWFyZCBhcm91bmQgdGhlCmRlYnVnZnNfY3JlYXRlX2RpcigpIHJl
dHVybiB2YWx1ZSBpcyB3cm9uZyDigJQgZGVidWdmcyBmdW5jdGlvbnMgaGFuZGxlIGEKTlVMTCBv
ciBlcnJvciBkaXIgc2lsZW50bHkgaW4gc3Vic2VxdWVudCBjYWxscywgc28gdGhlIGNoZWNrIGlz
CnVubmVjZXNzYXJ5LiBUaGUgZ3hmcF90cmFjZSBtb2R1bGUgd2lsbCBiZSByZW1vdmVkIGVudGly
ZWx5IGluIHYyIGFuZApyZXBsYWNlZCB3aXRoIGRldl9kYmcoKSB0aHJvdWdob3V0LgoKPiBUaGlz
IGltcGxpZXMgdGhhdCB0aGUgZHJpdmVyIGNhbWUgZnJvbSBhbiBleHRlcm5hbCBjb21wYW55IHRo
YXQgZG9lcwo+IG5vdCBoYXZlIG11Y2gga2VybmVsIGRldmVsb3BtZW50IGV4cGVyaWVuY2UsIG9y
IGEgTExNIHdyb3RlIHRoaXMuICBBcwo+IHRoZXJlIGlzIG5vIGNvcHlyaWdodCBpbmZvcm1hdGlv
biBvbiB0aGUgY29kZSwgd2hpY2ggaXMgaXQ/CgpUaGUgb3JpZ2luYWwgY29kZSB3YXMgd3JpdHRl
biBieSBWb2lkNzU1IChnaXRodWIuY29tL1ZvaWQ3NTUpIGZvcgpvdXQtb2YtdHJlZSB1c2UgdW5k
ZXIgR1BMLTIuMCBvbiBoYXJkd2FyZSBub3Qgc3VwcG9ydGVkIGJ5IGFueSBleGlzdGluZwpkcml2
ZXIuIEkgcG9ydGVkIGl0IHRvIG1haW5saW5lIGtlcm5lbCBzdHlsZSB3aXRoIGFzc2lzdGFuY2Ug
ZnJvbSBhbiBBSQp0b29sLCB3aGljaCBpcyByZXNwb25zaWJsZSBmb3IgdGhlIGRlYnVnZnMgbWlz
dXNlLCB0aGUgY3VzdG9tIHRyYWNlCnN5c3RlbSwgYW5kIHRoZSBvdGhlciBzdHlsZSBpc3N1ZXMg
eW91IGZvdW5kIOKAlCBpdCBhcHBsaWVkIHBhdHRlcm5zIHRoYXQKY29tcGlsZSBidXQgZG8gbm90
IGZvbGxvdyBrZXJuZWwgY29udmVudGlvbnMuIEkgc2hvdWxkIGhhdmUgY2F1Z2h0IHRoZXNlCmJl
Zm9yZSBzZW5kaW5nLgoKdjIgd2lsbCBjYXJyeSBwcm9wZXIgY29weXJpZ2h0IGhlYWRlcnM6Cgog
IENvcHlyaWdodCAoQykgMjAyNCBWb2lkNzU1IDxnaXRodWIuY29tL1ZvaWQ3NTU+CiAgQ29weXJp
Z2h0IChDKSAyMDI2IE1ldGVoYW4gR8O8bmVuIDxtZXRlaGFuZ25lbkBnbWFpbC5jb20+Cgo+IFRo
YXQncyBhbiBhYnVzZSBvZiBSRUFEX09OQ0UoKSA6KAoKQWdyZWVkIOKAlCBSRUFEX09OQ0UoKSBp
cyBmb3IgbG9ja2xlc3MgY29uY3VycmVudCBhY2Nlc3MgcGF0aHMsIG5vdCBhCnBsYWluIGluaXQg
ZmxhZy4gV2lsbCBiZSByZXBsYWNlZCB3aXRoIGEgcmVndWxhciBib29sZWFuIGNoZWNrIGluIHYy
LgoKVGhhbmtzLApNZXRlaGFuIEfDvG5lbg==

