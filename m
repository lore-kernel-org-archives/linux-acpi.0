Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9363F1675;
	Wed,  1 Apr 2026 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775068379; cv=none; b=iVRvZRp3TpmHImnRX4jg5O4lLTx6bz5A4EfCtyF/BF1BsHoqrTeXF8/g97jRA2Y8/C1hmRv8pgzPyEe99QYNRE9/L4yCyMK7zcfSvNx7eWcXYYKccL3H0aiQZ5Scwcaf5tzoJL0GwUgt1cBuqn1zioa1pVckGsHOaFdJaLuGou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775068379; c=relaxed/simple;
	bh=HT1QdOHgGJKJ1PAFiEhgKABmSuIFIRjeWlVkxNof3ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpC7ZjkmL4YXNbQzKHrXTbFoqccCY93N7A8FGx9JFh0vJqTTiQ+Srry6SUa7CB2Wamowll9BMLPeAkaM6kU3EEFBcR1MwFHkDswMuYZlrrUpgRmKVmwUmQKf9qItDtNBNXHwulcKUfrIIGmvV1XMt26paDj/y/Oc3RQXF1DHfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1yHS7Nri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1yHS7Nri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0267C19423;
	Wed,  1 Apr 2026 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775068379;
	bh=HT1QdOHgGJKJ1PAFiEhgKABmSuIFIRjeWlVkxNof3ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1yHS7Nrioo6Qx9RmIimcP7S+2yFZtSNis7aZUjAx8xHPOdmsQUHD7b/+af//8l7xO
	 I6NkCUNoPkCXvcQXSdQN6A6w5xSwGiEpLKvMcVyA8ctlj3wDZDsyjI5gJ1KrGLxpsW
	 EAFJRp76Dv+zULgJ8oMHP18XjB5jY7zREMRmgaoM=
Date: Wed, 1 Apr 2026 20:32:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
Message-ID: <2026040124-unbolted-timing-ce25@gregkh>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>

On Wed, Apr 01, 2026 at 02:06:25PM +0000, Markus Probst wrote:
> Export `acpi_of_match_device` function and use it to match the of device
> table against ACPI PRP0001 in Rust.
> 
> This fixes id_info being None on ACPI PRP0001 devices.
> 
> Using `device_get_match_data` is not possible, because Rust stores an
> index in the of device id instead of a data pointer.

I'm confused, why are we open-coding this in the rust layer?  What do we
need to change in the C side to make both layers be able to call the
same function instead?

thanks,

greg k-h
