Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0E7081A;
	Sat,  4 Apr 2026 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775338370; cv=none; b=ooVTCErBx7AcIjliJIsdlWh2DmtbmG2g47IXk4yrbknsmqyqZWHZJaqCp/A6KZuVnMEdNl+mM3bf0XGZoZ2kDJZvQmuP3XCoLB91oAV2LELzUykms+LmwW6XSemZiDsNJ2FLVQkQghBJxXzP2hnb0R/TeEikKmaCucqquL7LLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775338370; c=relaxed/simple;
	bh=oRjykBW0nT3M7SQsdCKaIp0YZUGwZd6xq9NQz3ck7w8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UQJaswJo60BD0y0/q+nVmcpWGLJGIjq+WxNhJ6plqG4t4IdmdZl1cWSjyFzt/WcDm+VXc/SxrllQSKyYNrx6MSpZbC9CCdWYEq5Q5k/XT1bjKrFoBNUZO0+wym+fHWIQsA3fvAIKLleCcbG3CdiCqilL08Ww4mUy4CsgKm/ev2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqh80IFk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqh80IFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF32C19421;
	Sat,  4 Apr 2026 21:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775338369;
	bh=oRjykBW0nT3M7SQsdCKaIp0YZUGwZd6xq9NQz3ck7w8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Kqh80IFkFKMvH/Xsa5aaoZZSHljbfx8sBNofoUAWAp77E0nxjGy9E9lE0H6smJMVG
	 gX42Ls2HAO9T0WoYIwuTgpDfh13xmSAmjWMub6Q/skOUEGH/CGYL45Z5FQ+HmCPtFT
	 jby3Axs/q20tqee7uhXK2XvxVB2VoG6FxAAEK6R+libS2677e9S0QVi5q/1FBdUJCY
	 Wnv8on0ipiZMsc4kuE3Clyrc6QbCxSEzaTcN3NuU0cuNk3aCzkKmsbx4mYU0X1kh25
	 Jft7ew4kv1KZg/H+WkNW1HyeZ6cfTZgCKIm6X1qU62iBDvoclRR4vkBtlM2eSp8+7I
	 DSYG7cIQa6D9A==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 23:32:44 +0200
Message-Id: <DHKOXDNO7MBC.PZK5N30ELOCG@kernel.org>
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
Cc: "Markus Probst" <markus.probst@posteo.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
 <2026040124-unbolted-timing-ce25@gregkh>
 <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
 <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
 <DHKOQBER5U5N.IHLHH5ORAZCQ@garyguo.net>
In-Reply-To: <DHKOQBER5U5N.IHLHH5ORAZCQ@garyguo.net>

On Sat Apr 4, 2026 at 11:23 PM CEST, Gary Guo wrote:
> BTW, if most drivers use driver_data of ID as pointers, why is it defined=
 as
> kernel_ulong_t instead of just `void*`?

I think that's because the ID tables are exported to userspace via
scripts/mod/file2alias.c. If it would be void *, then there could be a mism=
atch
in size when cross compiling.
