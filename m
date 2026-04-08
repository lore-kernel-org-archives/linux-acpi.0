Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD12D7DF8;
	Wed,  8 Apr 2026 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686069; cv=none; b=q7BJvM7AZwM/sOCc/DlxEmse9qq81QoEE4KkWxwPFsn/0/f8lwg9U5YT8XkfHrqEATtdjBo+Val8jOlnzf7m9KmmZkYWnd166YgEHsok5W5bld4E2dxe/B+4u9jkhYgAZ7K+4ryVJvqCGcPd+yxr91GXsvpwZHBcaOqkFPSj2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686069; c=relaxed/simple;
	bh=ldeSFHzd+esW/3vYuRK5wo593viA9F4pRs8eAx3H1uA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hcTl2HZvnOFYXHWTzyty2gwKa7tlo5H82wIDmB42T/xd6ga8ild8Dl4KuvI93z6luDOiGtFBgrmi9fc1Q74MshUfX/wmsyYHwZQnRT6IZkvMvXAdhg+VAmC2Ws4FofPclKZCsGSZttq+z+F79inTuQ9KcxLqcRY0HftEryRDaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6X8/5FM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6X8/5FM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA95C19421;
	Wed,  8 Apr 2026 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775686069;
	bh=ldeSFHzd+esW/3vYuRK5wo593viA9F4pRs8eAx3H1uA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=M6X8/5FMKygXTwSZVPn2jcDW7HnzFUkD6w2B+DY8Lj2/UPsO1qCPV9wqso710/e4E
	 XCBCv5pQfMYTkUl30CiA4W8bfnlR/3l38jUTg2g5QkmP27xdJ4o9rUrDb5rXDvSLPq
	 i3OWwgoACw9zgXvGiihRJ2x8bGzmRcBDbQDlAHagTqP/DUfgfLhyOdYCvnwHY5k2/4
	 hNHPtxJgOwg8voOnZJvJWyj4nJgNhS1dOJNpHSvzv1nOa1Ft79hCOAXngIG9HkUXoq
	 T/sNczVyZpn7wUPAhwSx2ATdi7LG3QBo1gRH0MZKbnH8XvJJOvkSIVyh/V+WxVN5U0
	 UuYmtijJ8IelQ==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 00:07:44 +0200
Message-Id: <DHO46CIJNVZH.1Q6ZLX1XNWRR4@kernel.org>
Subject: Re: [PATCH v3] rust: ACPI: fix missing match data for PRP0001
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Robert Moore" <robert.moore@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <acpica-devel@lists.linux.dev>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260407-rust_acpi_prp0001-v3-1-c5b24590c273@posteo.de>
 <DHNWFFEB3HD9.1QM2XXNE6BANY@kernel.org>
 <4d5cd9887e67007f4dabfed0986861a60e395ae6.camel@posteo.de>
 <DHO1GI8ZAR1L.3DUWFSM1VT8BS@kernel.org>
 <e6985ffe6d35e27b85b540e410cf92592d597a69.camel@posteo.de>
In-Reply-To: <e6985ffe6d35e27b85b540e410cf92592d597a69.camel@posteo.de>

On Wed Apr 8, 2026 at 11:42 PM CEST, Markus Probst wrote:
> On Wed, 2026-04-08 at 21:59 +0200, Danilo Krummrich wrote:
>> On Wed Apr 8, 2026 at 9:40 PM CEST, Markus Probst wrote:
>> > On Wed, 2026-04-08 at 18:03 +0200, Danilo Krummrich wrote:
>> > > On Tue Apr 7, 2026 at 11:41 PM CEST, Markus Probst wrote:
>> > > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> > > > index aad1a95e6863..d0098f24346f 100644
>> > > > --- a/include/acpi/acpi_bus.h
>> > > > +++ b/include/acpi/acpi_bus.h
>> > > > @@ -187,6 +187,10 @@ struct acpi_driver {
>> > > >   * -----------
>> > > >   */
>> > > > =20
>> > > > +bool acpi_of_match_device(const struct acpi_device *adev,
>> > > > +			  const struct of_device_id *of_match_table,
>> > > > +			  const struct of_device_id **of_id);
>> > >=20
>> > > This also has to be defined for !CONFIG_ACPI, otherwise we run into =
the
>> > > following compatible error.
>> > >=20
>> > > 	error[E0425]: cannot find function `acpi_of_match_device` in crate =
`bindings`
>> > > 	      --> rust/kernel/driver.rs:295:24
>> > > 	       |
>> > > 	   295 |       unsafe { bindings::acpi_of_match_device(adev, of_mat=
ch_table, of_id) }
>> > > 	       |                          ^^^^^^^^^^^^^^^^^^^^
>> > > 	       |
>> > > 	      ::: /mnt/nvme/work/projects/linux/driver-core/driver-core-tes=
ting/rust/bindings/bindings_generated.rs:118713:5
>> > >=20
>> > > There is an
>> > >=20
>> > > 	#else	/* CONFIG_ACPI */
>> > >=20
>> > > block at the end of acpi_bus.h for this.
>> > I don't think the function exists in that case and bindgen can't
>> > generate inline functions, so I will just add a `#[cfg(CONFIG_ACPI)]`
>> > condition on top of the function.
>>=20
>> Usually we provide a stub instead of conditionalize the callers; this ca=
se might
>> be a bit special, but I'd still follow the usual pattern.
> The usual C pattern would be
>
> static inline bool acpi_of_match_device(const struct acpi_device *adev,
> 			const struct of_device_id *of_match_table,
> 			const struct of_device_id **of_id);
>
> , which is ignored by bindgen (i. e. same error).

That's where you define a Rust helper; we have lots of cases where we only =
have
the Rust helper to deal with the inline function stub used when the
corresponding CONFIG_* is disabled.
