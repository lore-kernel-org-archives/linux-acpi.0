Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C6846A
	for <linux-acpi@vger.kernel.org>; Sun, 12 Jul 2026 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783828228; cv=none; b=FB1R5GX3/MbhYXyFVY8+UfBiV4+6jwgomkV4KNEjRyerkOfSubKzHFDcqWqf6AhhTC5qi2LfYWgL4WlwRDkQsTU9D9+aj8eA3nCu+m3q1tRKDbGEQvKDJrtaslyiQ5xw2uju0GeHIkSJ4Jhe+S/UTJDVNpilXjB8SeUk2NzzX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783828228; c=relaxed/simple;
	bh=DUwfmHa7lIZh61zgM5y21HwknAE8opugMFydhOiyKNk=;
	h=From:Subject:Date:Message-Id:Mime-Version:In-Reply-To:Cc:
	 References:Content-Type:To; b=DdRSqf/EPxyKZrua5Iy0VypBv4YbDguFW3PFCmzERjjmQ8wAsGNxSJTUgwX6xMEYIpENdhgev421DmXULFuDAcclq7l/h+y5cbQOqs5M802klVdNXtNa3+96/lwIlw+Vqmvn9BnbrBP3Z2Xqcf2niJ9WII7c1idg0GnmoLGi/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=gLLGZS4i; arc=none smtp.client-ip=209.127.231.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="gLLGZS4i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1783828221;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=DUwfmHa7lIZh61zgM5y21HwknAE8opugMFydhOiyKNk=;
 b=gLLGZS4iZH8igjAUHp6SC1kRR3LJBdW42p23Tz44hZHKbA7EODQsv8zFUvt+oGK3epbRlG
 qCTlL+hv+arbSXPizTOMvKBgX4DYkElV8V/cbBIWUqVKODn90/xIdIYfB2C8r/Rc7KunWb
 nZ3Tvzm0CKWnNzan6RJGD2nAjZ//TZjPEYL+2QI7B2klS0yL0jjn3bC2n8eMxLhCZxcH3s
 3jZhASFH7kY7oX9Md5MI+xrdsSdXxN4LjpCDo1C7jqzHLj1ifrzWBa884e4evAFiTlJ4Kr
 O8kP7Rjzq9dvD4mQYRL5Ae7iX1kCwOS04XOgcn4efFIZetzY5KUl7a+os1l2Cg==
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix USB-C Security probe failure on unsupported platforms
Date: Sun, 12 Jul 2026 11:50:14 +0800
Message-Id: <142193d8-3860-4d9d-acc8-5b6a0569321a@liuxiaozhen.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260711062249.503264-1-vishnuocv@gmail.com>
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Cc: <platform-driver-x86@vger.kernel.org>, <linux-acpi@vger.kernel.org>, 
	<ibm-acpi-devel@lists.sourceforge.net>, <mpearson-lenovo@squebb.ca>, 
	<vsankar@lenovo.com>, <hansg@kernel.org>, 
	<ilpo.jarvinen@linux.intel.com>, <oliver@liuxiaozhen.dev>
References: <20260711062249.503264-1-vishnuocv@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Received: from [198.18.0.0] ([23.151.104.71]) by smtp.feishu.cn with ESMTPS; Sun, 12 Jul 2026 11:50:18 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a530efb+df7981+vger.kernel.org+oliver@liuxiaozhen.dev>
To: "Vishnu Sankar" <vishnuocv@gmail.com>

Hello Vishnu,

It looks like my email address was recorded incorrectly. My address is:

 =C2=A0 =C2=A0 oliver@liuxiaozhen.dev

I'm currently testing this patch and will report back once the testing=20
is complete.

Thanks,
Oliver Lin
