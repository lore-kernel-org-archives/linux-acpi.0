Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D3208D0;
	Sat,  4 Apr 2026 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775340456; cv=none; b=nA393itmVwg/AnHoOEwPsB+jyPIFZ+i71oSp7GP0XgcoQar0J62HYKlVoO91M53JcQ0xfILzoCDYKvHG1GdiaD5BTsC7dg7VT44mNjQ5GhfDjB/9havft+fM07Q+kBrDUWPkPgAPxyKtkPm1cO2oI05mVfixKjDof9kVnV3fXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775340456; c=relaxed/simple;
	bh=36w1ZN6cEQpsNTKNtuHhvBuR75DgGZYNHwfwfmS7ktA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=chv4ahJgSLq1YlcxQAaTGq8kvaJGWCPLpNGYMPPFgRSLr9ylxbsinNMcO3QjPgE969WNrx7m3SgnOgcm1dNlY5iSVXamGT6IkFk7QAhcKA5l2PYQIJCdUe12LkowzG5UksMyHv2F2iSjc5wEZk/aOiq8ZHTiEd8H0EMGLGX2GwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6nzy0Ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6nzy0Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A59C19421;
	Sat,  4 Apr 2026 22:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775340455;
	bh=36w1ZN6cEQpsNTKNtuHhvBuR75DgGZYNHwfwfmS7ktA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=H6nzy0EigIK/erGUZQmZmH89HlvAGO3ICIdYmByUIDqduAIHL/udkn/1szekvi84Z
	 H6Lnty2l/p0RLT+dVrWZcpYHkm8z+mVKkGzbbKWQv2yddxzjg1XarAWT29KAewKluv
	 Kk7PHE+DLJybYNR5/F+fGwVXoz2wlHqU68qMSiGeLmYqOI6flWVgmE+TTco2kz93IP
	 LON3Gs2DVzTwCqAk1Ehh8ApkJQzw3t/6dfJlENzeku1wuV4W/QZ5GHrVnZQDyRenP2
	 UsjtRGxeMpZeBTb+jog//Wdct8smCpngWMpM/534naw8pDrfXFlt2hmNGOwY/WKuSt
	 7y6NM3Gyi60Ow==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 00:07:30 +0200
Message-Id: <DHKPNZT8IEO6.1JZ04J5AX26QF@kernel.org>
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
In-Reply-To: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>

On Wed Apr 1, 2026 at 4:06 PM CEST, Markus Probst wrote:
> @@ -866,6 +866,7 @@ static bool acpi_of_match_device(const struct acpi_de=
vice *adev,
> =20
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(acpi_of_match_device);

We only use this from Rust core code, so I'd rather avoid exporting this sy=
mbol.

We can work around the compiler inlining this into modules with this indire=
ction
instead:

+#[inline(never)]
+#[allow(clippy::missing_safety_doc)]
+#[must_use]
+unsafe fn acpi_of_match_device(
+    adev: *const bindings::acpi_device,
+    of_match_table: *const bindings::of_device_id,
+    of_id: *mut *const bindings::of_device_id,
+) -> bool {
+    // SAFETY: Safety requirements are the same as `bindings::acpi_device_=
id`.
+    unsafe { bindings::acpi_of_match_device(adev, of_match_table, of_id) }
+}
+
 /// The bus independent adapter to match a drivers and a devices.
 ///
 /// This trait should be implemented by the bus specific adapter, which re=
presents the connection
@@ -373,7 +385,7 @@ fn of_id_info(dev: &device::Device) -> Option<&'static =
Self::IdInfo> {
             // - `adev` is a valid pointer to `acpi_device` or is null. It=
 is guaranteed to be
             //   valid as long as `dev` is alive.
             // - `table` has static lifetime, hence it's valid for read.
-            if unsafe { bindings::acpi_of_match_device(adev, table.as_ptr(=
), &raw mut raw_id) } {
+            if unsafe { acpi_of_match_device(adev, table.as_ptr(), &raw mu=
t raw_id) } {
                 // SAFETY:
                 // - the function returns true, therefore `raw_id` has bee=
n set to a pointer to a
                 //   valid `of_device_id`.

Please see also [1].

[1] https://patch.msgid.link/20260213220718.82835-6-dakr@kernel.org

> @@ -329,35 +334,60 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'s=
tatic Self::IdInfo> {
>      ///
>      /// If this returns `None`, it means there is no match with an entry=
 in the [`of::IdTable`].
>      fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo>=
 {
> -        #[cfg(not(CONFIG_OF))]
> +        let table =3D Self::of_id_table()?;
> +
> +        #[cfg(not(any(CONFIG_OF, CONFIG_ACPI)))]
>          {
> -            let _ =3D dev;
> -            None
> +            let _ =3D (dev, table);
>          }
> =20
>          #[cfg(CONFIG_OF)]
>          {
> -            let table =3D Self::of_id_table()?;
> -
>              // SAFETY:
>              // - `table` has static lifetime, hence it's valid for read,
>              // - `dev` is guaranteed to be valid while it's alive, and s=
o is `dev.as_raw()`.
>              let raw_id =3D unsafe { bindings::of_match_device(table.as_p=
tr(), dev.as_raw()) };
> =20
> -            if raw_id.is_null() {
> -                None
> -            } else {
> +            if !raw_id.is_null() {
>                  // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrappe=
r of `struct of_device_id`
>                  // and does not add additional invariants, so it's safe =
to transmute.
>                  let id =3D unsafe { &*raw_id.cast::<of::DeviceId>() };
> =20
> -                Some(
> -                    table.info(<of::DeviceId as crate::device_id::RawDev=
iceIdIndex>::index(
> -                        id,
> -                    )),
> -                )
> +                return Some(table.info(
> +                    <of::DeviceId as crate::device_id::RawDeviceIdIndex>=
::index(id),
> +                ));
> +            }
> +        }
> +
> +        #[cfg(CONFIG_ACPI)]
> +        {
> +            let mut raw_id =3D ptr::null();
> +
> +            // SAFETY: `dev.fwnode().as_raw()` is a pointer to a valid `=
fwnode_handle`. A null
> +            // pointer will be passed through the function.
> +            let adev =3D unsafe {
> +                bindings::to_acpi_device_node(dev.fwnode().map_or(ptr::n=
ull_mut(), FwNode::as_raw))
> +            };

Please only pass the final pointer to bindings::to_acpi_device_node() to ke=
ep
unsafe {} sections as short as possible.

> +
> +            // SAFETY:
> +            // - `adev` is a valid pointer to `acpi_device` or is null. =
It is guaranteed to be
> +            //   valid as long as `dev` is alive.
> +            // - `table` has static lifetime, hence it's valid for read.
> +            if unsafe { bindings::acpi_of_match_device(adev, table.as_pt=
r(), &raw mut raw_id) } {
> +                // SAFETY:
> +                // - the function returns true, therefore `raw_id` has b=
een set to a pointer to a
> +                //   valid `of_device_id`.
> +                // - `DeviceId` is a `#[repr(transparent)]` wrapper of `=
struct of_device_id`
> +                //   and does not add additional invariants, so it's saf=
e to transmute.
> +                let id =3D unsafe { &*raw_id.cast::<of::DeviceId>() };
> +
> +                return Some(table.info(
> +                    <of::DeviceId as crate::device_id::RawDeviceIdIndex>=
::index(id),
> +                ));
>              }
>          }
> +
> +        None
>      }
