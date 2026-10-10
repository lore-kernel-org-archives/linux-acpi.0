Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D22E7631;
	Sat, 10 Oct 2026 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610347; cv=none; b=Kz4lKrAU2bPGRiKwaXNuDZvUnZxBgcQ1RibmnPL57frjZ9KciHu4+ZPXfog26m6hc3RLl065W2poqPPkHCGam9zUe76HSwtereMv4Cc2BraMMNOyZfuRnh6xO6GrV5v54SzsB/oVfuvFLWE40GBx9jETwP+KXfuZAtb7W1JG7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610347; c=relaxed/simple;
	bh=tXEuKuDMAjKduqabvyZJrAivaXAocQMUFJtmTYHSD5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba2UC4C7rC0RYLxIKrXFOzQ9O1rNynhCsqU2FcKsk1hnpUEmZ8m+ZbL8F5pmTehGDcw3p05pZRd+Jo4EMTyJYcEv41Tvt9lqZTa6p7Ws+s1vc55n2zItjMg/aZXSRkXsvhLxj7k/QZKHO6fGrGhoR0Xw4y2cLl6eLEQv32iBDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Gp26fZgk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Gp26fZgk"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6644840E015B;
	Sat, 10 Oct 2026 05:32:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id evsV9KfxQqa6; Sat, 10 Oct 2026 05:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791610324; bh=Gw/kyRb+I+cQspkN55V5Tk4wVCFmcxk3xrSp2odCCKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gp26fZgkP+/9ZZz1XSoWZdRaBjjCRjOdLXr3z65wIq0yyJg5xr6wE6RjXiMV7d5HT
	 /0jMreLhA20VOLERGtpfHKx5vZJeBA3sVGQtuvgy9t6xT/XbLx7hSQ7afTb8pbDpJs
	 q4bDISG/lM95NTq60p20NxutmMYxDnkkf4Ny/0Z1/GXBu8czrEM6ABU9DB8Fo6YagG
	 Jkxy024LZicrA/Xub//Q3cb0LRp4ESxb/GAbRXW0FOwuMsHfyuU9vXyu02SSB+aSh+
	 OY1Fd9QNevBkNLYynJcylL2JRZI/q98QpAzAFkMTQS1uM9/jnEZmVL5mIIXnlRyguP
	 6wwhJpVi2rAuNPuQmqP0kF59Vp+cPG/pTDC+Pd2RiYw8ApKmC+PjavtFrw8C5XfJHs
	 XVBgbmAmBkdFNN2RB9iq0H7d2E4D6/dELTD1KX8a9e9zZfMDhugKZmNm88Q6QD+EA8
	 VCHL+TrUad9EXtIO8YW0Mn+nzrN363/8A++Ri925AMuv1Z77ZRKCivduSHELyjEh84
	 83vmnNnChEPuSxA3ylYCMd0ZbMB3GNoiSKYgiZ22db3umb+BKSloCUV9ugl4UKV4w/
	 6KPf9EvuJobcqtWYAjNeH/RAjyXIKHskBK2/T85lCZ9tFw+FVnreWWUc+HPOVRxdtb
	 zUd2RGq7m5VxBPkKpZihx+aI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C19A940E0481;
	Sat, 10 Oct 2026 05:31:25 +0000 (UTC)
Date: Fri, 9 Oct 2026 22:31:22 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sathvika Vasireddy <sathvika.vasireddy@oss.qualcomm.com>
Cc: Shiju Jose <shijujose2008@gmail.com>,
	Ashok Raj <ashok.raj@oss.qualcomm.com>, rafael@kernel.org,
	akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	Yazen.Ghannam@amd.com, mchehab@kernel.org, jic23@kernel.org,
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	ashoraj@qti.qualcomm.com
Subject: Re: [PATCH v23 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20261010053122.GBasnNqq7PmQojCDaz@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-2-shijujose2008@gmail.com>
 <20261005235021.GBasQ3vXTivT3NLbBq@fat_crate.local>
 <asU7svV8g2Hb5DZl@hu-ashoraj-lv.qualcomm.com>
 <20261008030603.GAascImzt4cv8Gz49p@fat_crate.local>
 <CAG4KcRLhN9=6xeT4qfqKLFdukiZLUc7akGcWwXJUU1-qrfxTUQ@mail.gmail.com>
 <20261008174114.GAasfVutvsmAk8JGsD@fat_crate.local>
 <CAG4KcRLx69BK+aw+exUzPe+BW8exFM2LLvN9pEr-+1BoGVhFXg@mail.gmail.com>
 <20261010002159.GCasmFJy2F_2S22d4Y@fat_crate.local>
 <47c79d45-3545-4f06-b26d-000d8f3e9a4a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47c79d45-3545-4f06-b26d-000d8f3e9a4a@oss.qualcomm.com>

On Sat, Oct 10, 2026 at 10:25:22AM +0530, Sathvika Vasireddy wrote:
> The tests passed with the new version, and no issues were observed.
> 
> For this series, feel free to add:
> Tested-by: Sathvika Vasireddy <sathvika.vasireddy@oss.qualcomm.com>

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
