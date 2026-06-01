Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8463E0098;
	Mon,  1 Jun 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334041; cv=none; b=iqXzXcIJ7+FBBnWb+mHg30IGrCKN5zDpvY7u0zPLSqOA2783PNUZxBFGfV1ZucTtbncAAkisHUprBGMtidzZ+juQ40QOCQGDd9iYpROq5ec0ZvaTkhVs8raO/mMmo9eeYMJ3OXaAkaRwbiWraCtJpqByQtUnMH3fIuxZyUUVeXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334041; c=relaxed/simple;
	bh=jgtpcnH91goGTrFE+fVoIebcEOLOBswmeF4ItbhaPJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omvTqXTSSFy9mXjqr4QBNezMHt2cJWLjRIvTg21wqL4GFyguD03Bp/9qO+cMM/7ClN2DJ3Rkp+RwZwMBSd25xSeq7Me/wmXpxsd3LyDR0R7YptMkgytMTC/ogxYQXnAj8wPfBZ2okf5FXitVZEi2WYYW7ayDPz9G409gCNGi5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjgU7ZXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjgU7ZXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0381F00893;
	Mon,  1 Jun 2026 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334040;
	bh=jgtpcnH91goGTrFE+fVoIebcEOLOBswmeF4ItbhaPJs=;
	h=From:To:Cc:Subject:Date;
	b=UjgU7ZXfbiJz16PptXWTWDZdYc3umM1qxBOCiyZCM3+7GEskeBkcKNRBAsNv55j1O
	 ewvp2VMP7IzkVjmjntI/08sgziJQ6Ms2KVDeM4ay1+DewHPZ1fUg4FIlnFDFue9u2l
	 cA6heqgArbRv+qZIaH62mdRPln6fR4L7qm5W/ryZy5EjnIlf9VhihisVnhxTnBrFwe
	 2aLw7yo1o0OH8FzDlzuWGNP0/DEy25S0Fbk+OFFvmRVInp+zeyi2ZuurFk1lbKkRwj
	 B56+LNW2FDgbmfcWO/PLqx9oKwslxDLYXUzjBE9ywkmTsDh+lRuakpJAML2dQuiKLr
	 j3/jVnvupW6Zg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 00/15] ACPI: button: Cleanups and conversion to using devm
Date: Mon, 01 Jun 2026 18:53:55 +0200
Message-ID: <12913564.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series makes a number of changes, that are minor fixes and cleanups, to
the ACPI button driver and concludes in switching it over to devres-based
resource management.

Please see individual patch changelogs for details.

Thanks!



