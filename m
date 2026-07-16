Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070443E07A;
	Thu, 16 Jul 2026 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221790; cv=none; b=XHkitvpSckPq/L8h/R/cr8SLnfPFd6kuqbqtha4v7sPhMCPU4KFxG4uP5xNfShsiUOy5jN1FZxCgpURvQia66x+h+BgLmu6s1g2rD8mHcm6dKdRHlmsQ8EEK2hbyvrEOYwcLylGeiEzNM2kTYyZZw32fKdGdf8ArEo0/+Vnuqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221790; c=relaxed/simple;
	bh=rcnAPuhL8Z0tyvLmFviUdVzEcI4fwp6dRZrhwOTqVoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3JLTdE9WrjbwHRayGm07B8qIu13NkqRxnUXYoyAW1yoS7FiYtEwfEe8FNCu3vn3V3OCEP5TYhTvhsSedhpNXEA1rZPRaoMYe/xcEJ/bSxs5aYcmGtI0TAKOM33Esfc7DRMRojRcAQ04Fq+Z7w/kupN955wdNTAbtj1gD6S36lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nOETgqmV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nOETgqmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784221779;
	bh=rcnAPuhL8Z0tyvLmFviUdVzEcI4fwp6dRZrhwOTqVoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nOETgqmVNkaIt9iGQH/1tiOMAegyFKlI3RwPiCCK4gjxBd9f8iI1S3JDe2PnVCaAz
	 NxGs9kkQ3hD2UNPk26CSQb7Pv9r4aHe98FoTBCMfEUKzxP0P8pbkyv/7ki6/Mnn6kp
	 +slMWZBB5W6VhRNNdOGlrg04PHNiCNFqUxeHUdxM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 16 Jul 2026 19:09:30 +0200
Subject: [PATCH 5/6] configfs: Allow the registration of const struct
 configfs_attribute
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-configfs-const-base-v1-5-c545a4053cb5@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=3319;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rcnAPuhL8Z0tyvLmFviUdVzEcI4fwp6dRZrhwOTqVoA=;
 b=BbbHbm8YNFPQUYzw2eaFmTWdJbpX3GvBgFeLEGXDxWxnIG1Z8xTzlkFqKvEUcuRAd6g3Rl8FE
 OjFsAUTLCitCBHywW3Vn0JL/8AcrsjEWHYxagQ+dWpIfIh2HzKbjiX+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The attribute structure defined in driver code never need to be
modified. Allow them to be marked as const.

As there are many drivers which use these attributes, prepare for a
phased transition by using a union of const and non-const attributes.

After all drivers have been migrated to the const variant, the non-const
one can be replaced by the const one and the transition machinery will
be removed again.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/configfs/dir.c        | 4 ++--
 include/linux/configfs.h | 5 ++++-
 rust/kernel/configfs.rs  | 8 ++++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 9a5c2bc4065d..c2152288517c 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -632,8 +632,8 @@ static int populate_attrs(struct config_item *item)
 
 	ops = t->ct_group_ops;
 
-	if (t->ct_attrs) {
-		for (i = 0; (attr = t->ct_attrs[i]) != NULL; i++) {
+	if (t->ct_attrs_const) {
+		for (i = 0; (attr = t->ct_attrs_const[i]) != NULL; i++) {
 			if (ops && ops->is_visible && !ops->is_visible(item, attr, i))
 				continue;
 
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index eff2fb22ab70..5bead9173ec1 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -66,7 +66,10 @@ struct config_item_type {
 	struct module				*ct_owner;
 	const struct configfs_item_operations	*ct_item_ops;
 	const struct configfs_group_operations	*ct_group_ops;
-	struct configfs_attribute		**ct_attrs;
+	union {
+		struct configfs_attribute		**ct_attrs;
+		const struct configfs_attribute		*const *ct_attrs_const;
+	};
 	const struct configfs_bin_attribute	*const *ct_bin_attrs;
 };
 
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index f99a6e376fa3..2ef9cce693b9 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -756,7 +756,9 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
                         ct_owner: owner.as_ptr(),
                         ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
-                        ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
+                        __bindgen_anon_1: bindings::config_item_type__bindgen_ty_1 {
+                            ct_attrs_const: core::ptr::from_ref(attributes).cast(),
+                        },
                         ct_bin_attrs: core::ptr::null(),
                     }),
                     _p: PhantomData,
@@ -773,7 +775,9 @@ pub const fn new<const N: usize>(
                         ct_owner: owner.as_ptr(),
                         ct_group_ops: core::ptr::null(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
-                        ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
+                        __bindgen_anon_1: bindings::config_item_type__bindgen_ty_1 {
+                            ct_attrs_const: core::ptr::from_ref(attributes).cast(),
+                        },
                         ct_bin_attrs: core::ptr::null(),
                     }),
                     _p: PhantomData,

-- 
2.55.0

