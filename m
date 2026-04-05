Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7343033E7
	for <linux-acpi@vger.kernel.org>; Sun,  5 Apr 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408601; cv=none; b=nmvaGM0XA3PiptPlz1GYxMYy9HA/KC5YUJkj1TafPSOHZMDebhb/04xycmpposXh+SOCzj/icU6XYs7+x9uAGgaHvUOYr05vBXdCmsfn18cXd8wlX/bZlh/XwSJUZIhLC8xaYRTjc0obNQ3nKAxfqxVizZxisv1unejisIduahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408601; c=relaxed/simple;
	bh=cS3mkpf/+i346QJIDzIpjaM/Ao1/yNW0VZRE9zHvN6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kiG3kRybp0AQDzKGzXbnKc5BpL1miGo5ZwEUASM8zeXBbVctGb6agnLsVLkse5nttwCt7TEd/8wC4XHZxRNz+dpPDiYAKkF6mJP4sfEMsSrMIoKl29J+rMgcWOCC76NvklmdldaYk9LoAIoic/uLPzRkU07YppTid8AdJynPSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ijEM/Oka; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ijEM/Oka"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D359D240028
	for <linux-acpi@vger.kernel.org>; Sun,  5 Apr 2026 19:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1775408596; bh=BNrwQ9f/Mr+5JaoOesRAdqUi9/r2gTHNu6ybbYD9ivY=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=ijEM/Okayq25BMwLWHZ35xpWIxnibFHzIMBLQmbfFKFAv6CNiL3xHOKPc7unKsVNR
	 DmB0Coo3v//cLk0z23YOlQHRLZGc9Gjrwzf8MSHMY3R6ra5oVXKl9EqkOGnj+Fm53c
	 YisXO292CpcFnbQnl7baJuAJBERzbB1ZRyQgosS+LqwbBs+N5GV4JHWAuQ6BTOfjgb
	 Ov6J7ah8CGh+179GjqzLg+NPa/hmro3IOOfmQB92XA2b5wmRNSn9t4Yh+cqqLYgKwx
	 GCkr8ezoNAiTMMKp5vWa3RxrTM1JYH1GDTOGSZx9lecz7bnZP3tHJ4w/DagELmLe1i
	 59w2o9JCha4rA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fpf0y5Jw5z9rxF;
	Sun,  5 Apr 2026 19:03:14 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 05 Apr 2026 17:03:15 +0000
Subject: [PATCH v2] rust: ACPI: fix missing match data for PRP0001
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-rust_acpi_prp0001-v2-1-4f8b1cf075d3@posteo.de>
X-B4-Tracking: v=1; b=H4sIAMSV0mkC/32OSw6DIBRFt2LeuBigoLGj7qMxBvFZGSgUkLQx7
 r1U5x2em/vbIKA3GOBWbOAxmWDskoFfCtCTWp5IzJAZOOUVFZQRv4bYKe1M57yjNCuKNzWT4tp
 LKSHnnMfRvI/OR3uyx9eaq+MpQq8CEm3n2cRbkeqSEq8r+HknE6L1n+NOYof5z3JihJGxUmLgO
 DZciLuzIaItB4R23/cvEDjKWt4AAAA=
