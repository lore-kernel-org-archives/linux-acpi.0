Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710DB34F462;
	Sat, 18 Jul 2026 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387600; cv=none; b=pHNN8Eymt2xQsGfSJN069ECxLMWIdJHnpHQfpH/VS+Yj0z1U754AeUjUqn6JF2rNzFEAUrVzoDN07BMWsZYOJ2YmLcTlmCz5kmfuN27bcycwVpILdEjxfPqBeMGNKZAFPdYaXACE6QpQNYcgsMb+998Zhr7Ikbwod03j/6EE55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387600; c=relaxed/simple;
	bh=zmSTHDG5dlhEU+2vrT6aHm5ztcDYyoHrvMjt1+4g9eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF73YWtL1/lydlGsQgzxKrAWRyrKYoBbrp8UDSXAvLC+QOd0E2QkcYgV+iKn3v5GC6aCjjOPWkYHGpVR2Ng9/5DeZzkL7p2GKeud3Kb6Ii2o4uTkmyxVyRBsSuMMM5FHIwtCJX3YoRN6HVpJY9u2GK5ugikBtPlpOhDroi1zBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MdDV8tCy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MdDV8tCy"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1205140E019F;
	Sat, 18 Jul 2026 15:13:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id etNWueav3Hj4; Sat, 18 Jul 2026 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784387584; bh=mOrxs76HcHbX8sKHP7kCOZuuDQ6BQh8pFNy4vBZ32ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdDV8tCyIrc/n6jaUatPzyTzBWQb/RKhtI/z1mMo06tAhtU4MkgzC6B8YquVw6I+H
	 z518171qYK6Zjwj+onG0as18Xhc0FaslgvaJbxErGrLBYApCInYLK/OIJL4jnvEUVb
	 Nn2QRqIT2pamoM5rOgcVmDkkKHeJ0TCQt8zxvkf40ekYWHKdime9ymWPxXXcVuzGCx
	 W5Omqwg1CjPBj7dkxlpfXrU7U6hqpw+ytGnx4urDmAAdc1VCkiJmeZJ1fAgNUIbfEU
	 EyKcL7+0mqmdmud0Kb64RzDsoXtcH3rG8Z8AT5OGyi201Xt/gIki85KUIkS97MOCir
	 FgaBn8slnshBli7b6cMqh61yveSHqrpUeo5WCnXpP1a0r7q/x61c299XI6TjI8HeAk
	 DoGHMgqHKymHsI+n/6RMsZ374zeyh/BoCtrRbviSNzl+oEhcTjrADjQgQc6Qg/NNou
	 BJu+dNWvJseO3QFqnDjv2wLzmmTU6y4StMoh7ckJ3KysahDXIv1omEoEyX192pHZqr
	 fY+yHHag31RP26tqLT6qHp0p/luRc++rsWfWTTo5j45CfHZGOOr/DoBEsmXrT3d3lB
	 OtSZqKuylz1TkUtTlrkasuuFija5i2PnWEoafXU8lUt+S1bzIIgYoveqM7iLdoiu0/
	 1t5eJeRkq1y36ZoLqcwW2vT8=
Received: from stx.tnic (unknown [12.110.208.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53F9440E0031;
	Sat, 18 Jul 2026 15:12:27 +0000 (UTC)
Date: Sat, 18 Jul 2026 08:12:24 -0700
From: Borislav Petkov <bp@alien8.de>
To: shijujose2008@gmail.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jic23@kernel.org, linuxarm@huawei.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
Subject: Re: [PATCH v21 0/2] ACPI: Add support for ACPI RAS2 feature table
Message-ID: <20260718151224.GBaluX2N0kM11Wb11C@fat_crate.local>
References: <20260706000338.362421-1-shijujose2008@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706000338.362421-1-shijujose2008@gmail.com>

On Mon, Jul 06, 2026 at 01:03:36AM +0100, shijujose2008@gmail.com wrote:
> From: Shiju Jose <shijujose2008@gmail.com>
> 
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
> scrubbing feature.

Sashiko is asking more questions:

https://sashiko.dev/#/patchset/20260706000338.362421-1-shijujose2008%40gmail.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
