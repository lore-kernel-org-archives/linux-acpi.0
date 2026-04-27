Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DE34EEE3
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306463; cv=none; b=rz1ytwxR3QjqKpyIi347Qo34dX71ClZgeJFqDgxq/o/GOlOsdfBfGUgeXdJUTLISIZN7ejUx6nje1ZFZliy+dQjnFB0H6+81/idElcf9ag+07vsXuFc8IkDa75rDb7NoLDtsstH/AxAJeXXd1njqEqqXnP9wCWXffHbyNYJ86go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306463; c=relaxed/simple;
	bh=RQcrs3Ob1JeDCKvQ+r894JfOiaXS39WsIytF/75J718=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fE6u7nw0fq42ZxqkLbBFUpUIXrySC8fNELH5Yt+0IYvKfMWko049QuRlOORO4/SmIXJ8hkU+NOjZu4ikYbbN0AOSDZrTnNk24PoTUn2J01rYOIHhKrp2NE4Fi9TDbe3qf3GvB0JtUHJniuRg1hIHxZRzvCyzD1EHYsLH5oKVh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUG1b/qL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUG1b/qL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so55544845e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777306461; x=1777911261; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RQcrs3Ob1JeDCKvQ+r894JfOiaXS39WsIytF/75J718=;
        b=EUG1b/qLgKeSt7M8CWnIGg3f/W04s6JHdL8BJTUKbNvv62+JNSa5x9S+w25kQN5B8W
         roFafQKz5+wNoE2jHxw6nBF2zeWCx7426lHP8jcA859dAesIA/O0x3LcO9+3okOQgsGq
         7otK0UAY6ovsblhHpoy1S0hPwj2T0ErHh9Zn5h4G79fZBvx9GJZNXPQAS7oRl+zBAcj5
         Yopisx8ktJiCMZuYLZl4wpII/h0zvXERLow8CnLKJrG/CGHt4ZjQpotQhz7ll4xv/4H2
         DHxtaxEHRe8HqAy/DufRzLDl6iukjYTQiFqFj5QjBvfRWoBgIhLNEjoQyM5o+3yPL6Sc
         MWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306461; x=1777911261;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQcrs3Ob1JeDCKvQ+r894JfOiaXS39WsIytF/75J718=;
        b=bHPmqAaTFNRpSOj4hhz/nxaHYBRkGm/CHDju31p7aQmTsUvDDlzl3SenaIoFRFCKHz
         XT/rCYPiuPUoUEInk6resju/T1UTLXUOeDBGXhPcvrJ24ATnoovqKRunHSwJKguEPfqj
         tGS1rrKfRTCepL9vNmjfVmTlikLh03MFHPcm/8B6CAGpXb+N1llNxIZTmuWInpHpkxL6
         7s0HwEGNY5YrzoQc/eP+NQ3VX2IpJRjUnXURtMYtJJUylERMvAwvDvI83jydxFObQJqc
         D+OK8asyRtPkOjXi209uEaBiTBgFnRfXFZzYmj7qXQNftl27Ed2D2xSqyB0Qi1j5YydZ
         wU3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/xfgMFoBeu7buKMDEEm65zcvJaZNyJhv+5bIFWIfySQOff3PmDPEIszfq/yN7RExyHqmW27hshI5Yo@vger.kernel.org
X-Gm-Message-State: AOJu0YyEP25nQWwm2YKKPGDQLziOnIGXdwtIAJE7Vd82BiAUGlffO3h6
	8kVlWnsgZVDL/CgYvTsO0iZFWkpwq+QO8VYmpFEzQyG//fnOhDa1slX5
