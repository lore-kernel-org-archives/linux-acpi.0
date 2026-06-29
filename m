Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155CC429825;
	Mon, 29 Jun 2026 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748961; cv=none; b=bGuX7ON8vK/xEAGtmIoa36pE2+9iOujI1H5Gb/nthBX5ld+W1ofkz9cKs0vZ71kAKBe1heY1CrtgLdwKRjPDxFLxhI+1niF+92cHSvI+4n4jlRJgx9WNDL2asafVASiQ0xY7Jyu8uPeWKVK2Shn8rbW58sDv2UZY1k027WwPedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748961; c=relaxed/simple;
	bh=CmkyM0gKnkXc7iOZ4KWexJ+DOScGYYrexahA8IDf0Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0ovo2lacbHeLpXibrktlEFUyyDKft6/rAa8ZpbM0BuYvBx3J3qfhYLzfGnBkGVS674awKKWuNXBDk1GIR7mpb8I5EUNryspj+G597CPEWGn6Gn3W4P1t/4byTt4t2qcCG4K/NP8dqbFlEuUvTuH+oP+x+bqDb3CyqITzlRI1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=emMkk9rT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="emMkk9rT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=CmkyM0gKnkXc7iOZ4KWexJ+DOScGYYrexahA8IDf0Eo=; b=emMkk9rTbhnNhghgE55MfwVz3a
	r0n4XukSrz5gDKUzziYlr1RfQA2R2dAn7mnImS/buUGFiUCN4qn4QfbxvGrVO+o3jP2thPY66Eb6C
	fvINpG7/9AURgL5pREtz09JyNaEEG+8roTTsviLeilkdUsiSrOxsNwLX6rrR+zwdoP5Wlw+zJ5Lwc
	WcUte29QZmowNvkZ0ZS0LyY1bRmeSH/agZmXCqDm+ff9UyozEamDw3Zq+bkTi2meMF+CEJli5ZAQ+
	+hYQi2OnG7ynaoJoLLawpinKqgXUhpSTo2ADampGAKV97aHrEfNe9qBg/F6rLoJgAVo6/J4uVz8/F
	DLO7uaQA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weER2-006P44-1N;
	Mon, 29 Jun 2026 16:02:12 +0000
Date: Mon, 29 Jun 2026 09:02:06 -0700
From: Breno Leitao <leitao@debian.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	riel@surriel.com, caggio@meta.com, kexec@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] vmcoreinfo: GHES: track fatal hardware errors
Message-ID: <akKWJQNiX5MGJLl6@gmail.com>
References: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
X-Debian-User: leitao

On Wed, Jun 17, 2026 at 06:32:46AM -0700, Breno Leitao wrote:
> Hardware errors reported through APEI/GHES are recorded in the kernel's
> hwerr_data array so that crash tooling can tell from the vmcore whether a
> hardware error preceded a crash.

This Hardware error tracking "thing" is currently in an awkward
location—it doesn't belong in RAS and has minimal connection to vmcore
info.

Following Baoquan's earlier suggestion, I'll refactor this as a standalone
driver, which should make the code organization clearer and more maintainable.

https://lore.kernel.org/all/aYvi4Y_HNqk_u1-v@fedora/
