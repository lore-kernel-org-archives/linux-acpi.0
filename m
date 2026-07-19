Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4633391517
	for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458397; cv=none; b=P+4YrQBNi2UcT25sxaAPa+HBqTIuiJ9q2hOsa01oXk/tC95rGDPvT0CO557ZqWVh/Lz9ApkFcb7E6a2ahn0W4WMdEbQSARky9rGG/DUxtjSG9kGWycqc5bQV2t9fXY0FNPQfLWvPnrQhugKFnJVHpQag95L2JFaWkByQ0frlr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458397; c=relaxed/simple;
	bh=MTmnte4S6UYOUnm3zY8MP0s6uJEXNbI1TcU1jv9yttM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:
	 References:Subject; b=XofNxKkl9kWi27+rKikJseJk0XjcnBk//lBt4n8IYzY2qKzfdkJ2ePAZreECbecWlc964xuC4CAYyBd+o0hAyQ98uN4tAvjTjF3T7jfW5PaX8fRRhSwbCO6SxYwF3EEWoxBLGUTWT8U6W4o5GhTx/kqbxK8ljgVky31ssJiab80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlikNVQL; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlikNVQL"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f668ca741so63238f8f.1
        for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784458394; x=1785063194; darn=vger.kernel.org;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MTmnte4S6UYOUnm3zY8MP0s6uJEXNbI1TcU1jv9yttM=;
        b=RlikNVQL/WTftt1jHSjO35k+aEWhT5vm2nvKB80YtYywW7fFQqqE2JtBfFtHWUwTuT
         dwtagjzrEt+E0EsvYiV4ryCUrLRMCIIKzWIwutdX52vIfwp2Oc0/hVBpR5tNWCKKAGpE
         9KZMeUy+QnXKry5zkV8A12jdRm9X5mNHGhVN++t88KFE6BhdeQu3geDqZc+l1GKUnBPI
         8i3x53l39qi5NXmHr7gnNMQPFX/Tqv5BmR/KPli9bUoQOUGWMErMujTXyDfIxsio3/gp
         m0IVPm4zu8TLSh9hzthIe662ZDdNag8W93gU9o4+W1n2ExAjZWGZxtij5C1YsnARoJok
         OdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458394; x=1785063194;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTmnte4S6UYOUnm3zY8MP0s6uJEXNbI1TcU1jv9yttM=;
        b=b2rj/c8SII8ZfD/XgseOEnJaBc/eu5ph1ufU70vfDTUxXAw4gbqbniWZ9AjqS9J5cj
         XDlU3qj0bIPOzuZloPdwxGLoGrIs/vEZoFrkar8dD9PRzKODpBaRFzzHJqNdwQNMFkx/
         Zb1fzPeDIguGk9+yx7K3IFQoy8QxDLBAkrRNphKABpyPEmSx8375SXBcwdlc7No60oGS
         hRLYFthPqXYd0RMFpPNlX8Iz3mwAjrooNyM4Sgnm/z8Cotdxzkvh/VPG4VC+RU7VnCad
         uA1H3h1FCuujp3YSU/Jptuensk0OU93SXE5dhM8/OvGk2Bf/iPtMbg/30WDl+yrm7JcA
         xMFg==
X-Forwarded-Encrypted: i=1; AHgh+RoPI0nO8lM//14UCIDSbm7S8xFzLP74oxXwZDkuPb8uxVYr5+En6s1dOsnCSLeouE1r9F4EYyP3Wo8k@vger.kernel.org
X-Gm-Message-State: AOJu0YxKj71q0q3VTgtrcx1XqKQ8r0IwEuWBR3OrG415IHAiNHFgiAdI
	sBo/6Hvih6NH2GR2cgKYN3V+6ZG5slkH1lbak0RpjHaKu2YgiqJYjAcHLo0zu4XQ
X-Gm-Gg: AfdE7cnCk87X2Wec1bU//T5U6jcvip77GeUwXehrih7rwLyNnrf6Ee5Q4Da8C0Uhnr0
	aS5Ruhu261wI+p74cLcDQmMqVGkdXNkMKjVyD4vgjP2eDDMvIfVxePtTtmqlYRaU40P7seOE3aC
	8qsmclWe4h9XSiFLiDxDUigSnmuf44ng+U/iTzSlRlBcSowjnJLyxerfaTK+e1yFTXFCoFU20Qh
	j+w/KJKr4NkNuwMVEmTHPlAyMA2YHSU12eO7bgSjjHbr2CHYyr8WMvvZcsI8J9lJ520z1wPoWVI
	C8cuRIfPI3rpNec4EmuWhoh/Du4rV1Xazrknsr/YGSV39Vg5OnkQJsEr/Rz+Ea74Z1ldO0DUB7V
	rdRTrR1b9+pDaldvDFcxTSGeeBoMlBucyOHF5zh5SDXii/Ukp2sg/9uIAXFGS0cQQv0WWs/2zw3
	hv67U=
X-Received: by 2002:a05:600c:e548:20b0:490:ec79:3046 with SMTP id 5b1f17b1804b1-4954a38c438mr40676245e9.0.1784458393740;
        Sun, 19 Jul 2026 03:53:13 -0700 (PDT)
Received: from [127.0.1.1] ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm141919705e9.1.2026.07.19.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:13 -0700 (PDT)
Message-ID: <6a5cac99.b39440a8.65068.2901@mx.google.com>
Date: Sun, 19 Jul 2026 03:53:13 -0700 (PDT)
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
In-Reply-To: <2026071855-booted-filth-ff9a@gregkh>
References: <2026071855-booted-filth-ff9a@gregkh>
Subject: =?utf-8?q?Re=3A_=5BPATCH_1/4=5D_include/uapi/linux=3A_add_gxfp=5Fioctl=2Eh_f?=
 =?utf-8?q?or_GXFP5130_fingerprint_sensor?=

T24gU2F0LCBKdWwgMTgsIDIwMjYgYXQgMTE6MDg6MDZBTSArMDIwMCwgR3JlZyBLSCB3cm90ZToK
PiBXaHkgZG8geW91IGdldCB0byB1c2UgIkciIGhlcmU/CgpJIGRvbid0LiBJIGNoZWNrZWQgRG9j
dW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2lvY3RsL2lvY3RsLW51bWJlci5yc3QKYW5kICdHJyBp
cyBhbHJlYWR5IGFsbG9jYXRlZCB0byBtdWx0aXBsZSBzdWJzeXN0ZW1zLiBJIHdpbGwgcGljayBh
IGZyZWUKbWFnaWMgbnVtYmVyIGZyb20gdGhlIHVuYWxsb2NhdGVkIHJhbmdlcyBhbmQgcmVnaXN0
ZXIgaXQgaW4gdGhhdCBmaWxlCmluIHYyLgoKVGhhbmtzLApNZXRlaGFuIEfDvG5lbg==

