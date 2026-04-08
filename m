Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497283ACF19
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642350; cv=none; b=BnsPLtYuwDas5pJN3JSY3kUHSvBncU0CGOFOiP1J2BD0lnhMKR0i+PSXTKEq3fLctzE8pNsCcvsl6vA/g80RWpChQcFc3nsbdQBoEiApKT8XNvfKDNf3EPj6Dc2TEg1GK4hw3JdpUMHTGlt5wP3F882lppzJOJV3i/ucTD7uZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642350; c=relaxed/simple;
	bh=Da2yNQvkXwj63an8LuyZKSdmO++NFtu7LR403hXD8hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgSxO4jFaeZwEZy9AE9rgkIkjDPX45xv4zNC8qaUuHKbVhvZAn1SWaWGAXutiGzsCLz61HUWygHpq3pTDD9J7Z3+7N7McR6Q4gExDmuUuV6EeaAkp6YcujrsgtKmafloI66EJnyCYjuan6RmbLwOZ6vTMxhfqhm9j7K1hNWtfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdiaTBz+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdiaTBz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D41C2BCB7
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 09:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775642349;
	bh=Da2yNQvkXwj63an8LuyZKSdmO++NFtu7LR403hXD8hU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mdiaTBz+F5ZK5OXV4mUXUWaTrfTOIyAZ8qngxXlAJnRAwptA2w+sjQAO0FtUrrLR9
	 8jfIb/KKqIGn94/cIJ9V4C2YyJsGDboP8KEPjXIi1YtrrHCnGf00QUEsYjO0rhcaDN
	 yyYKe/4GgIlUl6+mUxIoH/29bJbgqtzA5TCmTYSeC3DCOqq9WeXSu4IxSQOdMpTsRs
	 +2YXcEel7vGgZn9zwrkjce4NPwmkDnV52GVNLJgWk9Bg7gROHbxmpHduzJkikZ1j92
	 u6SiFHX3vuPY23xBibt/n/58TuYse+8+dZK+VvjTCXgR8SM3r0mZD6CFqD/h3tnZcj
	 0am4+/mNh4IgQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-464ba2bb3aeso534186b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 08 Apr 2026 02:59:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEbc7ASHL+jDUBTkddwlXSFLc9jRP7+gctXAdKvsjRm0mnsw8IMnSYA6iPRyGa+0U5SwAHF8h/zSTK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3n/J7jwmsMET4vrK4fEIFYMGfMy2PWRnZ8gLYXXMg9n5G3gpH
	9u3Yl5A1qNA7KMz+QOREsmKdN5v1+Im735HmZu8NqFq4SOJniIuj19uz+YPLKB0Up9rNHKi2iM2
	OyUgKY2btCWaiRRX+cKBm83vNwi/dpHc=
X-Received: by 2002:a05:6808:181f:b0:45e:d94c:70b with SMTP id
 5614622812f47-46ddd03cfaamr10792739b6e.0.1775642348778; Wed, 08 Apr 2026
 02:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-rust_acpi_prp0001-v3-1-c5b24590c273@posteo.de>
In-Reply-To: <20260407-rust_acpi_prp0001-v3-1-c5b24590c273@posteo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Apr 2026 11:58:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBqxm93-eQ9UZZjbYmE_1+8KaBBe7-5LVz8cdDgwsyxA@mail.gmail.com>
X-Gm-Features: AQROBzCzmnz6xUMaOHp1Ir_2-UDZIj-o9h2F9-V4mhrLGimluFfFnEAx9JyeulE
Message-ID: <CAJZ5v0hBqxm93-eQ9UZZjbYmE_1+8KaBBe7-5LVz8cdDgwsyxA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: ACPI: fix missing match data for PRP0001
To: Markus Probst <markus.probst@posteo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 11:42=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> Export `acpi_of_match_device` function and use it to match the of device
> table against ACPI PRP0001 in Rust.
>
> This fixes id_info being None on ACPI PRP0001 devices.
>
> Using `device_get_match_data` is not possible, because Rust stores an
> index in the of device id instead of a data pointer. This was done this
> way to provide a convenient and obvious API for drivers, which can be
> evaluated in const context without the use of any unstable language
> features.
>
> Fixes: 7a718a1f26d1 ("rust: driver: implement `Adapter`")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

From the ACPI side

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

but I'm not a Rust expert.

