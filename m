Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DF18FDDE;
	Fri, 17 Jul 2026 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277854; cv=none; b=M0X/gI69mzz1Zy9zyq+Nqy44S/Zaq6svwXiENU7C8SRPLzIf+QLK9g6qpTmOMFnYyqUTf6eQWl+1Q40BatiZ6f5yAi7Vx6i9mu9H/sNgcKW2j1UnUzpI2YLK0PBMk/wMxsnYW19CoLLdVOoMEJEj9u9rJkBPmmeL5i7RHfynYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277854; c=relaxed/simple;
	bh=RZxDL7PLZm1qkkXCWHc4ex45kHAtDOtOMVaMtL76UaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpy5kFx800577r0ZueZBqZvFwLS3vIkqPS2HccG8T8cViBQD/sDPpyaa0g5rqvOOusoKXvlydbqvyV05KUV9L/gjj2agxMfEct2815xo8SnvZPl6JDmAT5IeCE+oGdgjOUYG+l7IJ7xwIX8XBkSPI6p73kQoxkUX3M2N/py1oWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=N66YOktr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="N66YOktr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=On0L/tUhVBCZkHcpg4iYUy0hWUVH8Ok6jsHQTKMmRd4=; b=N66YOktrtV+6V+16wEELIyghsT
	qd9ZhgIEex7fuSZ5Ej0bfE7aVb2og/BqNzyIzIO2QmGNWTIgJJY835686LzrFJbXtyA1gaYFhMQlp
	hy3SVjSrqjs4sttcnW4pJp2EehrtWDJZfjWxZQamqbJGmaew71niQBX5Aou/ejXzxwBJb5laRdPRk
	QXGGGqj+eBdkqHoCWrvoeXUgPjtPQvc8KeCi86ElcLPzchlXgsdVe4ng2V/pY4lhKeILYHJ0wQMNN
	QoFDU+R9ItAcUdgNMRKQKAdUeZzHmxsuD0gCJyYIiX4uZPhQ9NFUV311K787ZXFM8QZ4ynaXBeHGc
	c7AQNOWQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkeAb-004TMi-30;
	Fri, 17 Jul 2026 08:43:46 +0000
Date: Fri, 17 Jul 2026 01:43:36 -0700
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
Subject: Re: [PATCH 5/6] configfs: Allow the registration of const struct
 configfs_attribute
Message-ID: <alnrJJNb1hwDrAxI@gmail.com>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <20260716-configfs-const-base-v1-5-c545a4053cb5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716-configfs-const-base-v1-5-c545a4053cb5@weissschuh.net>
X-Debian-User: leitao

On Thu, Jul 16, 2026 at 07:09:30PM +0200, Thomas Weißschuh wrote:
> The attribute structure defined in driver code never need to be
> modified. Allow them to be marked as const.
> 
> As there are many drivers which use these attributes, prepare for a
> phased transition by using a union of const and non-const attributes.

How many drivers need to be migrated? Isn't this a mechanism move?
