Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29BB2931D3;
	Tue,  8 Sep 2026 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860424; cv=none; b=nHUNwJ419wQ/jNcGa7eyPbaFHg/O9Z0KKq2fh3hVulIlA+9jYbY/6p3Rnp72zGGNvAEb+zBegPUDUfuMj2I6uduUev3eDY+VxKfxNCrU7SCTiDoaM+OFkskH0meYE8KLA4v8IRk5XJEy2LNQlG7flGbpEpCGhdyctoGoKSuYuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860424; c=relaxed/simple;
	bh=UmTWHtlxpOmPDc7bC8+FllZDsuAbexNJC+TLoeqN3kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3OblrVI7O1XL0L4XPRXMRuUgqxIBazczRwT2tsF2JR8meHuw9FsMQeB2KDYhD9vFBOjowM34dhUerLAXq/nlAswA/k1Fx7N199DJIDezwyHenBTtlTkAW/PkIJBLydUmTf98TbIczgxWHRkdb9j8C3x/Lo+PVBhxbmmWVX13VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NajoaIGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NajoaIGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBAD1F00A3A;
	Tue,  8 Sep 2026 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788860423;
	bh=LLZs2wk/w9Dny3TGlhIuLiWrITsLFSqhaMa65jzR58k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NajoaIGLH0R4J1xhhpGdt1KsLHt/taDufyawdxzzK3Db2oKIoZG3sNKI9A9BOTh3V
	 F30u9W6XZ1+X0LSUHmuyVyUWkaUk0lS3hE1uJR5EvstgbYsLviRvA4nm77sLQogsPc
	 7GGc94FqrenCqiJINayxAySNgXrpT27kSRr0twAPKMw6LjVEbZjckfPk7OzYQnhn2r
	 GbrlcmUQuWZrEBXbO2xnUIiBVMn9UP+bUhpPoPkuO2PpiSfCrWSrCcX8I2l/qmtHTs
	 VDs3xUvS8kxsMLQ4UcZbCfUVD4F3w31XAE6LXj2hrD4RB/f9wia9/TpShJJLFF0HLo
	 nJtWRcV6Uyuag==
From: Danilo Krummrich <dakr@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH] driver core: fix typos in comments
Date: Tue,  8 Sep 2026 11:40:18 +0200
Message-ID: <20260908094018.3811720-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904111816.31254-1-hemanth.selam@gmail.com>
References: <20260904111816.31254-1-hemanth.selam@gmail.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri,  4 Sep 2026 16:48:14 +0530, Hemanth Selam wrote:
> [PATCH] driver core: fix typos in comments

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] driver core: fix typos in comments
      commit: d3bdf70cf0e8

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
