Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CD272E56;
	Wed,  8 Apr 2026 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664212; cv=none; b=WyqsA3yrnalaf0hO/4Au5Bcdop2be/ZyLCvGaDDysMFr7I9+oMSuV1HEoVAYqWxGR3UcAKhuiIIURYA8zYkoP5qFq4Oms+lKZU3NKy2lQrfhvh/ztpJGviZ5GsHvWgVbjLkuOQtJztjr3CpQJNNJ382Xhvq1IGQ+Afmqozg+ldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664212; c=relaxed/simple;
	bh=aOYEMe8DYHjELWWitRha6yUM4hwV/TSAsG6LDrMzUhg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=D2yEkg7Exa4ygEO+UMg30Fu9BL9lRtpxEojdVPUy1pwPauEHRIJS+UfAT4cTMX3udLaxbC0iJxoP635LjU41QRxUnBKA6kYg7ciVQqO0bQCf9hFDN3x8Rp6HGh7+ZQx+rpgeKdJYovVWDoMnUl9wiEkgaMFE0N350Zp2F6HOeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBs7c1rE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBs7c1rE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A11C19421;
	Wed,  8 Apr 2026 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775664212;
	bh=aOYEMe8DYHjELWWitRha6yUM4hwV/TSAsG6LDrMzUhg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mBs7c1rEojLYlA3cGDrknDuAeLgN0py0autr6qMveVPnL+emk4EWkDVXQXTZOX3Uq
	 y9qKMFPgH5/sskm6uRPQeu+ddffbx9tjA1me8A3m8yCsUflN8/6Ru379VzyoSzSDv8
	 8pZP9Eng29U2eOXlC4yP15v6iaTDUaBZCdIOgNdKm5mSBCgEOK2S1GdqiYXHp6i+4A
	 kBO3pN9CtZRl3MEwsarDNrSMX5kyYOTAdqxpTymizmupQUOvx42Ywfn9OQHJlDADvJ
	 s8r24UIjcbMt20QlwY+dTzfunCZzf0HMui4srktj3hKa6N1TBnpy9wMv5gG72z3fpl
	 0erc/M6kt6GXw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 18:03:26 +0200
Message-Id: <DHNWFFEB3HD9.1QM2XXNE6BANY@kernel.org>
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
In-Reply-To: <20260407-rust_acpi_prp0001-v3-1-c5b24590c273@posteo.de>

On Tue Apr 7, 2026 at 11:41 PM CEST, Markus Probst wrote:
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863..d0098f24346f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -187,6 +187,10 @@ struct acpi_driver {
>   * -----------
>   */
> =20
> +bool acpi_of_match_device(const struct acpi_device *adev,
> +			  const struct of_device_id *of_match_table,
> +			  const struct of_device_id **of_id);

This also has to be defined for !CONFIG_ACPI, otherwise we run into the
following compatible error.

	error[E0425]: cannot find function `acpi_of_match_device` in crate `bindin=
gs`
	      --> rust/kernel/driver.rs:295:24
	       |
	   295 |       unsafe { bindings::acpi_of_match_device(adev, of_match_tabl=
e, of_id) }
	       |                          ^^^^^^^^^^^^^^^^^^^^
	       |
	      ::: /mnt/nvme/work/projects/linux/driver-core/driver-core-testing/ru=
st/bindings/bindings_generated.rs:118713:5

There is an

	#else	/* CONFIG_ACPI */

block at the end of acpi_bus.h for this.

> +
>  /* Status (_STA) */
> =20
>  struct acpi_device_status {
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 083cc44aa952..e47643ce8b50 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -96,6 +96,11 @@
>   */
>  #include <../../drivers/base/base.h>
> =20
> +/*
> + * The driver-core Rust code needs to call `acpi_of_match_device`.
> + */

NIT: I'd drop this comment as such comments usually do not age very well. :=
)

I assume you followed the above comment for

	#include <../../drivers/base/base.h>

but this one is different as it justifies why we have to include an interna=
l
header in general (i.e. not for a specific function).

> @@ -278,6 +283,18 @@ fn init(
>      }
>  }
> =20
> +#[inline(never)]
> +#[allow(clippy::missing_safety_doc)]
> +#[must_use]
> +unsafe fn acpi_of_match_device(

Maybe add a very brief comment similar to the one in devres.rs for this.

> +    adev: *const bindings::acpi_device,
> +    of_match_table: *const bindings::of_device_id,
> +    of_id: *mut *const bindings::of_device_id,
> +) -> bool {
> +    // SAFETY: Safety requirements are the same as `bindings::acpi_devic=
e_id`.

Typo: s/bindings::acpi_device_id/bindings::acpi_of_match_device/

> +    unsafe { bindings::acpi_of_match_device(adev, of_match_table, of_id)=
 }
> +}
