Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC62BFC8F;
	Sat, 23 May 2026 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779503042; cv=none; b=W0a/BgnVc3TwiiCgPLgbGdDlH6s9L9He2Qcv6syo1QYD43ZhPXCJOohFt3iKVfVRANhVasaeWAf/21t52wPZ/7bSjpOgUR+e3cTqFHAWY9r9LR6/HeXDycewVatDZ50qBpSbmy3wlDe30ptwkhZ8RCaQqMNFkGDLaQXvCj4HUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779503042; c=relaxed/simple;
	bh=l+m52cJAp0bywPkjj6k/NK8p8JTbT2bIgGF2BYYrzG8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s7ILJRIEFo8lHAP8YFTBx5nGxa2lsvjbSdO/4tDryzbIg5Rv/5Rr30xHb9dZTUHMbyulUFC6AdvXYCAwnrQ8WDo36lQ68OX/wJ6XIRAUGtE0yBlKGchu51gfAf3IzlPF8Lj7ZFpRGiq9dDTnwChVNFGjCXeXMcaDvqqtHsiv0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sAhMO98E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sAhMO98E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BE41F00A3A;
	Sat, 23 May 2026 02:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779503039;
	bh=bgvMRPXaWJg/kqTU+nxDS8Jtv8FEeut5D7DpSk9T20w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=sAhMO98EwPzIR7wn6o9tQceUPeObdNNC5SSxqiJmI+XC04VQN0va044PzTKQk8qLU
	 +h1Eu4R2oe7VDZisCMkLOtQLGguKHA/SC7J0+xzNytBcinqzm+Gyy6Tg9OpC7llA1W
	 DXiFgnaR8tQYEL1jNZAwcG+kRNctEjjfqDZiaIkk=
Date: Fri, 22 May 2026 19:23:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Manuel Quintero Fonseca <sakunix@yahoo.com>
Cc: rafael@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
 hansg@kernel.org
Subject: Re: [PATCH v3] resource: Downgrade "resource sanity check" warning
 to debug level
Message-Id: <20260522192358.2a0c2db04578c8281eb22dac@linux-foundation.org>
In-Reply-To: <20260523000131.7086-1-sakunix@yahoo.com>
References: <CAJZ5v0ikd24Vj3H=2XAGwwHtBudDXJumL4H-whu1GgU-KjMnmQ@mail.gmail.com>
	<20260523000131.7086-1-sakunix@yahoo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 17:01:31 -0700 Manuel Quintero Fonseca <sakunix@yahoo.com> wrote:

> The "resource sanity check" warning currently triggers on certain
> systems, causing unnecessary noise in the kernel logs for users.
> Following the maintainer's suggestion, this patch downgrades the log
> level from pr_warn to pr_debug.

um, who is "the maintainer"?

hp2:/usr/src/25> grep kernel/resource.c MAINTAINERS
hp2:/usr/src/25> 

> This change reduces log clutter while keeping the diagnostic
> information available for debugging purposes if needed.
> 
> ...
>
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1859,7 +1859,7 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
>  		if (p->flags & IORESOURCE_BUSY)
>  			continue;
>  
> -		pr_warn("resource sanity check: requesting [mem %pa-%pa], which spans more than %s %pR\n",
> +		pr_debug("resource sanity check: requesting [mem %pa-%pa], which spans more than %s %pR\n",
>  			&addr, &end, p->name, p);
>  		err = -1;
>  		break;

lgtm, thanks.
