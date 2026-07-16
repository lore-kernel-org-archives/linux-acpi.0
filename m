Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CDE348C68;
	Thu, 16 Jul 2026 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221785; cv=none; b=pSNwSWU5kPoHT6ea4hH+6cpltGeE5+LoZy1LDjRYlawf4OI/AxiLNrZ+kZ4eRoy07UFfr4fhfW08eq3IhgDdjCWJq6ttm7OLBYRGHnSdo5jMoBx6xYs28RRDUbPz/j2g+yfW8gREGL8Fjbbe2t8Sq+UVOUQgl6bOyiCOm9Toy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221785; c=relaxed/simple;
	bh=dBHoPeFN74z8PL2Y8uyMGTiScXZKXOQLXSJUZCoOZ4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRnewSx6vSTaXQxatZ7zgsF+YF4WgO+LNGwgTkiYi8Is0M5FPk9ss1klBH5x3dOk5r4tnwlnpITGIAL/Mds5mIx8nR1H8UpDZaURXLPYF8+poUje+Pkt/GnBQypzX4pcgljWzovOk0rZ6b4T8agp+Tqh7QRA4IQyq8MQwXkSM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Z/kDlRFh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Z/kDlRFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784221779;
	bh=dBHoPeFN74z8PL2Y8uyMGTiScXZKXOQLXSJUZCoOZ4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z/kDlRFhDRFgYQgSzQoKmtwdpeG1w4EntJToLPpWO31pBQFdwbqjvfcEyOm85ByYY
	 kCg+CNUGmed4lMAcg69Wsrl0WUNMP9Zvkva2ooQJOdhW9AVbd+cbVmhggZklVF+V66
	 fu/7Cxz71Oje6RypHiqZnGnxw6whBn6dRpXX2Sj8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 16 Jul 2026 19:09:26 +0200
Subject: [PATCH 1/6] rust: configfs: remove mutability from some field
 initializers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-configfs-const-base-v1-1-c545a4053cb5@weissschuh.net>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
In-Reply-To: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=1897;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dBHoPeFN74z8PL2Y8uyMGTiScXZKXOQLXSJUZCoOZ4k=;
 b=aVZbs/uCZXHVODH1ABH4MgJRQ4jtEG5Zi7lWJCam5sEMkaRjBjYob9SC7itElVohbe8A6rYQA
 yn0fmFmJirVDAxMfzaB4EKaDCo0xfVyJDcuL2BzPBWSP+x+Cf8lizUa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These fields do not require mutable pointers.

Use regular immutable ones.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 rust/kernel/configfs.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2339c6467325..b33fb2e9adf1 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -754,8 +754,8 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
                         ct_owner: owner.as_ptr(),
-                        ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr().cast_mut(),
-                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
+                        ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr(),
+                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
                         ct_bin_attrs: core::ptr::null_mut(),
                     }),
@@ -771,8 +771,8 @@ pub const fn new<const N: usize>(
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
                         ct_owner: owner.as_ptr(),
-                        ct_group_ops: core::ptr::null_mut(),
-                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
+                        ct_group_ops: core::ptr::null(),
+                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
                         ct_bin_attrs: core::ptr::null_mut(),
                     }),

-- 
2.55.0

