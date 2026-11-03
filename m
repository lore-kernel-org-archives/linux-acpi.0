Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712407;
	b=fNECTF8qYmElJVJbzWHnb4eA6ZkJnbLjAymMEEWANz2JJnm6/CfiOAb+XNXT+i76OZbw
	 wWLqcovwZsGh/aC5bmz3F8YPwmXosT/uZU9Yfp6swWrhJz7ZotRpD/yb38jUCbyv7ILzK
	 msVMiokGsBlrH2Z5sGORCbbnRi1ZUz5FHaB4BkxJrx9q5Oed9i7UgwSopQcL1P3/nd8lk
	 cSk5V6P84IrsAYbuC6cu1LW0V4RUrleachiir6Za69EBNQ62fGngWO/wROMi2EWGeUuxA
	 Vut7NgRE4Zjc2rznv/HrXuW+b8/SK5uNFmsJ390CyShN0bH+QiEIbxJwuBMjh0Vrumg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712407;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=AGXCI024FcFgr9dz+t2RerRxCTBamIMClmZA1eWJSA8=;
	b=ahqiSYVqUCRxV15btP3EHlQkqWF9M/Do43OEo9mwsz7kEnnvXcDZbjO/rvt8y3caw93H
	 SfFH25fqYPuuvU86HdYZzwxhVFJvWgvmQ4227GmnaHt0PLRmTGnKB8+wYnft7gzkldtxw
	 QSblD11yl8k/zU5wFwUkLz4Nm6iJ976GwsUPZ0iHqYwM3f/rQOdmTf6ku6mauw7OcrUtN
	 cDV6W03vZVe8rK/G+fHepSumbR21OeHKkOAKzpFmQX8g6jqManx/cQRDHmLJFzhcAvw6E
	 VLn83UgWXAlVoI712PofqboMHktMkZnxQWS8/sUTxZJ/soeTldzrATMgl6lyNkfbxew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=PW4fPOJE;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72164606EE87;
	Tue,  3 Nov 2026 13:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72164606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=PW4fPOJE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AGXCI024FcFgr9dz+t2RerRxCTBamIMClmZA1eWJSA8=; b=PW4fPOJEoDuZNVvhol9JJJ/T5f
	fIDfyBoLaqCsPSFK/2kc0rDRaGvun6cyvb9Jat6YufpPkbvN8pplQOsqG1oNI+YfzsRI+9/yx6AVx
	5Bewd3vZg4J4aI0W04PQP1wclKq90V4PN5p7VbzKXgKXfazLWqfYfxBpjJHW1n/YQUz+O5MRP9MAj
	RR0BmfJkWYZu9EFCxPfKFjLyxItZ8HdN1A3xerpkFUp7vwhFg22/Ld2v7M4RjP1WNsn5V2ZovAVzt
	hganEqBZ92iwsMW4Xw/QAFGqhr98SDeEafc/dolClcagl5Y3Ern3oGLt7k8Y7s6fBiwQqN3hfm3yh
	xyM+zkkg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOEX2-006xsL-1a;
	Tue, 03 Nov 2026 13:26:32 +0000
Date: Tue, 3 Nov 2026 05:26:26 -0800
From: Breno Leitao <leitao@debian.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, 
	Mark Brown <broonie@kernel.org>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Pawel Chmielewski <pawel.chmielewski@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	Dan Williams <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Morduan Zang <zhangdandan@uniontech.com>, 
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 1/6] cper: use BIT_ULL() for processor and memory
 validation bits
Message-ID: <aung9yu4GRm1IpTW@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-2-pierre.gondois@arm.com>
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
In-Reply-To: <20261019203915.2019037-2-pierre.gondois@arm.com>
X-Debian-User: leitao

On Mon, Oct 19, 2026 at 10:38:40PM +0200, Pierre Gondois wrote:
> Use the BIT_ULL() macro to describe flag bits instead of
> hexadecimal values which are harder to read.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
