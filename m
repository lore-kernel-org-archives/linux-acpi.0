Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712732;
	b=2/WRzCeWsuUYoYHJk1AI0NZ6kL9mlFH9S8CcDBixAGQUuSpw0eROb8g2lcyapQ22ObbS
	 oYUSYYvK9nni2yRHV0i5IFY/XjkrkrP/ju7tQcRvVsiEvvVDw4v9rx3DEzbwr51W/FaZu
	 RyMEd6gHGVb6fOAvxiKhwp5aVdnCrlXla4imgDjnf4N2cSzGj0e4Zm2VKG1pSekV5aWW1
	 75zcQneapLjT+x5NDxyPflU7FQTg7mxXejIjqz8S0G5zVBjE4yBLrp6YtpDoBAcKLfaZ8
	 DlnSICKYPcFzchHekQAfe1lUVZCjkCmiRYEJzwVFiOWpBYSnuNNNLf9GW1BDITevGzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712732;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=adeIKc/Kab9bfJWFhlLNF3YX5iBhTAyFrVHwdnHONcg=;
	b=2JatI7OCFAVNMNU2oPux22w4BH727Thu9EoArewsdDiSrMMS8F/TqlCPbOLLVb96RHXd
	 D5HJRUF9bIwxhj/All19Z2Ab7DI9LXY3D7hdpoXfR8rRvXEl+hp7VQlDU8O9NLP+il6OV
	 LnGXb1Py3mALM0ayyd1i0lTEq2sDen6OgIU2NSmaey6igdHvTV9gDTc941ykIdAnaH5fP
	 5k/Ypkj07r7a4QLewDIzsWgSNGO+Mi4MXMdkdEWYM6e5x4BZWKuNE18iVpdalo9P1VSUp
	 ZNoe9TAebGBH9nET3tOb13M+WGGfXkh2LVagUw3Zl347C7CWXtJUqrBWiSJV7ROvl5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=J0ZhUUXc;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50021606A326;
	Tue,  3 Nov 2026 13:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50021606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=J0ZhUUXc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=adeIKc/Kab9bfJWFhlLNF3YX5iBhTAyFrVHwdnHONcg=; b=J0ZhUUXcZlMzR9/Bw2rDLAXojW
	Nce19MXaUalHS33FsKwlc5uyA8jtoeR8HO5tf18iWeWr7tw3mvIUAlzkv785yLWvD2Rwx4OcfXT8c
	IwkNKPbz5USOgRvi5IDI/AdS7x7F22F8KEtv2YZo7AkAD2TKoWqaOzwuBb8pX9I4a2L4iSpvvvbaZ
	jFshhpsoxETWLx78xiVnLq2wNJBBibokc7Z0Qtmr6FGZ90dHtBnojT8NAnKlpAJawdR/CyfwgZWsm
	BFEZYapoeevePxtVZ4bqpWLyLYqUxHpYWwIJNKdC/0UxQmeuxRYXNbkrb1ypbbSzE18ecHHzq2eK2
	ucj7RchA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOEcN-006y2e-1U;
	Tue, 03 Nov 2026 13:32:03 +0000
Date: Tue, 3 Nov 2026 05:31:57 -0800
From: Breno Leitao <leitao@debian.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Dave Jiang <dave.jiang@intel.com>, "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <auniCTG2pbFkGLXT@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-6-pierre.gondois@arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019203915.2019037-6-pierre.gondois@arm.com>
X-Debian-User: leitao

On Mon, Oct 19, 2026 at 10:38:44PM +0200, Pierre Gondois wrote:
> +static bool ghes_handle_memory_failure2(struct acpi_hest_generic_data *gdata,
> +					int sev, bool sync)
> +{
> +	int flags = -1;
> +	int sec_sev = ghes_severity(gdata->error_severity);
> +	struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
> +
> +	if (!(mem_err->validation_bits & CPER_MEM2_VALID_PA))
> +		return false;
> +
> +	/* iff following two events can be handled properly by now */
> +	if (sec_sev == GHES_SEV_CORRECTED &&
> +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> +		flags = MF_SOFT_OFFLINE;
> +	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
> +		flags = sync ? MF_ACTION_REQUIRED : 0;
> +
> +	if (flags != -1)
> +		return ghes_do_memory_failure(mem_err->physical_addr, flags);
> +
> +	return false;
> +}

This isn't a bug, but the body is ghes_handle_memory_failure() line for
line, apart from the payload type and the PA valid bit.

Could the severity to flags part move into a helper that takes the
physical address, so both share it?
