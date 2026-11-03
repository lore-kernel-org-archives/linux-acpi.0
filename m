Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712433;
	b=QLFfpUd0GSNoZcADoqvalPmHG4dXpYH4DM5bisGpKEVN8jGTlYrOHX3pvHqfUjEupomg
	 CImcSkoOD7/7WucLvvRSlxA8d7Uo+Ko8KAthAyJ35ioWbjUjkeH92yi2CeqnV4VNuC1P7
	 uZYpI0n2YZYZUmWn77Lyh0w/wP3qpNZzWGvmLBM/lablSHHQyRELsM0aqZAldQvu4r+5a
	 B+EfxEW802sb5NIrvtRnitqFSQJk9hAMHFFxBuTMXpx+gQLCJin//91akrGpL/oxvt7be
	 D7eGN5WcNbUf3oanB0Sba7bzSsrVEy2RcXyJG3tyLyFnBHja5CqWB1efKOn9uqSoy7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712433;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=tha04W+txhEVcN/Yy/5I0Iig4FC6+qwIWalbIdZGB60=;
	b=opOTiwwmIqG3SlrvYT7piU1pwH/MLucGJ61oan2sTtzQvf06VS7De/BTIl1TQiLnFImt
	 88cbvacfzgqh7BBSkdINSwUDWOoxhFZrLAVHhATDnOJV9CIK3Syu4Yy3AnCNjqQjwqik+
	 M6tUzLN96JuG7+jAzjj7SEE8VW8wHC+ZrerDC4TbhqoxVY6igXofeu1qdRV8rAaBUzS1y
	 jjbDOoQl6S59iB6+C2okdMUNIkLx4ay5GsD0bqTh4qp1kipE1cs2J8mjxFSYXKpCzFjJe
	 gEVRHTUUOkz4y8e6WthRSOjgURpY7JE84UW1uaWXHZ9JIlFuCXuFSIDzuCTmee8rQag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vK8Rw14I;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4B608363E;
	Tue,  3 Nov 2026 13:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC4B608363E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vK8Rw14I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tha04W+txhEVcN/Yy/5I0Iig4FC6+qwIWalbIdZGB60=; b=vK8Rw14IFEbzd8jZhMVPtiwVFY
	WBeTL7LG9pJ6CUOvwcp6aE6aYsZbxWDcTUAycjediam1E8ievoMZ0UsL5GC0RLOr5EGzbKWca3W2A
	2HSlNfDPZ8n/qe338/pzVIUPVDBF1swu2a0mhNOXy4pZJAxT18wYVfEPDWChvM9nbjHL4FPLOlnhF
	JpbsMQay3GRgM7vaR70B9lJLlhfYUuM/gRUsC7JVMSy66Ho3LaWnxZUYgfaMfttNJHr1LMCmr5znw
	CQyK8CZpB1URBkKuJ73aJZnXjUCpacO/jyIvlI/r7bVfYjC8g+TxPIOr7j/lQAQtnVVUxPiMiehv9
	pqzzrtdg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOEXd-006xsh-1Y;
	Tue, 03 Nov 2026 13:27:09 +0000
Date: Tue, 3 Nov 2026 05:27:02 -0800
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
Subject: Re: [PATCH v2 2/6] cper: add Memory Error Section 2 structures
Message-ID: <aunhE1aeSfk6YDgj@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-3-pierre.gondois@arm.com>
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
In-Reply-To: <20261019203915.2019037-3-pierre.gondois@arm.com>
X-Debian-User: leitao

On Mon, Oct 19, 2026 at 10:38:41PM +0200, Pierre Gondois wrote:
> Add CPER Memory Error Section 2 definitions to the CPER headers.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Reviewd-by: Breno Leitao <leitao@debian.org>
