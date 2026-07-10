Received: from va-2-49.ptr.blmpb.com (va-2-49.ptr.blmpb.com [209.127.231.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFD3DCD9D
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669970; cv=none; b=C5ysxAB2JqLD2D4snibU/tIHXhIEqpUxr1Jf8PT55jp39oOd1JruqeMJBrToqKeNqOf1guGZIGaMdYlxYaGkcIiD80H8lJIGliQ7XSwBUEyMDtFKB311/SbZBcS5klAb2pTDEM8ny4HpSauNE1t5NQrN5hGCYsxQfciCuzO2NrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669970; c=relaxed/simple;
	bh=mF4t76bqNPx6WmUi13sRFyjEfNHuL1kRunvuJFwA844=;
	h=Content-Type:To:Cc:From:Subject:In-Reply-To:Date:Message-Id:
	 Mime-Version:References; b=avPLVPj3BX3AHJQSgLdh8AagvbEZHY8nU20b85Y8EC7faGYm79LxKf6xJ9apDGNNOQCLcj73+3yX0HeXUGS4ViDwf3NKHQ3EfEse4MwUflYzqTBcOV9D3sc2UFvnd/ATczv8b0ADgyIOvnOJRb2xnJKhz2iRpizq/XDFZZEpJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=hTMEGQNL; arc=none smtp.client-ip=209.127.231.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="hTMEGQNL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1783669963;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=mF4t76bqNPx6WmUi13sRFyjEfNHuL1kRunvuJFwA844=;
 b=hTMEGQNLagWyHwbgHvFqQK/0+6OLN06Os9uYwpfkHlGP3NiAgBUV7aD/3W6bGuc0wea9qb
 Y/CZHRfo0/rKDIeiBvMRHboMXKEiTvB6W25rLmft4eiIkGKvc/cGHBBXKOedc9wAEO5iG1
 e57mJ3u0AWcAPGkujwC1tlaWlxzd2BimopY2h1Rx120iIBbSqpkJMlJhd6hgGxfnUaqTB5
 3PYRJQnWXYfMV9jFcFJXo/UdYuvfFcV0iZ7wp/YVs/JJucudWqqAaRYEVJVSCk9DdvB4RF
 p+GXM8cEKjqYMYeX3UGllDBhjKz6zY3cs3guy/r4oc9yKM1NAbnr1wjr5ZNUGA==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Vishnu Sankar" <vishnuocv@gmail.com>
Cc: <platform-driver-x86@vger.kernel.org>, <mark.pearson@lenovo.com>, 
	<linux-acpi@vger.kernel.org>, <ibm-acpi-devel@lists.sourceforge.net>, 
	<vsankar@lenovo.com>, <vishnuocv@gmail.com>, <mpearson-lenovo@squebb.ca>, 
	<oliver@liuxiaozhen.dev>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: Add USB-C Security (USCS) support
X-Lms-Return-Path: <lba+26a50a4c9+e7cd75+vger.kernel.org+oliver@liuxiaozhen.dev>
User-Agent: Mozilla Thunderbird
In-Reply-To: <20260709021504.465792-1-vishnuocv@gmail.com>
Date: Fri, 10 Jul 2026 15:52:35 +0800
Message-Id: <239c8162-e1e6-4b49-8292-35547c5a525c@liuxiaozhen.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [198.18.0.0] ([23.151.104.167]) by smtp.feishu.cn with ESMTPS; Fri, 10 Jul 2026 15:52:40 +0800
References: <20260709021504.465792-1-vishnuocv@gmail.com>
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Content-Language: en-US

Hi Vishnu,

I tested v4 on a Lenovo ThinkPad P15 Gen 1.

System:
 =C2=A0 - Lenovo ThinkPad P15 Gen 1
 =C2=A0 - BIOS: N30ET47W (1.30)
 =C2=A0 - Kernel: 7.2.0-rc2 + this patch

I checked the BIOS setup and could not find any USB-C Security (USCS)
option.

During boot, I get:


```

 =C2=A0 thinkpad_acpi: acpi_evalf(USCS, dd, ...) failed: AE_NOT_FOUND
 =C2=A0 thinkpad_acpi: required events 0x00720000 not enabled!
 =C2=A0 thinkpad_acpi: probe with driver thinkpad_acpi failed with error -5
 =C2=A0 thinkpad_acpi: unable to register main platform driver

```


As a result, thinkpad_acpi fails to probe and
/sys/devices/platform/thinkpad_acpi/ is not created.

It looks like systems without the USCS ACPI method may fail to load
thinkpad_acpi with this patch applied.

Please let me know if you would like me to provide the full dmesg log or

test a revised version.


If needed, I can also test on a ThinkPad P50s.


Thanks,
Oliver Lin
