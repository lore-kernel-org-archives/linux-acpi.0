Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770A36920F
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503184; cv=none; b=OHTzpn8T+QMgxFp7n4URRNQb21w/nVFN/lpWPYJx4Mb1dvFdwKm1BxBv78DyLWHZ0RSzu9Q3ReKQ3eLlVYFVMttpsO1Gc37W05j8jDE6mZZQiALf+oNLy9iuG2V6MCEu/2iql5ixA6+ek4KzgkdtUvUCxoD8/IYg9Ih975s5tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503184; c=relaxed/simple;
	bh=/72SslYpy2PVQIMAAmadnePuVCvoy+6MWfdj9ZYOdZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bp11whkakNiHYDzUexVmG03Ow976EzA8jLolfDzABT+6HZ7udJSXfbnM0ilKWgbFUCmy6r4rgXcRqSz71eIdsg8JoIPLNQOgcvU0lE40WoH5744aBIXw4ghxr0d8Qic89pz/1zeO+udjAa245hBa4om/Xu/SOPsW35F7PfoiYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHygtYvH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHygtYvH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc891373e0so9325285ad.2
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785503183; x=1786107983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWMr5EOxuzjVi5gwglHccB0LsO3CP+DoymMW6cwNef0=;
        b=pHygtYvHx1RtSbKvbmO2VWEp7Zl0b7xsJ/srCgu6Up3Yyuy6qws2EP+Lx401I81n6W
         kbmKuHdIuwGiQWsePnfVIch1zuFwQaVhwr/+b4R5ksp2izbK5dVSb5waca5pWbZOu5iq
         59t09lGDzqjRtOStDFehbVG6UouLLBTbs3NoVEalgZIu478AyOVe/Z4dHTO84qgX/9H4
         xXfeWm1nVA/gJ8nnur9H2OUQTKonmT+YYf/cdCQEygpexo9MQfM7Q03VP5/f+wAAeQY3
         SSuUWM/JoruOl6NuXyilXCHtE8/PpXBOb4QTQGmBwqx1NAM384u6Jp1l9R41czqJgJnp
         VmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503183; x=1786107983;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWMr5EOxuzjVi5gwglHccB0LsO3CP+DoymMW6cwNef0=;
        b=JP022pxYcPs4B92uX1aplK4oj/pCSUOMSrDzG9+calaMm5pHtlTPI+4xFTOI63icGk
         5kbF45blJoDeiqyiRjTl9vITQZP6MTIUFs3IlvXspxfQrPGEWngs3+pNrabgjVJJgnum
         ngezgozhuZhElISVmJoMlwh2Hbh6TO3AWKyWW77HI6q3QNOPXrbxljy0S5BbEggqJAwt
         ST3dcMZCftSSmmUifz09Aad1B54IcWkbzmNBw43nTvr2LMW8CLvOWs+7O5NttaPfezSi
         cLunK7XTL17qK7ap0ZJkcTAPE+ZEgstEhYPtSD+pC8n9RIWbU8I7VZhHuNkOcLxVZwKe
         4lTA==
X-Forwarded-Encrypted: i=1; AHgh+RqGZNrXtlt1Z94NkovRGHuNpLceYoFJslBUxCmRoOxZJdSWH4pJdD5OO9bH+e9re+VGTPcNZuPlD6x9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++J5ZNotG+95lZC4BXeg3+/McymZwyhjDs68vuXNuBFEnapNd
	WinkSYbmE27Fr06zqxrgpOb838077E2YS7RC8UfCNiBiCKNDlcBu8syT
X-Gm-Gg: AR+sD10XtYZzV+m973Je4cXXL/qQvqdQy6xXI16qOy9huC7cOTqDLF5zsS7/t/Ff0qG
	AfMxwaZ74H9HKyUgdOan5AKod31FBwzKvIuUKYdCibP8s9FF2/NO4urFmbLhGOtFzg8JUrRwpVI
	q/enRsiXmlHHGleFBCAD75THB4ZDE8Dljtjo/W8F2FQEswClRzNKZNMpbeq7nhODaFSsFJWvI1D
	cY36Uw8hmdzKcZBaAVBRUv/+8hKpl/w1zaXWGYbnMtum3h+CxC9r2F0+kB+uS8ueo55MWX9l/k7
	WElI/Btepnf1GAK7hiOZ/aO8U5f6vHuZ5vE8caYDdt+ylk8mQuRtlq2yMnTcFYiRoqdHsdf/Sa7
	zksUnyUw1fYp4AR8O876KgLc23wHPHAWZjUp1GFYMLMBK6yppZbSHdwFfxsPhCUcae+P7fNfi7B
	BKL4W5lpZFYk37qXYbpIPaa5nMaLUll8v/y7U3AJr6vfHSy6LNExmISxnVWg==
X-Received: by 2002:a17:903:190:b0:2ca:ecf6:9104 with SMTP id d9443c01a7336-2d046d81079mr19211725ad.4.1785503182834;
        Fri, 31 Jul 2026 06:06:22 -0700 (PDT)
Received: from [10.10.0.5] ([59.152.127.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb491sm5193715ad.42.2026.07.31.06.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:06:22 -0700 (PDT)
Message-ID: <588c2e18-e6fb-4fc1-95d5-7a5dd0f556fe@gmail.com>
Date: Fri, 31 Jul 2026 21:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
 <daf0bb9b-246d-437d-87ca-16706113b201@gmail.com>
 <CAJZ5v0jByxtQ2tmNm_ZyyBnDMBNjuqQwD_367NRyGNzF7wQtRw@mail.gmail.com>
 <7792f017-42b0-4a09-9941-5259138e21b1@gmail.com>
 <CAJZ5v0jCFFNuG7WtCE2CG+hP=YNsYMdXH_945QgkgAUcr4Lryg@mail.gmail.com>
 <37daa35f-06aa-49d0-bf0a-1b5ac9f44c89@gmail.com>
 <CAJZ5v0jyy0+hqU3=gmBrgMzLBVhdUQwDj8d0_jGCqZwqyWT=_g@mail.gmail.com>
Content-Language: en-US
From: Julian Silver <mendaxca@gmail.com>
In-Reply-To: <CAJZ5v0jyy0+hqU3=gmBrgMzLBVhdUQwDj8d0_jGCqZwqyWT=_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-07-31 19:58:32, Rafael J. Wysocki (Intel) wrote:
> Please boot with "intel_idle.states_off=16" in the kernel command line
> and see if the problem is still there.  If this doesn't help, please
> also try "intel_idle.states_off=24".

"intel_idle.states_off=16" does not help.  "intel_idle.states_off=24" works.
Note that the test is performed on vanilla kernel v7.2-rc5(without the patch).
