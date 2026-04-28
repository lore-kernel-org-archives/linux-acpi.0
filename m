Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5445BD4B
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398974; cv=none; b=DQVGy7XidCGd2341r3Cy2SNF7oTPmWtlHO9F1n8fkuZXYV5R87Kqk6TAAYo5zzwooOj0mrwQRmTwRskZ2KAXXsTZEYl57XYv5N2WLniJcftVauQ5zZmDu28Ue8+Dw3VcZQX031EEoWfNXbBEG8hzo7h+nDgr62yJtbTsDjrt3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398974; c=relaxed/simple;
	bh=SkkMxDiLgWfpYt+unzKfTpb7mJNQSINEpTuW8eIq0/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/DTUVQvV+C3OwOIMDvmIrGDev496xXPEjIFv1+WNIbvZGAmI0bjynNFMulg0lzPUnQF+xGQ8kYNxwq2zcX7VTMHSH2h7BKBi4VCVqJM37bIfHxc/Ip/jxO4TvZmbJE5F3cm3pz/lW0xFxVbpDaM4UTr+CulHSuQdOXDT+5kC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/eaYf0x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/eaYf0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B551C2BCF6
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777398974;
	bh=SkkMxDiLgWfpYt+unzKfTpb7mJNQSINEpTuW8eIq0/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J/eaYf0xA7WzT304CjqS8QQzUmMxKxMOW1x13goyG3TyUxw2UGHXTMZcjFL0svGsH
	 S4clCzd9rItPIytapBt1Fa2NLujID9ctsT7gAYZyhovpn5ZdQNNndpIvr/ycwNVVe1
	 XAIkGHsID6J++piGbm53LuTdpk8b4EJxCclNvD6grMiYKrV01WE25QHNd8M76mdFsg
	 x/vmyUz4mLhDyIMk62WrYtciJWozFwLMeKJqHpT3dD/KLirq10URWBP2UrJvPBai22
	 nN+Cg6+FU22tkwSRCXn/3CPWDWHWFoEXomEV4pJL8ubMEAsU3MwbYJDK/1caPi82EE
	 EZMQ2F+Hj0AWA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so17881441e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 10:56:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+f61CoxGOwcLyxStLsYWKpJfu3ZgPlRJn00YLs8gzfazTv19XoNHfmgADLXVx91Rehpjr4omyTeozK@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqp0TR5fNZpN0ttwCb8oknt2TtGmQLLgRZLKzSf3HTfR31v5I
	BTiUZ2waALN7LJ6uKoXH38kubxhSsOwVElKp7B2rlyOsCYmPkKvLSuCvPMGZH0TwyproY76un2T
	jsCRaXsfK4sfPfaKbOgKyFndJw4n7THw=
X-Received: by 2002:a05:6512:1385:b0:5a2:bb8e:d4f4 with SMTP id
 2adb3069b0e04-5a74640ef86mr1941827e87.15.1777398972508; Tue, 28 Apr 2026
 10:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-rust_acpi_prp0001-v6-1-6119b2a66183@posteo.de>
In-Reply-To: <20260427-rust_acpi_prp0001-v6-1-6119b2a66183@posteo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Apr 2026 19:55:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gGa2DGV4dL1X5RSC2oqDjptZHr_kBUoXpEXhN7BOVSiA@mail.gmail.com>
X-Gm-Features: AVHnY4LIegjLa45_DuPVqLfc-y2Ja4WyZSsjytLEeh-McdtzZO7iCLfB83c1VJ4
Message-ID: <CAJZ5v0gGa2DGV4dL1X5RSC2oqDjptZHr_kBUoXpEXhN7BOVSiA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: ACPI: fix missing match data for PRP0001
To: Markus Probst <markus.probst@posteo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:56=E2=80=AFPM Markus Probst <markus.probst@posteo=
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

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # ACPI