X-Change-ID: 20260401-rust_acpi_prp0001-a2971543b555
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8631;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=cS3mkpf/+i346QJIDzIpjaM/Ao1/yNW0VZRE9zHvN6E=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp0pXS0RfdYiC2AG6H8PM73s1bggRmxalkas0Fi
 PYGMZWVAdmJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCadKV0hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9L3RQ/+MXcgORBTl662QHMseJOXQRzrXygKY5f
 ow18WSYMK7DPUC3ga5t7GZ20uesyaWONcT4VmQm3a8QruVM5l0PgckYUQqw8rO/D3/gGtysZZ3/
 QhILdVJ9Csv45KkmvTwQSlKiHiNalk8HlkkqpIsh6BMksrUg/2ifElI9dYkrMqVu4qtosL+ALKd
 X7Dz8OuH5+uMS5kpk5SVngQk6W3n8q2Nl3s8Wx6QZ/OMhRLBzpZa6ZfI3UMu5pMDFTU3PYbr3Ma
 WpaxAHAwwHzwsk5UDKKehsGlQSduvGCJesp6uhBcoN1oWm19sxKyBbFdgtj47fVhYnPy7Ftt8ue
 njdgT+f1aAvTZTP3EaLj1S1fUTPh2JRMhnGrpELXeIyfxsVGVPlAQ6Ov/PsTywyd01DkCcbbeRJ
 jTr5PQzxFHoMXWgFpBxX/Ay3Q2krskfx81bzzXtKcythX9bRfzgCGMRHCyGgsTgnCY9t2wzSdEV
 3je/4fNqJqDBR5IFvO+I0QGsG3YjiEGAqs++QZF1J2Gu4wraNkRlOHKRpYh84ZHQF3jQe4aFtfb
 FiDsD94aI1vWRxftgn0THANPRdXq5ZX6zSJdr8mdOLuG3IkWjkJDGvxYuIp5cqRE8IK4LQ3jRTW
 25+VXhj/oHuuAy3RoECK7kFlw+M8oD3jOCcTWeXN92xJURJ+KdDM=
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
Changes in v2:
- keep unsafe block as short as possible
- don't export acpi_of_match_device
- add implementation decisions to commit msg
- Link to v1: https://lore.kernel.org/r/20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de
---
 MAINTAINERS                     |  1 +
 drivers/acpi/bus.c              |  6 ++--
 drivers/acpi/internal.h         |  4 +++
 rust/bindings/bindings_helper.h |  5 +++
 rust/helpers/acpi.c             |  8 +++++
 rust/helpers/helpers.c          |  1 +
 rust/kernel/driver.rs           | 70 ++++++++++++++++++++++++++++++++---------
 7 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..3a7b3b5f2a28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -302,6 +302,7 @@ F:	include/linux/acpi.h
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
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 40f875b265a9..f2e743175e93 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -99,6 +99,10 @@ static inline int acpi_arch_thermal_cpufreq_pctg(void)
 }
 #endif
 
+bool acpi_of_match_device(const struct acpi_device *adev,
+			  const struct of_device_id *of_match_table,
+			  const struct of_device_id **of_id);
+
 /* --------------------------------------------------------------------------
                      Device Node Initialization / Removal
    -------------------------------------------------------------------------- */
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952..9a1ae3dce746 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -96,6 +96,11 @@
  */
 #include <../../drivers/base/base.h>
 
+/*
+ * The driver-core Rust code needs to call `acpi_of_match_device`.
+ */
+#include <../../drivers/acpi/internal.h>
+
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 // Used by `#[export]` in `drivers/gpu/drm/drm_panic_qr.rs`.
 #include <drm/drm_panic.h>
diff --git a/rust/helpers/acpi.c b/rust/helpers/acpi.c
new file mode 100644
index 000000000000..f2aa00ec99c2
--- /dev/null
+++ b/rust/helpers/acpi.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/acpi.h>
+
+__rust_helper struct acpi_device *rust_helper_to_acpi_device_node(struct fwnode_handle *fwnode)
+{
+	return to_acpi_device_node(fwnode);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3c42e51f00a..8ecd1580aa69 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,6 +9,7 @@
 
 #define __rust_helper
 
+#include "acpi.c"
 #include "atomic.c"
 #include "atomic_ext.c"
 #include "auxiliary.c"
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 36de8098754d..62d7d1ab776c 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -96,13 +96,18 @@
 
 use crate::{
     acpi,
-    device,
+    device::{
+        self,
+        property::FwNode, //
+    },
     of,
     prelude::*,
     types::Opaque,
     ThisModule, //
 };
 
+use core::ptr;
+
 /// Trait describing the layout of a specific device driver.
 ///
 /// This trait describes the layout of a specific driver structure, such as `struct pci_driver` or
@@ -278,6 +283,18 @@ fn init(
     }
 }
 
+#[inline(never)]
+#[allow(clippy::missing_safety_doc)]
+#[must_use]
+unsafe fn acpi_of_match_device(
+    adev: *const bindings::acpi_device,
+    of_match_table: *const bindings::of_device_id,
+    of_id: *mut *const bindings::of_device_id,
+) -> bool {
+    // SAFETY: Safety requirements are the same as `bindings::acpi_device_id`.
+    unsafe { bindings::acpi_of_match_device(adev, of_match_table, of_id) }
+}
+
 /// The bus independent adapter to match a drivers and a devices.
 ///
 /// This trait should be implemented by the bus specific adapter, which represents the connection
@@ -329,35 +346,60 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
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
base-commit: b6c7d19951061de1be08fb8f5714e630b24bcc1c
change-id: 20260401-rust_acpi_prp0001-a2971543b555

