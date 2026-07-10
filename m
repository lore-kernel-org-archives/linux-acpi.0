Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B63BBFAA
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684476; cv=none; b=hDyaTe7pLco6qpgzIN9rBLHLnzOaVf9yGg2fb0/FJLWMALm9fp36sR8+wFL9sVPZ6QTscWyZB+1n8m31vgcciEgY5HLeerHbVThNh/L/mCZMUjU9fk2XzjzStc+H8kXCoiuTvoWFdwEXCoWrWPAxFMhn5y0yVDMpx7SZBTkpwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684476; c=relaxed/simple;
	bh=xmfra9Un/COokRR/bpWpmR2ZGK7tGZtb6RaMtHHGwic=;
	h=Subject:Message-Id:Content-Type:Cc:To:References:Date:
	 Mime-Version:In-Reply-To:From; b=s4PM1X2BLIF88T6XwzFH8DTGrRH8uG4UunG/jEW9K457WDTZ/VOZexHDTTnFKCOov61nabMZomSV8TqaRNV5cUFTxBCN3DdkcJx/IoN+P5h0RHGV9QeP8vU6kv17vleQPDRqXL//2aS19BOczcnEMTngc1jEwJHjUXleNn5ELKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=udEAXHWE; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="udEAXHWE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1783684457;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TrYxGSsHYiyf2hChlXciOyJVXYJIW1j0MgSGmllMGXE=;
 b=udEAXHWEkRNIqLGbYP95WxswII0d//cjs3UHokV7xdALM12rixDnoP28O3lRPRQp4rcJxq
 opLcdBblcK+oIDOvJTHzmrv6YufYo/4+m5KeBAxlVyST3MJwX5WuxF1VN1rpzauBH5SOEg
 7z/VfeOJopVDegrAz1cNNJTA8ngvtzvzbx5sQrW+InC6WqLGPUuA5tDBD4f0UDhkn0HWpV
 RZO/QJfy/WgYlTbD7N4kUXcGClg/2lc5jvwwSiPeD7hKWKt+7HjFWIz9ASZgrzZh1iorFI
 Qp8aRdDGag+21/UUYDMSMM09c75m62HLKY9hFom3w4h/Yis0G8F03EpYZkD4pg==
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: Add USB-C Security (USCS) support
Message-Id: <ac2dee60-0373-4d3a-b736-a795843c4e4f@liuxiaozhen.dev>
Content-Type: text/plain; charset=UTF-8
Cc: <platform-driver-x86@vger.kernel.org>, <mark.pearson@lenovo.com>, 
	<linux-acpi@vger.kernel.org>, <ibm-acpi-devel@lists.sourceforge.net>, 
	<mpearson-lenovo@squebb.ca>, <oliver@liuxiaozhen.dev>
User-Agent: Mozilla Thunderbird
To: "Vishnu Sankar" <vishnuocv@gmail.com>
References: <20260709021504.465792-1-vishnuocv@gmail.com> <239c8162-e1e6-4b49-8292-35547c5a525c@liuxiaozhen.dev> <CABxCQKtAYt7heT8a+GknA_4n+znA3+-=eRzuuky1RTLO+KNK0A@mail.gmail.com>
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Received: from [198.18.0.0] ([23.151.104.167]) by smtp.feishu.cn with ESMTPS; Fri, 10 Jul 2026 19:54:14 +0800
Content-Language: en-US
Date: Fri, 10 Jul 2026 19:54:11 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <CABxCQKtAYt7heT8a+GknA_4n+znA3+-=eRzuuky1RTLO+KNK0A@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a50dd67+38b506+vger.kernel.org+oliver@liuxiaozhen.dev>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>

Hi Vishnu,

Thanks for the quick analysis.

Your proposed fix makes sense to me.

Please send a follow-up patch and I'll be happy to test it on both my 
ThinkPad P15 Gen 1 and ThinkPad P50s.

Thanks!

Oliver Lin