X-Gm-Gg: AeBDiesTfNm8oQ+RNsqfGK2zxoss0rhks41kqfLS6aOYFHMFtDcjYjL9XtcefR3Fe/F
	I0GyYEehRbro+tUAn1acpX8DDLJXHBvZLUWmeXPt8ETlvA8oabLnRwen8Dvy8yFhRweq5vQZR86
	hyjaVjsyjY0ecgOF/4jOGicxehLJirqB7Ae8fYkvVOFby5YUlWXicFeXzYNyxFRCKHbDOYX2MwP
	wV86nt56BuebMqlXsNLcjfj32SDTdFFs5AUm0vzOWsDPA6/KpCBaN3fYphkgh03sxW3sFjreftI
	AaSR2r8m8xSyDETbrZwqrGNZN+f4G0MF+aqdanW6s6pXvXT10aIcG0gS6W9JHkRC8KEyNuOHbKd
	rKE6IoMdfUebXexjqj+HWn88b6ZcDdNJRUfJwfPiNPubS624/g7GjRbGDhWVAe5hj4mC2vDSb92
	WKI8xn/y0hGH5K2djYc9i7ekeEyEbGrg/yuzzCNlRvnHjVBm/ZyPA5jojSdnnZzYmaRsn4BoV0Z
	/5xS5Q=
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id 5b1f17b1804b1-48a5821692dmr328351515e9.4.1777306460610;
        Mon, 27 Apr 2026 09:14:20 -0700 (PDT)
