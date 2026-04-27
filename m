Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164C3148D9
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312568; cv=none; b=fPsaRzyvKmoF2t/CO2iHkqCYN44bU/bKFMzmasNXcTtfXcPhtpJBNH4lZhJWJR7WBxz2Pkt4Zm/zfaU9kw+vNofqtamkq131WTaCieNhcGHnHXRwVz5uluoyD240nW2+bb52n3Ysq4l7N8tPCiwhT06Ru9+ygQ+uJeqM146yUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312568; c=relaxed/simple;
	bh=3qRKYd4UMhwpiUDPa/Or7Kre8xyPoBOyuu6rw3abHpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WDdxeVc2C6/dq1HscEhfhYUpALsoJcY3xOedJaX3s0eh1MGVrKZSxg9KannGBi7ZZ/wxdYFd00nT0XtjiM6Csavzc6yiVElkLYeIBp09x/HFLn5Upe09noaAUuM2wP8g2d5RmB/FTQOHQ28y+2ehpNqKZqK1I2p8QFYVaMeEhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=lzIr5FO7; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="lzIr5FO7"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D687B240101
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 19:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1777312558; bh=Fdt6tmdNgh2RoTsIuiu6qAZtHWpwDQj+nnt3EfnXFVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=lzIr5FO79EphCoBnNkdnlIljSeOkDTT6CHk/t9srCUj8hXpN/ZWudnLHl01G6UkDH
	 mttnbI1i1xokPP8oKbmZDAhNw872NywfRtaeME6B61wnoMzCwUJOhdBSKneQ0uq5FT
	 7eaA0FA1N/Mv8SMMrKckIdf+SpTcK4znkqbLLO+Jo8qKatA8g9eopr3tuvfOwVuZ/T
	 FCxX2AmVkmagfZ19syhtl8XqluGOXs5aGuLWCcz30ORqFCgqxliMlWHtDm/RKdiNw6
	 Zd2WSkwUF7uyStjvAXmRwDhQ3CJXHYeBCoX2qzXIonjJHQzAldBeivZTK48u0xVd81
	 tQM98Om+KDJmQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4g4B7b374Wz6trs;
	Mon, 27 Apr 2026 19:55:55 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Mon, 27 Apr 2026 17:55:57 +0000
Subject: [PATCH v6] rust: ACPI: fix missing match data for PRP0001
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-rust_acpi_prp0001-v6-1-6119b2a66183@posteo.de>
X-B4-Tracking: v=1; b=H4sIACij72kC/33QwW7DIAwG4FeJOI8KDAToae8xVRUQWDm0SSFFn
 aq8+2h6QV2042/Zny0/UPYp+oz23QMlX2KO46WG/qND7mQu3x7HoWYEBHrCCcXpluejcVM8Tmk
 ipFYMaEkFZ1YIgerclHyI99X8Orxy8tdbpedXEVmTPXbj+RznfVfkjqBn3ynmeUw/6ymFro3/b
 C0UUxx6wwfwQQPnn9OYZz/uBr9qBVpBbAlQBR6UpS4QKQb2LrBWkFsCq4ITFrjQxIH8I/BWUFs
 Cr4KSViozSA1MvwuiEYBsCeL5BylVry1VVodWWJblF8XSUlziAQAA
X-Change-ID: 20260401-rust_acpi_prp0001-a2971543b555
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Saket Dumbre <saket.dumbre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 acpica-devel@lists.linux.dev, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9667;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=3qRKYd4UMhwpiUDPa/Or7Kre8xyPoBOyuu6rw3abHpI=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp76MrgytUfH+MlVHZ+CaTqkOJiosZuIhoPFvjU
 db9oBXEWNeJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCae+jKxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LgBxAAtysEvqDv1XlbaCFlzp900BZTQvkuXk0
 rKCp+earAbt1oWzeOJNIQLJ10d+/YNcGi1Bw70dnRkzvyZ7WNp/w6lApMzGuVEgz4D+bQ19RfTz
 hJNUiWyQJeUUAsxoGn+yh7ob9j2AUiCAYY5pKvJAtJPEgqU92ZLs0GjU3M1ofdpwrN8/C4SDtDU
 iI8l4056pldIFoMG9bSKQSvj+VwbLFf/7HApPbOaErxUtt0vqBrAwcqcEWxz9yhivxJiTmGKUE4
 lBjOkniydFXrTizddmSaHyP98SQMe36IUyWaXf+/onjeW3ekoFG3Hvse8oltXe2ef8l7ykoYjmI
 1pyTCy38USPn/bNpX2eDhMxqtoB87Qifv87Vz87BetjItniHIKpWJ5M3TktKabvH1Ek9UE0/FCS
 iZjyYmbBsuOZaIY+xvhcamEFnQD7iVQU8M5kZTNQQJGYosb+/X/UUvteS0EKPP3AAgop4jJVhba
 no7zwUmBS+fmH+dIT2r8wGRDz5C+cdl1gEikESgu8gvLyIEzaqNLBo9Pmbfya6dNV8khtGFi0uF
 jpc/9wFnKBiTOlSKHQL3H3UKn48O8cKWEKImlR/I2M/gTmB7Om9RTG3GpArkJC/RohyCq4349R6
 AmukxU8Y3n6PC8ArgmCa8Yl2atGfdHBImvjiHhPSiMPUjxRdvxOQ=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Export `acpi_of_match_device` function and use it to match the of device
