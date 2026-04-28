Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7832939C;
	Tue, 28 Apr 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402501; cv=none; b=kNO0mageC+9O2/0bLNn/DqdEqz5D3rcRw/G2SeF5+SzpjRSlZYvjfoEuzH4lrz2SIb6B3Gui0FiBuivIGlEI5GqOXHwBMAzSeBo4xIDMWRoeQlvcwhrlgv0MptR5eqVebJMcNnQf+htD805mwkDodRoN8SDfMvciVNlRHdznSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402501; c=relaxed/simple;
	bh=CyDS1MaMVtT1+trsop/It60OO3seF/7V9Bo2A5zSNyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryjpNxgTb6WoWguiWRgtyYk2zAguKEknoaMqVvibwH1JBZ9WpXtbR4RX8hjxQQ9/4SB1wWIGFk/gAKfnGUesZCdbA5TZj/de8LL/NtBdrs32kDgVFbukRWmLwj/Fx//tbXypteN7PHDBfuPPN9HhZIV6oe656ddMJ0ug23piB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxc7DgQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxc7DgQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75307C2BCAF;
	Tue, 28 Apr 2026 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777402501;
	bh=CyDS1MaMVtT1+trsop/It60OO3seF/7V9Bo2A5zSNyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxc7DgQoLhFNcYrW5gGzi4SXigbJWesnBA3rsVivvQmt/sVqTSpUdlFW38Vb3kvqt
	 zMzYLA5VnSJPr/irb9aJ05BzPTF6F4KMKQoReU6+i3cPiTymprADaKDmGL4vRcr7iB
	 Sw7qL/kOzv6MYiOBvNJSwlZgYleavu1QpGIASxr7/15ykrKGZxrPWw9dVmtAw55UYF
	 mNuHUe3svLV+AFJizTXfMHEnozT7geosmIqk/zonhcsA+4vAUzdeItQkUcKsPy7pj5
	 BH43lZ5aUGGdc/ToWLGksgoPDHn6qQTKVOYpm0CEiZAvV/EP4o2fro1EYu+cR7FnQl
	 MecIsfheX4O8Q==
From: Danilo Krummrich <dakr@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v6] rust: ACPI: fix missing match data for PRP0001
Date: Tue, 28 Apr 2026 20:54:40 +0200
Message-ID: <20260428185440.2596573-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427-rust_acpi_prp0001-v6-1-6119b2a66183@posteo.de>
References: <20260427-rust_acpi_prp0001-v6-1-6119b2a66183@posteo.de>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 17:55:57 +0000, Markus Probst wrote:
> [PATCH v6] rust: ACPI: fix missing match data for PRP0001

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: ACPI: fix missing match data for PRP0001
      commit: 2690d071584e

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
