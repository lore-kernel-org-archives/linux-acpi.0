Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEF331EB2;
	Wed, 22 Jul 2026 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784755427; cv=none; b=cT6zpBS7E27J+6gZm2H8MWRYaZA7zkmUvIQyKJGdQy0FKOwCFpXU2N4oaJVRgh9aL3ysyn1ukxyPKUu705flfO97Vd6pjZrki10GiSKyM0+p3KDpc9LSBGtl+sQqIiYaSi4RmdQunTjYSPlRr4orZjtTMkgxrf4CFYRsxzFs86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784755427; c=relaxed/simple;
	bh=h6KjFPOsNpwDDUKjeLnwXNhyRnlRiXrtf6BcPmX4HZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+Aym4e1Z5CXLWW2zuFzIf+iDJmZGSIwZuSI6YBFzxshYI9b2Z78L0dzZyGTJRCFoH0bGfeSv8A/qYpNdnfsgqEAUWxsPpHrJKH5wCyloAAQH8lf9meGsN86GqJbTd++OY9jhmZRsugMChCNgITObwk1IsPpDCKJr8siUdx2+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iycmiML/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iycmiML/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9F74340E014C;
	Wed, 22 Jul 2026 21:23:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YhOD5fZpqqlO; Wed, 22 Jul 2026 21:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784755413; bh=euMeKiLTiE/DOhvPP1t+L0UoWsOwmvcmefIO7EPwJMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iycmiML/v3UDpVyhJcqi0xMiA642wpMeE3WCgpBVAnOj3CsSpWG0vsgb8tRxxBSGR
	 oJXPsOAHAwCXztn9e8FRKV2R7U8BhNZTSSoTo4iN9XPtkATQ1RNkEkp5YMnoOGvCB7
	 fM15O3qgo98kMXEdaso8i+7cdrxVpdqNz0bmYWnMlImS+zos7bO7K5c4qEc3/pthG4
	 gAZB08cJPygcud3btvVOylhBVJIfvIZTqvKks0qhfVe6usirvMhHEERxUe45dcRZHb
	 RiNpwpVg8or9L0bIqFNiTb90N9jMMvPTjEyz1HmLtKQcD4HN3f6rK2Nuzb0K2jfjNC
	 OWrZTI+w7N9uIKAdihyZBLixgJCC4Dmz8YpBnY7/UZ4eKjCOJZFV5M6IMp1Xf/vDly
	 hHIfifr7Qj9OcZ/bi5i/HOn+zo8dZTP/wF9eMyVMREYGOdTpYdlQ2TNVzRiea1Hcn0
	 pMkoTSKczZu/VIeZfwIeh6v4cBUHuvSP36Fl3Y/LIQdwCiJGjAl4jqWZSdgKCjvqMq
	 B75/AP9VNTOz7hchWG6T1VV/5rTC9RVc5u5YBnItyZq7XRVKWwzxjdohXCLpB+qg3u
	 AqX9Jwoo6mW16hKBUDsa9MbxP/Oh050xk/w88U1mjCowcH8KW79iKAog7M1rgUy5FO
	 JPuMNeBKZ7RXBwHmzKfGoO7U=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03A2B40E00DC;
	Wed, 22 Jul 2026 21:23:17 +0000 (UTC)
Date: Wed, 22 Jul 2026 14:23:14 -0700
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, dave.hansen@linux.intel.com,
	Vishal Badole <Vishal.Badole@amd.com>, mingo@redhat.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
	wei.w.wang@hotmail.com
Subject: Re: [PATCH] x86/topo: Map vendor CPU types to generic Linux such
 types
Message-ID: <20260722212314.GFamE0wsvHL6eLvTjT@fat_crate.local>
References: <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
 <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
 <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>
 <un5ex54iuszxdubdkjhhtezk4rqkgrzrx4ewgu74id3n3swkyy@hh4df7yq32ox>
 <20260722195105.GEamEfKQIPgWp4HiBk@fat_crate.local>
 <bpncabyd5x7q2niuopingb4ztimoxz7ldw3mha7yntyq5mbsyb@5qjrfihupvym>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bpncabyd5x7q2niuopingb4ztimoxz7ldw3mha7yntyq5mbsyb@5qjrfihupvym>

On Wed, Jul 22, 2026 at 01:57:57PM -0700, Pawan Gupta wrote:
> Yes, but my main concern is about addition of TOPO_CPU_TYPE_ANY. If we
> don't add TOPO_CPU_TYPE_ANY, second patch will not be needed. Sorry if I am
> mis-interpreting things.

Well, I have no idea too what are you even fighting for? It sounds like
a giant waste of time to me for something as trivial as this.

What second patch?

Once the cleanup is done, only one of the two will survive - either
TOPO_CPU_TYPE_ANY or TOPO_CPU_TYPE_UNKNOWN. I'm calling the former "ANY" to
denote that it is the *same* ANY as X86_CPU_TYPE_ANY.

I don't know how else to explain it to you.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