table against ACPI PRP0001 in Rust.

This fixes id_info being None on ACPI PRP0001 devices.

Using `device_get_match_data` is not possible, because Rust stores an
index in the of device id instead of a data pointer. This was done this
way to provide a convenient and obvious API for drivers, which can be
evaluated in const context without the use of any unstable language
features.

Fixes: 7a718a1f26d1 ("rust: driver: implement `Adapter`")
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v6:
- rebased onto v7.1-rc1
- Link to v5: https://patch.msgid.link/20260420-rust_acpi_prp0001-v5-1-f77869b18b9f@posteo.de

Changes in v5:
- provide a stub instead of canditionalize the caller
- Link to v4: https://lore.kernel.org/r/20260408-rust_acpi_prp0001-v4-1-87b78ad79239@posteo.de

Changes in v4:
- fix compilation on !CONFIG_ACPI
- fix typo
- add doc to `acpi_of_match_device` and remove from header file include
- Link to v3: https://lore.kernel.org/r/20260407-rust_acpi_prp0001-v3-1-c5b24590c273@posteo.de

Changes in v3:
- use acpi/acpi_bus.h instead of drivers/acpi/internal.h to declare
  `acpi_of_match_device`
- Link to v2: https://lore.kernel.org/r/20260405-rust_acpi_prp0001-v2-1-4f8b1cf075d3@posteo.de

Changes in v2:
- keep unsafe block as short as possible
- don't export acpi_of_match_device
- add implementation decisions to commit msg
- Link to v1: https://lore.kernel.org/r/20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de
---
 MAINTAINERS             |  1 +
 drivers/acpi/bus.c      |  6 ++--
 include/acpi/acpi_bus.h | 11 ++++++++
 rust/helpers/acpi.c     | 16 +++++++++++
 rust/helpers/helpers.c  |  1 +
 rust/kernel/driver.rs   | 74 ++++++++++++++++++++++++++++++++++++++++---------
 6 files changed, 93 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..4367a303e90e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -291,6 +291,7 @@ F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	include/linux/fw_table.h
 F:	lib/fw_table.c
+F:	rust/helpers/acpi.c
 F:	rust/kernel/acpi.rs
 F:	tools/power/acpi/
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2ec095e2009e..554dbddb1c8c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -831,9 +831,9 @@ const struct acpi_device *acpi_companion_match(const struct device *dev)
  * identifiers and a _DSD object with the "compatible" property, use that
  * property to match against the given list of identifiers.
  */
