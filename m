Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357B3D0BFC;
	Tue, 12 May 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603822; cv=none; b=IY9F+rsmu6g3vlSWvqtwklie37lHi1KGMnfKDvCwytOxUoEwP5MRR1KURgG2dtvOw6jjCvyBGvGZGiUlrrZYK+v1/Jk7xnK1TrPUp6v9NQXddtbrtrojh6wXM12tsAelxGVEZW2ZyNuitm20qaBDBhAcmaQI11fqg674j3x/Res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603822; c=relaxed/simple;
	bh=WgrWpJkKErgCdhZGA9+n+L86BGNP1puXk4uYOGqFexM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j1o3veDMoevv6zEzbFqmIMu9FmvA7zimAbHeAK5a76JCVLTdTn+xntw/fYw43rQk4fH18+LKee7Qr7AFHODC0uvrIv1BuLsPue7B2kV3CNbCHZ+3sojrZuTNct17N/QB8Y8Ay+Mmt6gx55WlP1EEmVlgQERdr74FEs2d5zAvoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYnurd5l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYnurd5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B576C2BCC7;
	Tue, 12 May 2026 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603821;
	bh=WgrWpJkKErgCdhZGA9+n+L86BGNP1puXk4uYOGqFexM=;
	h=From:To:Cc:Subject:Date:From;
	b=cYnurd5lcv5NcnfZfa7LqLh+Zc9AvkZxaN+nCpiPK5rYxfueKZSTcv9ZMDFrsJZKd
	 dWDLrGCQglvWGpRbVGzXpUCh8wlTx8WdUwYL/0gc4qrcKUlyK0uObUBsX3yUU/THdo
	 5Wre9UwMGD4+K7Aml0DXd89Of6PoULMRiYFZBmeKe7yXSQsW2b4X+1s5boZRNEYEqO
	 hVf/jPHZyQp4f6hJY3TK+cIgF4pKZQe82yLs9S2j4ITSPrSEJ77w0EDnBg2RkY3WZT
	 LRRk05rSIj4yNzPdQEoFbDkg68MbgzPbroCo0OEkifgJiObpISribOr7z+onUJzomQ
	 r09IytYceDqkQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev
Subject:
 [PATCH v1 0/3] platform/chrome: Check ACPI_COMPANION() against NULL at probe
 time
Date: Tue, 12 May 2026 18:34:06 +0200
Message-ID: <3710526.iIbC2pHGDl@rafael.j.wysocki>
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

This series fixes up three platform/chrome drivers recently converted to
platform drivers to make them check the devices' ACPI companion objects at
probe time.

Thanks!



