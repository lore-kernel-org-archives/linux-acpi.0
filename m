Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712502;
	b=WvSg72QBqqZ1YwWa7CJdbCdhgr0FgpJCebSwBvliIkk4g3bgBsGFYdcjCbW5iO0GolIL
	 Q/QLNi9VHKyJ5DcjDjKRGsgiOE8QS+v0TibvRFe6QKsNQfxxm2ThLixVAX9EsexcBASmD
	 oKt4bVi6Uis8ZabYL9dL41Lyj4A+z2SYD4m4Pou4mlA04dyJjK1pQm0qM/+SSDFAqLSlO
	 wvWe8dN4VC0Zhs9thYuBWQPAoB5tdX4VQkupB5vtMiwV0HcsJir9YEfT/pHArtYQCb9L2
	 uf27TO+FiHCLVnNYY8A8n+4iKF99DlF5ftlv1bjDPiVquPCuJIN5jmVvmWVeSoy/Reg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712502;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=NDgIv6UYvc9qwtxBmUUaJp3oAg3smrJXrxrca4tXtdY=;
	b=cA01MMHLxyiEEV0nhD4R1Q8GcyxojEIHMcBjB1y34sIAbzyw4ne5x1cskIYWwRgxpLIX
	 fpL1/TqBMD7MP3jmof33rvGKNklbDnBANm3rsL9O8OlVPBcQAsPg7VkSgr20dJUUn92Ya
	 xeEn8VewIZnPNuvwHga+WkyabLSK9XcF9GWMmM6i2uSZTnQTig76/xxovBLEBu0WC/p49
	 X8/F2AwF/ll88PNu/h+p9awudISxq5fqWdbm/scMTMQeq5+S33dn66eaeLfIZJrSMXcSA
	 OZh3bWMJwDyiSOgSJu+hC5OvyCioBk8+W6yeBxvZGlG4AMtfdWJo5HyC/xQwgEi3WGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=FSdPQNGC;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9171606A333;
	Tue,  3 Nov 2026 13:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9171606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=FSdPQNGC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NDgIv6UYvc9qwtxBmUUaJp3oAg3smrJXrxrca4tXtdY=; b=FSdPQNGCfV4aVTesRwEzLurmlm
	usLxxffKobDjmJ+LekR46PmHP4/v8aS0Z7Skr8y69WKBMZN8Th8DeyButehHqPaI+P0wHsTC/7R6d
	xFvDEM+k8HxY//20K2p+RtMXxtsdmhwnrYdpnQEnlVP6TNHscajiktLUWtUuklR0BNXUPIeGtENrM
	o2mB/ObKaRj1YH6KvkHMlL1P2MqBrY7xxNl7teJzEtnra6ufE++6dzh2th3A4GHiwY4Wg9stEu8KE
	QMw28pcdZki1WuxYA6V4EOIWU0NrGnYkv4+F69wz7X4N3ETUaqalORFMxYiJj90vFS5//CqmldXkc
	W9/+6W0g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOEYj-006xtQ-0b;
	Tue, 03 Nov 2026 13:28:17 +0000
Date: Tue, 3 Nov 2026 05:28:11 -0800
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
Subject: Re: [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
Message-ID: <aunhSdekC1oRRXK6@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-5-pierre.gondois@arm.com>
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
In-Reply-To: <20261019203915.2019037-5-pierre.gondois@arm.com>
X-Debian-User: leitao

On Mon, Oct 19, 2026 at 10:38:43PM +0200, Pierre Gondois wrote:
> -static int ghes_edac_report_mem_error(struct notifier_block *nb,
> -				      unsigned long val, void *data)
> +/* Caller must hold ghes_lock. */

Is it worth adding lockdep_assert_held(ghes_lock) instead of the
comment?