-static bool acpi_of_match_device(const struct acpi_device *adev,
-				 const struct of_device_id *of_match_table,
-				 const struct of_device_id **of_id)
+bool acpi_of_match_device(const struct acpi_device *adev,
+			  const struct of_device_id *of_match_table,
+			  const struct of_device_id **of_id)
 {
 	const union acpi_object *of_compatible, *obj;
 	int i, nval;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b701b5f972cb..c85f7d8f1632 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -187,6 +187,10 @@ struct acpi_driver {
  * -----------
  */
 
+bool acpi_of_match_device(const struct acpi_device *adev,
+			  const struct of_device_id *of_match_table,
+			  const struct of_device_id **of_id);
+
 /* Status (_STA) */
 
 struct acpi_device_status {
@@ -992,6 +996,13 @@ int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
+static inline bool acpi_of_match_device(const struct acpi_device *adev,
+					const struct of_device_id *of_match_table,
+					const struct of_device_id **of_id)
+{
+	return false;
+}
+
 static inline int register_acpi_bus_type(void *bus) { return 0; }
 static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
diff --git a/rust/helpers/acpi.c b/rust/helpers/acpi.c
new file mode 100644
index 000000000000..e75c9807bbad
--- /dev/null
+++ b/rust/helpers/acpi.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+
+__rust_helper bool rust_helper_acpi_of_match_device(const struct acpi_device *adev,
+						    const struct of_device_id *of_match_table,
+						    const struct of_device_id **of_id)
+{
+	return acpi_of_match_device(adev, of_match_table, of_id);
+}
+
+__rust_helper struct acpi_device *rust_helper_to_acpi_device_node(struct fwnode_handle *fwnode)
+{
+	return to_acpi_device_node(fwnode);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 625921e27dfb..38b34518eff1 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -38,6 +38,7 @@
 #define __rust_helper __always_inline
 #endif
 
+#include "acpi.c"
 #include "atomic.c"
 #include "atomic_ext.c"
 #include "auxiliary.c"
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 36de8098754d..93e5dd6ae371 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -278,6 +278,26 @@ fn init(
     }
 }
 
+// Calling the FFI function directly from the `Adapter` impl may result in it being called
+// directly from driver modules. This happens since the Rust compiler will use monomorphisation, so
+// it might happen that functions are instantiated within the calling driver module. For now, work
+// around this with `#[inline(never)]` helpers.
+//
+// TODO: Remove once a more generic solution has been implemented. For instance, we may be able to
+// leverage `bindgen` to take care of this depending on whether a symbol is (already) exported.
+#[inline(never)]
+#[allow(clippy::missing_safety_doc)]
+#[allow(dead_code)]
+#[must_use]
+unsafe fn acpi_of_match_device(
+    adev: *const bindings::acpi_device,
+    of_match_table: *const bindings::of_device_id,
+    of_id: *mut *const bindings::of_device_id,
+) -> bool {
+    // SAFETY: Safety requirements are the same as `bindings::acpi_of_match_device`.
+    unsafe { bindings::acpi_of_match_device(adev, of_match_table, of_id) }
+}
+
 /// The bus independent adapter to match a drivers and a devices.
 ///
 /// This trait should be implemented by the bus specific adapter, which represents the connection
@@ -329,35 +349,63 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
     fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        #[cfg(not(CONFIG_OF))]
+        let table = Self::of_id_table()?;
+
+        #[cfg(not(any(CONFIG_OF, CONFIG_ACPI)))]
         {
-            let _ = dev;
-            None
+            let _ = (dev, table);
         }
 
         #[cfg(CONFIG_OF)]
         {
-            let table = Self::of_id_table()?;
-
             // SAFETY:
             // - `table` has static lifetime, hence it's valid for read,
             // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
             let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
 
-            if raw_id.is_null() {
-                None
-            } else {
+            if !raw_id.is_null() {
                 // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id`
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
-                Some(
-                    table.info(<of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(
-                        id,
-                    )),
-                )
+                return Some(table.info(
+                    <of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id),
+                ));
             }
         }
+
+        #[cfg(CONFIG_ACPI)]
+        {
+            use core::ptr;
+            use device::property::FwNode;
+
+            let mut raw_id = ptr::null();
+
+            let fwnode = dev.fwnode().map_or(ptr::null_mut(), FwNode::as_raw);
+
+            // SAFETY: `fwnode` is a pointer to a valid `fwnode_handle`. A null pointer will be
+            // passed through the function.
+            let adev = unsafe { bindings::to_acpi_device_node(fwnode) };
+
+            // SAFETY:
+            // - `adev` is a valid pointer to `acpi_device` or is null. It is guaranteed to be
+            //   valid as long as `dev` is alive.
+            // - `table` has static lifetime, hence it's valid for read.
+            if unsafe { acpi_of_match_device(adev, table.as_ptr(), &raw mut raw_id) } {
+                // SAFETY:
+                // - the function returns true, therefore `raw_id` has been set to a pointer to a
+                //   valid `of_device_id`.
+                // - `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id`
+                //   and does not add additional invariants, so it's safe to transmute.
+                let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
+
+                return Some(table.info(
+                    <of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id),
+                ));
+            }
+        }
+
+        None
     }
 
     /// Returns the driver's private data from the matching entry of any of the ID tables, if any.

---
base-commit: 3131ff5a117498bb4b9db3a238bb311cbf8383ce
change-id: 20260401-rust_acpi_prp0001-a2971543b555

