Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194E421A02;
	Wed,  3 Jun 2026 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475176; cv=none; b=m5Q4Q5h/Q7rbiQ0VhyilN7hG2rEe5QZgXa4YV/lLwPiqrN66J9oKNuKh1HTQFm6DEbV5DXPsTgRUSjXkCQagBqTxJSbAXtyAMgdN+SPPtHgH7hrTLAe5CHB/FWyk3SJhTs6Z6OVUFMtks8okmNCQQf/RxFackt6rrmk4eKGvi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475176; c=relaxed/simple;
	bh=HnDoJc1wVP1qFgJjnEmr1/CMX1uh1tn18/Vyj8exdoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djm4fZvb0aHz32klY55EjiJy5J7b4RAtJUGcWBhG/SXvczZk3WVXnOUQKxA9walLGFOCU1+MHSscIE7b1Ak95wm8LUY2ABRdRiAUGdyjUWkbEk4TqqlfEZYoM2zP0/Pa9hguJrdHe4CDB8C1zd1G62XP3n9jzc2WrVAsDPPBX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kd/m92Jt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kd/m92Jt"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1591327155;
	Wed,  3 Jun 2026 10:26:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MmAZXT24dWYo; Wed,  3 Jun 2026 10:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780475172; bh=HnDoJc1wVP1qFgJjnEmr1/CMX1uh1tn18/Vyj8exdoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kd/m92JtkMmtgc+g+DEyyJgaXgJ2nr/I5S26A3qqTubRB+HYycNk9kvAZFegLtAdF
	 IgY73f3aRMasf1EY2wlNvSJwzDk2fIDRo5sdmE2Dodxp+Q4PSnhiMm4Xc6tR4gZNMl
	 k09mf4AieZ4A28J3M+1cQht7guLuyjH4RlCGlYZ1IJP3eNyxlMeuKQz/Bf9WfPB0As
	 w0v3Kok7GaPQKfuXnnpYxHXDUy/alvXjYvEyAEdSiQRJEWNw7Rf4QGkiK6pruHtk7B
	 DDKo93r+sgeruhgsjUSG74V9MkOzCldcCa73ZRBcQkO6SkeR9ZqIGM59Lx6qHitCBa
	 PbNTLMex7Go6Q==
From: Marco Scardovi <scardracs@disroot.org>
To: mika.westerberg@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	scardracs@disroot.org
Subject: Re: [PATCH v5] gpiolib: acpi: prevent address truncation in OperationRegion handler
Date: Wed,  3 Jun 2026 10:25:50 +0200
Message-ID: <20260603082550.11989-1-scardracs@disroot.org>
In-Reply-To: <20260602121535.GC2990@black.igk.intel.com>
References: <20260602121535.GC2990@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mika,

Thanks for the clarification.

After looking again at the ACPI specification, I agree that AML accesses
GPIO fields through Connection() resources, so the offset used by the
handler is derived from the GPIO resource descriptor itself.

Therefore, describing this as a truncation issue is not accurate. The
actual issue is that the address argument is used as an index into
agpio->pin_table without first validating that it is within
agpio->pin_table_length.

I'll update the description accordingly and focus on the missing bounds
check rather than truncation or wrap-around.

If You or anyone else haven't any more suggestions/reviews I'll post it
later today/tomorrow as a v6.

Thanks,
Marco
