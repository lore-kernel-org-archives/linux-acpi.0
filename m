Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9E24BD03;
	Sat,  4 Apr 2026 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775338690; cv=none; b=BfjEgI+Sp1+qUr4Od60nctET5Z2HI3Arqi2aScQa4CMFtke8vQtymSfBTHENVDKmDwkr+csbljtpURvlwrK3TS0b9rboS8JYPff/tTi4iY7RAGGOqlY+QoJjFSxAg9tJHOsT060tMAuRgkIIXCgHf706DhFRsA+Rg+WJxpZ+Iko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775338690; c=relaxed/simple;
	bh=wLpBt/QX/r8oCObXcLOY4KG40GlrwoKJR9emN11HvSs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fTikTXqyrdQduffZzqUtadp+9cEjyxgoccqoMk+tm1fKjFtiluglFRvyO29hDr5nslZ+OwQduci8jNEa64d0h1RHcfXtiu8aCkNywi20DGp2LrSG8oxa+oiy8e7Q19/8iz5b7Y9Jk+73v9ga7cCokM/Mk4qWmnLsd3+mPy++Yqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm2IBXtD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm2IBXtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A032CC19421;
	Sat,  4 Apr 2026 21:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775338689;
	bh=wLpBt/QX/r8oCObXcLOY4KG40GlrwoKJR9emN11HvSs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cm2IBXtDKhYoSXNWn3ByJBDlPXCEWkLKM4mUWgs12aEldQbLgypRykbbLQ0LAVAKy
	 ZaEPE7GlJQue5eMUkZRDnm9v2QKA/k0w0+4gS+wi3KdoskbctQAD9/iP9KHJlEaot0
	 9xlOx5UJ/XsYbuZCCc5RO6bRsd94Js1qU+83SYh1fMpdCHk2taQTNaSP+cPT3x1uy9
	 vVZrkNFpkzkUoWDedS85EbQrmfesJY70RPkQBoWRdGHjjYrb68ODOto8+abBdxMNdh
	 4zplW5FZhjKTJL4IJg4EP76ZwcLV3e1p2RlPagEVaVhDdevLhL3KP8l9glVj5vSg32
	 t8glYCfe09HXA==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 23:38:04 +0200
Message-Id: <DHKP1GMJTKQS.3EJRADTILHHOS@kernel.org>
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
Cc: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
 <2026040124-unbolted-timing-ce25@gregkh>
 <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
 <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
 <DHKOQBER5U5N.IHLHH5ORAZCQ@garyguo.net>
 <398ba2627148b9224ed41d383c906ca23427986f.camel@posteo.de>
In-Reply-To: <398ba2627148b9224ed41d383c906ca23427986f.camel@posteo.de>

On Sat Apr 4, 2026 at 11:33 PM CEST, Markus Probst wrote:
> What does this mean for this patch series?
>
> Will it be merged in the meantime or should we wait for your rewrite?

It will be merged, but you may want to adjust the changelog as asked by Gre=
g
first.

Thanks,
Danilo