> ---
> Changes in v3:
> - use acpi/acpi_bus.h instead of drivers/acpi/internal.h to declare
>   `acpi_of_match_device`
> - Link to v2: https://lore.kernel.org/r/20260405-rust_acpi_prp0001-v2-1-4=
f8b1cf075d3@posteo.de
>
> Changes in v2:
> - keep unsafe block as short as possible
> - don't export acpi_of_match_device
> - add implementation decisions to commit msg
> - Link to v1: https://lore.kernel.org/r/20260401-rust_acpi_prp0001-v1-1-f=
6a4d2ef9244@posteo.de
> ---
>  MAINTAINERS                     |  1 +
>  drivers/acpi/bus.c              |  6 ++--
>  include/acpi/acpi_bus.h         |  4 +++
>  rust/bindings/bindings_helper.h |  5 +++
>  rust/helpers/acpi.c             |  8 +++++
>  rust/helpers/helpers.c          |  1 +
>  rust/kernel/driver.rs           | 70 ++++++++++++++++++++++++++++++++---=
------
>  7 files changed, 78 insertions(+), 17 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3fe46d7c4bc..3a7b3b5f2a28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -302,6 +302,7 @@ F:  include/linux/acpi.h
>  F:     include/linux/fwnode.h
>  F:     include/linux/fw_table.h
>  F:     lib/fw_table.c
> +F:     rust/helpers/acpi.c
>  F:     rust/kernel/acpi.rs
>  F:     tools/power/acpi/
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 2ec095e2009e..554dbddb1c8c 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -831,9 +831,9 @@ const struct acpi_device *acpi_companion_match(const =
struct device *dev)
>   * identifiers and a _DSD object with the "compatible" property, use tha=
t
>   * property to match against the given list of identifiers.
>   */
> -static bool acpi_of_match_device(const struct acpi_device *adev,
> -                                const struct of_device_id *of_match_tabl=
e,
> -                                const struct of_device_id **of_id)
> +bool acpi_of_match_device(const struct acpi_device *adev,
> +                         const struct of_device_id *of_match_table,
> +                         const struct of_device_id **of_id)
>  {
>         const union acpi_object *of_compatible, *obj;
>         int i, nval;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863..d0098f24346f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -187,6 +187,10 @@ struct acpi_driver {
>   * -----------
>   */
>
> +bool acpi_of_match_device(const struct acpi_device *adev,
> +                         const struct of_device_id *of_match_table,
> +                         const struct of_device_id **of_id);
> +
>  /* Status (_STA) */
>
>  struct acpi_device_status {
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 083cc44aa952..e47643ce8b50 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -96,6 +96,11 @@
>   */
>  #include <../../drivers/base/base.h>
>
> +/*
> + * The driver-core Rust code needs to call `acpi_of_match_device`.
> + */
> +#include <acpi/acpi_bus.h>
> +
>  #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>  // Used by `#[export]` in `drivers/gpu/drm/drm_panic_qr.rs`.
>  #include <drm/drm_panic.h>
> diff --git a/rust/helpers/acpi.c b/rust/helpers/acpi.c
> new file mode 100644
> index 000000000000..f2aa00ec99c2
> --- /dev/null
> +++ b/rust/helpers/acpi.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/acpi.h>
> +
> +__rust_helper struct acpi_device *rust_helper_to_acpi_device_node(struct=
 fwnode_handle *fwnode)
> +{
> +       return to_acpi_device_node(fwnode);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index a3c42e51f00a..8ecd1580aa69 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -9,6 +9,7 @@
>
>  #define __rust_helper
>
> +#include "acpi.c"
>  #include "atomic.c"
>  #include "atomic_ext.c"
>  #include "auxiliary.c"
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 36de8098754d..62d7d1ab776c 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -96,13 +96,18 @@
>
>  use crate::{
>      acpi,
> -    device,
> +    device::{
> +        self,
> +        property::FwNode, //
> +    },
>      of,
>      prelude::*,
>      types::Opaque,
>      ThisModule, //
>  };
>
> +use core::ptr;
> +
>  /// Trait describing the layout of a specific device driver.
>  ///
>  /// This trait describes the layout of a specific driver structure, such=
 as `struct pci_driver` or
> @@ -278,6 +283,18 @@ fn init(
>      }
>  }
>
> +#[inline(never)]
> +#[allow(clippy::missing_safety_doc)]
> +#[must_use]
> +unsafe fn acpi_of_match_device(
> +    adev: *const bindings::acpi_device,
> +    of_match_table: *const bindings::of_device_id,
> +    of_id: *mut *const bindings::of_device_id,
> +) -> bool {
> +    // SAFETY: Safety requirements are the same as `bindings::acpi_devic=
e_id`.
> +    unsafe { bindings::acpi_of_match_device(adev, of_match_table, of_id)=
 }
> +}
> +
>  /// The bus independent adapter to match a drivers and a devices.
>  ///
>  /// This trait should be implemented by the bus specific adapter, which =
represents the connection
> @@ -329,35 +346,60 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'s=
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
>
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
>
> -            if raw_id.is_null() {
> -                None
> -            } else {
> +            if !raw_id.is_null() {
>                  // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrappe=
r of `struct of_device_id`
>                  // and does not add additional invariants, so it's safe =
to transmute.
>                  let id =3D unsafe { &*raw_id.cast::<of::DeviceId>() };
>
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
>              }
>          }
> +
> +        #[cfg(CONFIG_ACPI)]
> +        {
> +            let mut raw_id =3D ptr::null();
> +
> +            let fwnode =3D dev.fwnode().map_or(ptr::null_mut(), FwNode::=
as_raw);
> +
> +            // SAFETY: `fwnode` is a pointer to a valid `fwnode_handle`.=
 A null pointer will be
> +            // passed through the function.
> +            let adev =3D unsafe { bindings::to_acpi_device_node(fwnode) =
};
> +
> +            // SAFETY:
> +            // - `adev` is a valid pointer to `acpi_device` or is null. =
It is guaranteed to be
> +            //   valid as long as `dev` is alive.
> +            // - `table` has static lifetime, hence it's valid for read.
> +            if unsafe { acpi_of_match_device(adev, table.as_ptr(), &raw =
mut raw_id) } {
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
> +            }
> +        }
> +
> +        None
>      }
>
>      /// Returns the driver's private data from the matching entry of any=
 of the ID tables, if any.
>
> ---
> base-commit: 0e5d0a0b5ca6ea4e391d6786266405c5871e0151
> change-id: 20260401-rust_acpi_prp0001-a2971543b555
>
>
