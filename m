Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9E3EAC74;
	Tue, 22 Sep 2026 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087701; cv=none; b=RelK4ouvXdDW0CMIjBk/7zF2J9WqwSYs1l+pd3mdK9sNgQaaMcshjQ1SviJUvLCvQEWLM+nsaJxvpvYGV69+nf30ASbajS8DOZG65Sq+5Hpie71KJ9Z3lnS7v2YDZPhzG+0tqtzGp+jYdLJE4/zQ91VtuyOFKHXind2wRN7JvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087701; c=relaxed/simple;
	bh=KlbmuMxkLkoxuH6oBTyGHj5Wu5Zm16Y5Kw/5vSn8XIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i958nEEj+knnAz9IoYvTJQOQSNi93pennVhiz+LcnqJEJLQiloyjxtKaGrkgUUvdu4WFqe5Vc5HWhFeZ3hVFCCwXpQiSP2StgYRwlftcCgXOqxC9Q1IgvFw/qvhmL3G5w1J3q23jjo5ODKzrFy0K+NWcvd9WLrBgIivdv6Uy4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhgkK8MU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhgkK8MU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499E61F000FF;
	Tue, 22 Sep 2026 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790087700;
	bh=KlbmuMxkLkoxuH6oBTyGHj5Wu5Zm16Y5Kw/5vSn8XIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DhgkK8MUcycLpRmE6lKgjwUAQSEMQlBlYhu8F0yUAhEOaR3ya3vwei4H3JmHqqqCV
	 yCRLObzvCszsYxMELOFj91Vxv6hQXsiKkVqBXRzKTXgUoORkELo/PnBv7NK2sZLvyU
	 OluB9RoD9ac8FGdL3meQeq6eVCLjlD/h+99ZYq0pUSZ0XUkAzdmpcbSk+jJ8tkaqCT
	 fkgKY8PkKUjugPCXUBb9Yl5q03WyxZtkTSl9ewmIR24j/yJc3HP4CLvRbMp5/PNwbj
	 MriE240BfaQUp5tespqgyhztYV3IGo+Iz3Hi19TIy44b5Up3rRFygj3ijWwPZK7Sbz
	 TB9a3XOMhA9hA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Breno Leitao
 <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>, Matthew Brost
 <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi
 <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Subject: Re: [PATCH 0/6] configfs: Allow the registration of const struct
 configfs_attribute
In-Reply-To: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
References: <bHvLFyR13nE7HUTBaSLSUZOfB-goGIQLnTtXl9nIQ_beVuvnPA2GpKpdWw-JM4MamQAdiSxOnCc_msKnwqqISw==@protonmail.internalid>
 <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
Date: Tue, 22 Sep 2026 16:34:46 +0200
Message-ID: <87tsnh2w3d.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> The attribute structure defined in driver code never need to be
> modified. Allow them to be marked as const.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

For the rust parts:

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

@Breno, will you take the entire series through your tree?


Best regards,
Andreas Hindborg




