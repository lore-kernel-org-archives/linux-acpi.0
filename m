Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD7368D6E;
	Fri, 17 Jul 2026 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276001; cv=none; b=oSq7MaGT0PSNzbi3gDk3r84shCUD0hOfGwo+mheybvbPE6NHu/w1a7+FeUKNUzircOSafZOTihabashxpGi83XVLlytsWHJYCtHBnhC6kziKVzvLYic1nDmluH0lSnNBemFg9ucDJyOBpmLOjC7vM7akjLMruRDH2xvy2lEORM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276001; c=relaxed/simple;
	bh=+kAKX8HqUnVT/agpyyOXAJ8wRu9oesvCUH6OSFzcY1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O17mWcGAUbyd02W2B7OgZIEeXl/pfLyBtg0xL5Ej7ATZ+lXsfRb/gTR6mVav66rxnkSbJrEOtItv4ru4YDK3BXcGPZzUoYhzXrtc95/rU7oYXe1Whhnyw5wX8/RqCqsUDyVW+0jjbuV7ogqBPmVzbDIKmsG6EZ6VNtrk4cvxxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uRnCV7WO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uRnCV7WO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=8MTwBqQy4fwBi+1HxOFe11MYEhXTYtV/dEi31TU+oa4=; b=uRnCV7WO7QwXl/+Ybie6otp3yT
	UDYu2LJzTLZL/TcAO/+HvnXGSc7baE98N7qWYDrn8tmVEtLf2iLuCpUf2V9uLZG8A6Z5txMg7SsbO
	aJ3Vr0JGIH25KLRF8MT4s3OLDDU4Cf4t3AbBjxDV1j8+V/plugcZZNHME3RS71YGpei6npLL3LUGZ
	xbH2w35MIG9MxA4rGpX+aHhSfopcdxbqWTTCrIjKslFyGqPOYNjzlwqgXCxqc+KfAhnGL9/MwjiHv
	6YEQnSMQphTH5fh0tmf2PgwhPgw7N6P4uCOFaOzt999el6kARiFuts5VPvyQx52jawA1gfHp72PRm
	zfbTp4Yw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkdgd-004SOc-0Y;
	Fri, 17 Jul 2026 08:12:47 +0000
Date: Fri, 17 Jul 2026 01:12:40 -0700
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
Subject: Re: [PATCH 2/6] configfs: Constify is_visible/is_visible_bin in
 configfs_group_operations
Message-ID: <alnj6zcuMWR74If4@gmail.com>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <20260716-configfs-const-base-v1-2-c545a4053cb5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716-configfs-const-base-v1-2-c545a4053cb5@weissschuh.net>
X-Debian-User: leitao

On Thu, Jul 16, 2026 at 07:09:27PM +0200, Thomas Weiﬂschuh wrote:
> These callbacks are never meant to modify their configfs_attribute
> structure. Enforce this in the type system.
> 
> As there are only two implementers of these callbacks, adapt them right
> away, avoiding a phased transition.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Breno Leitao <leitao@debian.org>
