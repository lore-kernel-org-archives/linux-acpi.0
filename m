Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BD35BDC2
	for <linux-acpi@vger.kernel.org>; Thu, 16 Apr 2026 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366947; cv=none; b=S5252NM+ComWTlBsduPI+gicRjaaniThKW1dkjwml1oMIVF3cI6sr1XqV0u83bugPogubNNCq7+OSvnTIqTzFhT01Nl17u4W3/1FYuQG6e5w2ZK2fCXZq885AYLoHa8DFFXWGeQIy++moELWs0JOpfH6TfNL4jiLFXQMwZiCu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366947; c=relaxed/simple;
	bh=OJeI+3mV9W6ncnLD1OqQ+pA6ULnbFdUSlKq0JT7njbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWcJIcaAEADSXJXMKNA3N0h0OTLNVisFQdXuWgQQDeFjLVWcavJVtgN3MrqoPEUwL9PKWQJz3eYRXnTrUgqMdT9YxNgxF2DujZfyAwhMyvxqiZR4EqdT4n0H+3mfbTGcQ24jadlTz+5x8s+InLeC97gWMgYmh4VoHvoB7u40OqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY8Id/xC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY8Id/xC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso79035205e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 16 Apr 2026 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776366942; x=1776971742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI2dSkxrwqhQpR5uFXP6GxtJ/asEeAYI1RS8A1ZzV9c=;
        b=QY8Id/xCkNSDyRp/6Ia+IhGODB81KC4sCUqlBNfTsAhr60CKClN3QAh6bbWUbx9w0F
         bowURat77zHN+ZHlfvOuP63DWSZJLS9CB67JIgVAKCi6+vwdDnB0WCbS+mhqXyCZvNgH
         3LgovKTZOOZSrowianOqjoxUQU00rBtvbO969KTtzDkyjg4GJlw/bqQS1tjsfKG/nQPm
         ogEfTFcSlOlyCQukZYVXoZ8VBq3hePPIvwrDjEotzfkKEEGQrm4PF/3sJRfFVVsqc4hv
         U3krfzau87CZFEd4MdPgtiuytDHml1jLJtOQsqDYRuR1b6pukPY/ROgrGM7JVAH/3WFp
         ckmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776366942; x=1776971742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI2dSkxrwqhQpR5uFXP6GxtJ/asEeAYI1RS8A1ZzV9c=;
        b=Fh3tDNeeVVxOmpAdBFd2F0zdzIO3k2p6J8ZojRNSKC60xUk6FUSQNFtQknXUcUR8EF
         8PWtvTdPrQpJ63ex0ud6W35cL6CYdYQl4rEtdcOJiNU3o6kLcsOjkljWRCEyE/ubg4v4
         wN7fLmZ1zgrPVE/TQ8WHUun9cB28PtWRm8iefY7bdi3Jgso0H4Cg3EUSsQfGhVhlN4k2
         UoT39jDZFRjxSFtoxHFOj6sOwXbLbnN698LN8n8PFRgr1u+QakWXPJzaH3YhdZXauO4y
         S1SUpQIfCceofaOufPS0w9RuBdVoPTlpeAJm+0Mr+kYFm5KBMBxJ0NcvutCFc3ET3sjf
         CL9A==
X-Forwarded-Encrypted: i=1; AFNElJ9c7MuHaxwhLhv3DibRVFQkfiVr1BBlr2HLcu5gtBg6+CnnQx+PEL849UlWiTEc2KZ80tGocUKy/vH5@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmRzaNoqHCOKM2D/0GOaKAV8y8OtCcV29S8kRjOrteptVT1M5
	ppCvnrBsywNoHLUqw/wFEtUqHmy4ZugPEkGjSpOD67XhMVz0wTmwESrA
X-Gm-Gg: AeBDietV5fAnZDJfFtNTTGe46cj+UqfnFNT0gyNyOTtgu/sbwEzmb4nfciVwbqWkrDT
	8fHwGKqB4dolrqnGSxm93dqlY0W2ZMuvY45ThCXxjcEeWKifagsLBzrP5xrC5oJcrlw3BDfXHkp
	y5eKkA+jgDe0QxlczesPFRTcyHX9nlWE59+xqVr4RqOP76zilHT5wpmDs8av1QK+G/GAHYL32nG
	omw1xAewpnJ7Ci0RGZi6TOhWmSaAaVw37RUFDzaSdx5+uZL39KDrp87PJovdB+1MwCoYdILhAKk
	EoKV3bS/0WVEMo7LoDngZ/tVbNd1ldeU4Ubb/LJ3Ax+iMoet/j9JcB4tG/GXznRDVCC3//PA0P+
	RZQF6tLrqXeU9rcP0d+vTkrMgg+0Zcbcxxl6gLllMDyIeKhA0VyRNPTh80D7pTy1/9up2T7FMwk
	SnaUSdj9P0tEh9iN1n3fbkH7M6zRAyCM3IkljUgRWHVi6rWaPPncCQX7GsU6SQxJQ7uhO//5Eyk
	+I=
X-Received: by 2002:a05:600c:a415:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-488fb26d43fmr1783635e9.1.1776366941546;
        Thu, 16 Apr 2026 12:15:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm16561608f8f.17.2026.04.16.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:15:41 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:15:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: chensong_2000@189.cn, rafael@kernel.org, lenb@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, viresh.kumar@linaro.org,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 bmarzins@redhat.com, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, jason.wessel@windriver.com, danielt@kernel.org,
 dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
 petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
 joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list
 with double-linked list for reverse traversal
Message-ID: <20260416201539.2cee3b99@pumpkin>
In-Reply-To: <aeD4H8P1DiPQoM8V@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
	<20260416133004.07bd2886@pumpkin>
	<aeD4H8P1DiPQoM8V@pathway.suse.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Apr 2026 16:54:23 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Thu 2026-04-16 13:30:04, David Laight wrote:
> > On Wed, 15 Apr 2026 15:01:37 +0800
> > chensong_2000@189.cn wrote:
> >   
> > > From: Song Chen <chensong_2000@189.cn>
> > > 
> > > The current notifier chain implementation uses a single-linked list
> > > (struct notifier_block *next), which only supports forward traversal
> > > in priority order. This makes it difficult to handle cleanup/teardown
> > > scenarios that require notifiers to be called in reverse priority order.  
> > 
> > If it is only cleanup/teardown then the list can be order-reversed
> > as part of that process at the same time as the list is deleted.  
> 
> Interesting idea. But it won't work in all situations.

It is useful for things like locklessy queuing a request to be processed later.
Items can be added with a cmpxchg and the list grabbed by xchg of NULL.
The only downside is that reversing a list isn't cache friendly.
Thinks... although that may not be any worse than accessing the current 'tail'
to add to the end of a doubly linked (or singly linked with a tail ptr) list.

	David

> 
> Note that the motivation for this update are the module loader
> notifiers which are called several times for each loaded/removed module.
> 
> Best Regards,
> Petr
> 

