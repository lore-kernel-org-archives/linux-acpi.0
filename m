Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75692ECE93;
	Fri, 17 Jul 2026 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277792; cv=none; b=LrB01tlcsVxCh0Ct+aHsCqp1u1E9PNssCGN6Fkq58iGuvxfFrtbI9TIroAXS78xxPW9QiyqUXGG9w/SMN9DjsWlL1+On4dKi7cfrOPnHcqG7rvZcxnm9fIh7iPPTE4oYfNrJ94VgvsDiSO2c4HqL0AEIjbkeSuv19YH3zmSn6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277792; c=relaxed/simple;
	bh=GLkmRUcE0VHnwGjsz6YNCNFm4msWad5Ar3LYq86OZ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWz7bsM6GIzXxiU22Te57JF8M9VVX8QG46sknjOEtpT0VlmhYJLkLX6L9IwVhxSu8K2DKrylt64EfqJV4hJIrxuhY2WfnhViF4LPTE91rbS5KGAA3ZCmdycMG24QK9oicqojZaK1cu1fb895TqVUTO1/9QnZ9HA7tfYszH05C08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ufc1GRaj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ufc1GRaj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=B83D+jF4SGuaxMDcd9EbBbuj2TpoK4d5rCxDGp71roU=; b=Ufc1GRajEB4dSl5CI1TBmljZep
	QS8O6U9rPmK2rJ6dQ04MZV0Sd3m15FA8sinPRXCSl0syTU7m5Bcl3ae9682+BJT3tLk3i2YPCtgW4
	oTrxPnK3ZTEji+FEFfqse71PZlmvAV1/I/HGkijQNrqfEHwG650dV55NQuQXyTIcsQ0zAO7wG3ima
	zA3DeqdhVYMOeckunTELci5V/Qz+Q85e9GMjZG1xVB6szOwBCs0ha26GTY3vofEvpRe1F1CpHAGQy
	FMwyL99bhUDX1+SHf4xlQMXBlLXjF4E4rdAo1eNfLLMSoSWDrDGit20rgIBa0ZkOTMIH/T6yWgLZ4
	P9PaWLCw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wke9O-004TLa-2T;
	Fri, 17 Jul 2026 08:42:31 +0000
Date: Fri, 17 Jul 2026 01:42:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 6/6] samples: configfs: constify the configfs_attribute
 structures
Message-ID: <alnq5X8BkMGF8TB5@gmail.com>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <20260716-configfs-const-base-v1-6-c545a4053cb5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716-configfs-const-base-v1-6-c545a4053cb5@weissschuh.net>
X-Debian-User: leitao

On Thu, Jul 16, 2026 at 07:09:31PM +0200, Thomas Weiﬂschuh wrote:
> To show that the transition machinery works, constify the sample code.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Breno Leitao <leitao@debian.org>
