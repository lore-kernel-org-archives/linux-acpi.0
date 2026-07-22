Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5629402BB8;
	Wed, 22 Jul 2026 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749901; cv=none; b=c42qIMyg11AZ/F4wwMvRGlNa/tpVYsUmY/xNNQBt4i59dF7jLXBnePpa42uuw2cYyxuTLMk0oR1N8o4QHCenAATGetHMpdExc7E/yQwJaNGTicN8UOIqKKdSWp8MaIcIkwaa68mqESQzBRWYTouWo75aAsiKApqOrWBuydLLHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749901; c=relaxed/simple;
	bh=pmE97SJPLZT82pghyRIB7/c8+tLyBw/aiElz9qE8miQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR4qdFlZpxDNcitq/laOSxM4J6M/Dd9+2a4HpWZO080tQ9vUWzxSA2W6sF2f+PJaGsBpCE3P2x93eTbieesWGQS38lKAdALgEZ7ww77bty2iwtBA22849Co8eXRhNabA19tZ1wZ+3msm24tSsO3/IaS4GUC0yIb5GE+WzdnpDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aGzO+9xc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aGzO+9xc"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FE3F40E029F;
	Wed, 22 Jul 2026 19:51:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XfmcOCvUg5g2; Wed, 22 Jul 2026 19:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784749885; bh=PhCFvcRN4xXgUvcBMTLmkKdZTW8t8om9tO8OZPf7qy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGzO+9xcSSjlP7KwJTVjH8I5IwaKnpi60aN3byzDnVFTADclByfflMJCzc0LqfYDz
	 N036dNzvrm+xDLvudldo5ckQSkY4qlxEIZ1EGDN6pPiYU/ouECBqTRKB+J4ORH6vcC
	 dbkX/8s1GikL/foQztgh3nxBGzIVnG1rqMNTsjmSakRgqMOwO8xkHM9z+eHzKvAH8r
	 OnkVXIyM6vRlf89o6nm9XQKkfZUtX9JfeKnHx2/xJYXc2d+FFzsMjiZECFx/olZBhS
	 QLzwiofATmd5Yqki/AQphjxDOIlcggYEsu4wHGUeqhlSFxasruZT1aS7dJMKbfvm1f
	 3dkMhoUewjjcRuMmgXK6cppk0lJu5LR7u7K3lWFqD20cbM2FTff3F8Ij1i+yA/FiiK
	 TGMSnw9t3cw6TJRo+gUsU5HxFffzcCoW0+cw0RkGAFwP1qfHZgmKGuBLVimZoS38RK
	 vZrM38ya0ZKBUtOq1Z/TJn9rEZTCBIi/HFcuAlJVt5EiQRPxb8byUxdkgQ+mDt23p3
	 /iIAYCgTIuNfnNjE4RU8/1tYAT0RP7dBf5MTnEX7qMgtyyFDs/JY7oll2HBaYFyEjX
	 3uTxfSm2HFX0TuFGPcCvc44GWpvEj5Gsr3hFwLZ/d1im9diyl4J5hHbjddttsK3b/s
	 h20iXPDNwOCPC2T8GFmYcS04=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90DDC40E00DC;
	Wed, 22 Jul 2026 19:51:09 +0000 (UTC)
Date: Wed, 22 Jul 2026 12:51:05 -0700
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
Message-ID: <20260722195105.GEamEfKQIPgWp4HiBk@fat_crate.local>
References: <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
 <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
 <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>
 <un5ex54iuszxdubdkjhhtezk4rqkgrzrx4ewgu74id3n3swkyy@hh4df7yq32ox>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <un5ex54iuszxdubdkjhhtezk4rqkgrzrx4ewgu74id3n3swkyy@hh4df7yq32ox>

On Wed, Jul 22, 2026 at 12:22:11PM -0700, Pawan Gupta wrote:
> Unless I am misreading, TOPO_CPU_TYPE_ANY is introduced in this patch.
> X86_*_ANY in x86_match_cpu() are much needed wildcards, I dont really
> understand why x86_topology_cpu_type needs to carry a wildcard. It should
> reflect the true state, PERFORMANCE, EFFICIENCY or UNKNOWN.
> 
> Between ANY and UNKNOWN, I would prefer UNKNOWN when CPU did not report a
> type.

Because X86_CPU_TYPE_ANY is already there and it is 0 and TOPO_CPU_TYPE_ANY is
supposed to be the same and mirror it.

Did you even read my mail where I explain that we don't do multiple things in
one patch?

> Ya. If need be, a mask of each possible cpu_type can be built for
> dispatching work selectively.

Instead of doing the completely sensible thing and keeping a per-CPU type?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
