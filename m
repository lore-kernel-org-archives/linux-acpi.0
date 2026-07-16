Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876143A7F0;
	Thu, 16 Jul 2026 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221785; cv=none; b=MsYiywx45UWaZIKlSi+25WR5BVvcWgFuubNOoMukvzt/ycPxWeX89esDvHivBQaWbmKeaC6MixbqQUBgfqhilVwAGT6XnVIcV7z3k3ZoFF2HUCa54uhhE4oloZffK47dG96LnOJusQ/LTm3gxeWgTDFkr9VoQ60xBiR63YfEMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221785; c=relaxed/simple;
	bh=E/neM9q45oFk5vumCuNs3BlrBpr2PnvuUZbONFwRIKg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hs+G0iogwW81MvvMKVsjXBEhJSX5NttrD5OCu5+g/TuP9UTWjobIoB2BPPq56tZr6QGdoJWwPE/aAecX673C4bFtWi1GYvuT2x4Yg0JJYaucqxBWfasqWuUloTyPKfuqAleiCzUNSEJKEoSkmNxmB/4Polgr3tNkFN6OFOM6m9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Ni9G6ir7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ni9G6ir7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784221779;
	bh=E/neM9q45oFk5vumCuNs3BlrBpr2PnvuUZbONFwRIKg=;
	h=From:Subject:Date:To:Cc:From;
	b=Ni9G6ir7X07AFt8GUroRRtE9hkhAZNVOrzMQepnCFH2BcL030i+v9bC1kxvm2nAcT
	 nBbfHbVv/hBI75X0GZYJLl9tKUrCqPmSJWW3FIN5WIibKGxUoM65IQK9N0kdBRsDF1
	 ZIUvhnPTAVAJ1lFO1jm81GcoprxerHFvc3XjcNzY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/6] configfs: Allow the registration of const struct
 configfs_attribute
Date: Thu, 16 Jul 2026 19:09:25 +0200
Message-Id: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWtSl1Z4FbHQmjIWJR1EIt5ds
 Tvf4vwXMAZChia5IOBBTIuPyNIE7NT7EQUN0ZDLXMsq08Iu3tHo+B28CdMzCl0rZWRZKC0NxOc
 a0NH5VdvuN+9mRru9KbjvB7LL58h3AAAA
X-Change-ID: 20260716-configfs-const-base-6955b043560b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=1356;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=E/neM9q45oFk5vumCuNs3BlrBpr2PnvuUZbONFwRIKg=;
 b=W8B1eCdzBPF+vX/iGW+KJHE8xAceDD1at4gcqjxGEzdBiqCIOPZrlc1rI1Witb3eC2twB400h
 B8v+ldzTTnpAVplEdwuXCfW7epvpRYTFvlvmL1bey309UhnH5QkbVcJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The attribute structure defined in driver code never need to be
modified. Allow them to be marked as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (6):
      rust: configfs: remove mutability from some field initializers
      configfs: Constify is_visible/is_visible_bin in configfs_group_operations
      configfs: Treat attribute structures as const internally
      configfs: Constify configfs_bin_attribute
      configfs: Allow the registration of const struct configfs_attribute
      samples: configfs: constify the configfs_attribute structures

 drivers/acpi/acpi_configfs.c       |  2 +-
 drivers/gpu/drm/xe/xe_configfs.c   |  4 +--
 drivers/virt/coco/guest/report.c   |  6 ++--
 fs/configfs/configfs_internal.h    | 10 +++---
 fs/configfs/dir.c                  | 10 +++---
 fs/configfs/file.c                 |  6 ++--
 fs/configfs/inode.c                |  2 +-
 include/linux/configfs.h           | 73 ++++++++++++++++++++------------------
 rust/kernel/configfs.rs            | 20 ++++++-----
 samples/configfs/configfs_sample.c | 16 ++++-----
 10 files changed, 78 insertions(+), 71 deletions(-)
---
base-commit: c8d07eca6270b3f41c0e528a470895f1bd42e2b7
change-id: 20260716-configfs-const-base-6955b043560b

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

