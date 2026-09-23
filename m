Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D19279DB1;
	Wed, 23 Sep 2026 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156950; cv=none; b=HygrxO+dubFD67ETWjruxz3QNObfGlw4IxiEPy19xA/CCybG6skhB2GwhZCefFXwpGl57wZl8JOC4CEV1ZvO1QJr64bbaljOcZkaxP+tjfnsbT41y5BClMCqunkR2tP/4+ObOkDOawhqaCLr/d7o/ygE9fDpJvNUjJghpIx5pPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156950; c=relaxed/simple;
	bh=4+z+/tjnqK3oGf7DjIikgICCz3ff+K+BIr06IV9A3Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8uP4tEKl3qINfABnHJ2PPHCaAHwSUO8bRd44mAl9jwi5kIECQVySGlBGkVgghBDL8UNBrqiI8s9yV4Tgz1MZX7pG9VAk6vj5zbOM0dMK9G9YOXwWZZN8Polku7wLS9jJGIUGth8rf1NN3q/He/yFtL75shXaftBgyzc3OL06Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AJIfUjnp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AJIfUjnp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=1H+3Z2DPAcCWqo1xbpVn92Me3B62Xb28l4NormQ35o8=; b=AJIfUjnpVEyRUeft6V8FsjDZ/h
	29+o65vm2jRXPCZM5PiAT9NkquWaTUdyi9+DrjRskOXLNPTud3tFAn47TOpMRTtO69hTWb8l3QYgl
	cHML4WqWCVW3qFoiljy9ZnKCBftMXJAZ9UWNsjif90oExj5wkBoGoMA7dfyX0HQxHdCd0Ll2Y+L12
	fgtUsHI8L6MRptIAml6YpIZAs0LIHLjPu1pjwDiM7BQnWMDLNTurDkoFDm3DcDPM91xA99Kc8EQqK
	YSfHEvIaifZ299vA37Qm5yGb0Rl2EvXiMYdhExrGa3s2sAZJ2uqMJEiEz0Jh5+g6x+pviFvYz7cia
	BfzCsyHg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x9Jah-003fMW-2s;
	Wed, 23 Sep 2026 09:48:40 +0000
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dan Williams <djbw@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-coco@lists.linux.dev,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/6] configfs: Allow the registration of const struct configfs_attribute
Date: Wed, 23 Sep 2026 02:48:06 -0700
Message-ID: <179015667258.1932464.18085260511355627713.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Debian-User: leitao


On Thu, 16 Jul 2026 19:09:25 +0200, Thomas Weißschuh wrote:
> The attribute structure defined in driver code never need to be
> modified. Allow them to be marked as const.

Applied, thanks!

[1/6] rust: configfs: remove mutability from some field initializers
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=fd2d4fa740e2
[2/6] configfs: Constify is_visible/is_visible_bin in configfs_group_operations
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=8ea6cd50ce94
[3/6] configfs: Treat attribute structures as const internally
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=9c21b22db69e
[4/6] configfs: Constify configfs_bin_attribute
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=a84dbcbac28a
[5/6] configfs: Allow the registration of const struct configfs_attribute
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=8900c54dc695
[6/6] samples: configfs: constify the configfs_attribute structures
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=620938e7da89

Best regards,
-- 
Breno Leitao <leitao@debian.org>
