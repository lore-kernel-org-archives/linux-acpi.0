Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4C35028C;
	Sun,  5 Apr 2026 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368059; cv=none; b=GPOYLpN/geTdQv02gqJ1ufAKccwHOA3MT1A6hg4hdNU3D82ugx07zG3IRG67yjXE28AbRfVOaoKjdkeKGCN7dxHXK4Ks90L4paJh/2HTsyo2kBzylBCeEfxYVToRQUJNY+ru5SfG35l5vUR2M0xpv5r3C7cqA5FnsFDbdsrbefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368059; c=relaxed/simple;
	bh=NK8JjZnHJ4/O8IXkZDusrAyD7dFWkxTddsoeyi8rEe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axi6f30xA5I4JYVjfTr7hROD7uCnJMk4fAZxseL1BNcD0BBHMx2CxzDeXAwick9PGKly9TM7RKwM5ri2fsc6XXNy/RUXW27PyHpNPWKEc6CrgXxdaE9QOiGGx+uG9+f0gQKL7jHLAY3PgcYVEyyPeID+IsP2a8NLkyTEi3Jch1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJdrsKQx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJdrsKQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F775C116C6;
	Sun,  5 Apr 2026 05:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775368058;
	bh=NK8JjZnHJ4/O8IXkZDusrAyD7dFWkxTddsoeyi8rEe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJdrsKQxL6+Z9hRZN9f7wuK7ApgYzrJ93WQTGcbml1yplRt0zjrnqHMhYIPqEr8ej
	 4tdmYG7B0/HXc5xxp5GzIUmc/ksqbQfBrvwUBvACT5N1y19OPztkihQN8cKLQwGGw2
	 gfiYUmB0NYk2Oxbv2bWY24mdwOsBPP9TToeRV15c=
Date: Sun, 5 Apr 2026 07:47:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Markus Probst <markus.probst@posteo.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
Message-ID: <2026040502-monetary-mammal-667f@gregkh>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
 <2026040124-unbolted-timing-ce25@gregkh>
 <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
 <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
 <DHKOQBER5U5N.IHLHH5ORAZCQ@garyguo.net>
 <DHKOXDNO7MBC.PZK5N30ELOCG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHKOXDNO7MBC.PZK5N30ELOCG@kernel.org>

On Sat, Apr 04, 2026 at 11:32:44PM +0200, Danilo Krummrich wrote:
> On Sat Apr 4, 2026 at 11:23 PM CEST, Gary Guo wrote:
> > BTW, if most drivers use driver_data of ID as pointers, why is it defined as
> > kernel_ulong_t instead of just `void*`?
> 
> I think that's because the ID tables are exported to userspace via
> scripts/mod/file2alias.c. If it would be void *, then there could be a mismatch
> in size when cross compiling.
> 

That is correct, and is why it is defined this way.
