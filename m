Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23E3E6DDD
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939900; cv=none; b=afjhLUaHNdRDcMIcmqxjyNw9WOdFo/N0NY8VTxT475abnE/pR8GsIzosc3mQ8LEWNYCdeLh/hQyUGJjlqgoE1gC3PysBUsQnCZlrQT8qyZS58VEI+IG7poikALrtNkvN+Kol6LCL4uSYsojodcCcKG9aalkwnjR89jj9+fWyAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939900; c=relaxed/simple;
	bh=gJpXnZIHERE4b1brTnIou/gy2uT2dedy+T3v+TB0y8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKxmgK0oIWQenLGyhU2YnPC5aGGS8LKTFqamLs7QIqQowts/3XsF1i7Jssvpk62hUorfEtLfpaLpsrkx/9ho4CzzNb+0JCsvzxFkit13xZsI3QYs2/QoiBzFTFJTxc2lJ2MM2rrb+GFdeFhsqp4k+sxNYc1A8jz6ua8bPXqQmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PbACmgzy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PbACmgzy"
Date: Mon, 13 Jul 2026 18:51:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783939886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gD3A9pJWmGNBEpcGuAJUTYfdEqwu/kB9DlQTnjeCkJU=;
	b=PbACmgzyg49Tkt0MnyM5u8X5Npc6gqSDxGyrXUuvFQftDo4XLRDP4h/5xfXzgVqm95CVPW
	KZABNZjNng9M8/0G9vdNu7G8AgDqhTdFwj1LWFKBKru/YE0uToUtZW3lVP7FftA86r5DX3
	aIXLrXciYsHVhutR0ciWNRoPO6oOFAs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com,
	vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <alTDI53vd4u_YY_G@MiWiFi-R3L-srv>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
 <aYvi4Y_HNqk_u1-v@fedora>
 <ak0JSScR3EYgLEf9@gmail.com>
 <alDRawveM-auCHwB@MiWiFi-R3L-srv>
 <alSqd2U9zhqYz1Wn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alSqd2U9zhqYz1Wn@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 07/13/26 at 02:08am, Breno Leitao wrote:
> On Fri, Jul 10, 2026 at 07:03:07PM +0800, Baoquan He wrote:
> 
> > Anyway, I am glad to see it's been taken out of vmcoreinfo.c,
> > which is going in the right way from kdump side. For its migrating
> > into driver folder, leave it to the relevant reviewer to review and
> > decide.
> 
> On that patch, If you could confirm that moving it away from vmcoreinfo
> is the preferred approach, that would help establish consensus around
> the right direction.

Yes, I can confirm moving it away from vmcoreinfo is expected.

