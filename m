Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C12F7478;
	Wed,  8 Apr 2026 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775678402; cv=none; b=mMSEt6G2rM+sTCvsAPmueneJqBxyHu8C2U0/oqmTaMsjIq0e0OKl/S87C9hD6v+YViXy/UPngVjPfRuI+yyRB3TnTzZ4zMtgkXJ8R1HF7sLAnNvQ0e/uBDVyVndRKorxu3vIVvcm6CQbYGnwGxHHBBGTg3MIb6PtUAJ/sj/WnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775678402; c=relaxed/simple;
	bh=P2OXSa0PQsfqTCrKlJrHzDvFDKJTw0z4yVEiGgWfBDI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nmQH/IFicMK/l7trvEdeDIy5nFMmoMo/V6WXSU6unh+EHrWWu8F6VmWgfisg2TzddRNpd4JhVR1YE278qM9rf4o1gaMX6TBVoIj7U2l0SG/9SwwBKzYp7ZZ4jmFEaTq56nYd7t3ZAMhxRdMszK5EcYkouVY6M0064gAfdrFoY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdAlw++k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdAlw++k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECF2C19421;
	Wed,  8 Apr 2026 19:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775678401;
	bh=P2OXSa0PQsfqTCrKlJrHzDvFDKJTw0z4yVEiGgWfBDI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=PdAlw++k0ZkCQEAAe6/aOg0jTC5xBnAB5PjUy/OqaT461l5YG+hfbjpWBflQK4za7
	 WlBSc248sTw9InNa5bcZ6NWyiAQQoRxW0Oi25fZ9WIJER+M90x9LS2kOHD0tM5Y3UM
	 lWW0PQOg5ZYw9b/xDmdDzPAHis5nrfh1ZGjK5EGFoGTmNd5zwCCMmDwuz7tVbfLqDG
	 QQeLe5f4Yre0bBVJ/hq7gPNkz5HwSl/2LnOUSeSspS0V/+42C2S+hSW+64gw5UgA0b
	 /6w5Ar/d6zfEojr86Y/CfM3nrToHd9oEFMUeJHoeHTnho+s85Or2Rdi1Q1Yk2EsOqJ
	 QfAhBvAS9Z0ag==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 21:59:57 +0200
Message-Id: <DHO1GI8ZAR1L.3DUWFSM1VT8BS@kernel.org>
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
In-Reply-To: <4d5cd9887e67007f4dabfed0986861a60e395ae6.camel@posteo.de>

On Wed Apr 8, 2026 at 9:40 PM CEST, Markus Probst wrote:
> On Wed, 2026-04-08 at 18:03 +0200, Danilo Krummrich wrote:
>> On Tue Apr 7, 2026 at 11:41 PM CEST, Markus Probst wrote:
>> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> > index aad1a95e6863..d0098f24346f 100644
>> > --- a/include/acpi/acpi_bus.h
>> > +++ b/include/acpi/acpi_bus.h
>> > @@ -187,6 +187,10 @@ struct acpi_driver {
>> >   * -----------
>> >   */
>> > =20
>> > +bool acpi_of_match_device(const struct acpi_device *adev,
>> > +			  const struct of_device_id *of_match_table,
>> > +			  const struct of_device_id **of_id);
>>=20
>> This also has to be defined for !CONFIG_ACPI, otherwise we run into the
>> following compatible error.
>>=20
>> 	error[E0425]: cannot find function `acpi_of_match_device` in crate `bin=
dings`
>> 	      --> rust/kernel/driver.rs:295:24
>> 	       |
>> 	   295 |       unsafe { bindings::acpi_of_match_device(adev, of_match_t=
able, of_id) }
>> 	       |                          ^^^^^^^^^^^^^^^^^^^^
>> 	       |
>> 	      ::: /mnt/nvme/work/projects/linux/driver-core/driver-core-testing=
/rust/bindings/bindings_generated.rs:118713:5
>>=20
>> There is an
>>=20
>> 	#else	/* CONFIG_ACPI */
>>=20
>> block at the end of acpi_bus.h for this.
> I don't think the function exists in that case and bindgen can't
> generate inline functions, so I will just add a `#[cfg(CONFIG_ACPI)]`
> condition on top of the function.

Usually we provide a stub instead of conditionalize the callers; this case =
might
be a bit special, but I'd still follow the usual pattern.

That said, I'm fine with both -- Rafaels call.
