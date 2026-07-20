Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7163998BF;
	Mon, 20 Jul 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543344; cv=none; b=a+PGEG7ZcDVCb7Q2LZO924mXjCTdZG3mqwMNi/gO7cdtY98Rv65VSjAeyQPkGXhGmtooVxxoKxyISXD4hHmuMKAPWI8xwWC/AQwDLYtNwo0JQVo2Vla+/mbFP1/e60+IBYOvu1Dey5eSpQIG3lveUZFczsFk1RQo0Hpen2DZDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543344; c=relaxed/simple;
	bh=oStq1SyDJtC1T39C/pkQ4yFUo1EyJXJmt0vK3oyvDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdJnLis9BvXEao2g8wzQfjYsDylvWb26pF6l27lWucd5xeOTp5+zU87E3F2nnInKWDobPg/QxEK5kn9ucvXj7fwpsxKmONGOume4JKTfRPJUOZe4u7CL/0tydQ95jfbhycBtXx6eIcdKLmF3YJfmOrP85fGtpmWBVyii2n8QSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Pf3g4cXA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Pf3g4cXA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=kN4cC/bOjAkP17ys9nqWJLj3dIHXS/dxpUOm1g1CFEs=; b=Pf3g4cXAXr/g0s7OsHX77p7uV7
	9tjNMwNhx2v4bx9VsHg4k6Ye1MAqoQOedpVvFJL8sWD8L8ozrQstroFUWYoT7qLcVoeDOtJ9Q9YxZ
	rJT8ARXgdW97Z/oLP45uvuMRcuQjeJijYJR9ebH2lECKWYfcsMU3wDXeWD/LKyYxaxFceXOBG9y5w
	iCqee1XbX0FBoGRToG6WYAEwJwcZ9midh0DYAdSk66yqXn7OIYugA1kJmOhyM3Wd/1llIAWMKwxHz
	JNyw+ei3BgQ8hAOfVlaDdZGO1+NxiOL6Eq+ty5uQmlMPMrqt1k5SaWs29ynI2lup14/7iX/tS+hPF
	EYPveIGw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wllEh-001N8i-0p;
	Mon, 20 Jul 2026 10:28:35 +0000
Date: Mon, 20 Jul 2026 03:28:27 -0700
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
Subject: Re: [PATCH 3/6] configfs: Treat attribute structures as const
 internally
Message-ID: <al34Puuz4cy_3zXh@gmail.com>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <20260716-configfs-const-base-v1-3-c545a4053cb5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716-configfs-const-base-v1-3-c545a4053cb5@weissschuh.net>
X-Debian-User: leitao

On Thu, Jul 16, 2026 at 07:09:28PM +0200, Thomas Weiﬂschuh wrote:
> The configfs core never modifies the attribute structures defined in
> driver core.
> 
> Reflect this in the types used internally in the configfs core.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Breno Leitao <leitao@debian.org>