Received: from ?IPV6:2a01:e11:202b:40:2329:3f37:4392:9142? ([2a01:e11:202b:40:2329:3f37:4392:9142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc5e3f4sm458413265e9.2.2026.04.27.09.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 09:14:19 -0700 (PDT)
Message-ID: <b6e7fd4c-8211-44e0-92f3-0279586e7214@gmail.com>
Date: Mon, 27 Apr 2026 18:14:19 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
From: Marco Scardovi <mscardovi95@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Francesco Lauritano <francesco.lauritano1@protonmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "westeri@kernel.org" <westeri@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
References: <b57b44c3-ea96-4189-8b70-71bf4a80d29b@kernel.org>
 <20251218103831.GW2275908@black.igk.intel.com>
 <51f999d7-2064-47dc-8d9b-e262588bfbdb@gmail.com>
 <20260422090709.GB557136@black.igk.intel.com>
 <4e55e31e-a5e8-4098-8a7f-bb52476b882a@gmail.com>
 <20260422095558.GC557136@black.igk.intel.com>
 <5a36760d-5d1e-4eee-9006-3fed042aa2cd@gmail.com>
 <20260423044211.GD557136@black.igk.intel.com>
 <3d562963-9581-4e0f-b9a0-5f0fe28d2495@kernel.org>
 <c55b55ea-a8d5-481e-916f-eb92aeb2e06d@kernel.org>
 <20260427122806.GN557136@black.igk.intel.com>
 <edac84e9-93c0-4248-b28f-c121583b9f65@gmail.com>
 <f8efd77f-6c49-4ec1-9d16-a855c2577908@kernel.org>
 <9959ecd7-6af1-432d-836f-5444491ce689@gmail.com>
Content-Language: en-US
Autocrypt: addr=mscardovi95@gmail.com; keydata=
 xjMEae9cbxYJKwYBBAHaRw8BAQdA87PkpEc/V9AjPUZtgCt1HozYZOv2i7DmtWO9bufzcXbN
 Jk1hcmNvIFNjYXJkb3ZpIDxtc2NhcmRvdmk5NUBnbWFpbC5jb20+wokEExYIADEWIQRyXlTt
 5wtfOVmei6r6GFPSqT1V1AUCae9cbwIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEPoYU9KpPVXU
 bIEA/jcKrvvxQhFrLMIj5P2MOG1zMmjNViG8i1HKfockEPmoAP45CR30ML0PkQQglMR2Wpxl
 n9WUeA151rzqTrGbkZxeCs44BGnvXG8SCisGAQQBl1UBBQEBB0Ao3nuNtHI9dr8Lg4xpvFE3
 dIX9HNaBa/2zz5suxiV+MgMBCAfCeAQYFggAIBYhBHJeVO3nC185WZ6LqvoYU9KpPVXUBQJp
 71xvAhsMAAoJEPoYU9KpPVXUUmAA/jfx6umko6uNFGpFcDX5wrxh/eTL7x+4YORx9Z+bwti7
 AQCiGVnEL8Hd3zRVp0u5UaQs5CfD22sPYLGpkJEuCDo0Cg==
In-Reply-To: <9959ecd7-6af1-432d-836f-5444491ce689@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fv9iS0ASDbnFmVXkvQFcixWH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fv9iS0ASDbnFmVXkvQFcixWH
Content-Type: multipart/mixed; boundary="------------0UYgUZaB0kk551e7CoAtlDAF";
 protected-headers="v1"; hp="clear"
Message-ID: <b6e7fd4c-8211-44e0-92f3-0279586e7214@gmail.com>
Date: Mon, 27 Apr 2026 18:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
From: Marco Scardovi <mscardovi95@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Francesco Lauritano <francesco.lauritano1@protonmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "westeri@kernel.org" <westeri@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
References: <b57b44c3-ea96-4189-8b70-71bf4a80d29b@kernel.org>
 <20251218103831.GW2275908@black.igk.intel.com>
 <51f999d7-2064-47dc-8d9b-e262588bfbdb@gmail.com>
 <20260422090709.GB557136@black.igk.intel.com>
 <4e55e31e-a5e8-4098-8a7f-bb52476b882a@gmail.com>
 <20260422095558.GC557136@black.igk.intel.com>
 <5a36760d-5d1e-4eee-9006-3fed042aa2cd@gmail.com>
 <20260423044211.GD557136@black.igk.intel.com>
 <3d562963-9581-4e0f-b9a0-5f0fe28d2495@kernel.org>
 <c55b55ea-a8d5-481e-916f-eb92aeb2e06d@kernel.org>
 <20260427122806.GN557136@black.igk.intel.com>
 <edac84e9-93c0-4248-b28f-c121583b9f65@gmail.com>
 <f8efd77f-6c49-4ec1-9d16-a855c2577908@kernel.org>
 <9959ecd7-6af1-432d-836f-5444491ce689@gmail.com>
Content-Language: en-US
Autocrypt: addr=mscardovi95@gmail.com; keydata=
 xjMEae9cbxYJKwYBBAHaRw8BAQdA87PkpEc/V9AjPUZtgCt1HozYZOv2i7DmtWO9bufzcXbN
 Jk1hcmNvIFNjYXJkb3ZpIDxtc2NhcmRvdmk5NUBnbWFpbC5jb20+wokEExYIADEWIQRyXlTt
 5wtfOVmei6r6GFPSqT1V1AUCae9cbwIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEPoYU9KpPVXU
 bIEA/jcKrvvxQhFrLMIj5P2MOG1zMmjNViG8i1HKfockEPmoAP45CR30ML0PkQQglMR2Wpxl
 n9WUeA151rzqTrGbkZxeCs44BGnvXG8SCisGAQQBl1UBBQEBB0Ao3nuNtHI9dr8Lg4xpvFE3
 dIX9HNaBa/2zz5suxiV+MgMBCAfCeAQYFggAIBYhBHJeVO3nC185WZ6LqvoYU9KpPVXUBQJp
 71xvAhsMAAoJEPoYU9KpPVXUUmAA/jfx6umko6uNFGpFcDX5wrxh/eTL7x+4YORx9Z+bwti7
 AQCiGVnEL8Hd3zRVp0u5UaQs5CfD22sPYLGpkJEuCDo0Cg==
In-Reply-To: <9959ecd7-6af1-432d-836f-5444491ce689@gmail.com>

--------------0UYgUZaB0kk551e7CoAtlDAF
Content-Type: multipart/mixed; boundary="------------wJf9zehBaG5WXLELX0ygLmlL"

--------------wJf9zehBaG5WXLELX0ygLmlL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpJbCAyNy8wNC8yNiAxODoxMCwgTWFyY28gU2NhcmRvdmkgaGEgc2NyaXR0bzoNCj4NCj4g
SWwgMjcvMDQvMjYgMTc6MzAsIEhhbnMgZGUgR29lZGUgaGEgc2NyaXR0bzoNCj4+IEhpLA0K
Pj4NCj4+IE9uIDI3LUFwci0yNiAxNDo0MSwgTWFyY28gU2NhcmRvdmkgd3JvdGU6DQo+Pj4g
SWwgMjcvMDQvMjYgMTQ6MjgsIE1pa2EgV2VzdGVyYmVyZyBoYSBzY3JpdHRvOg0KPj4+PiBP
biBNb24sIEFwciAyNywgMjAyNiBhdCAwMTo0NjowM1BNICswMjAwLCBIYW5zIGRlIEdvZWRl
IHdyb3RlOg0KPj4+Pj4gSGksDQo+Pj4+Pg0KPj4+Pj4gT24gMjMtQXByLTI2IDA3OjE1LCBN
YXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4+Pj4+PiBPbiA0LzIyLzI2IDIzOjQyLCBNaWth
IFdlc3RlcmJlcmcgd3JvdGU6DQo+Pj4+Pj4+IEhpLA0KPj4+Pj4+Pg0KPj4+Pj4+PiBPbiBX
ZWQsIEFwciAyMiwgMjAyNiBhdCAwMjowODoyOVBNICswMjAwLCBNYXJjbyBTY2FyZG92aSB3
cm90ZToNCj4+Pj4+Pj4+Pj4gQXNzdW1pbmcgYWxsIHRoZSB2YXJpYW50cyBzdWZmZXIgdGhl
IHNhbWUgcHJvYmxlbSB3b3VsZCBpdCBiZSANCj4+Pj4+Pj4+Pj4gb2sgdG8gdXNlIGENCj4+
Pj4+Pj4+Pj4gd2lsZGNhcmQgZm9yIGl0Pw0KPj4+Pj4+Pj4+IFllYWgsIHdlIGNvdWxkIGV4
cGFuZCBpdCB0byBhbGwgIlJPRyBTdHJpeCBHMTYiIEkgdGhpbms6DQo+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW9saWItYWNwaS1xdWlya3Mu
YyANCj4+Pj4+Pj4+PiBiL2RyaXZlcnMvZ3Bpby9ncGlvbGliLWFjcGktcXVpcmtzLmMNCj4+
Pj4+Pj4+PiBpbmRleCBhMDExNmYwMDQ5NzUuLmUzYTYxMTE4NTRlOCAxMDA2NDQNCj4+Pj4+
Pj4+PiAtLS0gYS9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1hY3BpLXF1aXJrcy5jDQo+Pj4+Pj4+
Pj4gKysrIGIvZHJpdmVycy9ncGlvL2dwaW9saWItYWNwaS1xdWlya3MuYw0KPj4+Pj4+Pj4+
IEBAIC0zOTIsNiArMzkyLDIzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9p
ZCANCj4+Pj4+Pj4+PiBncGlvbGliX2FjcGlfcXVpcmtzW10gX19pbml0Y29uc3QgPSB7DQo+
Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmlnbm9yZV93YWtl
ID0gIlZFTl8wNDg4OjAwQDM1NSIsDQo+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0sDQo+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9LA0KPj4+Pj4+Pj4+ICvCoMKg
wqAgew0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAvKg0KPj4+Pj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgICogVGhlIEFTVVMgUk9HIFN0cml4IEcxNiAoMjAyNSkgQUNQSSBHUElPIGNv
bmZpZ3VyYXRpb24NCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGNhdXNlcyBhY3Bp
X2dwaW9faGFuZGxlX2RlZmVycmVkX3JlcXVlc3RfaXJxcygpIHRvDQo+Pj4+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKiBzdGFsbCBmb3IgfjM2IHNlY29uZHMgZHVyaW5nIGJvb3Qgc28g
aWdub3JlIHRoZSB0d28NCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGludGVycnVw
dHMgaW52b2x2ZWQuDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKg0KPj4+Pj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgICogRm91bmQgaW4gQklPUyBHNjE0UFAuMzA3Lg0KPj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5t
YXRjaGVzID0gew0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERNSV9NQVRD
SChETUlfU1lTX1ZFTkRPUiwgIkFTVVNUZUsgQ09NUFVURVIgSU5DLiIpLA0KPj4+Pj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAi
Uk9HIFN0cml4IEcxNiIpLA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9LA0KPj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCAuZHJpdmVyX2RhdGEgPSAmKHN0cnVjdCBhY3BpX2dwaW9s
aWJfZG1pX3F1aXJrKSB7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmln
bm9yZV9pbnRlcnJ1cHQgPSAiQU1ESTAwMzA6MDBAMjEsQU1ESTAwMzA6MDBAMjQiLA0KPj4+
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9LA0KPj4+Pj4+Pj4+ICvCoMKgwqAgfSwNCj4+Pj4+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIHt9IC8qIFRlcm1pbmF0aW5nIGVudHJ5ICovDQo+Pj4+
Pj4+Pj4gwqDCoMKgwqAgfTsNCj4+Pj4+Pj4+IEFzIGZvciBub3cgaXQgc2VlbXMgd29ya2lu
Zy4gSSd2ZSByZXZlcnRlZCBpdCBvbiBteSBrZXJuZWwgYXMgSSANCj4+Pj4+Pj4+IHByZWZl
cg0KPj4+Pj4+Pj4gcmVtYWluIGFzIG11Y2ggYXMgcG9zc2libGUgY2xvc2UgdG8gdGhlIENh
Y2h5T1MnIG9uZSBidXQgDQo+Pj4+Pj4+PiBob3BlZnVsbHkgaXQgd2lsbA0KPj4+Pj4+Pj4g
YmUgaW1wbGVtZW50ZWQgb24gNy4xLCBpZiBzb21lb25lIHByb3Bvc2UgdGhlIHBhdGNoIGFu
ZCBpdCBpcyANCj4+Pj4+Pj4+IGFjY2VwdGVkLiBJdA0KPj4+Pj4+Pj4gd291bGQgYmUgYW1h
emluZyB0byBzZWUgQXN1cyBtb3JlIGludGVyZXN0ZWQgb24gTGludXggYW5kIG1vcmUgDQo+
Pj4+Pj4+PiBzdHJpY3Qgd2l0aA0KPj4+Pj4+Pj4gdGhlaXIgQklPUyBidXQgaW4gdGhlIGVu
ZCBJIHVuZGVyc3RhbmQgaXQncyBsaWtlIGFza2luZyBmb3IgdGhlIA0KPj4+Pj4+Pj4gbW9v
bi4NCj4+Pj4+Pj4gT2theSB0aGFua3MgZm9yIGNoZWNraW5nLiBJIGd1ZXNzIHRoaXMgaXMg
d2hhdCB3ZSBoYXZlIHRvIGxpdmUgDQo+Pj4+Pj4+IHdpdGggZm9yIG5vdw0KPj4+Pj4+PiB1
bnRpbCBzb21lb25lIGZpbmRzIGEgYmV0dGVyIHdheSBvZiBkZWFsaW5nIHdpdGggdGhlc2Uu
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEBGcmFuY2VzY28sIHdvdWxkIHlvdSBsaWtlIHRvIHN1Ym1p
dCBhIG5ldyB2ZXJzaW9uIG9mIHRoZSBwYXRjaCANCj4+Pj4+Pj4gc2ltaWxhciB0bw0KPj4+
Pj4+PiBhYm92ZSBvciB5b3Ugd2FudCBtZSB0byBkbyB0aGF0Pw0KPj4+Pj4+IEhhbnMgc3Vn
Z2VzdGVkIHRoYXQgd2UgbWlnaHQgd2FudCB0byBsb29rIGF0IHJpcHBpbmcgb3V0IHRoaXMg
DQo+Pj4+Pj4gZWRnZSB0cmlnZ2VyZWQgZXZlbnRzIGF0IGJvb3QgZWFybGllciBpbiB0aGUg
dGhyZWFkLg0KPj4+Pj4+DQo+Pj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGxhdGZv
cm0tZHJpdmVyLXg4Ni8yMDI2MDQyMzA0NDIxMS5HRDU1NzEzNkBibGFjay5pZ2suaW50ZWwu
Y29tL1QvI21kY2E4ODJlNjYwNmQzYTg5NGVjNzQ5OWQzYjc0MmQwNDA5MzNkYmRiIA0KPj4+
Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBIYW5zIC0gYXMgeW91IHBvaW50ZWQgb3V0IHRoYXQgdGhl
IFN1cmZhY2UgbGlkIHN0YXRlIGlzIHRoZSBvbmx5IA0KPj4+Pj4+IHJlYWwgaXNzdWUgbGVm
dCBhbmQgeW91IGhhcHBlbiB0byBoYXZlIG9uZSBkbyB5b3UgdGhpbmsgeW91IGNvdWxkIA0K
Pj4+Pj4+IHdvcmsgdXAgc29tZSBwYXRjaGVzPw0KPj4+Pj4gUmlnaHQsIHNvIEkgcmVhZCBm
dXJ0aGVyIGluIHRoZSB0aHJlYWQgdGhhdCBBcm1pbiBoYXMgYSBtYXliZSANCj4+Pj4+IGJl
dHRlciBzdWdnZXN0aW9uLA0KPj4+Pj4gYWZ0ZXIgdGhhdCBoYXMgYmVlbiBtZXJnZWQgSSBj
YW4gY2hlY2sgYSBidW5jaCBvZiB0aGUgY3VycmVudCANCj4+Pj4+IGRldmljZXMgd2l0aA0K
Pj4+Pj4gLm5vX2VkZ2VfZXZlbnRzX29uX2Jvb3Qgd2hpY2ggSSBzdGlsbCBoYXZlIGFuZCBz
ZWUgaWYgdGhvc2UgcXVpcmtzIA0KPj4+Pj4gY2FuIGJlDQo+Pj4+PiBkcm9wcGVkIG5vdy4N
Cj4+Pj4+DQo+Pj4+PiBCdXQgdGhlIGFib3ZlIHF1aXJrIGZvciB0aGUgQVNVUyBST0cgU3Ry
aXggRzE2ICgyMDI1KSBkb2VzIG5vdCB1c2UNCj4+Pj4+IC5ub19lZGdlX2V2ZW50c19vbl9i
b290IHdoaWNoIGp1c3QgZGlzYWJsZXMgdGhlIGluaXRpYWwgcnVuIG9mDQo+Pj4+PiB0aGUg
QUNQSSBldmVudCBoYW5kbGVyIGF0IGJvb3QuIEluc3RlYWQgaXQgdXNlczoNCj4+Pj4+DQo+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuaWdub3JlX2ludGVycnVwdCA9ICJB
TURJMDAzMDowMEAyMSxBTURJMDAzMDowMEAyNCIsDQo+Pj4+Pg0KPj4+Pj4gd2hpY2ggKmNv
bXBsZXRlbHkqIGRpc2FibGVzIHRoZSBBQ1BJIGV2ZW50IGhhbmRsZXJzIGZvciB0aGUgDQo+
Pj4+PiBtZW50aW9uZWQgcGlucy4NCj4+Pj4gT2gsIEkndmUgY29tcGxldGVseSBsb3N0IHRy
YWNrIG9mIGFsbCB0aGUgcXVpcmtzIHRoYXQgd2VyZSBhZGRlZCANCj4+Pj4gYWZ0ZXIgSQ0K
Pj4+PiBkaWQgYW55dGhpbmcgd2l0aCB0aGUgQUNQSSBHUElPIHN0dWZmIDooLiBTb3JyeSBh
Ym91dCBtaXNzaW5nIHRoaXMuIA0KPj4+PiBJIHdpbGwNCj4+Pj4gc3RheSBzaWxlbnQgZnJv
bSBub3cgb24gOy0pDQo+Pj4gSGkgRXZlcnlvbmUsDQo+Pj4NCj4+PiBAaGFucywgSSB0cmll
ZCBpdCBhbmQgY2FuIGNvbmZpcm0gaXQgZG9lcyB0aGUgdHJpY2sgYXMgd2VsbC4NCj4+IEdy
ZWF0LCB0aGF0IGlzIGdvb2QgbmV3cy4NCj4+DQo+PiBUaGFuayB5b3UgZm9yIHRlc3Rpbmcu
DQo+Pg0KPj4gQ2FuIHlvdSB0cnkgTWFyaW8ncyBwYXRjaCBmcm9tOg0KPj4NCj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3BsYXRmb3JtLWRyaXZlci14ODYvZjQ5NzlkNDMtZjYxZi00
Mzg3LTg0OTAtY2NlYzcwNDNjOTQwQGtlcm5lbC5vcmcvIA0KPj4NCj4+DQo+PiBUaGF0IGNo
YW5nZXMgdGhlIHJ1bi1lZGdlLWV2ZW50cy1hdC1ib290IGJlaGF2aW9yIHRvIG9ubHkgcnVu
DQo+PiB1bmRlciB0aGUgc2FtZSBjb25kaXRpb25zIGFzIGl0IGRvZXMgdW5kZXIgV2luZG93
cyAoYWNjb3JkaW5nIHRvDQo+PiB0aGUgV2luZG93cyBkb2NzKS4gU28gbWF5YmUgdGhhdCB3
aWxsIGZpeCB0aGluZ3Mgd2l0aG91dCBuZWVkaW5nDQo+PiBhIHF1aXJrID8NCj4+DQo+PiBJ
ZiB5b3UgZ2l2ZSB0aGlzIGEgdGVzdCBwbGVhc2UgcmVtZW1iZXIgdG8gcmVtb3ZlIGFueSBv
dGhlcg0KPj4gd29ya2Fyb3VuZHMgbGlrZSB0aGUga2VybmVsIGNvbW1hbmRsaW5lIG9wdGlv
bi4NCj4+DQo+PiBSZWdhcmRzLA0KPj4NCj4+IEhhbnMNCj4gVGVzdGVkIG9uIHVidW50dSAy
Ni4wNCBhbmQgaXQgd29ya2VkIG5pY2VseS4gVGhlIHBhdGNoIGRlZmluaXRlbHkgDQo+IG1h
a2VzIHRoZSB0cmljayBvbiBteSBwYw0KTm93IEknbSB3b25kZXJpbmc6IHdobyB3aWxsIHN1
Ym1pdCB0aGUgcGF0Y2ggdG8gbGludXggZ3V5cz8gSXQgd291bGQgYmUgDQpuaWNlIHRvIHNl
ZSBpdCBvbiA3LjAuMiBidXQgSSBhc3N1bWUgSSdtIGFza2luZyBmb3IgdGhlIG1vb24sIGRl
c3BpdGUgDQpob3cgc21hbGwgaXQgaXMNCg==
--------------wJf9zehBaG5WXLELX0ygLmlL
Content-Type: application/pgp-keys; name="OpenPGP_0xFA1853D2A93D55D4.asc"
Content-Disposition: attachment; filename="OpenPGP_0xFA1853D2A93D55D4.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEae9cbxYJKwYBBAHaRw8BAQdA87PkpEc/V9AjPUZtgCt1HozYZOv2i7DmtWO9
bufzcXbNJk1hcmNvIFNjYXJkb3ZpIDxtc2NhcmRvdmk5NUBnbWFpbC5jb20+wokE
ExYIADEWIQRyXlTt5wtfOVmei6r6GFPSqT1V1AUCae9cbwIbAwQLCQgHBRUICQoL
BRYCAwEAAAoJEPoYU9KpPVXUbIEA/jcKrvvxQhFrLMIj5P2MOG1zMmjNViG8i1HK
fockEPmoAP45CR30ML0PkQQglMR2Wpxln9WUeA151rzqTrGbkZxeCs44BGnvXG8S
CisGAQQBl1UBBQEBB0Ao3nuNtHI9dr8Lg4xpvFE3dIX9HNaBa/2zz5suxiV+MgMB
CAfCeAQYFggAIBYhBHJeVO3nC185WZ6LqvoYU9KpPVXUBQJp71xvAhsMAAoJEPoY
U9KpPVXUUmAA/jfx6umko6uNFGpFcDX5wrxh/eTL7x+4YORx9Z+bwti7AQCiGVnE
L8Hd3zRVp0u5UaQs5CfD22sPYLGpkJEuCDo0Cg=3D=3D
=3DOSma
-----END PGP PUBLIC KEY BLOCK-----

--------------wJf9zehBaG5WXLELX0ygLmlL--

--------------0UYgUZaB0kk551e7CoAtlDAF--

--------------fv9iS0ASDbnFmVXkvQFcixWH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRyXlTt5wtfOVmei6r6GFPSqT1V1AUCae+LWwUDAAAAAAAKCRD6GFPSqT1V1Ies
AP44zOQeSEi39QyIv5xRuKaMbYYDdhaJWD6acq9gipaUEAD+LWfruMfGG3o74xDTt+BfJYUuJBEM
9yNGySRP0AuKkgo=
=2Qnr
-----END PGP SIGNATURE-----

--------------fv9iS0ASDbnFmVXkvQFcixWH--