(and I think I've already ACKed it once).

> ---
> Changes in v6:
> - rebased onto v7.1-rc1
> - Link to v5: https://patch.msgid.link/20260420-rust_acpi_prp0001-v5-1-f7=
7869b18b9f@posteo.de
>
> Changes in v5:
> - provide a stub instead of canditionalize the caller
> - Link to v4: https://lore.kernel.org/r/20260408-rust_acpi_prp0001-v4-1-8=
7b78ad79239@posteo.de
>
> Changes in v4:
> - fix compilation on !CONFIG_ACPI
> - fix typo
> - add doc to `acpi_of_match_device` and remove from header file include
> - Link to v3: https://lore.kernel.org/r/20260407-rust_acpi_prp0001-v3-1-c=
5b24590c273@posteo.de
>
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
>  MAINTAINERS             |  1 +
>  drivers/acpi/bus.c      |  6 ++--
>  include/acpi/acpi_bus.h | 11 ++++++++
>  rust/helpers/acpi.c     | 16 +++++++++++
>  rust/helpers/helpers.c  |  1 +
>  rust/kernel/driver.rs   | 74 ++++++++++++++++++++++++++++++++++++++++---=
------
>  6 files changed, 93 insertions(+), 16 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..4367a303e90e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -291,6 +291,7 @@ F:  include/linux/acpi.h
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
> index b701b5f972cb..c85f7d8f1632 100644
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
> @@ -992,6 +996,13 @@ int acpi_scan_add_dep(acpi_handle handle, struct acp=
i_handle_list *dep_devices);
>  u32 arch_acpi_add_auto_dep(acpi_handle handle);
>  #else  /* CONFIG_ACPI */
>
> +static inline bool acpi_of_match_device(const struct acpi_device *adev,
> +                                       const struct of_device_id *of_mat=
ch_table,
> +                                       const struct of_device_id **of_id=
)
> +{
> +       return false;
> +}
> +
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
>  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
>
> diff --git a/rust/helpers/acpi.c b/rust/helpers/acpi.c
> new file mode 100644
> index 000000000000..e75c9807bbad
> --- /dev/null
> +++ b/rust/helpers/acpi.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/acpi.h>
> +#include <acpi/acpi_bus.h>
> +
> +__rust_helper bool rust_helper_acpi_of_match_device(const struct acpi_de=
vice *adev,
> +                                                   const struct of_devic=
e_id *of_match_table,
> +                                                   const struct of_devic=
e_id **of_id)
> +{
> +       return acpi_of_match_device(adev, of_match_table, of_id);
> +}
> +
> +__rust_helper struct acpi_device *rust_helper_to_acpi_device_node(struct=
 fwnode_handle *fwnode)
> +{
> +       return to_acpi_device_node(fwnode);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 625921e27dfb..38b34518eff1 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -38,6 +38,7 @@
>  #define __rust_helper __always_inline
>  #endif
>
> +#include "acpi.c"
>  #include "atomic.c"
>  #include "atomic_ext.c"
>  #include "auxiliary.c"
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 36de8098754d..93e5dd6ae371 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -278,6 +278,26 @@ fn init(
>      }
>  }
>
> +// Calling the FFI function directly from the `Adapter` impl may result =
in it being called
> +// directly from driver modules. This happens since the Rust compiler wi=
ll use monomorphisation, so
> +// it might happen that functions are instantiated within the calling dr=
iver module. For now, work
> +// around this with `#[inline(never)]` helpers.
> +//
> +// TODO: Remove once a more generic solution has been implemented. For i=
nstance, we may be able to
> +// leverage `bindgen` to take care of this depending on whether a symbol=
 is (already) exported.
> +#[inline(never)]
> +#[allow(clippy::missing_safety_doc)]
> +#[allow(dead_code)]
> +#[must_use]
> +unsafe fn acpi_of_match_device(
> +    adev: *const bindings::acpi_device,
> +    of_match_table: *const bindings::of_device_id,
> +    of_id: *mut *const bindings::of_device_id,
> +) -> bool {
> +    // SAFETY: Safety requirements are the same as `bindings::acpi_of_ma=
tch_device`.
> +    unsafe { bindings::acpi_of_match_device(adev, of_match_table, of_id)=
 }
> +}
> +
>  /// The bus independent adapter to match a drivers and a devices.
>  ///
>  /// This trait should be implemented by the bus specific adapter, which =
represents the connection
> @@ -329,35 +349,63 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'s=
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
> +            use core::ptr;
> +            use device::property::FwNode;
> +
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
> base-commit: 3131ff5a117498bb4b9db3a238bb311cbf8383ce
> change-id: 20260401-rust_acpi_prp0001-a2971543b555
>
>
