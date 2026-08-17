Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D513E2756;
	Mon, 17 Aug 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959782; cv=none; b=frbD5x8lCh5FEzSnKalmTvJaDso1Sy9x78qGqNLtHHcd7rp/pFjBGpNXGqzMqKfF1GepYhnKogX26cNeIlV57nQ+tRxMJX3KQVTaqx3VoSktnIzAyv9kxVsOD1ATUeL3wuw6JRWIvlojtY9vgELwIjrL3UQOnLIfWPiNBFNbR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959782; c=relaxed/simple;
	bh=0BDe1q0/PG+gtr3JikCZCyntPWIP75+wD6CVvwujyaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7KW/xuI3iRONnidFrZ1mkws8/DO7ltyaVnFYFn45NYmCM972bpoEs2d7jJx0qdBKEI7wM6soZi6iFJkZf9nah5wejeNSE4Si8MDGBXpQqylkF4E8O7dJYATkh0YEQ3BEA4FZrCWjjZjvUVI+nMmLXWbXA9XYkX59qRwN8Mkf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=R/BcTH4Y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="R/BcTH4Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0BDe1q0/PG+gtr3JikCZCyntPWIP75+wD6CVvwujyaA=; b=R/BcTH4Y4o5+7byWk+ZonuSEuo
	z7EoSTc+Dkhg1PySdgRQ0aVmIffDMhJZiaNcGIy1n3VIk1s3/80fm5dTY4XtZICnY1GC0HPCDKkeJ
	F1zJm3IkQEhikj5uHNEQcovf4kkaY45JSalrrXMnuB9wwokoia6UFY7KOmM6vnoBQ6y5VCIObETd7
	chxIcyWSekKbMvbo8vLflL+CsIrOWQ7qkveJYKJQy15HNwEyT8/dH0r8SXOIiUFbO45LTXrLPQ1NI
	ugSQBq24ySnLal8GRO1uPZR+6/z+j134/EkMxGUDon7noaYI//6vWWgRzOHd0hEiJ710KipX7GoAP
	6EXtJZIw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wvtrm-0088JS-27;
	Mon, 17 Aug 2026 09:42:51 +0000
Date: Mon, 17 Aug 2026 02:42:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Adam Young <admiyo@os.amperecomputing.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	kernel-team@meta.com
Subject: Re: [PATCH] mailbox: pcc: Free the channel before unmapping the
 shared memory
Message-ID: <aoLVnCqlj3ffTd-e@gmail.com>
References: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
 <1a2fb06b-a5e1-46e6-93d8-829b7419142d@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2fb06b-a5e1-46e6-93d8-829b7419142d@amperemail.onmicrosoft.com>
X-Debian-User: leitao

Hello Adam,

On Sat, Aug 15, 2026 at 11:58:16PM -0400, Adam Young wrote:
> On 8/12/26 08:36, Breno Leitao wrote:
> > Free the channel first, before the memory unmap. mbox_free_channel()
> > calls pcc_shutdown(), which frees the platform interrupt, and then unmap
> > shared memory.
>
> I posted a related fix undere the MCTP PCC Driver changes.
>
> This fix is necessary but not sufficient to deal with the race conditions.
> Take a look at the series of patches under here:
>
> https://lore.kernel.org/all/20260721175258.87600-1-admiyo@os.amperecomputing.com/

That looks like a much bigger series, with new features, open discussions,
Nacks, and already 45 revisions.

This curent fix is only meant to address a real problem (user after
free) I am hitting in production systems.

My suggestion is that we get this real issue unblocked, even if not
complete, while you keep working on your larger series.

Thanks,
--breno
